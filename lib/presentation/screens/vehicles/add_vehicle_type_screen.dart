// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../core/widgets/custom_button.dart';
// import 'add_vehicle_details_screen.dart';
//
// class AddVehicleTypeScreen extends StatefulWidget {
//   const AddVehicleTypeScreen({super.key});
//
//   @override
//   State<AddVehicleTypeScreen> createState() => _AddVehicleTypeScreenState();
// }
//
// class _AddVehicleTypeScreenState extends State<AddVehicleTypeScreen> {
//   String _selectedType = 'Four Wheeler';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Add New Vehicle',
//           style: GoogleFonts.poppins(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose Vehicle Type',
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF1D1D1D),
//               ),
//             ),
//             const SizedBox(height: 24),
//             _buildTypeCard('Four Wheeler', Icons.directions_car, 'assets/images/car_type.png'),
//             const SizedBox(height: 16),
//             _buildTypeCard('Two Wheeler', Icons.motorcycle, 'assets/images/bike_type.png'),
//             const Spacer(),
//             CustomButton(
//               text: 'Continue',
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AddVehicleDetailsScreen(vehicleType: _selectedType),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTypeCard(String type, IconData icon, String imagePath) {
//     bool isSelected = _selectedType == type;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedType = type),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: isSelected ? const Color(0xFF2155FF) : const Color(0xFFF5F7FA),
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.02),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Radio<String>(
//               value: type,
//               groupValue: _selectedType,
//               activeColor: const Color(0xFF2155FF),
//               onChanged: (value) {
//                 setState(() => _selectedType = value!);
//               },
//             ),
//             const SizedBox(width: 8),
//             Text(
//               type,
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: const Color(0xFF1D1D1D),
//               ),
//             ),
//             const Spacer(),
//             Icon(icon, size: 60, color: isSelected ? const Color(0xFF2155FF) : Colors.grey.shade300),
//           ],
//         ),
//       ),
//     );
//   }
// }
