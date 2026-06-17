import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  Future<void> _goToLogin() async {
    await Future.delayed(
      const Duration(
        seconds: 4,
      ),
    );

    if (!mounted) {
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      '/login',
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/dcsa_logo.png',
                  height: 180,
                ),

                const SizedBox(
                  height: 24,
                ),

                const Text(
                  'Darke County Soccer Association',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Text(
                  'Youth Soccer League Management',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors
                        .grey
                        .shade700,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors
                        .grey
                        .shade200,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: const Text(
                    'Current Season: Fall 2026',
                    style: TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                const Text(
                  'Teams • Players • Schedules • Standings',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 48,
                ),

                const CircularProgressIndicator(),

                const SizedBox(
                  height: 24,
                ),

                const Text(
                  'Loading...',
                ),

                const SizedBox(
                  height: 12,
                ),

                const Text(
                  'Version 0.8.0',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}