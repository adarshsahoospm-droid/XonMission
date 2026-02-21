import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_theme.dart';
import 'network_hero_painter.dart';

class CandidateLandingScreen extends StatefulWidget {
  const CandidateLandingScreen({super.key});

  @override
  State<CandidateLandingScreen> createState() => _CandidateLandingScreenState();
}

class _CandidateLandingScreenState extends State<CandidateLandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _heroController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();

    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _heroController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Animation<double> _stagger(int start, int length) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Interval(start / 100, (start + length) / 100, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    const purple = Color(0xFF7C3AED);
    const darkGray = Color(0xFF111827);
    const midGray = Color(0xFF6B7280);
    const lightGray = Color(0xFF9CA3AF);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                purple.withValues(alpha: 0.02),
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Header
                  AnimatedBuilder(
                    animation: _entranceController,
                    builder: (context, child) {
                      final a = _stagger(0, 14);
                      return Opacity(
                        opacity: a.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - a.value)),
                          child: child,
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                purple.withValues(alpha: 0.2),
                                purple.withValues(alpha: 0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: purple.withValues(alpha: 0.4),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: purple.withValues(alpha: 0.12),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: purple,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Niche Hiring',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: darkGray,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Hero graphic (animated)
                  Center(
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_heroController, _pulseController]),
                      builder: (context, child) {
                        final expand = CurvedAnimation(
                          parent: _heroController,
                          curve: Curves.easeOutCubic,
                        ).value;
                        final pulse = Curves.easeInOut.transform(_pulseController.value);
                        return CustomPaint(
                          size: const Size(280, 220),
                          painter: NetworkHeroPainter(
                            primaryColor: purple,
                            dotCount: 14,
                            t: expand,
                            pulse: pulse,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Headline
                  AnimatedBuilder(
                    animation: _entranceController,
                    builder: (context, child) {
                      final a = _stagger(14, 18);
                      return Opacity(
                        opacity: a.value,
                        child: Transform.translate(
                          offset: Offset(0, 24 * (1 - a.value)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get Hired.',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: darkGray,
                            height: 1.15,
                            letterSpacing: -0.5,
                          ),
                        ),
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [purple, purple.withValues(alpha: 0.85)],
                          ).createShader(bounds),
                          child: Text(
                            'Instantly.',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 38,
                              height: 1.15,
                              letterSpacing: -0.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedBuilder(
                    animation: _entranceController,
                    builder: (context, child) {
                      final a = _stagger(32, 16);
                      return Opacity(
                        opacity: a.value,
                        child: Transform.translate(
                          offset: Offset(0, 16 * (1 - a.value)),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'The AI-first platform for verified immediate joiners.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: midGray,
                        height: 1.4,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Buttons
                  AnimatedBuilder(
                    animation: _entranceController,
                    builder: (context, child) {
                      final a = _stagger(48, 22);
                      return Opacity(
                        opacity: a.value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - a.value)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              backgroundColor: purple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward_rounded, size: 22),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/login'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              side: BorderSide(
                                color: const Color(0xFFE5E7EB),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              foregroundColor: darkGray,
                            ),
                            child: const Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Trust strip
                  AnimatedBuilder(
                    animation: _entranceController,
                    builder: (context, child) {
                      final a = _stagger(70, 30);
                      return Opacity(
                        opacity: a.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - a.value)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40 + 24 + 24 + 8,
                              height: 40,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    child: _buildAvatar(const Color(0xFFBFDBFE)),
                                  ),
                                  Positioned(
                                    left: 24,
                                    child: _buildAvatar(const Color(0xFFBBF7D0)),
                                  ),
                                  Positioned(
                                    left: 48,
                                    child: _buildAvatar(const Color(0xFFFDE68A)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: purple,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: purple.withValues(alpha: 0.35),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '+5k',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              size: 18,
                              color: purple,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'TRUSTED BY 5,000+ VERIFIED TALENT',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: lightGray,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 134,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
