import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/auth/register.dart';
import 'package:smart_chitty/utils/constants.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/widgets/global/buttonwidget.dart';
import 'package:smart_chitty/widgets/global/textfieldwidget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    getUserCredentials();
    _context = context; // Store context in state variable
  }

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final formKeypass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(loginBackground), fit: BoxFit.cover),
        ),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login Now!',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black54,
                    // Text color
                  ),
                ),
                widgetSpace(height: 20),
                const Text(
                  'Hello,Welcome back',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    // Text color
                  ),
                ),
                widgetSpace(height: 20),
                textField(
                    hintText: 'Enter Username',
                    icons: Icons.person,
                    controller: userNameController,
                    key: formKey,
                    validator: (name) =>
                        name!.length < 3 ? 'Name should be 3 character' : null),
                widgetSpace(height: 20),
                textField(
                    hintText: 'Enter password',
                    icons: Icons.lock,
                    controller: passwordController,
                    key: formKeypass,
                    validator: (password) => password!.length < 3
                        ? 'Name should be 3 character'
                        : null),
                widgetSpace(height: 20),
                buttons(
                  buttonAction: () {
                    if (formKey.currentState!.validate()) {
                      checkLogin(context);
                    }
                  },
                  buttonName: 'Sign In',
                  color: const Color.fromRGBO(0, 205, 255, 1),
                ),
                widgetSpace(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        // Text color
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetSpace({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Future<void> checkLogin(BuildContext context) async {
    getUserCredentials();
    for (final data in allData) {
      final userId = data.userId;
      final password = data.password;
      if (userId == userNameController.text &&
          password == passwordController.text) {
        final sharedPre = await SharedPreferences.getInstance();
        sharedPre.setBool(saveKeyName, true);
        Navigator.of(_context!).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid username or password'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
