import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ScanResult {
  final double hcMm;
  final double? gaWeeks;
  final String classification;
  final String percentileBand;
  final String? edd;
  final String? trimester;
  final String? weeksRemaining;
  final String annotatedImageBase64;

  ScanResult({
    required this.hcMm,
    required this.gaWeeks,
    required this.classification,
    required this.percentileBand,
    required this.edd,
    required this.trimester,
    required this.weeksRemaining,
    required this.annotatedImageBase64,
  });
}

class ScanService {
  static const String _baseUrl = "http://127.0.0.1:5003";


  Future<ScanResult> uploadAndAnalyzeScan({
    required File imageFile,
    String race = "Asian",
    double pixelSizeMm = 0.5,
    required DateTime scanDate,
  }) async {
    final uri = Uri.parse("$_baseUrl/api/analyze_image");

    final request = http.MultipartRequest("POST", uri)
      ..fields["race"] = race
      ..fields["pixel_size_mm"] = pixelSizeMm.toString()
      ..fields["scan_date"] = scanDate.toIso8601String().split("T").first
      ..files.add(
        await http.MultipartFile.fromPath(
          "image",
          imageFile.path,
        ),
      );

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode != 200) {
      throw Exception("Scan analysis failed: $responseBody");
    }

    final json = jsonDecode(responseBody);

    if (json["status"] != "success") {
      throw Exception("Analysis error: ${json["error"]}");
    }

    final String imageId = json["annotated_image_id"];

    final annotatedImageBase64 = await _fetchAnnotatedImage(imageId);

    return ScanResult(
      hcMm: (json["hc_mm"] as num).toDouble(),
      gaWeeks: json["ga_weeks"] != null
          ? (json["ga_weeks"] as num).toDouble()
          : null,
      classification: json["classification"],
      percentileBand: json["percentile_band"],
      edd: json["edd"],
      trimester: json["trimester"],
      weeksRemaining: json["weeks_remaining"],
      annotatedImageBase64: annotatedImageBase64,
    );
  }

  /// Fetch annotated image as Base64
  Future<String> _fetchAnnotatedImage(String imageId) async {
    final uri =
    Uri.parse("$_baseUrl/api/get_annotated_image/$imageId");

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch annotated image");
    }

    final json = jsonDecode(response.body);

    return json["image_base64"];
  }
}
