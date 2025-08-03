import 'package:flutter/material.dart';

class NewReportScreen extends StatelessWidget {
  const NewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Report")),
      body: const Center(
        child: Text("This is the New Report screen"),
      ),
    );
  }
}
