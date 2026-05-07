import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../data/models/vehicle_model.dart';
import '../../providers/vehicle_provider.dart';

class AddVehicleDetailsScreen extends StatefulWidget {
  final String vehicleType;

  const AddVehicleDetailsScreen({super.key, required this.vehicleType});

  @override
  State<AddVehicleDetailsScreen> createState() => _AddVehicleDetailsScreenState();
}

class _AddVehicleDetailsScreenState extends State<AddVehicleDetailsScreen> {
  final _nameController = TextEditingController();
  final _regController = TextEditingController();
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _onSave() async {
    if (_nameController.text.isEmpty || _regController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final vehicle = Vehicle(
      id: '', // Will be assigned by API or locally
      vehicleName: _nameController.text,
      regNo: _regController.text,
      vehicleType: widget.vehicleType,
    );

    final success = await context.read<VehicleProvider>().addVehicle(
          vehicle,
          _image?.path,
        );

    if (success && mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
      // Ideally, navigate to vehicle list tab
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add New Vehicle',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                dashPattern: const [8, 4],
                color: const Color(0xFF2155FF).withOpacity(0.5),
                strokeWidth: 2,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.cloud_upload_outlined, size: 48, color: Color(0xFF2155FF)),
                            const SizedBox(height: 12),
                            Text(
                              'Add Car Image',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF2155FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '(Front or Side View)',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextField(
              controller: _nameController,
              labelText: 'Vehicle Name',
              hintText: 'Enter Vehicle Name (e.g. BMW)',
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: _regController,
              labelText: 'Registration Number',
              hintText: 'Enter Registration Number',
            ),
            const SizedBox(height: 48),
            Consumer<VehicleProvider>(
              builder: (context, provider, _) {
                return CustomButton(
                  text: 'Save Vehicle',
                  isLoading: provider.isLoading,
                  onPressed: _onSave,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
