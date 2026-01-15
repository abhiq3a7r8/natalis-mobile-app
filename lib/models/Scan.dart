class Scan {
  final String id;             // Unique ID for the scan
  final String filename;       // Original file name
  final String base64Data;     // Base64-encoded image
  final DateTime uploadedAt;   // Timestamp

  Scan({
    required this.id,
    required this.filename,
    required this.base64Data,
    required this.uploadedAt,
  });

  // Convert to JSON for sending to backend
  Map<String, dynamic> toJson() => {
    'id': id,
    'filename': filename,
    'image': base64Data,                 // Base64 string
    'uploaded_at': uploadedAt.toIso8601String(),
  };
}
