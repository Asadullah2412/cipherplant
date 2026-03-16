import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SubtitleManager {
  static final SubtitleManager _instance = SubtitleManager._internal();
  factory SubtitleManager() => _instance;
  SubtitleManager._internal();

  OverlayEntry? _currentOverlay;

  void show(BuildContext context, List<String> lines) {
    _remove(); // Clean up existing subtitle if active

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    _currentOverlay = OverlayEntry(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark ? Colors.white : Colors.black;
        final bgColor = isDark
            ? const Color.fromRGBO(0, 0, 0, 0.1) // Subtle black
            : const Color.fromRGBO(255, 255, 255, 0.25); // Subtle white
        final shadowColor = isDark
            ? const Color.fromRGBO(0, 0, 0, 0.15)
            : const Color.fromRGBO(100, 100, 100, 0.08);

        return Positioned.fill(
          child: IgnorePointer(
            ignoring: true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: bgColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 24.0),
                margin: const EdgeInsets.only(bottom: 40),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 18,
                    color: textColor,
                    fontWeight: FontWeight.w300,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: shadowColor,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: lines
                        .map((line) => TyperAnimatedText(
                              line,
                              speed: const Duration(milliseconds: 50),
                            ))
                        .toList(),
                    onFinished: () {
                      _remove();
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_currentOverlay!);
  }

  void _remove() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }
}
