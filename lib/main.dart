import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilepos_beta/asset/themecolor.dart';

import 'homePage.dart';

void main() {
  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false, // Prevents resizing when keyboard is shown
          body: Stack(
            children: const [
              Positioned.fill(child: WaveBackground()), // Ensure background fills the screen
              Center(
                child: const SingleChildScrollView(
                  child: const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text("MobilePOS Portal", style: TextStyle(
                            color: appColor, fontSize: 35, fontWeight: FontWeight.bold
                          ),),
                        ),
                        SizedBox(height: 80),
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: LoginForm(), // Use the LoginForm widget here
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
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Replace with your authentication logic
      if (email == 'parking' && password == 'toilet') {
        showSnackBar(context, 'Login Successful!');
      } else {
        showSnackBar(context, 'Invalid email or password!');
      }
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          SingleChildScrollView(
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter username',
                prefixIcon: const Icon(FontAwesomeIcons.user, color: appColor, size: 20,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                // You can add more complex email validation here if needed
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter Password' ,
              prefixIcon: const Icon(FontAwesomeIcons.lock, color: appColor, size: 20,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              // You can add more complex password validation here if needed
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => _login(context),
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: MaterialButton(
                onPressed: () {

                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => home()), (route) => false);

                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                color:appColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Handle forgot password tap
              showSnackBar(context, 'Forgot Password');
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: appColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaveBackground extends StatelessWidget {
  const WaveBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: const WavePainter(),
    );
  }
}

class WavePainter extends CustomPainter {
  const WavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = appColor ?? appColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.25, size.height * 0.7, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.9, size.width, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..color = appColor ?? appColor
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.9);
    path2.quadraticBezierTo(
        size.width * 0.25, size.height * 0.8, size.width * 0.5, size.height * 0.9);
    path2.quadraticBezierTo(
        size.width * 0.75, size.height, size.width, size.height * 0.9);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
