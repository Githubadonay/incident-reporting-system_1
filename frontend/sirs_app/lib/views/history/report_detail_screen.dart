import 'dart:io';                    
import 'package:flutter/material.dart';
import '../../models/report.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;
  const ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Description 
            Text('Description', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(report.description),
            const SizedBox(height: 16),
            // Location
            Text('Location', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(report.location.isNotEmpty ? report.location : 'N/A'),
            const SizedBox(height: 16),
            // Date
            Text('Date', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(report.date.toLocal().toString()),
            // Image (if any)
            if (report.imageUrl != null) ...[
              const SizedBox(height: 16),
              Text('Attached Image', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Image.file(File(report.imageUrl!)),
            ],
          ],
        ),
      ),
    );
  }
}
