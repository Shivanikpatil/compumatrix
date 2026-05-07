import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/vehicle_card.dart';
import '../../providers/vehicle_provider.dart';
import 'add_vehicle_type_screen.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleProvider>().fetchVehicles();
    });
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
          'My Vehicles',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<VehicleProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: provider.isLoading && provider.vehicles.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : provider.vehicles.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey),
                                const SizedBox(height: 16),
                                Text(
                                  'No vehicles added yet',
                                  style: GoogleFonts.poppins(color: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(24),
                            itemCount: provider.vehicles.length,
                            itemBuilder: (context, index) {
                              final vehicle = provider.vehicles[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: VehicleCard(
                                  name: vehicle.vehicleName,
                                  regNo: vehicle.regNo,
                                  imageUrl: vehicle.imageUrl,
                                  onDelete: () async {
                                    final confirmed = await _showDeleteDialog(context);
                                    if (confirmed == true) {
                                      provider.deleteVehicle(vehicle.id);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: CustomButton(
                  text: 'Add New Vehicle',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddVehicleTypeScreen()),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Vehicle'),
        content: const Text('Are you sure you want to delete this vehicle?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
