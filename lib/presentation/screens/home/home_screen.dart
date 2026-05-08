// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/service_provider.dart';
import '../../widgets/service_card.dart';
import '../../widgets/shimmer_card.dart';
import '../vehicles/vehicle_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ── Hero header ──────────────────────────────────────────
            _buildHeroHeader(),

            // ── Tabs ─────────────────────────────────────────────────
            _buildTabs(),

            // ── Scrollable content ───────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildActiveServicesSection(),
                    const SizedBox(height: 16),
                    _buildComingSoonSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom navigation bar ─────────────────────────────────────
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─── HERO HEADER ────────────────────────────────────────────────────────────
  Widget _buildHeroHeader() {
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyVehiclesScreen()));
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFCCE8FF), Color(0xFFE0F0FF), Color(0xFFF5FAFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Column(
          children: [
            // User row
            Row(
              children: [
                // Avatar
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFB0C8E8),
                  ),
                  child: const Center(
                    child: Text(
                      'JS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2A5080),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Name & location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jack Sparrow',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A2A3A),
                        ),
                      ),
                      Row(
                        children: const [
                          Text(
                            'Nanded, Pune Division, Pune',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF4A6080),
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 14,
                            color: Color(0xFF4A6080),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bell
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.notifications_outlined,
                    size: 20,
                    color: Color(0xFF4A6080),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFD0DBE8), width: 0.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              child: Row(
                children: const [
                  Icon(Icons.search_rounded, size: 18, color: Color(0xFF8A9BB0)),
                  SizedBox(width: 8),
                  Text(
                    'Search services car wash, sofa cleaning',
                    style: TextStyle(fontSize: 12, color: Color(0xFF8A9BB0)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── TABS ────────────────────────────────────────────────────────────────────
  Widget _buildTabs() {
    return Consumer<ServiceProvider>(
      builder: (context, provider, _) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: [
              _buildTabButton(
                label: 'Fixed Price',
                icon: Icons.work_outline_rounded,
                index: 0,
                selectedIndex: provider.selectedTab,
                onTap: () => provider.setTab(0),
              ),
              const SizedBox(width: 10),
              _buildTabButton(
                label: 'Get a Quote',
                icon: Icons.description_outlined,
                index: 1,
                selectedIndex: provider.selectedTab,
                onTap: () => provider.setTab(1),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabButton({
    required String label,
    required IconData icon,
    required int index,
    required int selectedIndex,
    required VoidCallback onTap,
  }) {
    final bool isActive = index == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1565C0) : const Color(0xFFF0F4F8),
          borderRadius: BorderRadius.circular(20),
          border: isActive
              ? null
              : Border.all(color: const Color(0xFFD0DBE8), width: 0.5),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 15, color: isActive ? Colors.white : const Color(0xFF4A6080)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF4A6080),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── ACTIVE SERVICES ─────────────────────────────────────────────────────────
  Widget _buildActiveServicesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Services',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2A3A),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Grid
          Consumer<ServiceProvider>(
            builder: (context, provider, _) {
              if (provider.status == ServiceStatus.loading) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (_, __) => const ShimmerCard(),
                );
              }

              if (provider.status == ServiceStatus.error) {
                return _buildErrorWidget(provider.errorMessage, () {
                  provider.fetchServices();
                });
              }

              if (provider.services.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No services available',
                      style: TextStyle(color: Color(0xFF8A9BB0)),
                    ),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  return ServiceCard(service: provider.services[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── COMING SOON ─────────────────────────────────────────────────────────────
  Widget _buildComingSoonSection() {
    final comingSoon = [
      {'title': 'Home Deep Cleaning', 'price': '₹1,299', 'icon': Icons.home_outlined},
      {'title': 'Window & Glass Cleaning', 'price': '₹499', 'icon': Icons.window_outlined},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Coming Soon Services',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2A3A),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comingSoon.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (_, i) {
              final item = comingSoon[i];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14)),
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            color: const Color(0xFFE8F0F8),
                            child: Icon(
                              item['icon'] as IconData,
                              size: 40,
                              color: const Color(0xFF8AADCC),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Coming Soon',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFB85C00),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A2A3A),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item['price'] as String,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1565C0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ─── ERROR WIDGET ─────────────────────────────────────────────────────────────
  Widget _buildErrorWidget(String message, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: Color(0xFFB0C0D0)),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF5A7090),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  // ─── BOTTOM NAV ───────────────────────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      Icons.home_rounded,
      Icons.calendar_month_outlined,
      Icons.credit_card_outlined,
      Icons.person_outline_rounded,
    ];

    return SafeArea(
      child: Container(
        height: 64,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE0E8F0), width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final bool isActive = i == _currentNavIndex;
            return GestureDetector(
              onTap: () => setState(() => _currentNavIndex = i),
              child: isActive
                  ? Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1565C0),
                ),
                child: Icon(items[i], color: Colors.white, size: 22),
              )
                  : Icon(items[i],
                  color: const Color(0xFF8A9BB0), size: 22),
            );
          }),
        ),
      ),
    );
  }
}
