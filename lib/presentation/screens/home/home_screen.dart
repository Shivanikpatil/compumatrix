// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/constants/app_colors.dart';
import '../../providers/service_provider.dart';
import '../../providers/home_provider.dart';
import '../profile/profile_screen.dart';
import '../vehicles/vehicle_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: homeProvider.currentIndex,
        children: [
          const HomeTab(),
          const Center(child: Text('Bookings Coming Soon')),
          const Center(child: Text('Wallet Coming Soon')),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(
        currentIndex: homeProvider.currentIndex,
        onTap: homeProvider.setIndex,
      ),
    );
  }
}

// ──────────────────────────────────────────────
// CUSTOM BOTTOM NAV — matches design (home has floating blue circle)
// ──────────────────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const items = [
      _NavItem(icon: Icons.home_rounded, label: 'Home'),
      _NavItem(icon: Icons.calendar_month_outlined, label: 'Bookings'),
      _NavItem(icon: Icons.account_balance_wallet_outlined, label: 'Wallet'),
      _NavItem(icon: Icons.person_outline_rounded, label: 'Profile'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 72,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Home tab gets the floating blue circle
                      if (i == 0)
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            items[i].icon,
                            color: selected ? Colors.white : AppColors.textSecondary,
                            size: 24,
                          ),
                        )
                      else ...[
                        Icon(
                          items[i].icon,
                          color: selected ? AppColors.primary : AppColors.textSecondary,
                          size: 24,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          items[i].label,
                          style: TextStyle(
                            fontSize: 10,
                            color: selected ? AppColors.primary : AppColors.textSecondary,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

// ──────────────────────────────────────────────
// HOME TAB — main content
// ──────────────────────────────────────────────
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Gradient header section (teal bubble bg) ──
          _buildGradientHeader(context),

          const SizedBox(height: 16),

          // ── Fixed Price / Get a Quote tabs ──
          _buildTabs(serviceProvider),

          const SizedBox(height: 8),

          // ── Active Services 2-column grid ──
          _buildActiveServices(context, serviceProvider),

          const SizedBox(height: 8),

          // ── Coming Soon ──
          _buildComingSoon(),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ── GRADIENT HEADER WITH BUBBLES ──────────────────
  Widget _buildGradientHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5DB8C8), Color(0xFF8FD3E0), Color(0xFFB8E8F0)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative bubbles
          ..._buildBubbles(),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                children: [
                  // User row
                  Row(
                    children: [
                      // Avatar
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: AppColors.primary,
                        ),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primary,
                          // Replace with: backgroundImage: NetworkImage(userPhotoUrl)
                          child: Text(
                            'JS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Name + location
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jack Sparrow',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: const [
                                Icon(Icons.location_on, size: 12, color: Colors.white),
                                SizedBox(width: 2),
                                Flexible(
                                  child: Text(
                                    'Nanded, Pune Division, Pune',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Bell button
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search bar
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Color(0xFF8A8A9A), size: 20),
                        hintText: 'Search services car wash, sofa cleaning',
                        hintStyle: TextStyle(color: Color(0xFF8A8A9A), fontSize: 13),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Decorative floating bubbles for the header
  List<Widget> _buildBubbles() {
    return [
      _bubble(top: -20, right: 40, size: 80, opacity: 0.15),
      _bubble(top: 10, right: -10, size: 60, opacity: 0.12),
      _bubble(top: 60, right: 60, size: 40, opacity: 0.10),
      _bubble(top: 20, left: -15, size: 50, opacity: 0.10),
      _bubble(bottom: 10, right: 30, size: 30, opacity: 0.12),
      _bubble(bottom: -10, left: 80, size: 45, opacity: 0.08),
    ];
  }

  Widget _bubble({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required double opacity,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(opacity * 3),
            width: 1.5,
          ),
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }

  // ── TABS ────────────────────────────────────────
  Widget _buildTabs(ServiceProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _TabChip(
            label: 'Fixed Price',
            icon: Icons.directions_car_rounded,
            isSelected: provider.selectedTab == 0,
            onTap: () => provider.setTab(0),
          ),
          const SizedBox(width: 12),
          _TabChip(
            label: 'Get a Quote',
            icon: Icons.receipt_long_outlined,
            isSelected: provider.selectedTab == 1,
            onTap: () => provider.setTab(1),
          ),
        ],
      ),
    );
  }

  // ── ACTIVE SERVICES GRID ─────────────────────────
  Widget _buildActiveServices(BuildContext context, ServiceProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Services',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        if (provider.isLoading)
          _buildShimmerGrid()
        else if (provider.services.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(child: Text('No active services found.')),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: provider.services.length,
              itemBuilder: (context, index) {
                final service = provider.services[index];
                return _ServiceCard(service: service);
              },
            ),
          ),
      ],
    );
  }

  // Shimmer placeholder while loading
  Widget _buildShimmerGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,
        ),
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // ── COMING SOON ──────────────────────────────────
  Widget _buildComingSoon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Coming Soon Services',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8E8F0)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.home_repair_service, color: AppColors.primary, size: 22),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Home Deep Cleaning',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// SERVICE CARD — matches the Figma card design
// ──────────────────────────────────────────────
class _ServiceCard extends StatelessWidget {
  final dynamic service; // Replace with your ServiceModel type

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image with "Fixed price" badge overlay ──
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: service.serviceImages.isNotEmpty
                      ? service.serviceImages.first
                      : '',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey[200],
                    child: const Icon(Icons.directions_car, color: Colors.grey, size: 36),
                  ),
                ),
              ),
              // Fixed price badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Fixed price',
                    style: TextStyle(
                      color: Color(0xFF7A5500),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Card content ──
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title
                  Text(
                    service.serviceTitle ?? 'Service',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: Color(0xFF1A1A2E),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Price + Duration chips
                  Row(
                    children: [
                      _InfoChip(label: 'CFA ${service.price ?? "156"}'),
                      const SizedBox(width: 6),
                      _InfoChip(label: service.duration ?? '30–40 Mins'),
                    ],
                  ),

                  // Book Now button
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: navigate to booking
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Text(
                        'Book Now',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      label: const Icon(Icons.arrow_outward_rounded, size: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Pill chip for price/duration info
class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFF5A5A6E),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// TAB CHIP — Fixed Price / Get a Quote
// ──────────────────────────────────────────────
class _TabChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppColors.primary : const Color(0xFF8A8A9A),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? AppColors.primary : const Color(0xFF8A8A9A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (isSelected)
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}