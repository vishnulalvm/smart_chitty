import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/buttonwidget.dart';
import 'package:smart_chitty/widgets/dropdown_addmember.dart';
import 'package:smart_chitty/widgets/textfieldwidget.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final memberNameController = TextEditingController();
  final contactNumController = TextEditingController();
  final memberAgeController = TextEditingController();
  final memberAddressController = TextEditingController();

  List<String> list = ['Option 1', 'Option 2', 'Option 3'];
  final formKeys = GlobalKey<FormState>();
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context;
  }

  var imagePath = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 330,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/background home.jpeg',
                      ),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(imagePath)),
                    backgroundColor: const Color.fromRGBO(199, 245, 245, 1),
                    radius: 55,
                    child: IconButton(
                        onPressed: () {
                          pickAndSaveImage(context);
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate,
                          size: 35,
                          color: Color.fromARGB(150, 0, 0, 0),
                        )),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250,
              left: 12,
              right: 12,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(199, 245, 245, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        gap(height: 20),
                        BoldText(
                            text: 'Member Details',
                            size: 20,
                            color: AppColor.fontColor),
                        gap(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ModifiedText(
                              text: 'Selected Scheme :',
                              size: 16,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            DropdownButtonScheme(list: list),
                          ],
                        ),
                        gap(height: 20),
                        textField(
                            hintText: 'Enter Your name',
                            icons: Icons.person,
                            controller: memberNameController,
                            validator: (name) => name!.length < 3
                                ? 'Name should be 3 character'
                                : null),
                        gap(height: 12),
                        textField(
                            hintText: 'Enter Your Number',
                            keyboardtype: TextInputType.number,
                            icons: Icons.contacts,
                            controller: contactNumController,
                            validator: (name) => name!.length < 3
                                ? 'Name should be 3 character'
                                : null),
                        gap(height: 12),
                        textField(
                            hintText: 'Enter Your Age',
                            icons: Icons.event,
                            controller: memberAgeController,
                            validator: (name) => name!.length < 3
                                ? 'Name should be 3 character'
                                : null),
                        gap(height: 12),
                        textField(
                            hintText: 'Enter Your Address',
                            icons: Icons.notes,
                            controller: memberAddressController,
                            validator: (name) => name!.length < 3
                                ? 'Name should be 3 character'
                                : null),
                        gap(height: 20),
                        BoldText(
                            text: 'Add Id card Image',
                            size: 20,
                            color: AppColor.fontColor),
                        gap(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                ModifiedText(
                                    text: 'Back',
                                    size: 16,
                                    color: AppColor.fontColor),
                                gap(height: 10),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(imagePath)),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        pickAndSaveImage(context);
                                      },
                                      icon: const Icon(
                                        Icons.add_photo_alternate,
                                        size: 30,
                                        color: Color.fromARGB(60, 0, 0, 1),
                                      )),
                                ),
                              ],
                            ),
                            gap(width: 50),
                            Column(
                              children: [
                                ModifiedText(
                                    text: 'Front',
                                    size: 16,
                                    color: AppColor.fontColor),
                                gap(height: 10),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(imagePath)),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        pickAndSaveImage(context);
                                      },
                                      icon: const Icon(
                                        Icons.add_photo_alternate,
                                        size: 30,
                                        color: Color.fromARGB(60, 0, 0, 0),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 400,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 850,
              left: 50,
              right: 50,
              child: buttons(
                buttonAction: () {
                  if (formKeys.currentState!.validate()) {
                    // collectDataOnclick(context);
                  }
                },
                buttonName: 'Register',
                color: const Color.fromRGBO(0, 205, 255, 1),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickAndSaveImage(BuildContext context) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imagePath = pickedImage.path;
      });
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
}
