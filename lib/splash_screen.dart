import 'package:flutter/material.dart';
import 'package:stock_app/main.dart';
// Import HomePage properly

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _sloganAnimation;
  late Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    // Fade animation for logo
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Slide animation for slogan
    _sloganAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Scaling animation for logo
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();

    // Navigate after splash screen animations
    _navigateToHome();
  }

  // Navigate to home after the splash screen finishes
  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));  // Adjusted time for smooth transition
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()), // Navigate to HomePage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with scaling animation
                      ScaleTransition(
                        scale: _logoScaleAnimation,
                        child: const Icon(
                          Icons.account_balance_wallet,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Wealth Wave',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Slogan sliding animation
                      SlideTransition(
                        position: Tween<Offset>( 
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0),
                        ).animate(_controller),
                        child: const Text(
                          'Your gateway to financial freedom!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDotAnimation(),
                    _buildDotAnimation(),
                    _buildDotAnimation(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Animated dots
  Widget _buildDotAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double scale = 1.0 + (_controller.value * 0.5);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 12.0,
              height: 12.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Wave background
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(0, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.55, size.width * 0.5, size.height * 0.65)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.75, size.width, size.height * 0.6)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
