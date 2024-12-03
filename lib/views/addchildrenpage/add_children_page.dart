import 'package:autiverse/core/widgets/my_buttons.dart';
import 'package:autiverse/core/widgets/text_field.dart';
import 'package:flutter/material.dart'; // For date formatting

class AddChildrenPage extends StatefulWidget {
  const AddChildrenPage({super.key});

  @override
  _AddChildrenPageState createState() => _AddChildrenPageState();
}

class _AddChildrenPageState extends State<AddChildrenPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController parentMobileController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();

  String? selectedGender;
  String? selectedBloodGroup;
  final _formKey = GlobalKey<FormState>();
  bool _isFormSubmitted = false;

  String? _validateField(String? value, String fieldName) {
    if (!_isFormSubmitted)
      return null; // Do not validate until form is submitted
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    if (fieldName == 'Age' && int.tryParse(value) == null) {
      return 'Age must be a valid number';
    }
    if (fieldName == 'Email' &&
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  void _submitForm() {
    setState(() {
      _isFormSubmitted = true;
    });
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Child added successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Children',
          style: TextStyle(
            fontFamily: 'conf',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextFieldInput(
                textEditingController: nameController,
                hintText: 'Name',
                icon: Icons.person,
                textInputType: TextInputType.name,
                errorText: _validateField(nameController.text, 'Name'),
              ),
              // Age Field
              TextFieldInput(
                textEditingController: ageController,
                hintText: 'Age',
                icon: Icons.cake,
                textInputType: TextInputType.number,
                errorText: _validateField(ageController.text, 'Age'),
              ),
              // Date of Birth
              TextFieldInput(
                textEditingController: dobController,
                hintText: 'Date of Birth (YYYY-MM-DD)',
                icon: Icons.calendar_today,
                textInputType: TextInputType.datetime,
                errorText: _validateField(dobController.text, 'Date of Birth'),
                onChanged: (value) {}, // Allow manual input
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        hint: const Text(
                          'Select',
                          style: TextStyle(color: Colors.black45, fontSize: 16),
                        ),
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Add small space here
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        value: selectedBloodGroup,
                        hint: const Text(
                          'Select',
                          style: TextStyle(color: Colors.black45, fontSize: 16),
                        ),
                        items:
                            ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                                .map((group) => DropdownMenuItem<String>(
                                      value: group,
                                      child: Text(
                                        group,
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ))
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBloodGroup = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Blood Group',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Email Field
              TextFieldInput(
                textEditingController: emailController,
                hintText: 'Email',
                icon: Icons.email,
                textInputType: TextInputType.emailAddress,
                errorText: _validateField(emailController.text, 'Email'),
              ),
              // Parent Mobile Number
              TextFieldInput(
                textEditingController: parentMobileController,
                hintText: 'Parent Mobile Number',
                icon: Icons.phone,
                textInputType: TextInputType.phone,
                errorText: _validateField(
                    parentMobileController.text, 'Parent Mobile Number'),
              ),
              // Father Name
              TextFieldInput(
                textEditingController: fatherNameController,
                hintText: 'Father Name',
                icon: Icons.person,
                textInputType: TextInputType.name,
                errorText:
                    _validateField(fatherNameController.text, 'Father Name'),
              ),
              // Mother Name
              TextFieldInput(
                textEditingController: motherNameController,
                hintText: 'Mother Name',
                icon: Icons.person,
                textInputType: TextInputType.name,
                errorText:
                    _validateField(motherNameController.text, 'Mother Name'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: MyButtons(
                  onTap: _submitForm,
                  text: "+ Add Child",
                ),
              ),
              // Submit Button
            ],
          ),
        ),
      ),
    );
  }
}
