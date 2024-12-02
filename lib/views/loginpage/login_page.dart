import 'package:autiverse/core/widgets/app_drawer.dart';
import 'package:autiverse/core/widgets/common_app_bar.dart';
import 'package:autiverse/core/widgets/text_field.dart';
import 'package:autiverse/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:autiverse/core/widgets/my_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  bool _emailStartedTyping = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _validateEmail(String value) {
    if (_emailStartedTyping) {
      setState(() {
        _emailError = _isValidEmail(value) ? null : "Invalid email address";
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordError = "Password cannot be empty";
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  Future<void> _handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Input validation
    setState(() {
      _emailError = email.isEmpty ? "Email cannot be empty" : null;
      _passwordError = password.isEmpty ? "Password cannot be empty" : null;
    });

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      String result =
          await Authentication().loginUser(email: email, password: password);

      setState(() {
        _isLoading = false;
      });

      if (result == "success") {
        Navigator.pushNamed(context, '/home');
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Text(
                  "Invalid Credentials",
                  style: TextStyle(fontSize: 16),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/images/decoration_images/vrlogo.jpg',
                height: 58,
                width: 58,
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Auti',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 95, 103, 107),
                ),
                children: [
                  TextSpan(
                    text: ' Verse',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          blurRadius: 3.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.7,
                      child: Image.asset(
                        "assets/images/decoration_images/login.jpg",
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFieldInput(
                      textEditingController: emailController,
                      hintText: "Enter Your Email",
                      icon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      errorText: _emailError,
                      onChanged: (value) {
                        if (!_emailStartedTyping) {
                          setState(() {
                            _emailStartedTyping = true;
                          });
                        }
                        _validateEmail(value);
                      },
                    ),
                    TextFieldInput(
                      textEditingController: passwordController,
                      hintText: "Enter Your Password",
                      icon: Icons.lock,
                      textInputType: TextInputType.text,
                      isPass: true,
                      obscureText: !_isPasswordVisible,
                      onIconPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      errorText: _passwordError,
                      onChanged: _validatePassword,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    MyButtons(
                      onTap: _handleLogin,
                      text: "Login",
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            " SignUp",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            ModalBarrier(
              dismissible: false,
              color: Colors.black.withOpacity(0.5),
            ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
