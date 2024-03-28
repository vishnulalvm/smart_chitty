import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/services/models/registration_model.dart';
import 'package:smart_chitty/auth/login.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/widgets/global/buttonwidget.dart';
import 'package:smart_chitty/widgets/global/textfieldwidget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final chittyNameController = TextEditingController();

  final contactNumController = TextEditingController();

  final whatsappLinkController = TextEditingController();

  final userIdSignupController = TextEditingController();

  final passwordSignupController = TextEditingController();
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context; // Store context in state variable
  }

  final formKeys = GlobalKey<FormState>();
  var imagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: AssetImage(loginBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKeys,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(File(imagePath)),
                            backgroundColor:
                                const Color.fromRGBO(199, 245, 245, 1),
                            radius: 50,
                            child: IconButton(
                                onPressed: () {
                                  pickAndSaveImage(context);
                                },
                                icon:  Icon(
                                  Icons.add_a_photo,
                                  color:imagePath.isEmpty? Colors.black: Colors.transparent
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Register Your Chitty',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      textField(
                          hintText: 'Enter Chitty Name',
                          icons: Icons.domain,
                          controller: chittyNameController,
                          validator: (name) => name!.length < 3
                              ? 'Name should be 3 character'
                              : null),
                      const SizedBox(height: 20),
                      textField(
                          keyboardtype: TextInputType.phone,
                          hintText: 'Enter Contact Number',
                          icons: Icons.contacts,
                          controller: contactNumController,
                          validator: (contact) => contact!.length < 10
                              ? 'Contact should be 10 character'
                              : null),
                      const SizedBox(height: 20),
                      textField(
                          hintText: 'Whatsapp Group Link',
                          icons: Icons.chat,
                          controller: whatsappLinkController,
                          validator: (link) => link!.length < 3
                              ? 'Whatsapp Link should be 3 character'
                              : null),
                      const SizedBox(height: 20),
                      textField(
                          hintText: 'Enter User id',
                          icons: Icons.account_box,
                          controller: userIdSignupController,
                          validator: (userId) => userId!.length < 3
                              ? 'User Id should be 4 character'
                              : null),
                      const SizedBox(height: 20),
                      textField(
                          hintText: 'Enter password',
                          icons: Icons.lock,
                          controller: passwordSignupController,
                          validator: (password) => password!.length < 3
                              ? 'Name should be 3 character'
                              : null),
                      const SizedBox(height: 20),
                      buttons(
                        buttonAction: () {
                          if (formKeys.currentState!.validate()) {
                            collectDataOnclick(context);
                          }
                        },
                        buttonName: 'Register',
                        color: const Color.fromRGBO(0, 205, 255, 1),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'All ready Register account?',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                             context.pushReplacement('/login');
                            },
                            child: const Text(
                              'Sign In',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickAndSaveImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      updateImagePath(pickedImage.path);
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Image saved successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('No image selected.'),
        ),
      );
    }
  }

  void collectDataOnclick(context) async {
    final chittyName = chittyNameController.text.trim();
    final contactNum = contactNumController.text.trim();
    final whatsapplink = whatsappLinkController.text.trim();
    final userId = userIdSignupController.text.trim();
    final password = passwordSignupController.text.trim();
// cheching value is empty
    if (chittyName.isEmpty &&
        contactNum.isEmpty &&
        whatsapplink.isEmpty &&
        userId.isEmpty &&
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Text field Can\'t Empty'),
          duration: Duration(seconds: 2),
        ),
      );
    }
    // converting the variable value from textfield to a modelclass format
    final data = RegistrationModel(
        companyName: chittyName,
        password: password,
        phoneNumber: contactNum,
        userId: userId,
        whatsappLink: whatsapplink,
        imagePath: imagePath);
    // passing and adding data from textfield to hive
    insertData(data);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration Successful'),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  void updateImagePath(String newImagePath) {
  setState(() {
    imagePath = newImagePath;
  });
}
}