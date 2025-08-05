import 'package:flutter/material.dart';
import '../../models/report.dart';
import '../../services/report_service.dart';
import 'report_detail_screen.dart';


class ReportHistoryScreen extends StatefulWidget {
  const ReportHistoryScreen({super.key});

  @override
  State<ReportHistoryScreen> createState() => _ReportHistoryScreenState();
}

class _ReportHistoryScreenState extends State<ReportHistoryScreen> {
  final ReportService _service = ReportService();
  late Future<List<Report>> _reportsFuture;

//calls the fetchreport from server
  @override
  void initState() {
    super.initState();
    _reportsFuture = _service.fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report History')),
      body: FutureBuilder<List<Report>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          //if any error comes up due to network or something related to the http throw error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // else throw a proper snapshot
          final reports = snapshot.data!;
          //if nothing is reported report history is empty
          if(reports.isEmpty) {
            return const Center(child: Text('No reports yet'));
          }
          // design a clean look for the report maybe a card style, tap and enter to see full report
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, i) {
              final rpt = reports[i];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(rpt.description),
                  subtitle: Text(
                    rpt.date.toLocal().toString().split('.').first,
                  ),
                  trailing:
                      rpt.imageUrl != null ? const Icon(Icons.image) : null,
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                         builder: (_) => ReportDetailScreen(report: rpt),
                      ),
                    );
                    },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

