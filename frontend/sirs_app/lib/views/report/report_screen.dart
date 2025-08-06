import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../models/report.dart';
import '../../services/report_service.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _imageFile;
  bool _isAnonymous = false;
  // navigates to file to pick a phote.
  //fucntion for IMG
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  // inside _ReportScreenState
  final ReportService _service = ReportService();
  //function for the form submition
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Build Report model
    final report = Report(
      id: 0,
      description: _descriptionController.text,
      location: _locationController.text,
      date: DateTime.now(),
      imageUrl: _imageFile?.path,
    );

    // Shows that its loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // Submits report to backend to be stored
    final success = await _service.submitReport(
      report,
      anonymous: _isAnonymous,
    );

    // when successfully submited the application stops loading and allows you to submit agian
    Navigator.of(context).pop();

    //lets users know if the report went through or not.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Report sent!' : 'Submission failed.')),
    );
    //clean it back up to be used again
    if (success) {
      _formKey.currentState!.reset();
      _descriptionController.clear();
      _locationController.clear();
      setState(() {
        _imageFile = null;
        _isAnonymous = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Report')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          // decription, location, img, amonymous and submit are stored in _formkey( superclass)
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // description controller
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Describe the incident',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a description'
                    : null,
              ),
              const SizedBox(height: 16),
              // location controller
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              //img controller
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Attach a photo'),
              ),
              if (_imageFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('Selected: ${_imageFile!.path.split('/').last}'),
                ),
              const SizedBox(height: 16),
              //anonymous controller
              SwitchListTile(
                value: _isAnonymous,
                onChanged: (val) => setState(() => _isAnonymous = val),
                title: const Text('Submit anonymously'),
              ),
              const SizedBox(height: 20),
              // submit buttom controller
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit Report'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
