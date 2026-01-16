import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/ScanService.dart';

class ScanResultScreen extends StatelessWidget {
  final ScanResult result;

  const ScanResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Results"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Annotated Image --------
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                base64Decode(
                  result.annotatedImageBase64.split(",").last,
                ),
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            // -------- Metrics --------
            _metric("Head Circumference", "${result.hcMm} mm"),
            _metric(
              "Gestational Age",
              result.gaWeeks != null ? "${result.gaWeeks} weeks" : "N/A",
            ),
            _metric("Classification", result.classification),
            _metric("Percentile Band", result.percentileBand),
            _metric("EDD", result.edd ?? "N/A"),
            _metric("Trimester", result.trimester ?? "N/A"),
            _metric("Weeks Remaining", result.weeksRemaining ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _metric(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
