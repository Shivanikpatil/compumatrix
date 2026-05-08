import 'package:flutter/material.dart';
import '../../../generated/assets.dart'; // Ensure these paths are correct in your project

class AddNewVehicleScreen extends StatefulWidget {
  const AddNewVehicleScreen({super.key});

  @override
  State<AddNewVehicleScreen> createState() => _AddNewVehicleScreenState();
}

class _AddNewVehicleScreenState extends State<AddNewVehicleScreen> {
  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Add New Vehicle",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A), // Deep Navy/Black
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Choose Vehicle Type",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569), // Slate Grey
              ),
            ),
            const SizedBox(height: 20),

            // Four Wheeler Card
            VehicleTypeCard(
              title: "Four Wheeler",
              imagePath: Assets.images.img3.path, // Replace with your actual car asset
              isSelected: selectedType == "four",
              onTap: () => setState(() => selectedType = "four"),
            ),

            const SizedBox(height: 20),

            // Two Wheeler Card
            VehicleTypeCard(
              title: "Two Wheeler",
              imagePath: Assets.images.img.path, // Replace with your actual scooter asset
              isSelected: selectedType == "two",
              onTap: () => setState(() => selectedType = "two"),
            ),

            const Spacer(),

            // Continue Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  if (selectedType == null)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 15, color: Colors.red),
                          SizedBox(width: 6),
                          Text(
                            'Please select a vehicle type to continue.',
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedType == null) {
                          setState(() {}); // triggers the error message above
                          return;
                        }
                        final apiType = selectedType == 'four'
                            ? 'four_wheeler'
                            : 'two_wheeler';

                        Navigator.pushNamed(
                          context,
                          '/add-vehicle',
                          arguments: apiType, // 👈 pass to next screen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D4ED8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleTypeCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const VehicleTypeCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.maxFinite,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF1D4ED8) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected ? [
            BoxShadow(
              color: const Color(0xFF1D4ED8).withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Stack(
          children: [
            // Text and Radio Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  // Radio Indicator
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF1D4ED8) : Colors.black,
                        width: 1.5,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1D4ED8),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                        : null,
                  ),
                ],
              ),
            ),

            // Image positioning
            Positioned(
              right: -10, // Slight negative offset for that modern look
              bottom: 10,
              child: Image.asset(
                imagePath,
                height: 110,
                width: 180,
                fit: BoxFit.contain,
                // Fallback for missing images
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}