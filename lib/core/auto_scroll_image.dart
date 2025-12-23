import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AutoScrollImage extends StatefulWidget {
  const AutoScrollImage({super.key});

  @override
  _AutoScrollImageState createState() => _AutoScrollImageState();
}

class _AutoScrollImageState extends State<AutoScrollImage> {

  final ScrollController _scrollController = ScrollController();
  final int itemCount = 11;
  final double itemWidth = 116.0; // itemWidth (100) + margin (8*2) = 116
  final Duration autoScrollDuration = const Duration(milliseconds: 50);
  Timer? _timer;
  bool scrollingRight = true;

  @override
  void initState() {
    super.initState();
    // Delay to ensure the ListView is built and scroll controller is attached
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Additional delay for web to ensure scroll controller is ready
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            startAutoScroll();
          }
        });
      }
    });
  }

  void startAutoScroll() {
    _timer?.cancel(); // Cancel any existing timer
    
    _timer = Timer.periodic(autoScrollDuration, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      if (_scrollController.hasClients) {
        try {
          double maxScrollExtent = _scrollController.position.maxScrollExtent;
          double currentPosition = _scrollController.position.pixels;
          
          // Check if we can scroll
          if (maxScrollExtent <= 0) {
            // Content doesn't overflow, try scrolling anyway
            if (scrollingRight) {
              _scrollController.jumpTo(currentPosition + 2);
            } else {
              if (currentPosition > 0) {
                _scrollController.jumpTo(currentPosition - 2);
              } else {
                scrollingRight = true;
              }
            }
            return;
          }
          
          double targetPosition;
          if (scrollingRight) {
            targetPosition = currentPosition + 2;
            if (targetPosition >= maxScrollExtent) {
              // Reached the end, change direction
              scrollingRight = false;
              targetPosition = maxScrollExtent;
            }
          } else {
            targetPosition = currentPosition - 2;
            if (targetPosition <= 0) {
              // Reached the start, change direction
              scrollingRight = true;
              targetPosition = 0;
            }
          }

          // Clamp to valid range
          targetPosition = targetPosition.clamp(0.0, maxScrollExtent);
          
          // Use jumpTo for smoother continuous scrolling on web
          if (kIsWeb) {
            _scrollController.jumpTo(targetPosition);
          } else {
            _scrollController.animateTo(
              targetPosition,
              duration: autoScrollDuration,
              curve: Curves.linear,
            );
          }
        } catch (e) {
          // Handle any errors silently
          timer.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.0,
      width: double.infinity, // Ensure full width on web
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        shrinkWrap: false,
        physics: const AlwaysScrollableScrollPhysics(), // Enable scrolling on web
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // Use different images for each item
          String imagePath =
              'assets/scroller_images/image_$index.png'; // Adjust the image path

          return Container(
            width: itemWidth,
            margin: const EdgeInsets.all(8.0),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 80.0, // Adjust the width as needed
                height: 80.0, // Adjust the height as needed
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Return empty container if image fails to load
                  return const SizedBox(width: 80.0, height: 80.0);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
