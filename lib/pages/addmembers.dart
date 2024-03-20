import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_chitty/models/addmember_model.dart';
import 'package:smart_chitty/models/scheme_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
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

  List<String> schemeId = [];
  String avatar = '';
  String idFront = '';
  String idBack = '';

  final formKeys = GlobalKey<FormState>();
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context;
    getSchemeNames();
  }

  Future<void> getSchemeNames() async {
    final box = await Hive.openBox<SchemeModel>('schemes');
    final schemeData = box.values.toList();
    schemeId = schemeData.map((scheme) => scheme.schemeId).toList();

    setState(() {});
  }

  Map<String, String> imagePaths = {
    'avatar': '',
    'frontImage': '',
    'backImage': '',
  };

  var imagePath = 'A';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 330,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      backgroundImage,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: CircleAvatar(
                  backgroundImage: FileImage(File(imagePaths['avatar']!)),
                  // backgroundColor: const Color.fromRGBO(199, 245, 245, 1),
                  // imagePath == '' ?  (File(imagePath)) :
                  radius: 55,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          pickAndSaveImage(context, 'avatar');
                        });
                      },
                      icon: const Icon(
                        Icons.add_photo_alternate,
                        size: 35,
                        color: Color.fromARGB(60, 0, 0, 1),
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
                  child: Form(
                    key: formKeys,
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
                              text: 'Selected Scheme Id :',
                              size: 16,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            DropdownButtonScheme(list: schemeId),
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
                            keyboardtype: TextInputType.number,
                            hintText: 'Enter Your Age',
                            icons: Icons.event,
                            controller: memberAgeController,
                            validator: (name) => name!.isEmpty
                                ? 'Name should be 3 character'
                                : null),
                        gap(height: 12),
                        textField(
                            maxLine: 3,
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
                                    text: 'Front Side',
                                    size: 16,
                                    color: AppColor.fontColor),
                                gap(height: 10),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(imagePaths['frontImage']!)),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        pickAndSaveImage(context, 'frontImage');
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
                                    text: 'Back Side',
                                    size: 16,
                                    color: AppColor.fontColor),
                                gap(height: 10),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(imagePaths['backImage']!)),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        pickAndSaveImage(context, 'backImage');
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
          ),
          Positioned(
            top: 850,
            left: 100,
            right: 100,
            child: buttons(
              buttonAction: () {
                if (formKeys.currentState!.validate()) {
                  saveDataToHive();
                  Navigator.pop(context);
                  // collectDataOnclick(context);
                }
              },
              buttonName: 'Register',
              color: const Color.fromRGBO(0, 205, 255, 1),
            ),
          )
        ],
      ),
    );
  }

  Future<void> pickAndSaveImage(BuildContext context, String location) async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imagePaths[location] = pickedImage.path;
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

  Future<void> saveDataToHive() async {
    try {
      final memberName = memberNameController.text;
      final contactNumber = contactNumController.text.trim();
      final memberAge = memberAgeController.text.trim();
      final memberAddress = memberAddressController.text;
      avatar = imagePaths['avatar']!.toString();
      idFront = imagePaths['frontImage']!.toString();
      idBack = imagePaths['backImage']!.toString();

          if (memberName.isEmpty &&
          contactNumber.isEmpty &&
          memberAge.isEmpty &&
          memberAddress.isEmpty &&
          avatar.isEmpty) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          const SnackBar(
            content: Text('Invalid input. Please check the values.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      final member = MemberModel(
        memberName: memberName,
        contactNumber: contactNumber,
        memberAge: memberAge,
        memberAddress: memberAddress,
        avatar: avatar,
        idFront: idFront,
        idBack: idBack,
        schemeId: dropdownValue,
      );
      final box = await Hive.openBox<MemberModel>('members');
      await box.add(member);

      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Member added successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Failed to add member'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
