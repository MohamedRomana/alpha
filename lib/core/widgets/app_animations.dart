import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';
import '../constants/colors.dart';
import 'app_input.dart';
import 'app_text.dart';

/// ============================================================================
/// app_animations.dart
///
/// A single reusable collection of general-purpose animations for any Flutter
/// app: entrance animations (fade / slide / scale), continuous effects
/// (pulse, shake, shimmer, floating, rotation, breathing), text animations
/// (typewriter, fade-in words, animated counter), background animations
/// (animated gradient), list / staggered animations, and animated switchers.
///
/// Everything here is dependency-free (pure Flutter) so it works in any project.
/// Sizes use `flutter_screenutil` (.h / .w / .sp) to stay responsive.
///
/// Quick reference:
///   • FadeIn / SlideIn / ScaleIn / FadeSlideScaleIn ... entrance
///   • RotateIn / FlipIn / BlurIn / ClipReveal / CircleReveal  entrance (extra)
///   • StaggeredColumn / StaggeredList / AnimatedListItem . lists
///   • StaggeredGridView ................................... grids
///   • Pulse / Shake / Floating / Breathing / Spin / Bounce  continuous
///   • Wiggle / HeartBeat .................................. continuous (extra)
///   • ShimmerLoading ....................................... skeleton loaders
///   • TypewriterText / FadeInText / AnimatedCounter ....... text
///   • ShinyText / WavyText / PopInText / BlurInText ....... text (extra)
///   • RotatingWords / HighlightedText / GradientText ...... text (extra)
///   • KenBurns / ShineSweep / Tilt3D ...................... images & cards
///   • FlipCard / PressLift / GradientBorderCard ........... cards
///   • AnimatedLogo / LogoShine / LogoGlow ................. logo
///   • AnimatedInput ....................................... fields (AppInput API)
///   • FocusAnimatedField / ShakeOnError / AnimatedErrorText  fields (generic)
///   • AnimatedUnderline ................................... fields (generic)
///   • ColorTransition / ColorLoop / ColorPulse ............ colours
///   • AnimatedGradientBox ................................. colours
///   • AnimatedGradientBackground .......................... backgrounds
///   • AppAnimatedSwitcher / AnimatedVisibility ............ transitions
///   • ExpandableSection ................................... expand / collapse
///   • `.fadeIn()` `.slideIn()` `.shine()` ... on any Widget  shorthand
///
/// ⚠️ Arabic note: animations that split text into letters break Arabic letter
/// joining. Word-level splitting is the default everywhere; only opt into
/// `byCharacter: true` for Latin text.
/// ============================================================================

/// Direction a widget travels from during a slide animation.
enum AnimDirection { bottom, top, left, right, none }

extension _DirectionOffset on AnimDirection {
  Offset toOffset(double distance) {
    switch (this) {
      case AnimDirection.bottom:
        return Offset(0, distance.h);
      case AnimDirection.top:
        return Offset(0, -distance.h);
      case AnimDirection.left:
        return Offset(-distance.w, 0);
      case AnimDirection.right:
        return Offset(distance.w, 0);
      case AnimDirection.none:
        return Offset.zero;
    }
  }
}

// ============================================================================
// ENTRANCE ANIMATIONS
// ============================================================================

/// Fades [child] in. Optionally delays the start (useful for staggering).
class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  const FadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 450),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
  });

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: widget.curve),
      child: widget.child,
    );
  }
}

/// Slides [child] in from [from] while fading in.
class SlideIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimDirection from;
  final double distance;
  final Curve curve;

  const SlideIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.from = AnimDirection.bottom,
    this.distance = 32,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<SlideIn> createState() => _SlideInState();
}

class _SlideInState extends State<SlideIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    final begin = widget.from.toOffset(widget.distance);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final t = anim.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(begin.dx * (1 - t), begin.dy * (1 - t)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Scales [child] up from [beginScale] while fading in.
class ScaleIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double beginScale;
  final Curve curve;
  final Alignment alignment;

  const ScaleIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 450),
    this.delay = Duration.zero,
    this.beginScale = 0.8,
    this.curve = Curves.easeOutBack,
    this.alignment = Alignment.center,
  });

  @override
  State<ScaleIn> createState() => _ScaleInState();
}

class _ScaleInState extends State<ScaleIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final t = anim.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: widget.beginScale + (1 - widget.beginScale) * t,
            alignment: widget.alignment,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Combines fade + slide + scale into one entrance animation.
/// The most flexible single-shot entrance in this file.
class FadeSlideScaleIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimDirection from;
  final double distance;
  final double beginScale;
  final Curve curve;

  const FadeSlideScaleIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 550),
    this.delay = Duration.zero,
    this.from = AnimDirection.bottom,
    this.distance = 30,
    this.beginScale = 0.95,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<FadeSlideScaleIn> createState() => _FadeSlideScaleInState();
}

class _FadeSlideScaleInState extends State<FadeSlideScaleIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    final begin = widget.from.toOffset(widget.distance);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final t = anim.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(begin.dx * (1 - t), begin.dy * (1 - t)),
            child: Transform.scale(
              scale: widget.beginScale + (1 - widget.beginScale) * t,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

// ============================================================================
// LIST / STAGGERED ANIMATIONS
// ============================================================================

/// Wraps children in a [Column] where each child animates in with an
/// increasing delay, producing a staggered "cascade" entrance.
class StaggeredColumn extends StatelessWidget {
  final List<Widget> children;
  final Duration itemDuration;
  final Duration stagger;
  final Duration initialDelay;
  final AnimDirection from;
  final double distance;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  const StaggeredColumn({
    super.key,
    required this.children,
    this.itemDuration = const Duration(milliseconds: 450),
    this.stagger = const Duration(milliseconds: 70),
    this.initialDelay = Duration.zero,
    this.from = AnimDirection.bottom,
    this.distance = 24,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: [
        for (int i = 0; i < children.length; i++)
          SlideIn(
            from: from,
            distance: distance,
            duration: itemDuration,
            delay: initialDelay + (stagger * i),
            child: children[i],
          ),
      ],
    );
  }
}

/// Drop-in animated [ListView.builder]: every item animates in as it is built.
///
/// Great for feeds, cards and lists. Pass the same [itemBuilder]/[itemCount]
/// you would give a normal ListView.
class StaggeredListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Duration itemDuration;
  final Duration stagger;
  final AnimDirection from;
  final double distance;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final ScrollController? controller;

  /// Items with an index >= this value animate with a fixed (non-growing)
  /// delay so long lists don't wait seconds for the last item.
  final int maxStaggerItems;

  const StaggeredListView.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemDuration = const Duration(milliseconds: 400),
    this.stagger = const Duration(milliseconds: 60),
    this.from = AnimDirection.bottom,
    this.distance = 24,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.maxStaggerItems = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      scrollDirection: scrollDirection,
      controller: controller,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final steps = math.min(index, maxStaggerItems);
        return SlideIn(
          from: from,
          distance: distance,
          duration: itemDuration,
          delay: stagger * steps,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

/// Wrap a single list item to animate it in. Handy when you already have a
/// ListView/GridView and only want to decorate its items.
class AnimatedListItem extends StatelessWidget {
  final int index;
  final Widget child;
  final Duration itemDuration;
  final Duration stagger;
  final AnimDirection from;
  final double distance;

  const AnimatedListItem({
    super.key,
    required this.index,
    required this.child,
    this.itemDuration = const Duration(milliseconds: 400),
    this.stagger = const Duration(milliseconds: 60),
    this.from = AnimDirection.bottom,
    this.distance = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SlideIn(
      from: from,
      distance: distance,
      duration: itemDuration,
      delay: stagger * index,
      child: child,
    );
  }
}

// ============================================================================
// CONTINUOUS / LOOPING ANIMATIONS
// ============================================================================

/// Gently scales [child] up and down forever (a "heartbeat").
/// Use for call-to-action buttons, badges, live indicators.
class Pulse extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minScale;
  final double maxScale;
  final bool animate;

  const Pulse({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 900),
    this.minScale = 0.97,
    this.maxScale = 1.06,
    this.animate = true,
  });

  @override
  State<Pulse> createState() => _PulseState();
}

class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _scale = Tween<double>(
    begin: widget.minScale,
    end: widget.maxScale,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant Pulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}

/// Shakes [child] horizontally. Trigger by toggling [trigger] to a new value
/// (e.g. an error counter). Perfect for invalid form fields.
class Shake extends StatefulWidget {
  final Widget child;
  final Object? trigger;
  final Duration duration;
  final double amplitude;
  final int shakes;

  const Shake({
    super.key,
    required this.child,
    this.trigger,
    this.duration = const Duration(milliseconds: 500),
    this.amplitude = 8,
    this.shakes = 4,
  });

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void didUpdateWidget(covariant Shake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final dx =
            math.sin(_controller.value * math.pi * widget.shakes) *
            widget.amplitude.w *
            (1 - _controller.value);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: widget.child,
    );
  }
}

/// Slowly floats [child] up and down forever. Nice for illustrations,
/// empty-state graphics and hero images.
class Floating extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double distance;

  const Floating({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2600),
    this.distance = 10,
  });

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat(reverse: true);
  late final Animation<double> _anim = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final dy = (_anim.value - 0.5) * 2 * widget.distance.h;
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: widget.child,
    );
  }
}

/// Fades opacity in and out forever (a soft "breathing" glow).
class Breathing extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minOpacity;
  final double maxOpacity;

  const Breathing({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1400),
    this.minOpacity = 0.35,
    this.maxOpacity = 1.0,
  });

  @override
  State<Breathing> createState() => _BreathingState();
}

class _BreathingState extends State<Breathing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat(reverse: true);
  late final Animation<double> _opacity = Tween<double>(
    begin: widget.minOpacity,
    end: widget.maxOpacity,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _opacity, child: widget.child);
  }
}

/// Rotates [child] continuously. Use for loaders, sync icons, spinners.
class Spin extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool clockwise;

  const Spin({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1200),
    this.clockwise = true,
  });

  @override
  State<Spin> createState() => _SpinState();
}

class _SpinState extends State<Spin> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: widget.clockwise ? _controller : ReverseAnimation(_controller),
      child: widget.child,
    );
  }
}

/// Bounces [child] once on first build (or when [trigger] changes).
class Bounce extends StatefulWidget {
  final Widget child;
  final Object? trigger;
  final Duration duration;
  final double strength;

  const Bounce({
    super.key,
    required this.child,
    this.trigger,
    this.duration = const Duration(milliseconds: 600),
    this.strength = 0.25,
  });

  @override
  State<Bounce> createState() => _BounceState();
}

class _BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  late final Animation<double> _scale = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(begin: 1.0, end: 1.0 + widget.strength),
      weight: 40,
    ),
    TweenSequenceItem(
      tween: Tween(begin: 1.0 + widget.strength, end: 1.0),
      weight: 60,
    ),
  ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant Bounce oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}

// ============================================================================
// SHIMMER / SKELETON LOADING
// ============================================================================

/// A dependency-free shimmer that sweeps a highlight across [child].
/// Wrap grey placeholder boxes with it to build skeleton loaders.
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final bool enabled;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1400),
    this.enabled = true,
  });

  /// A ready-made rounded grey box to place inside a [ShimmerLoading].
  static Widget box({double? width, double height = 16, double radius = 8}) {
    return Container(
      width: width?.w,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    if (widget.enabled) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant ShimmerLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.enabled && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final dx = (_controller.value * 2 - 1) * bounds.width;
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.35, 0.5, 0.65],
              transform: _SlideGradient(dx),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlideGradient extends GradientTransform {
  final double dx;
  const _SlideGradient(this.dx);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(dx, 0, 0);
  }
}

// ============================================================================
// TEXT ANIMATIONS
//
// Every animated-text widget below takes the SAME parameters as [AppText]
// (text / family / size / color / lines / overflow / start / top / end /
// bottom / fontWeight / textAlign / fontStyle / decoration / decorationColor)
// so you can swap `AppText` for any of them without touching the styling.
//
// Directional padding (start/top/end/bottom) is applied once around the whole
// animation, never around each animated piece.
// ============================================================================

/// Directional padding shared by all animated-text widgets, matching [AppText].
EdgeInsetsDirectional _textPadding(
  double? start,
  double? top,
  double? end,
  double? bottom,
) {
  return EdgeInsetsDirectional.only(
    start: start ?? 0,
    end: end ?? 0,
    top: top ?? 0,
    bottom: bottom ?? 0,
  );
}

/// Reveals [text] character by character (typewriter effect).
class TypewriterText extends StatefulWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration charDuration;
  final Duration startDelay;
  final VoidCallback? onDone;
  final bool showCursor;

  const TypewriterText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.charDuration = const Duration(milliseconds: 55),
    this.startDelay = Duration.zero,
    this.onDone,
    this.showCursor = false,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.charDuration * math.max(1, widget.text.length),
  );
  late final Animation<int> _count = StepTween(
    begin: 0,
    end: widget.text.length,
  ).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener((s) {
      if (s == AnimationStatus.completed) widget.onDone?.call();
    });
    _startAfterDelay(_controller, widget.startDelay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _count,
      builder: (context, _) {
        final shown = widget.text.substring(0, _count.value);
        final cursor = widget.showCursor && !_controller.isCompleted ? '|' : '';
        return AppText(
          text: '$shown$cursor',
          family: widget.family,
          size: widget.size,
          color: widget.color,
          lines: widget.lines,
          overflow: widget.overflow,
          start: widget.start,
          top: widget.top,
          end: widget.end,
          bottom: widget.bottom,
          fontWeight: widget.fontWeight,
          textAlign: widget.textAlign,
          fontStyle: widget.fontStyle,
          decoration: widget.decoration,
          decorationColor: widget.decorationColor,
        );
      },
    );
  }
}

/// Fades in [text] word by word — a softer alternative to the typewriter.
class FadeInText extends StatelessWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration wordDuration;
  final Duration stagger;
  final Duration startDelay;
  final WrapAlignment alignment;

  const FadeInText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.wordDuration = const Duration(milliseconds: 400),
    this.stagger = const Duration(milliseconds: 90),
    this.startDelay = Duration.zero,
    this.alignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');
    return Padding(
      padding: _textPadding(start, top, end, bottom),
      child: Wrap(
        alignment: alignment,
        spacing: 4.w,
        runSpacing: 2.h,
        children: [
          for (int i = 0; i < words.length; i++)
            SlideIn(
              from: AnimDirection.bottom,
              distance: 12,
              duration: wordDuration,
              delay: startDelay + (stagger * i),
              child: AppText(
                text: words[i],
                family: family,
                size: size,
                color: color,
                lines: lines,
                overflow: overflow,
                fontWeight: fontWeight,
                textAlign: textAlign,
                fontStyle: fontStyle,
                decoration: decoration,
                decorationColor: decorationColor,
              ),
            ),
        ],
      ),
    );
  }
}

/// Smoothly counts a number from [from] to [to] (e.g. prices, points, stats).
///
/// The number range is named `from`/`to` (not begin/end) because `end` is
/// already the directional end-padding inherited from [AppText].
class AnimatedCounter extends StatelessWidget {
  final num from;
  final num to;

  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration duration;
  final int fractionDigits;
  final String prefix;
  final String suffix;
  final Curve curve;

  const AnimatedCounter({
    super.key,
    this.from = 0,
    required this.to,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.duration = const Duration(milliseconds: 900),
    this.fractionDigits = 0,
    this.prefix = '',
    this.suffix = '',
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: from.toDouble(), end: to.toDouble()),
      duration: duration,
      curve: curve,
      builder: (context, value, _) {
        return AppText(
          text: '$prefix${value.toStringAsFixed(fractionDigits)}$suffix',
          family: family,
          size: size,
          color: color,
          lines: lines,
          overflow: overflow,
          start: start,
          top: top,
          end: end,
          bottom: bottom,
          fontWeight: fontWeight,
          textAlign: textAlign,
          fontStyle: fontStyle,
          decoration: decoration,
          decorationColor: decorationColor,
        );
      },
    );
  }
}

// ============================================================================
// TEXT ANIMATIONS — EXTRA
// ============================================================================

/// Splits [text] into animatable units.
///
/// Word mode is the safe default: splitting Arabic into single letters breaks
/// the cursive joining between them.
List<String> _splitText(String text, bool byCharacter) {
  if (!byCharacter) return text.split(' ');
  return text.split('');
}

/// Sweeps a moving "shine" highlight across [text] forever.
/// Great for premium badges, prices and hero headlines.
class ShinyText extends StatefulWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Color baseColor;
  final Color shineColor;
  final Duration duration;

  const ShinyText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.baseColor = const Color(0xFF9E9E9E),
    this.shineColor = Colors.white,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<ShinyText> createState() => _ShinyTextState();
}

class _ShinyTextState extends State<ShinyText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _textPadding(
        widget.start,
        widget.top,
        widget.end,
        widget.bottom,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              final dx = (_controller.value * 2 - 1) * bounds.width;
              return LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [widget.baseColor, widget.shineColor, widget.baseColor],
                stops: const [0.35, 0.5, 0.65],
                transform: _SlideGradient(dx),
              ).createShader(bounds);
            },
            child: child,
          );
        },
        child: AppText(
          text: widget.text,
          family: widget.family,
          size: widget.size,
          color: widget.color,
          lines: widget.lines,
          overflow: widget.overflow,
          fontWeight: widget.fontWeight,
          textAlign: widget.textAlign,
          fontStyle: widget.fontStyle,
          decoration: widget.decoration,
          decorationColor: widget.decorationColor,
        ),
      ),
    );
  }
}

/// Fills [text] with a continuously moving multi-colour gradient.
class GradientText extends StatefulWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final List<Color> colors;
  final Duration duration;

  const GradientText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.colors = const [
      Color(0xFF2196F3),
      Color(0xFF9C27B0),
      Color(0xFF2196F3),
    ],
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _textPadding(
        widget.start,
        widget.top,
        widget.end,
        widget.bottom,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => LinearGradient(
              colors: widget.colors,
              transform: _SlideGradient(_controller.value * bounds.width),
              tileMode: TileMode.mirror,
            ).createShader(bounds),
            child: child,
          );
        },
        child: AppText(
          text: widget.text,
          family: widget.family,
          size: widget.size,
          color: widget.color,
          lines: widget.lines,
          overflow: widget.overflow,
          fontWeight: widget.fontWeight,
          textAlign: widget.textAlign,
          fontStyle: widget.fontStyle,
          decoration: widget.decoration,
          decorationColor: widget.decorationColor,
        ),
      ),
    );
  }
}

/// Makes each word (or letter) bob up and down in a continuous wave.
class WavyText extends StatefulWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration duration;
  final double amplitude;
  final WrapAlignment alignment;

  /// ⚠️ Only enable for Latin text — it breaks Arabic letter joining.
  final bool byCharacter;

  const WavyText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.duration = const Duration(milliseconds: 1800),
    this.amplitude = 6,
    this.alignment = WrapAlignment.start,
    this.byCharacter = false,
  });

  @override
  State<WavyText> createState() => _WavyTextState();
}

class _WavyTextState extends State<WavyText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final units = _splitText(widget.text, widget.byCharacter);
    return Padding(
      padding: _textPadding(
        widget.start,
        widget.top,
        widget.end,
        widget.bottom,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Wrap(
            alignment: widget.alignment,
            spacing: widget.byCharacter ? 0 : 4.w,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (int i = 0; i < units.length; i++)
                Transform.translate(
                  offset: Offset(
                    0,
                    math.sin((_controller.value * 2 * math.pi) + (i * 0.6)) *
                        widget.amplitude.h,
                  ),
                  child: AppText(
                    text: units[i],
                    family: widget.family,
                    size: widget.size,
                    color: widget.color,
                    lines: widget.lines,
                    overflow: widget.overflow,
                    fontWeight: widget.fontWeight,
                    textAlign: widget.textAlign,
                    fontStyle: widget.fontStyle,
                    decoration: widget.decoration,
                    decorationColor: widget.decorationColor,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Pops each word (or letter) in with a scale + fade, one after another.
class PopInText extends StatelessWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration unitDuration;
  final Duration stagger;
  final Duration startDelay;
  final WrapAlignment alignment;

  /// ⚠️ Only enable for Latin text — it breaks Arabic letter joining.
  final bool byCharacter;

  const PopInText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.unitDuration = const Duration(milliseconds: 380),
    this.stagger = const Duration(milliseconds: 70),
    this.startDelay = Duration.zero,
    this.alignment = WrapAlignment.start,
    this.byCharacter = false,
  });

  @override
  Widget build(BuildContext context) {
    final units = _splitText(text, byCharacter);
    return Padding(
      padding: _textPadding(start, top, end, bottom),
      child: Wrap(
        alignment: alignment,
        spacing: byCharacter ? 0 : 4.w,
        runSpacing: 2.h,
        children: [
          for (int i = 0; i < units.length; i++)
            ScaleIn(
              beginScale: 0.4,
              duration: unitDuration,
              delay: startDelay + (stagger * i),
              child: AppText(
                text: units[i],
                family: family,
                size: size,
                color: color,
                lines: lines,
                overflow: overflow,
                fontWeight: fontWeight,
                textAlign: textAlign,
                fontStyle: fontStyle,
                decoration: decoration,
                decorationColor: decorationColor,
              ),
            ),
        ],
      ),
    );
  }
}

/// Fades [text] in while sharpening it from a blur — a soft, premium entrance.
class BlurInText extends StatelessWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration duration;
  final Duration delay;
  final double blurSigma;

  const BlurInText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.blurSigma = 10,
  });

  @override
  Widget build(BuildContext context) {
    return BlurIn(
      duration: duration,
      delay: delay,
      blurSigma: blurSigma,
      child: AppText(
        text: text,
        family: family,
        size: size,
        color: color,
        lines: lines,
        overflow: overflow,
        start: start,
        top: top,
        end: end,
        bottom: bottom,
        fontWeight: fontWeight,
        textAlign: textAlign,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }
}

/// Cycles through [words] forever, animating each one in and out.
/// Perfect for taglines like "سريع · آمن · موثوق".
class RotatingWords extends StatefulWidget {
  /// The list of words to cycle through (this replaces [AppText]'s `text`).
  final List<String> words;

  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Duration interval;
  final Duration transition;
  final AnimDirection from;

  const RotatingWords({
    super.key,
    required this.words,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.interval = const Duration(seconds: 2),
    this.transition = const Duration(milliseconds: 400),
    this.from = AnimDirection.bottom,
  });

  @override
  State<RotatingWords> createState() => _RotatingWordsState();
}

class _RotatingWordsState extends State<RotatingWords> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % widget.words.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty) return const SizedBox.shrink();
    final offset = widget.from.toOffset(14);
    return AnimatedSwitcher(
      duration: widget.transition,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              // AnimatedSwitcher works in fractional offsets.
              begin: Offset(offset.dx / 100, offset.dy / 100),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: AppText(
        key: ValueKey(_index),
        text: widget.words[_index],
        family: widget.family,
        size: widget.size,
        color: widget.color,
        lines: widget.lines,
        overflow: widget.overflow,
        start: widget.start,
        top: widget.top,
        end: widget.end,
        bottom: widget.bottom,
        fontWeight: widget.fontWeight,
        textAlign: widget.textAlign,
        fontStyle: widget.fontStyle,
        decoration: widget.decoration,
        decorationColor: widget.decorationColor,
      ),
    );
  }
}

/// Grows a coloured highlight bar behind [text], like a marker pen stroke.
class HighlightedText extends StatelessWidget {
  final String text;
  final String? family;
  final double? size;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final Color? color;
  final int? lines;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final Color highlightColor;
  final Duration duration;
  final Duration delay;

  /// Fraction of the text height the highlight covers (0.0 – 1.0).
  final double thickness;

  const HighlightedText({
    super.key,
    required this.text,
    this.family,
    this.size,
    this.color,
    this.lines,
    this.overflow,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.decoration,
    this.decorationColor,
    this.highlightColor = const Color(0x552196F3),
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.thickness = 0.45,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _textPadding(start, top, end, bottom),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned.fill(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: duration,
              curve: Curves.easeOutCubic,
              builder: (context, t, _) {
                return Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: FractionallySizedBox(
                    widthFactor: t,
                    heightFactor: thickness,
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(color: highlightColor),
                  ),
                );
              },
            ),
          ),
          AppText(
            text: text,
            family: family,
            size: size,
            color: color,
            lines: lines,
            overflow: overflow,
            fontWeight: fontWeight,
            textAlign: textAlign,
            fontStyle: fontStyle,
            decoration: decoration,
            decorationColor: decorationColor,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// BACKGROUND ANIMATIONS
// ============================================================================

/// An animated gradient background that smoothly shifts between [colorSets].
/// Place it behind your content (e.g. as the first child of a [Stack]).
class AnimatedGradientBackground extends StatefulWidget {
  final List<List<Color>> colorSets;
  final Duration duration;
  final Widget? child;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const AnimatedGradientBackground({
    super.key,
    required this.colorSets,
    this.duration = const Duration(seconds: 5),
    this.child,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground> {
  int _index = 0;

  List<Color> get _current =>
      widget.colorSets[_index % widget.colorSets.length];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(_index),
      tween: Tween(begin: 0, end: 1),
      duration: widget.duration,
      onEnd: () => setState(() => _index++),
      builder: (context, t, child) {
        final from =
            widget.colorSets[(_index - 1).clamp(
                  0,
                  widget.colorSets.length - 1,
                ) %
                widget.colorSets.length];
        final to = _current;
        final colors = [
          for (int i = 0; i < to.length; i++)
            Color.lerp(from[i % from.length], to[i], t) ?? to[i],
        ];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: widget.begin,
              end: widget.end,
              colors: colors,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ============================================================================
// SWITCHERS / VISIBILITY TRANSITIONS
// ============================================================================

/// A pre-configured [AnimatedSwitcher] that fades + scales between children.
/// Give each child a unique `key` so the switcher knows when to animate.
class AppAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final bool scale;

  const AppAnimatedSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
    this.scale = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final fade = FadeTransition(opacity: animation, child: child);
        if (!scale) return fade;
        return ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(animation),
          child: fade,
        );
      },
      child: child,
    );
  }
}

/// Animates a widget in/out (fade + optional size collapse) based on [visible].
class AnimatedVisibility extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Duration duration;
  final bool collapse;

  const AnimatedVisibility({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.collapse = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: duration,
      curve: Curves.easeInOut,
      child: child,
    );
    if (!collapse) return content;
    return AnimatedSize(
      duration: duration,
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: visible ? content : const SizedBox.shrink(),
    );
  }
}

/// A tappable header that smoothly expands / collapses its [content].
/// Useful for FAQs, filters, "show more" sections.
class ExpandableSection extends StatefulWidget {
  final Widget header;
  final Widget content;
  final bool initiallyExpanded;
  final Duration duration;

  const ExpandableSection({
    super.key,
    required this.header,
    required this.content,
    this.initiallyExpanded = false,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Expanded(child: widget.header),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: widget.duration,
                child: const Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ],
          ),
        ),
        AnimatedSize(
          duration: widget.duration,
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Align(alignment: Alignment.topCenter, child: widget.content)
              : const SizedBox(width: double.infinity, height: 0),
        ),
      ],
    );
  }
}

// ============================================================================
// TAP / PRESS FEEDBACK
// ============================================================================

/// Shrinks its [child] slightly while pressed — a tactile tap effect.
/// Wrap buttons, cards or list tiles to make taps feel responsive.
class TapScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double pressedScale;
  final Duration duration;

  const TapScale({
    super.key,
    required this.child,
    this.onTap,
    this.pressedScale = 0.95,
    this.duration = const Duration(milliseconds: 120),
  });

  @override
  State<TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<TapScale> {
  bool _pressed = false;

  void _set(bool v) {
    if (mounted) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? widget.pressedScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}

// ============================================================================
// ENTRANCE ANIMATIONS — EXTRA
// ============================================================================

/// Fades [child] in while sharpening it from a blur.
/// Works on anything, but looks especially good on images and headlines.
class BlurIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double blurSigma;
  final Curve curve;

  const BlurIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.blurSigma = 12,
    this.curve = Curves.easeOut,
  });

  @override
  State<BlurIn> createState() => _BlurInState();
}

class _BlurInState extends State<BlurIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final t = anim.value;
        final sigma = widget.blurSigma * (1 - t);
        final content = Opacity(opacity: t.clamp(0.0, 1.0), child: child);
        // ImageFilter.blur(0, 0) is wasteful — skip it once we're sharp.
        if (sigma < 0.05) return content;
        return ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: content,
        );
      },
      child: widget.child,
    );
  }
}

/// Rotates [child] into place while fading and scaling it up.
class RotateIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  /// Starting rotation in turns (0.25 = a quarter turn).
  final double beginTurns;
  final double beginScale;
  final Curve curve;

  const RotateIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.beginTurns = -0.08,
    this.beginScale = 0.8,
    this.curve = Curves.easeOutBack,
  });

  @override
  State<RotateIn> createState() => _RotateInState();
}

class _RotateInState extends State<RotateIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final t = anim.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.rotate(
            angle: widget.beginTurns * (1 - t) * 2 * math.pi,
            child: Transform.scale(
              scale: widget.beginScale + (1 - widget.beginScale) * t,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Flips [child] into view in 3D around the X or Y axis.
/// A striking entrance for cards and images.
class FlipIn extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Axis axis;
  final Curve curve;

  const FlipIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.axis = Axis.horizontal,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<FlipIn> createState() => _FlipInState();
}

class _FlipInState extends State<FlipIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        final t = anim.value;
        final angle = (1 - t) * (math.pi / 2);
        final matrix = Matrix4.identity()..setEntry(3, 2, 0.0012);
        if (widget.axis == Axis.horizontal) {
          matrix.rotateY(angle);
        } else {
          matrix.rotateX(angle);
        }
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform(
            transform: matrix,
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Wipes [child] into view from one edge (a directional reveal).
/// The layout size never changes — only what's painted.
class ClipReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final AnimDirection from;
  final Curve curve;

  const ClipReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.from = AnimDirection.left,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ClipReveal> createState() => _ClipRevealState();
}

class _ClipRevealState extends State<ClipReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        return ClipRect(
          clipper: _RevealClipper(anim.value, widget.from),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _RevealClipper extends CustomClipper<Rect> {
  final double t;
  final AnimDirection from;

  const _RevealClipper(this.t, this.from);

  @override
  Rect getClip(Size size) {
    switch (from) {
      case AnimDirection.left:
        return Rect.fromLTWH(0, 0, size.width * t, size.height);
      case AnimDirection.right:
        return Rect.fromLTWH(
          size.width * (1 - t),
          0,
          size.width * t,
          size.height,
        );
      case AnimDirection.top:
        return Rect.fromLTWH(0, 0, size.width, size.height * t);
      case AnimDirection.bottom:
        return Rect.fromLTWH(
          0,
          size.height * (1 - t),
          size.width,
          size.height * t,
        );
      case AnimDirection.none:
        return Offset.zero & size;
    }
  }

  @override
  bool shouldReclip(_RevealClipper old) => old.t != t || old.from != from;
}

/// Reveals [child] through a growing circle. Great for avatars and hero images.
class CircleReveal extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Alignment center;
  final Curve curve;

  const CircleReveal({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.center = Alignment.center,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<CircleReveal> createState() => _CircleRevealState();
}

class _CircleRevealState extends State<CircleReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _startAfterDelay(_controller, widget.delay);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anim = CurvedAnimation(parent: _controller, curve: widget.curve);
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        return ClipPath(
          clipper: _CircleRevealClipper(anim.value, widget.center),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _CircleRevealClipper extends CustomClipper<Path> {
  final double t;
  final Alignment center;

  const _CircleRevealClipper(this.t, this.center);

  @override
  Path getClip(Size size) {
    final origin = center.alongSize(size);
    // Radius that always covers the furthest corner.
    final maxRadius = math.sqrt(
      math.pow(math.max(origin.dx, size.width - origin.dx), 2) +
          math.pow(math.max(origin.dy, size.height - origin.dy), 2),
    );
    return Path()
      ..addOval(Rect.fromCircle(center: origin, radius: maxRadius * t));
  }

  @override
  bool shouldReclip(_CircleRevealClipper old) => old.t != t;
}

// ============================================================================
// IMAGE ANIMATIONS
// ============================================================================

/// The classic "Ken Burns" effect: a slow, continuous zoom and pan.
/// Wrap a full-bleed image to make a static banner feel alive.
class KenBurns extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginScale;
  final double endScale;

  /// How far the image drifts, as a fraction of its size (0.0 – 0.5).
  final Alignment beginAlignment;
  final Alignment endAlignment;

  const KenBurns({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 12),
    this.beginScale = 1.0,
    this.endScale = 1.18,
    this.beginAlignment = Alignment.topLeft,
    this.endAlignment = Alignment.bottomRight,
  });

  @override
  State<KenBurns> createState() => _KenBurnsState();
}

class _KenBurnsState extends State<KenBurns>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat(reverse: true);
  late final Animation<double> _anim = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _anim,
        builder: (context, child) {
          final t = _anim.value;
          return Transform.scale(
            scale:
                widget.beginScale + (widget.endScale - widget.beginScale) * t,
            alignment: Alignment.lerp(
              widget.beginAlignment,
              widget.endAlignment,
              t,
            )!,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

/// Sweeps a diagonal gloss/light band across [child] forever.
/// Use on cards, images and buttons to give them a glassy sheen.
class ShineSweep extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration pause;
  final Color shineColor;
  final double bandWidth;
  final BorderRadius borderRadius;

  const ShineSweep({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1400),
    this.pause = const Duration(milliseconds: 1200),
    this.shineColor = Colors.white,
    this.bandWidth = 60,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<ShineSweep> createState() => _ShineSweepState();
}

class _ShineSweepState extends State<ShineSweep>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _run();
  }

  void _run() {
    _controller.forward(from: 0);
    _timer = Timer.periodic(widget.duration + widget.pause, (_) {
      if (!mounted) return;
      _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      final travel = width + widget.bandWidth.w * 2;
                      final dx =
                          -widget.bandWidth.w + _controller.value * travel;
                      return Transform.translate(
                        offset: Offset(dx, 0),
                        child: Transform.rotate(
                          angle: -0.35,
                          child: Container(
                            width: widget.bandWidth.w,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  widget.shineColor.withValues(alpha: 0),
                                  widget.shineColor.withValues(alpha: 0.45),
                                  widget.shineColor.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tilts [child] in 3D as the user drags across it, then springs back.
/// Feels great on product images and feature cards.
class Tilt3D extends StatefulWidget {
  final Widget child;

  /// Maximum tilt in radians at the edges.
  final double maxTilt;
  final Duration returnDuration;

  const Tilt3D({
    super.key,
    required this.child,
    this.maxTilt = 0.18,
    this.returnDuration = const Duration(milliseconds: 450),
  });

  @override
  State<Tilt3D> createState() => _Tilt3DState();
}

class _Tilt3DState extends State<Tilt3D> {
  Offset _tilt = Offset.zero;
  bool _dragging = false;

  void _update(Offset local, Size size) {
    if (size.width == 0 || size.height == 0) return;
    // Map the pointer to -1..1 on both axes.
    final px = (local.dx / size.width).clamp(0.0, 1.0) * 2 - 1;
    final py = (local.dy / size.height).clamp(0.0, 1.0) * 2 - 1;
    setState(() {
      _dragging = true;
      _tilt = Offset(px, py);
    });
  }

  void _reset() => setState(() {
    _dragging = false;
    _tilt = Offset.zero;
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return GestureDetector(
          onPanStart: (d) => _update(d.localPosition, size),
          onPanUpdate: (d) => _update(d.localPosition, size),
          onPanEnd: (_) => _reset(),
          onPanCancel: _reset,
          child: TweenAnimationBuilder<Offset>(
            tween: Tween(begin: Offset.zero, end: _tilt),
            duration: _dragging
                ? const Duration(milliseconds: 90)
                : widget.returnDuration,
            curve: _dragging ? Curves.linear : Curves.easeOutBack,
            builder: (context, value, child) {
              final matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateY(value.dx * widget.maxTilt)
                ..rotateX(-value.dy * widget.maxTilt);
              return Transform(
                transform: matrix,
                alignment: Alignment.center,
                child: child,
              );
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}

// ============================================================================
// CARD ANIMATIONS
// ============================================================================

/// A card that flips between [front] and [back] in 3D when tapped.
class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final Duration duration;
  final Axis axis;

  /// Flip programmatically instead of on tap by changing this value.
  final bool? showBack;

  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    this.duration = const Duration(milliseconds: 550),
    this.axis = Axis.horizontal,
    this.showBack,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: (widget.showBack ?? false) ? 1 : 0,
  );

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showBack != null && widget.showBack != oldWidget.showBack) {
      widget.showBack! ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    // Ignore taps when the parent drives the flip.
    if (widget.showBack != null) return;
    _controller.isCompleted ? _controller.reverse() : _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = Curves.easeInOut.transform(_controller.value);
          final angle = t * math.pi;
          final showingBack = t >= 0.5;
          final matrix = Matrix4.identity()..setEntry(3, 2, 0.0012);
          widget.axis == Axis.horizontal
              ? matrix.rotateY(angle)
              : matrix.rotateX(angle);
          return Transform(
            transform: matrix,
            alignment: Alignment.center,
            child: showingBack
                // Un-mirror the back face.
                ? Transform(
                    transform: widget.axis == Axis.horizontal
                        ? (Matrix4.identity()..rotateY(math.pi))
                        : (Matrix4.identity()..rotateX(math.pi)),
                    alignment: Alignment.center,
                    child: widget.back,
                  )
                : widget.front,
          );
        },
      ),
    );
  }
}

/// Lifts a card (shadow grows, content rises) while pressed.
/// A richer alternative to [TapScale] for cards and tiles.
class PressLift extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;
  final double liftDistance;
  final double restElevation;
  final double pressedElevation;
  final Color shadowColor;
  final BorderRadius borderRadius;

  const PressLift({
    super.key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 160),
    this.liftDistance = 4,
    this.restElevation = 10,
    this.pressedElevation = 22,
    this.shadowColor = const Color(0x33000000),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<PressLift> createState() => _PressLiftState();
}

class _PressLiftState extends State<PressLift> {
  bool _pressed = false;

  void _set(bool v) {
    if (mounted) setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _set(true),
      onTapUp: (_) => _set(false),
      onTapCancel: () => _set(false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _pressed ? -widget.liftDistance.h : 0,
          0,
        ),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              blurRadius:
                  (_pressed ? widget.pressedElevation : widget.restElevation).r,
              offset: Offset(0, _pressed ? 10.h : 5.h),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}

/// Wraps [child] in a border whose gradient rotates continuously.
/// Eye-catching for "featured" / "premium" cards.
class GradientBorderCard extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final double borderWidth;
  final double radius;
  final Color backgroundColor;
  final Duration duration;

  const GradientBorderCard({
    super.key,
    required this.child,
    this.colors = const [
      Color(0xFF2196F3),
      Color(0xFF9C27B0),
      Color(0xFFFF9800),
      Color(0xFF2196F3),
    ],
    this.borderWidth = 2,
    this.radius = 16,
    this.backgroundColor = Colors.white,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<GradientBorderCard> createState() => _GradientBorderCardState();
}

class _GradientBorderCardState extends State<GradientBorderCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(widget.borderWidth.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius.r),
            gradient: SweepGradient(
              colors: widget.colors,
              transform: GradientRotation(_controller.value * 2 * math.pi),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(
                (widget.radius - widget.borderWidth).clamp(0, 999).r,
              ),
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

// ============================================================================
// GRID ANIMATIONS
// ============================================================================

/// Drop-in animated [GridView.builder] — every tile animates in as it's built.
class StaggeredGridView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final SliverGridDelegate gridDelegate;
  final Duration itemDuration;
  final Duration stagger;
  final AnimDirection from;
  final double distance;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;

  /// Tiles past this index share a fixed delay so long grids stay snappy.
  final int maxStaggerItems;

  const StaggeredGridView.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.itemDuration = const Duration(milliseconds: 400),
    this.stagger = const Duration(milliseconds: 60),
    this.from = AnimDirection.bottom,
    this.distance = 24,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.controller,
    this.maxStaggerItems = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
      itemCount: itemCount,
      gridDelegate: gridDelegate,
      itemBuilder: (context, index) {
        final steps = math.min(index, maxStaggerItems);
        return FadeSlideScaleIn(
          from: from,
          distance: distance,
          duration: itemDuration,
          delay: stagger * steps,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

// ============================================================================
// CONTINUOUS ANIMATIONS — EXTRA
// ============================================================================

/// Rocks [child] back and forth forever — a playful "look at me" nudge.
class Wiggle extends StatefulWidget {
  final Widget child;
  final Duration duration;

  /// Maximum rotation in turns (0.02 ≈ 7°).
  final double turns;
  final bool animate;

  const Wiggle({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.turns = 0.02,
    this.animate = true,
  });

  @override
  State<Wiggle> createState() => _WiggleState();
}

class _WiggleState extends State<Wiggle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    if (widget.animate) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant Wiggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
      _controller.value = 0.5;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Map 0..1 to -turns..+turns.
        final angle = (_controller.value * 2 - 1) * widget.turns * 2 * math.pi;
        return Transform.rotate(angle: angle, child: child);
      },
      child: widget.child,
    );
  }
}

/// A double "lub-dub" heartbeat pulse, repeated forever.
/// Stronger and more organic than [Pulse].
class HeartBeat extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double strength;

  const HeartBeat({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1400),
    this.strength = 0.14,
  });

  @override
  State<HeartBeat> createState() => _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();
  late final Animation<double> _scale = TweenSequence<double>([
    // beat
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.0 + widget.strength,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 10,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0 + widget.strength,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 10,
    ),
    // second, softer beat
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.0 + widget.strength * 0.6,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 8,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0 + widget.strength * 0.6,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 8,
    ),
    // rest
    TweenSequenceItem(tween: ConstantTween(1.0), weight: 44),
  ]).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}

// ============================================================================
// FIELD / FORM ANIMATIONS
//
// [AnimatedInput] takes the SAME parameters as [AppInput] plus animation
// options, so you can swap `AppInput` for it without touching anything else.
//
// The other widgets here are generic wrappers — use them when you need to
// animate a field that isn't an [AppInput].
// ============================================================================

/// An [AppInput] that reacts: it glows and lifts on focus, and shakes when
/// [errorText] changes to a new message.
///
/// Every [AppInput] parameter is accepted and forwarded unchanged:
/// ```dart
/// AnimatedInput(
///   hint: 'البريد الإلكتروني',
///   controller: emailController,
///   errorText: state.emailError,
/// )
/// ```
class AnimatedInput extends StatefulWidget {
  // ---- identical to AppInput ----
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validate;
  final FocusNode? focusNode;
  final bool? read;
  final bool? filled;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final double? start;
  final double? end;
  final double? top;
  final double? bottom;
  final TextInputType? inputType;
  final String? label;
  final String? hint;
  final bool? secureText;
  final bool? isEnabled;
  final bool? autofocus;
  final Color? color;
  final Color? iconColor;
  final Color? hintColor;
  final TextEditingController? controller;
  final Color? borderColorr;
  final double? contentLeft;
  final double? contentRight;
  final double? contentTop;
  final double? contentBottom;
  final Color? outLineInputColorColor;
  final Color? enabledBorderColor;
  final Color? disableBorderColor;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final Color? focusedErrorBorderColor;
  final Color? cursorColor;
  final BoxConstraints? prefixSize;
  final BoxConstraints? suffixSize;
  final double? border;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Color? labelColor;
  final Color? inputColor;

  // ---- animation extras ----
  /// Changing this to a new non-null message shakes the field.
  final String? errorText;
  final bool shakeOnError;
  final bool focusAnimation;
  final double focusedScale;
  final Color? glowColor;
  final double glowRadius;
  final Duration focusDuration;

  /// Set a direction to make the field animate in on first build.
  final AnimDirection? entranceFrom;
  final Duration entranceDelay;

  const AnimatedInput({
    super.key,
    this.onChanged,
    this.validate,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.label,
    this.hint,
    this.secureText,
    this.onSubmitted,
    this.isEnabled = true,
    this.controller,
    this.color = Colors.white,
    this.onSaved,
    this.autofocus,
    this.iconColor,
    this.borderColorr = AppColors.borderColor,
    this.contentLeft,
    this.contentRight,
    this.contentTop,
    this.contentBottom,
    this.start,
    this.end,
    this.top,
    this.bottom,
    this.enabledBorderColor = AppColors.borderColor,
    this.maxLines,
    this.maxLength,
    this.border,
    this.outLineInputColorColor,
    this.disableBorderColor,
    this.errorBorderColor,
    this.focusedBorderColor = AppColors.primary,
    this.focusedErrorBorderColor,
    this.onTap,
    this.read,
    this.prefixSize,
    this.suffixSize,
    this.filled,
    this.hintColor,
    this.textInputAction,
    this.cursorColor = AppColors.primary,
    this.contentPadding,
    this.focusNode,
    this.labelColor,
    this.inputColor = AppColors.primary,
    this.errorText,
    this.shakeOnError = true,
    this.focusAnimation = true,
    this.focusedScale = 1.015,
    this.glowColor,
    this.glowRadius = 14,
    this.focusDuration = const Duration(milliseconds: 220),
    this.entranceFrom,
    this.entranceDelay = Duration.zero,
  });

  @override
  State<AnimatedInput> createState() => _AnimatedInputState();
}

class _AnimatedInputState extends State<AnimatedInput> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onNodeChange);
  }

  void _onNodeChange() {
    final v = widget.focusNode?.hasFocus ?? false;
    if (v != _focused && mounted) setState(() => _focused = v);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onNodeChange);
    super.dispose();
  }

  void _set(bool v) {
    if (v != _focused && mounted) setState(() => _focused = v);
  }

  @override
  Widget build(BuildContext context) {
    // The inner AppInput gets zero padding so the glow hugs the field itself;
    // the real directional padding is applied by the outer Padding below.
    Widget field = AppInput(
      onChanged: widget.onChanged,
      validate: widget.validate,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      inputType: widget.inputType,
      label: widget.label,
      hint: widget.hint,
      secureText: widget.secureText,
      onSubmitted: widget.onSubmitted,
      isEnabled: widget.isEnabled,
      controller: widget.controller,
      color: widget.color,
      onSaved: widget.onSaved,
      autofocus: widget.autofocus,
      iconColor: widget.iconColor,
      borderColorr: widget.borderColorr,
      contentLeft: widget.contentLeft,
      contentRight: widget.contentRight,
      contentTop: widget.contentTop,
      contentBottom: widget.contentBottom,
      start: 0,
      end: 0,
      top: 0,
      bottom: 0,
      enabledBorderColor: widget.enabledBorderColor,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      border: widget.border,
      outLineInputColorColor: widget.outLineInputColorColor,
      disableBorderColor: widget.disableBorderColor,
      errorBorderColor: widget.errorBorderColor,
      focusedBorderColor: widget.focusedBorderColor,
      focusedErrorBorderColor: widget.focusedErrorBorderColor,
      onTap: widget.onTap,
      read: widget.read,
      prefixSize: widget.prefixSize,
      suffixSize: widget.suffixSize,
      filled: widget.filled,
      hintColor: widget.hintColor,
      textInputAction: widget.textInputAction,
      cursorColor: widget.cursorColor,
      contentPadding: widget.contentPadding,
      focusNode: widget.focusNode,
      labelColor: widget.labelColor,
      inputColor: widget.inputColor,
    );

    if (widget.focusAnimation) {
      final glow =
          widget.glowColor ?? widget.focusedBorderColor ?? Colors.white;
      field = AnimatedScale(
        scale: _focused ? widget.focusedScale : 1.0,
        duration: widget.focusDuration,
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: widget.focusDuration,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.border ?? 51.r),
            boxShadow: _focused
                ? [
                    BoxShadow(
                      color: glow.withValues(alpha: 0.25),
                      blurRadius: widget.glowRadius.r,
                      spreadRadius: 1,
                    ),
                  ]
                : const [],
          ),
          child: field,
        ),
      );

      // Without an external node, watch the descendant TextFormField instead.
      if (widget.focusNode == null) {
        field = Focus(
          canRequestFocus: false,
          skipTraversal: true,
          onFocusChange: _set,
          child: field,
        );
      }
    }

    if (widget.shakeOnError) {
      field = Shake(trigger: widget.errorText, child: field);
    }

    if (widget.entranceFrom != null) {
      field = SlideIn(
        from: widget.entranceFrom!,
        delay: widget.entranceDelay,
        child: field,
      );
    }

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: widget.start ?? 20.w,
        end: widget.end ?? 20.w,
        top: widget.top ?? 0,
        bottom: widget.bottom ?? 0,
      ),
      child: field,
    );
  }
}

/// Animates a form field when it gains focus: it lifts slightly, its border
/// changes colour and a soft glow appears.
///
/// Wrap it around ANY field — it detects focus of its descendants, so you
/// don't have to pass a [FocusNode]:
/// ```dart
/// FocusAnimatedField(child: TextFormField(...))
/// ```
class FocusAnimatedField extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double focusedScale;
  final Color focusedBorderColor;
  final Color unfocusedBorderColor;
  final double borderWidth;
  final Color? glowColor;
  final double glowRadius;
  final BorderRadius borderRadius;

  /// Optional: react to an external node instead of descendant focus.
  final FocusNode? focusNode;

  const FocusAnimatedField({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 220),
    this.focusedScale = 1.015,
    this.focusedBorderColor = const Color(0xFF2196F3),
    this.unfocusedBorderColor = Colors.transparent,
    this.borderWidth = 1.4,
    this.glowColor,
    this.glowRadius = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.focusNode,
  });

  @override
  State<FocusAnimatedField> createState() => _FocusAnimatedFieldState();
}

class _FocusAnimatedFieldState extends State<FocusAnimatedField> {
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onNodeChange);
  }

  void _onNodeChange() {
    final v = widget.focusNode?.hasFocus ?? false;
    if (v != _focused && mounted) setState(() => _focused = v);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onNodeChange);
    super.dispose();
  }

  void _set(bool v) {
    if (v != _focused && mounted) setState(() => _focused = v);
  }

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? widget.focusedBorderColor;
    final field = AnimatedScale(
      scale: _focused ? widget.focusedScale : 1.0,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          border: Border.all(
            color: _focused
                ? widget.focusedBorderColor
                : widget.unfocusedBorderColor,
            width: widget.borderWidth,
          ),
          boxShadow: _focused
              ? [
                  BoxShadow(
                    color: glow.withValues(alpha: 0.25),
                    blurRadius: widget.glowRadius.r,
                    spreadRadius: 1,
                  ),
                ]
              : const [],
        ),
        child: widget.child,
      ),
    );

    // When no node is supplied, listen to descendant focus instead.
    if (widget.focusNode != null) return field;
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onFocusChange: _set,
      child: field,
    );
  }
}

/// Shakes its [child] every time [errorText] becomes a new, non-null message.
/// Drop it around a field to make validation failures physical.
///
/// ```dart
/// ShakeOnError(errorText: state.emailError, child: TextFormField(...))
/// ```
class ShakeOnError extends StatelessWidget {
  final Widget child;
  final String? errorText;
  final double amplitude;
  final int shakes;
  final Duration duration;

  const ShakeOnError({
    super.key,
    required this.child,
    required this.errorText,
    this.amplitude = 8,
    this.shakes = 4,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return Shake(
      // A null error keeps the previous trigger, so clearing never shakes.
      trigger: errorText,
      amplitude: amplitude,
      shakes: shakes,
      duration: duration,
      child: child,
    );
  }
}

/// Slides + fades an error message in and out under a field, collapsing the
/// space when there is no error.
class AnimatedErrorText extends StatelessWidget {
  final String? errorText;
  final Duration duration;
  final Color color;
  final double? size;
  final String? family;
  final double? start;
  final double? top;
  final double? end;
  final double? bottom;
  final TextAlign? textAlign;

  const AnimatedErrorText({
    super.key,
    required this.errorText,
    this.duration = const Duration(milliseconds: 250),
    this.color = const Color(0xFFD32F2F),
    this.size,
    this.family,
    this.start,
    this.top,
    this.end,
    this.bottom,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    return AnimatedSize(
      duration: duration,
      curve: Curves.easeInOut,
      alignment: AlignmentDirectional.topStart,
      child: !hasError
          ? const SizedBox(width: double.infinity, height: 0)
          : SlideIn(
              from: AnimDirection.top,
              distance: 6,
              duration: duration,
              child: AppText(
                text: errorText!,
                color: color,
                size: size ?? 12.sp,
                family: family,
                start: start,
                top: top ?? 4.h,
                end: end,
                bottom: bottom,
                textAlign: textAlign,
                lines: 3,
              ),
            ),
    );
  }
}

/// An underline that grows out from the centre when the field is focused.
/// Place it directly under a borderless [TextField].
class AnimatedUnderline extends StatefulWidget {
  final Widget child;
  final Color focusedColor;
  final Color unfocusedColor;
  final double thickness;
  final Duration duration;

  const AnimatedUnderline({
    super.key,
    required this.child,
    this.focusedColor = const Color(0xFF2196F3),
    this.unfocusedColor = const Color(0xFFBDBDBD),
    this.thickness = 2,
    this.duration = const Duration(milliseconds: 260),
  });

  @override
  State<AnimatedUnderline> createState() => _AnimatedUnderlineState();
}

class _AnimatedUnderlineState extends State<AnimatedUnderline> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onFocusChange: (v) {
        if (v != _focused && mounted) setState(() => _focused = v);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          widget.child,
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: widget.thickness.h,
                color: widget.unfocusedColor,
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: _focused ? 1 : 0),
                duration: widget.duration,
                curve: Curves.easeOutCubic,
                builder: (context, t, _) {
                  return FractionallySizedBox(
                    widthFactor: t,
                    child: Container(
                      height: widget.thickness.h,
                      color: widget.focusedColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// LOGO ANIMATIONS
// ============================================================================

/// Where the logo is being shown — each style has its own personality.
enum LogoAnimationStyle {
  /// Big, confident entrance for the splash screen: scale-up with a bounce,
  /// a breathing glow and a shine sweep, settling into a slow pulse.
  splash,

  /// Softer entrance for login / register: blur + scale in, gentle float.
  auth,

  /// Quick and quiet — for dialogs, app bars and image placeholders.
  inline,

  /// No entrance animation (use the `glow` / `shine` / `idleMotion` flags
  /// on their own).
  none,
}

/// Sweeps a highlight across a logo **without** covering its transparent
/// areas — the shine only lands on the logo's own pixels.
///
/// Unlike [ShineSweep] (which paints a band over the whole box), this uses a
/// shader mask, so it's the right choice for transparent PNGs.
class LogoShine extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration pause;
  final Color shineColor;

  const LogoShine({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.pause = const Duration(milliseconds: 1600),
    this.shineColor = Colors.white,
  });

  @override
  State<LogoShine> createState() => _LogoShineState();
}

class _LogoShineState extends State<LogoShine>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward(from: 0);
    _timer = Timer.periodic(widget.duration + widget.pause, (_) {
      if (mounted) _controller.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          // srcATop keeps the shader inside the logo's opaque pixels only.
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final dx = (_controller.value * 2 - 1) * bounds.width;
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                widget.shineColor.withValues(alpha: 0),
                widget.shineColor.withValues(alpha: 0.55),
                widget.shineColor.withValues(alpha: 0),
              ],
              stops: const [0.35, 0.5, 0.65],
              transform: _SlideGradient(dx),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A soft halo behind [child] that breathes in and out.
/// Built for logos, but works behind any widget.
class LogoGlow extends StatefulWidget {
  final Widget child;
  final Color color;
  final Duration duration;

  /// Halo size at its smallest / largest.
  final double minRadius;
  final double maxRadius;

  const LogoGlow({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 2200),
    this.minRadius = 18,
    this.maxRadius = 46,
  });

  @override
  State<LogoGlow> createState() => _LogoGlowState();
}

class _LogoGlowState extends State<LogoGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat(reverse: true);
  late final Animation<double> _anim = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final t = _anim.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: 0.10 + 0.18 * t),
                blurRadius:
                    (widget.minRadius +
                            (widget.maxRadius - widget.minRadius) * t)
                        .r,
                spreadRadius: (2 + 6 * t).r,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// The app logo with an animation tuned to where it appears.
///
/// ```dart
/// AnimatedLogo.splash(width: 230.w, height: 225.w)   // splash screen
/// AnimatedLogo.auth(width: 140.w)                     // login / register
/// AnimatedLogo.inline(width: 60.w)                    // dialogs, app bars
/// ```
///
/// Defaults to `Assets.img.logo.path`; pass [path] for another asset, or
/// [logo] to supply your own widget (an SVG, for example).
class AnimatedLogo extends StatelessWidget {
  final String? path;
  final Widget? logo;
  final double? width;
  final double? height;
  final BoxFit fit;
  final LogoAnimationStyle style;
  final Duration delay;
  final Color glowColor;

  /// Each defaults to whatever [style] implies — set one to override it.
  final bool? glow;
  final bool? shine;
  final bool? idleMotion;

  /// Rotation: a full turn on entrance, and a slow endless spin on the splash.
  /// Defaults to on for the splash and auth styles.
  final bool? spin;

  /// Recolours the artwork (alpha kept) — the trademark is registered in
  /// black, so `AppColors.logoColor` is the default. Pass `null` explicitly
  /// via [tinted] `false` to draw the asset with its own colours.
  final Color tint;
  final bool tinted;

  const AnimatedLogo({
    super.key,
    this.path,
    this.logo,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.style = LogoAnimationStyle.inline,
    this.delay = Duration.zero,
    this.glowColor = Colors.white,
    this.glow,
    this.shine,
    this.idleMotion,
    this.spin,
    this.tint = AppColors.logoColor,
    this.tinted = true,
  });

  const AnimatedLogo.splash({
    super.key,
    this.path,
    this.logo,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.delay = Duration.zero,
    this.glowColor = Colors.white,
    this.glow,
    this.shine,
    this.idleMotion,
    this.spin,
    this.tint = AppColors.logoColor,
    this.tinted = true,
  }) : style = LogoAnimationStyle.splash;

  const AnimatedLogo.auth({
    super.key,
    this.path,
    this.logo,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.delay = Duration.zero,
    this.glowColor = Colors.white,
    this.glow,
    this.shine,
    this.idleMotion,
    this.spin,
    this.tint = AppColors.logoColor,
    this.tinted = true,
  }) : style = LogoAnimationStyle.auth;

  const AnimatedLogo.inline({
    super.key,
    this.path,
    this.logo,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.delay = Duration.zero,
    this.glowColor = Colors.white,
    this.glow,
    this.shine,
    this.idleMotion,
    this.spin,
    this.tint = AppColors.logoColor,
    this.tinted = true,
  }) : style = LogoAnimationStyle.inline;

  bool get _glow => glow ?? (style == LogoAnimationStyle.splash);
  bool get _shine => shine ?? (style == LogoAnimationStyle.splash);
  bool get _idle =>
      idleMotion ??
      (style == LogoAnimationStyle.splash || style == LogoAnimationStyle.auth);
  bool get _spin =>
      spin ??
      (style == LogoAnimationStyle.splash || style == LogoAnimationStyle.auth);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (logo != null) {
      // ودجت جاهزة من برّه — بتترسم زي ما هي من غير تلوين.
      image = logo!;
    } else {
      image = Image.asset(
        path ?? Assets.img.logo.path,
        width: width,
        height: height,
        fit: fit,
      );
      // الشعار خطوط على خلفية شفافة، فـ srcIn بيلوّن الخطوط بس والشفاف
      // بيفضل شفاف — الماركة بتطلع بلون العلامة المسجّلة (أسود).
      if (tinted) {
        image = ColorFiltered(
          colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
          child: image,
        );
      }
    }

    // Innermost first: shine sits on the artwork itself.
    if (_shine) image = LogoShine(child: image);
    if (_glow) image = LogoGlow(color: glowColor, child: image);

    // Entrance.
    switch (style) {
      case LogoAnimationStyle.splash:
        image = _spin
            // لفة كاملة وهو بيكبر — الختم بيتبرم لحد ما يستقر.
            ? RotateIn(
                beginTurns: -1,
                beginScale: 0.5,
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutBack,
                delay: delay,
                child: image,
              )
            : ScaleIn(
                beginScale: 0.5,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutBack,
                delay: delay,
                child: image,
              );
        break;
      case LogoAnimationStyle.auth:
        image = BlurIn(
          blurSigma: 10,
          duration: const Duration(milliseconds: 700),
          delay: delay,
          child: _spin
              ? RotateIn(
                  beginTurns: -1,
                  beginScale: 0.85,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutBack,
                  delay: delay,
                  child: image,
                )
              : ScaleIn(
                  beginScale: 0.85,
                  duration: const Duration(milliseconds: 650),
                  delay: delay,
                  child: image,
                ),
        );
        break;
      case LogoAnimationStyle.inline:
        image = FadeIn(
          duration: const Duration(milliseconds: 350),
          delay: delay,
          child: ScaleIn(
            beginScale: 0.9,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            delay: delay,
            child: image,
          ),
        );
        break;
      case LogoAnimationStyle.none:
        break;
    }

    // Outermost: the never-ending idle motion. On the splash the logo keeps
    // turning slowly while the app boots — انطباع إن فيه حاجة بتتحمّل.
    if (_idle) {
      image = style == LogoAnimationStyle.splash
          ? Pulse(
              minScale: 0.985,
              maxScale: 1.03,
              duration: const Duration(milliseconds: 2200),
              child: _spin
                  ? Spin(
                      duration: const Duration(milliseconds: 9000),
                      child: image,
                    )
                  : image,
            )
          : Floating(
              distance: 5,
              duration: const Duration(milliseconds: 3000),
              child: image,
            );
    }

    return image;
  }
}

// ============================================================================
// COLOR ANIMATIONS
// ============================================================================

/// Smoothly animates to a new [color] whenever it changes, and hands the
/// in-between value to [builder]. Works with text, icons, containers — anything.
///
/// ```dart
/// ColorTransition(
///   color: isActive ? Colors.blue : Colors.grey,
///   builder: (context, c) => Icon(Icons.star, color: c),
/// )
/// ```
class ColorTransition extends StatelessWidget {
  final Color color;
  final Duration duration;
  final Curve curve;
  final Widget Function(BuildContext context, Color color) builder;

  const ColorTransition({
    super.key,
    required this.color,
    required this.builder,
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: color),
      duration: duration,
      curve: curve,
      builder: (context, value, _) => builder(context, value ?? color),
    );
  }
}

/// Cycles endlessly through [colors], handing the current blend to [builder].
///
/// ```dart
/// ColorLoop(
///   colors: const [Colors.blue, Colors.purple, Colors.orange],
///   builder: (context, c) => Icon(Icons.favorite, color: c),
/// )
/// ```
class ColorLoop extends StatefulWidget {
  final List<Color> colors;

  /// Time for one full trip through every colour.
  final Duration duration;
  final Widget Function(BuildContext context, Color color) builder;

  const ColorLoop({
    super.key,
    required this.colors,
    required this.builder,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<ColorLoop> createState() => _ColorLoopState();
}

class _ColorLoopState extends State<ColorLoop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.colors.isEmpty) {
      return widget.builder(context, Colors.transparent);
    }
    if (widget.colors.length == 1) {
      return widget.builder(context, widget.colors.first);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final scaled = _controller.value * widget.colors.length;
        final index = scaled.floor() % widget.colors.length;
        final next = (index + 1) % widget.colors.length;
        final color = Color.lerp(
          widget.colors[index],
          widget.colors[next],
          scaled - scaled.floor(),
        )!;
        return widget.builder(context, color);
      },
    );
  }
}

/// Fades back and forth between two colours forever — a colour "heartbeat".
/// Handy for live badges, recording dots and attention states.
class ColorPulse extends StatefulWidget {
  final Color from;
  final Color to;
  final Duration duration;
  final Widget Function(BuildContext context, Color color) builder;

  const ColorPulse({
    super.key,
    required this.from,
    required this.to,
    required this.builder,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<ColorPulse> createState() => _ColorPulseState();
}

class _ColorPulseState extends State<ColorPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat(reverse: true);
  late final Animation<double> _anim = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final color = Color.lerp(widget.from, widget.to, _anim.value)!;
        return widget.builder(context, color);
      },
    );
  }
}

/// A box whose gradient sweeps continuously — like
/// [AnimatedGradientBackground] but sized to its child, with a radius.
class AnimatedGradientBox extends StatefulWidget {
  final Widget? child;
  final List<Color> colors;
  final Duration duration;
  final double radius;
  final EdgeInsetsGeometry? padding;

  const AnimatedGradientBox({
    super.key,
    this.child,
    this.colors = const [
      Color(0xFF2196F3),
      Color(0xFF9C27B0),
      Color(0xFF2196F3),
    ],
    this.duration = const Duration(seconds: 4),
    this.radius = 16,
    this.padding,
  });

  @override
  State<AnimatedGradientBox> createState() => _AnimatedGradientBoxState();
}

class _AnimatedGradientBoxState extends State<AnimatedGradientBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Slide the gradient one full width per cycle.
        final shift = _controller.value * 2 - 1;
        return Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius.r),
            gradient: LinearGradient(
              begin: Alignment(-1 + shift * 2, -1),
              end: Alignment(1 + shift * 2, 1),
              colors: widget.colors,
              tileMode: TileMode.mirror,
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// ============================================================================
// SHORTHAND EXTENSIONS
// ============================================================================

/// Chainable shorthands so you can write `Text('hi').fadeIn().floating()`
/// instead of nesting widgets by hand.
extension AppAnimationX on Widget {
  Widget fadeIn({
    Duration duration = const Duration(milliseconds: 450),
    Duration delay = Duration.zero,
  }) => FadeIn(duration: duration, delay: delay, child: this);

  Widget slideIn({
    AnimDirection from = AnimDirection.bottom,
    double distance = 32,
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
  }) => SlideIn(
    from: from,
    distance: distance,
    duration: duration,
    delay: delay,
    child: this,
  );

  Widget scaleIn({
    double beginScale = 0.8,
    Duration duration = const Duration(milliseconds: 450),
    Duration delay = Duration.zero,
  }) => ScaleIn(
    beginScale: beginScale,
    duration: duration,
    delay: delay,
    child: this,
  );

  Widget blurIn({
    double blurSigma = 12,
    Duration duration = const Duration(milliseconds: 700),
    Duration delay = Duration.zero,
  }) => BlurIn(
    blurSigma: blurSigma,
    duration: duration,
    delay: delay,
    child: this,
  );

  Widget rotateIn({
    Duration duration = const Duration(milliseconds: 600),
    Duration delay = Duration.zero,
  }) => RotateIn(duration: duration, delay: delay, child: this);

  Widget flipIn({
    Axis axis = Axis.horizontal,
    Duration duration = const Duration(milliseconds: 650),
    Duration delay = Duration.zero,
  }) => FlipIn(axis: axis, duration: duration, delay: delay, child: this);

  Widget floating({double distance = 10}) =>
      Floating(distance: distance, child: this);

  Widget pulse({double maxScale = 1.06}) =>
      Pulse(maxScale: maxScale, child: this);

  Widget wiggle({double turns = 0.02}) => Wiggle(turns: turns, child: this);

  Widget heartBeat({double strength = 0.14}) =>
      HeartBeat(strength: strength, child: this);

  Widget shine({
    BorderRadius borderRadius = BorderRadius.zero,
    Duration duration = const Duration(milliseconds: 1400),
  }) => ShineSweep(borderRadius: borderRadius, duration: duration, child: this);

  Widget kenBurns({Duration duration = const Duration(seconds: 12)}) =>
      KenBurns(duration: duration, child: this);

  Widget tilt3D({double maxTilt = 0.18}) =>
      Tilt3D(maxTilt: maxTilt, child: this);

  Widget tapScale({VoidCallback? onTap, double pressedScale = 0.95}) =>
      TapScale(onTap: onTap, pressedScale: pressedScale, child: this);

  /// Staggered entrance for an item at [index] inside a list or grid.
  Widget staggered(
    int index, {
    Duration stagger = const Duration(milliseconds: 60),
  }) => AnimatedListItem(index: index, stagger: stagger, child: this);

  /// Glow + lift this field while it (or a descendant) has focus.
  Widget focusAnimated({
    Color focusedBorderColor = const Color(0xFF2196F3),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) => FocusAnimatedField(
    focusedBorderColor: focusedBorderColor,
    borderRadius: borderRadius,
    child: this,
  );

  /// Shake this field whenever [errorText] becomes a new message.
  Widget shakeOnError(String? errorText) =>
      ShakeOnError(errorText: errorText, child: this);
}

// ============================================================================
// INTERNAL HELPERS
// ============================================================================

/// Starts [controller] immediately, or after [delay] if it is non-zero.
/// Safe against the widget being disposed during the delay.
void _startAfterDelay(AnimationController controller, Duration delay) {
  if (delay == Duration.zero) {
    controller.forward();
  } else {
    Future.delayed(delay, () {
      if (controller.isAnimating || controller.isCompleted) return;
      try {
        controller.forward();
      } catch (_) {
        // Controller was disposed before the delay elapsed — ignore.
      }
    });
  }
}
