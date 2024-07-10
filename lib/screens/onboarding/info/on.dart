import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:system_auth/screens/authenticate/sign_in.dart';
import 'package:confetti/confetti.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnboardingScreen11(),
    );
  }
}

class OnboardingScreen11 extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen11> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              IntroPage1(
                onNext: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
              IntroPage2(
                onGetStarted: () {
                  // Navigate to the sign-up page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.black : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navigate to sign-in page
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
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
}

class IntroPage1 extends StatelessWidget {
  final VoidCallback onNext;

  IntroPage1({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Lottie.asset(
  'assets/caterpillar.json',
  repeat: true,
  width: 200,
  height: 200,
),            // App logo or icon
            // Image.asset(
            //   'assets/cat.gif', // Replace with your app logo path
            //   width: 200,
            //   height: 200,
            // ),
            SizedBox(height: 20),
            // Title
            Center(
              child: Text(
                'Hello Smartypants and welcome to Soma App',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Subtitle
            Text(
              'Unlock the world of knowledge and excel in your studies with Soma App',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Next button
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(400, 50),
                backgroundColor: Color(0xFF397EF3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class IntroPage2 extends StatefulWidget {
  final VoidCallback onGetStarted;

  IntroPage2({required this.onGetStarted});

  @override
  _IntroPage2State createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/caterpillar.json',
                        repeat: true,
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Lets get started!',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: widget.onGetStarted,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 50),
                    backgroundColor: const Color(0xFF397EF3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          colors: const [
            Colors.green,
            Colors.blue,
            Colors.pink,
            Colors.orange,
            Colors.purple
          ],
        ),
      ],
    );
  }
}
