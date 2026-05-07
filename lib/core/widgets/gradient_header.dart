import 'package:flutter/material.dart';

class GradientHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final VoidCallback? onBackTap;
  final double heightFactor;

  const GradientHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.onBackTap,
    this.heightFactor = 0.35,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 200,
        maxHeight: screenHeight * heightFactor,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2155FF), Color(0xFF0033BB)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (onBackTap != null)
                GestureDetector(
                  onTap: onBackTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                  ),
                ),
              const Spacer(),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
              ),
              if (subtitle != null || subtitleWidget != null) ...[
                const SizedBox(height: 12),
                if (subtitleWidget != null)
                  subtitleWidget!
                else
                  Text(
                    subtitle!,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
