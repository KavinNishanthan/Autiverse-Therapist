import 'package:autiverse/core/widgets/my_buttons.dart';
import 'package:autiverse/core/widgets/text_field.dart';
import 'package:autiverse/services/authentication.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Authentication _authService = Authentication();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController centerNameController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  String? _emailError;
  String? _nameError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _centerNameError;

  bool _emailStartedTyping = false;
  bool _nameStartedTyping = false;
  bool _phoneStartedTyping = false;
  bool _passwordStartedTyping = false;
  bool _confirmPasswordStartedTyping = false;
  bool _centerNameStartedTyping = false;

  void _validateEmail(String value) {
    if (_emailStartedTyping) {
      setState(() {
        _emailError = _isValidEmail(value) ? null : "Invalid email address";
      });
    }
  }

  void _validateName(String value) {
    if (_nameStartedTyping) {
      setState(() {
        _nameError = value.isNotEmpty ? null : "Name cannot be empty";
      });
    }
  }

  void _validatePhone(String value) {
    if (_phoneStartedTyping) {
      setState(() {
        _phoneError =
            _isValidPhoneNumber(value) ? null : "Invalid phone number";
      });
    }
  }

  void _validatePassword(String value) {
    if (_passwordStartedTyping) {
      setState(() {
        _passwordError = value.isNotEmpty ? null : "Password cannot be empty";
      });
      _validateConfirmPassword(confirmPasswordController.text);
    }
  }

  void _validateConfirmPassword(String value) {
    if (_confirmPasswordStartedTyping) {
      setState(() {
        _confirmPasswordError =
            value == passwordController.text ? null : "Passwords do not match";
      });
    }
  }

  void _validateCenterName(String value) {
    if (_centerNameStartedTyping) {
      setState(() {
        _centerNameError =
            value.isNotEmpty ? null : "Center name cannot be empty";
      });
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r"^\d{10}$");
    return phoneRegex.hasMatch(phoneNumber);
  }

  bool _isValidName(String name) {
    final nameRegex = RegExp(r"^[a-zA-Z\s]+$");
    return nameRegex.hasMatch(name);
  }

  // bool _isValidPassword(String password) {
  //   final passwordRegex =
  //       RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  //   return passwordRegex.hasMatch(
  //       password); // This ensures password has an uppercase letter, a number, and a special character.
  // }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_emailError == null &&
        _nameError == null &&
        _phoneError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _centerNameError == null) {
      String res = await _authService.signUpUser(
        email: emailController.text.trim(),
        password: passwordController.text,
        name: nameController.text.trim(),
        phone: phoneNumberController.text.trim(),
        centername: centerNameController.text.trim(),
      );

      setState(() {
        _isLoading = false;
      });

      if (res == "success") {
        Navigator.pushNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix the errors and try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  right: 10.0), // Adds spacing to the right of the image
              child: Image.asset(
                'assets/images/decoration_images/vrlogo.jpg', // Replace with your image path
                height: 58, // Adjust as needed
                width: 58,
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'Auti', // Regular part
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Color.fromARGB(255, 95, 103, 107),
                ),
                children: [
                  TextSpan(
                    text: ' Verse', // Decorated part
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5), // Shadow position
                          blurRadius: 3.0, // Shadow blur
                          color: Colors.grey, // Shadow color
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 6.5,
                child:
                    Image.asset("assets/images/decoration_images/signup.jpg"),
              ),
              TextFieldInput(
                textEditingController: nameController,
                hintText: "Enter Your Name",
                icon: Icons.person,
                textInputType: TextInputType.text,
                errorText: _nameError,
                onChanged: (value) {
                  if (!_nameStartedTyping) {
                    setState(() {
                      _nameStartedTyping = true;
                    });
                  }
                  _validateName(value);
                },
              ),
              TextFieldInput(
                textEditingController: centerNameController,
                hintText: "Enter Center Name",
                icon: Icons.business,
                textInputType: TextInputType.text,
                errorText: _centerNameError,
                onChanged: (value) {
                  if (!_centerNameStartedTyping) {
                    setState(() {
                      _centerNameStartedTyping = true;
                    });
                  }
                  _validateCenterName(value);
                },
              ),
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
                textEditingController: phoneNumberController,
                hintText: "Enter Your Phone Number",
                icon: Icons.phone,
                textInputType: TextInputType.phone,
                errorText: _phoneError,
                onChanged: (value) {
                  if (!_phoneStartedTyping) {
                    setState(() {
                      _phoneStartedTyping = true;
                    });
                  }
                  _validatePhone(value);
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
              TextFieldInput(
                textEditingController: confirmPasswordController,
                hintText: "Confirm Your Password",
                icon: Icons.lock,
                textInputType: TextInputType.text,
                isPass: true,
                obscureText: !_isConfirmPasswordVisible,
                onIconPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                errorText: _confirmPasswordError,
                onChanged: (value) {
                  if (!_confirmPasswordStartedTyping) {
                    setState(() {
                      _confirmPasswordStartedTyping = true;
                    });
                  }
                  _validateConfirmPassword(value);
                },
              ),
              SizedBox(height: 15),
              MyButtons(
                onTap: _registerUser,
                text: "Register",
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an accunt?",
                    style: TextStyle(fontSize: 12),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(" Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.blue)))
                ],
              ),
              if (_isLoading)
                ModalBarrier(
                  dismissible: false,
                  color: Colors.black.withOpacity(0.5),
                ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
