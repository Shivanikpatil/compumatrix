import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/home_provider.dart';
import '../services/active_services_screen.dart';
import '../vehicles/vehicle_list_screen.dart';
import 'home_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    ActiveServicesScreen(),
    VehicleListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: homeProvider.currentIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 30,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(context, homeProvider, 1, Icons.miscellaneous_services_outlined, 'Services'),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(context, homeProvider, 2, Icons.directions_car_outlined, 'Vehicles'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeProvider.setIndex(0),
        backgroundColor: const Color(0xFF2155FF),
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.home, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildNavItem(BuildContext context, HomeProvider provider, int index, IconData icon, String label) {
    bool isSelected = provider.currentIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => provider.setIndex(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2155FF) : Colors.grey,
              size: 26,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? const Color(0xFF2155FF) : Colors.grey,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
