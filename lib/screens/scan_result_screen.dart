import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/ScanService.dart';

class ScanResultScreen extends StatelessWidget {
  final ScanResult result;

  const ScanResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Subtle off-white background
      appBar: AppBar(
        title: const Text("Scan Analysis",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () { /* Add share logic */ },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Hero Image Section --------
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  base64Decode(result.annotatedImageBase64.split(",").last),
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // -------- Stats Header --------
            Text(
              "Clinical Metrics",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[900],
              ),
            ),
            const SizedBox(height: 16),

            // -------- Metrics Card --------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  _metricRow(
                    context,
                    icon: Icons.straighten,
                    label: "Head Circumference",
                    value: "${result.hcMm} mm",
                    color: Colors.blue,
                  ),
                  const Divider(height: 32),
                  _metricRow(
                    context,
                    icon: Icons.calendar_today,
                    label: "Gestational Age",
                    value: result.gaWeeks != null ? "${result.gaWeeks} weeks" : "N/A",
                    color: Colors.purple,
                  ),
                  const Divider(height: 32),
                  _metricRow(
                    context,
                    icon: Icons.assignment_outlined,
                    label: "Classification",
                    value: result.classification,
                    color: Colors.teal,
                  ),
                  const Divider(height: 32),
                  _metricRow(
                    context,
                    icon: Icons.analytics_outlined,
                    label: "Percentile Band",
                    value: result.percentileBand,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------- Secondary Info Grid --------
            Row(
              children: [
                _smallInfoCard(context, "EDD", result.edd ?? "N/A", Icons.event),
                const SizedBox(width: 16),
                _smallInfoCard(context, "Trimester", result.trimester ?? "N/A", Icons.layers),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _metricRow(BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const Spacer(),
        Icon(Icons.chevron_right, color: Colors.grey[300]),
      ],
    );
  }

  Widget _smallInfoCard(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}