import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

enum LogoAnimationStyle { splash, auth, inline, none }

/// ===============================================================
/// ALPHA LOGO PREMIUM SYSTEM
/// ===============================================================

class AlphaLogoFX extends StatefulWidget {
  final Widget child;
  final LogoAnimationStyle style;
  final Duration delay;

  const AlphaLogoFX({
    super.key,
    required this.child,
    required this.style,
    this.delay = Duration.zero,
  });

  @override
  State<AlphaLogoFX> createState() => _AlphaLogoFXState();
}

class _AlphaLogoFXState extends State<AlphaLogoFX>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _energyController;
  late final AnimationController _shineController;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.style == LogoAnimationStyle.splash
            ? 1800
            : widget.style == LogoAnimationStyle.auth
            ? 900
            : 420,
      ),
    );

    _energyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    Future.delayed(widget.delay, () {
      if (!mounted) return;

      _mainController.forward();

      if (widget.style == LogoAnimationStyle.auth) {
        _energyController.repeat(reverse: true);
        _startShineLoop();
      }

      if (widget.style == LogoAnimationStyle.splash) {
        _energyController.forward();
        _shineController.forward();
      }
    });
  }

  Future<void> _startShineLoop() async {
    while (mounted) {
      await Future.delayed(const Duration(milliseconds: 3200));

      if (!mounted) return;

      await _shineController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _energyController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.style) {
      case LogoAnimationStyle.splash:
        return _buildSplash();

      case LogoAnimationStyle.auth:
        return _buildAuth();

      case LogoAnimationStyle.inline:
        return _buildInline();

      case LogoAnimationStyle.none:
        return widget.child;
    }
  }

  // =============================================================
  // SPLASH
  // =============================================================

  Widget _buildSplash() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _mainController,
        _energyController,
        _shineController,
      ]),
      child: widget.child,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(_mainController.value);

        final energy = Curves.easeInOut.transform(_energyController.value);

        final shine = _shineController.value;

        final scale = Tween<double>(
          begin: 0.72,
          end: 1.0,
        ).transform(Curves.easeOutBack.transform(t));

        final opacity = Curves.easeOut.transform((t * 1.25).clamp(0.0, 1.0));

        final blur = Tween<double>(
          begin: 18,
          end: 0,
        ).transform(Curves.easeOutCubic.transform(t));

        final redIntensity = (1 - t) * 0.65 + energy * 0.15;

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // RED ENERGY AURA
                  _logoGlow(
                    child: child!,
                    opacity: redIntensity,
                    blur: 35 + (energy * 20),
                  ),

                  // MAIN LOGO
                  child,

                  // METALLIC LIGHT
                  _logoShine(child: child, progress: shine, intensity: 0.75),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =============================================================
  // AUTH
  // =============================================================

  Widget _buildAuth() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _mainController,
        _energyController,
        _shineController,
      ]),
      child: widget.child,
      builder: (context, child) {
        final entrance = Curves.easeOutBack.transform(_mainController.value);

        final energy = Curves.easeInOut.transform(_energyController.value);

        final shine = _shineController.value;

        final scale = Tween<double>(begin: 0.88, end: 1.0).transform(entrance);

        // VERY subtle 3D movement
        final rotationY = (energy - 0.5) * 0.025;

        final rotationX = (0.5 - energy) * 0.015;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0012)
            ..rotateX(rotationX)
            ..rotateY(rotationY)
            ..scale(scale),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // REACTOR GLOW
              _logoGlow(
                child: child!,
                opacity: 0.12 + (energy * 0.18),
                blur: 20 + (energy * 25),
              ),

              // ORIGINAL LOGO
              child,

              // PERIODIC METALLIC SWEEP
              _logoShine(child: child, progress: shine, intensity: 0.55),
            ],
          ),
        );
      },
    );
  }

  // =============================================================
  // INLINE
  // =============================================================

  Widget _buildInline() {
    return AnimatedBuilder(
      animation: _mainController,
      child: widget.child,
      builder: (context, child) {
        final t = Curves.easeOutBack.transform(_mainController.value);

        final scale = Tween<double>(begin: 0.82, end: 1.0).transform(t);

        final opacity = Curves.easeOutCubic.transform(_mainController.value);

        return Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _logoGlow(
                  child: child!,
                  opacity: 0.12 * _mainController.value,
                  blur: 14,
                ),
                child,
              ],
            ),
          ),
        );
      },
    );
  }

  // =============================================================
  // LOGO GLOW
  // =============================================================

  Widget _logoGlow({
    required Widget child,
    required double opacity,
    required double blur,
  }) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Opacity(
        opacity: opacity,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            const Color(0xFFFF0000),
            BlendMode.srcIn,
          ),
          child: child,
        ),
      ),
    );
  }

  // =============================================================
  // METALLIC SHINE
  // =============================================================

  Widget _logoShine({
    required Widget child,
    required double progress,
    required double intensity,
  }) {
    if (progress <= 0) {
      return const SizedBox.shrink();
    }

    final position = -1.5 + (progress * 4.0);

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        final start = position;
        final end = position + 0.22;

        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [
            0.0,
            ((start + 1) / 2).clamp(0.0, 1.0),
            ((end + 1) / 2).clamp(0.0, 1.0),
            1.0,
          ],
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.white.withValues(alpha: intensity),
            Colors.transparent,
          ],
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
