// lib/presentation/screens/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';

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
      title: 'Professional Cleaning, Simplified',
      titleHighlight: 'Professional',
      description:
      'Book vehicle and professional cleaning services managed end-to-end by a verified system no guesswork, no compromises.',
    ),
    _OnboardingData(
      image: 'assets/images/live_tracking.png',
      title: 'Live Tracking & Transparency',
      titleHighlight: 'Live Tracking',
      description:
      'From booking to completion, track your service in real time and view verified before-and-after proof.',
    ),
    _OnboardingData(
      image: 'assets/images/Quality You Can Trust and Validate',
      titleHighlight: 'Quality',
      description:
      'Every job is assigned, monitored, and validated by an admin-controlled system to ensure quality and reliable service.', title: '',
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D4ED8), // Brand Blue
      body: Stack(
        children: [
          // Background UI / Image Area
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (_, i) => _OnboardingHeader(data: _pages[i]),
          ),

          // Skip Button
          Positioned(
            top: 60,
            right: 20,
            child: TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),

          // Bottom Content Card (The White Area)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.42,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with highlights
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                        height: 1.2,
                      ),
                      children: _buildTitleSpans(_pages[_currentPage]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Text(
                    _pages[_currentPage].description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  // Dot Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentPage == i
                              ? const Color(0xFFFFD700) // Gold/Yellow
                              : Colors.grey.shade300,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  // Button
                  ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

  List<TextSpan> _buildTitleSpans(_OnboardingData data) {
    final title = data.title;
    final highlight = data.titleHighlight;
    final idx = title.indexOf(highlight);

    if (idx == -1) return [TextSpan(text: title)];

    return [
      TextSpan(
        text: title.substring(0, idx + highlight.length),
        style: const TextStyle(color: Color(0xFF1D4ED8)),
      ),
      TextSpan(text: title.substring(idx + highlight.length)),
    ];
  }
}

class _OnboardingHeader extends StatelessWidget {
  final _OnboardingData data;
  const _OnboardingHeader({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 100),
      child: Image.asset(
        data.image,
        height: MediaQuery.of(context).size.height * 0.35,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(
          Icons.image_outlined,
          size: 200,
          color: Colors.white24,
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String image, title, titleHighlight, description;
  const _OnboardingData({
    required this.image,
    required this.title,
    required this.titleHighlight,
    required this.description,
  });
}