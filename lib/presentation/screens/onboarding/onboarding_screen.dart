// lib/presentation/screens/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      image: 'assets/images/car_wash.png',
      title: 'Professional\nCleaning, Simplified',
      titleHighlight: 'Professional',
      description:
          'Book vehicle and professional cleaning services managed end-to-end by a verified system, no guesswork, no compromises.',
    ),
    _OnboardingData(
      image: 'assets/images/live_tracking.png',
      title: 'Live Tracking &\nTransparency',
      titleHighlight: 'Live Tracking',
      description:
          'From booking to completion, track your service in real time and view verified before-and-after proof.',
    ),
    _OnboardingData(
      image: 'assets/images/quality.png',
      title: 'Quality You Can Trust\nand Validate',
      titleHighlight: 'Quality',
      description:
          'Every job is assigned, monitored, and validated by an admin-controlled system to ensure quality and reliable service.',
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
          ),
          Positioned(
            top: 50, right: 20,
            child: TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
              child: const Text('Skip', style: TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            bottom: 40, left: 24, right: 24,
            child: Column(
              children: [
                // Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pages.length, (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == i ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentPage == i ? AppColors.badgeYellow : Colors.white54,
                    ),
                  )),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
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

class _OnboardingData {
  final String image, title, titleHighlight, description;
  const _OnboardingData({
    required this.image, required this.title,
    required this.titleHighlight, required this.description,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0xFF1F5FFF), Color(0xFF0A2FCC)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Image.asset(data.image, height: 280, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported, size: 280, color: Colors.white54);
              }),
              const SizedBox(height: 32),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  children: _buildHighlightedText(data.title, data.titleHighlight),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                data.description,
                style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildHighlightedText(String title, String highlight) {
    final idx = title.indexOf(highlight);
    if (idx == -1) return [TextSpan(text: title)];
    return [
      if (idx > 0) TextSpan(text: title.substring(0, idx)),
      TextSpan(text: highlight, style: const TextStyle(color: Color(0xFFFFC107))),
      TextSpan(text: title.substring(idx + highlight.length)),
    ];
  }
}
