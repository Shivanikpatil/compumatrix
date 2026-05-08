import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../generated/assets.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ─── PRIMARY BRAND COLORS ────────────────────────────────────────────────
  static const Color kBlue   = Color(0xFF0055FF);
  static const Color kYellow = Color(0xFFFFD600);

  // ─── ONBOARDING DATA ─────────────────────────────────────────────────────
  // Replace imagePath values with your actual asset paths, e.g.
  //   'assets/images/onboarding_1.png'
  final List<OnboardingData> _pages = [
    OnboardingData(
      highlightedTitle: 'Professional',
      restTitle: '\nCleaning, Simplified',
      description:
      'Book vehicle and professional cleaning services managed end-to-end '
          'by a verified system — no guesswork, no compromises.',
      imagePath: Assets.images.img1.path, // 🔁 replace with your image
    ),
    OnboardingData(
      highlightedTitle: 'Live Tracking',
      restTitle: ' &\nTransparency',
      description:
      'From booking to completion, track your service in real time and '
          'view verified before-and-after proof.',
      imagePath: Assets.images.img2.path, // 🔁 replace with your image
    ),
    OnboardingData(
      highlightedTitle: 'Quality',
      restTitle: ' You Can Trust\nand Validate',
      description:
      'Every job is assigned, monitored, and validated by an admin-controlled '
          'system to ensure quality and reliable service.',
      imagePath: Assets.images.img1.path, // 🔁 replace with your image
    ),
  ];

  // ─── BUILD ────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Swipeable pages
          PageView.builder(
            controller: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page),
            itemCount: _pages.length,
            itemBuilder: (ctx, i) => _buildPage(_pages[i]),
          ),

          // ── Skip button (top-right)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 20,
            child: TextButton(
              onPressed: _completeOnboarding,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              child: const Text('Skip'),
            ),
          ),

          // ── Bottom controls (dots + button)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 28,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                        (i) => _buildDot(i),
                  ),
                ),
                const SizedBox(height: 28),

                // Next / Get Started button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
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

  // ─── SINGLE PAGE ──────────────────────────────────────────────────────────
  Widget _buildPage(OnboardingData data) {
    return Column(
      children: [
        // ── Top illustration area (blue with blob bottom)
        Expanded(
          flex: 58,
          child: ClipPath(
            clipper: _BlobClipper(),
            child: Container(
              width: double.infinity,
              color: kBlue,
              child: Padding(
                // Push image away from the status bar
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 60,
                  bottom: 40,
                ),
                child: _OnboardingImage(path: data.imagePath),
              ),
            ),
          ),
        ),

        // ── Bottom text area
        Expanded(
          flex: 42,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),

                // Mixed-colour title
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                    ),
                    children: [
                      TextSpan(
                        text: data.highlightedTitle,
                        style: const TextStyle(color: kBlue),
                      ),
                      TextSpan(
                        text: data.restTitle,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Description
                Text(
                  data.description,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey[500],
                    height: 1.6,
                  ),
                ),

                // Spacer so button sits at bottom
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── INDICATOR DOT ────────────────────────────────────────────────────────
  Widget _buildDot(int index) {
    final bool isActive = index == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      height: 8,
      width: isActive ? 24 : 8,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isActive ? kYellow : Colors.grey[300],
      ),
    );
  }

  // ─── NAVIGATION ───────────────────────────────────────────────────────────
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }
}

// ─── BLOB CLIPPER ─────────────────────────────────────────────────────────────
// Creates the organic curved bottom edge on the blue illustration area.
class _BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);

    // Left curve dipping down then rising
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height + 20,
      size.width * 0.5,
      size.height - 20,
    );

    // Right curve rising back up
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 70,
      size.width,
      size.height - 10,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_BlobClipper _) => false;
}

// ─── ILLUSTRATION WIDGET ──────────────────────────────────────────────────────
// Shows your asset image; falls back to a placeholder icon while not yet set.
class _OnboardingImage extends StatelessWidget {
  const _OnboardingImage({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    // Once you've added real assets, replace the body with just:
    //   return Image.asset(path, fit: BoxFit.contain);
    return Image.asset(
      path,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const _PlaceholderIllustration(),
    );
  }
}

// Placeholder shown when the image asset isn't found yet.
class _PlaceholderIllustration extends StatelessWidget {
  const _PlaceholderIllustration();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.local_car_wash_rounded,
            size: 90,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Add your illustration here',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ─── DATA MODEL ───────────────────────────────────────────────────────────────
class OnboardingData {
  final String highlightedTitle; // shown in blue
  final String restTitle;        // shown in black (include \n if needed)
  final String description;
  final String imagePath;

  const OnboardingData({
    required this.highlightedTitle,
    required this.restTitle,
    required this.description,
    required this.imagePath,
  });
}