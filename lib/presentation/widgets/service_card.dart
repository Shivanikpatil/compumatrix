// lib/widgets/service_card.dart

import 'package:flutter/material.dart';
import '../../data/models/service_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: service.serviceImages.isNotEmpty
                    ? Image.network(
                        'https://wa-peke-api.demohub.tech/${service.serviceImages.first}',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(),
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return _buildPlaceholder();
                        },
                      )
                    : _buildPlaceholder(),
              ),
              // Fixed Price badge
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5C518),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    service.priceType == 'fixed' ? 'Fixed price' : 'Quote',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7A5A00),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Card body
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  service.serviceTitle,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A2A3A),
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Price + Duration row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F1FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '₹${service.price.toInt()}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 10,
                          color: Color(0xFF5A7090),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          service.duration,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF5A7090),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Book Now button
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {},
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: const Color(0xFF1565C0),
                    //   foregroundColor: Colors.white,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   elevation: 0,
                    // ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF1565C0),
                        borderRadius: BorderRadius.circular(20)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                fontSize: 11,color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Container(
                            width: 16,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_outward_rounded,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
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

  Widget _buildPlaceholder() {
    return Container(
      height: 110,
      width: double.infinity,
      color: const Color(0xFFD8E8F5),
      child: const Icon(
        Icons.home_repair_service_rounded,
        size: 36,
        color: Color(0xFF8AADCC),
      ),
    );
  }
}
