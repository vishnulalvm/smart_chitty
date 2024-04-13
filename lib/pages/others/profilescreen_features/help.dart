import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:smart_chitty/widgets/features/stepper_content.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({super.key});

  @override
  State<HelperScreen> createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Help', onpresed: (value) {},showMenu: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Theme(
                      data: ThemeData(
                        colorScheme: const ColorScheme.light(
                          primary:  Color.fromRGBO(2, 199, 192, 1), // Sets primary color for controls
                        ),
                      ),
                      child: Stepper(
                          currentStep: _currentStep,
                          onStepContinue: () {
                            if (_currentStep < 6) {
                              setState(() {
                                _currentStep += 1;
                              });
                            } else {
                              // Last step reached
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Tutorial completed')),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          onStepCancel: () {
                            if (_currentStep > 0) {
                              setState(() {
                                _currentStep -= 1;
                              });
                            }
                          },
                          steps: [
                            Step(
                              title: const Icon(
                                Icons.handshake_rounded,
                                size: 40,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 0,
                              content: const StepperContent(
                                imagePath: 'assets/images/home.jpg',
                                text: 'This is Begining',
                              ),
                            ),
                            Step(
                              title: const Icon(
                                Icons.add_box_rounded,
                                size: 45,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 1,
                              content: const StepperContent(
                                imagePath: 'assets/images/update.jpg',
                                text: 'Update Payment',
                              ),
                            ),
                            Step(
                              title: const Icon(
                                Symbols.group,
                                size: 40,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 2,
                              content: const StepperContent(
                                imagePath: 'assets/images/members.jpg',
                                text: 'Showing Member Screen',
                              ),
                            ),
                            Step(
                              title: const Icon(
                                Symbols.note_stack_add_rounded,
                                size: 45,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 3,
                              content: const StepperContent(
                                imagePath: 'assets/images/addmember.jpg',
                                text: 'This is the\n Add Member',
                              ),
                            ),
                            Step(
                              title: const Icon(
                                Icons.notification_important_rounded,
                                size: 45,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 4,
                              content: const StepperContent(
                                imagePath: 'assets/images/profile.jpg',
                                text: 'This is Profile\nscreen',
                              ),
                            ),
                            Step(
                              title: const Icon(
                                Symbols.finance,
                                size: 45,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 5,
                              content: const StepperContent(
                                imagePath: 'assets/images/statics.jpg',
                                text: 'Showing total Stastics\n full chitty',
                              ),
                            ),
                            Step(
                              title: const Icon(
                                Symbols.keyboard_command_key,
                                size: 45,
                                color: Color.fromRGBO(1, 82, 136, 1),
                              ),
                              isActive: _currentStep >= 6,
                              content: const StepperContent(
                                imagePath: 'assets/images/addscheme.jpg',
                                text: 'Add new Chits by \n this features',
                              ),
                            ),
                          ]),
                    )))
          ],
        ),
      ),
    );
  }
}
