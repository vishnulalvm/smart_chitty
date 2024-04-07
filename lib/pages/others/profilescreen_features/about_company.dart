import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_chitty/pages/tabs/home.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/models/registration_model.dart';
import 'package:smart_chitty/services/models/reminder_model.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/global/textfieldwidget.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class AboutCompany extends StatefulWidget {
  const AboutCompany({super.key});

  @override
  State<AboutCompany> createState() => _AboutCompanyState();
}

class _AboutCompanyState extends State<AboutCompany> {
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
      backgroundColor: AppColor.primaryColor,
      appBar:
          customAppBar(title: 'About', onpresed: (vlaue) {}, showMenu: false),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                enableFeedback: true,
                subtitle: const ModifiedText(
                  text: 'Company Details',
                  size: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                shape: const Border(),
                title: ModifiedText(
                  text: 'About',
                  size: 16,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(File(companyLogo)),
                            radius: 25,
                          ),
                          rowText(
                              firstText: 'Company Name',
                              secoundText: companyName),
                          gap(height: 12),
                          const AutoSizeText(
                            "The word 'Chit' suggests the origin of Chit Funds. 'Chit' means a written note on a small piece of paper. The Malayalam equivalent for the word 'chitty' is 'Kuri,' which has been derived from 'Kurippu' (a piece of writing or script). The term 'Chitty' or 'Kuri' is derived from the root word 'lot.' The foreman (person who operates chitties) writes the names of each subscriber on separate pieces of paper and folds them in such a way that the name written on the paper is not visible to the assembled people there.",
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            gap(height: 12),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                enableFeedback: true,
                subtitle: const ModifiedText(
                  text: 'Option for forgot password',
                  size: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                shape: const Border(),
                title: ModifiedText(
                  text: 'Change Company Details',
                  size: 16,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 580,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                icon: Icon(Icons.add_a_photo,
                                    color: imagePath.isEmpty
                                        ? Colors.black
                                        : Colors.transparent)),
                          ),
                          gap(height: 12),
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
                          gap(height: 10),
                          ElevatedButton(
                              onPressed: () {
                                collectDataOnclick(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            gap(height: 12),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ExpansionTile(
                collapsedBackgroundColor: Colors.white,
                enableFeedback: true,
                subtitle: const ModifiedText(
                  text: 'For Deleta All Data',
                  size: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                shape: const Border(),
                title: ModifiedText(
                  text: 'Delete All Datas',
                  size: 16,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ModifiedText(
                              text: 'Delete All Datas :',
                              size: 16,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w600,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showLogoutDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
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

  void updateImagePath(String newImagePath) {
    setState(() {
      imagePath = newImagePath;
    });
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
    insertData(data, companyName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registration Successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to Clear All?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final paymentDb = await Hive.openBox<PaymentModel>('payments');
                await paymentDb.clear();
                final companyDb =
                    await Hive.openBox<RegistrationModel>('company_data');
                await companyDb.clear();
                final schemeDB = await Hive.openBox<SchemeModel>('schemes');
                await schemeDB.clear();
                final collectionBox =
                    await Hive.openBox<MonthlyCollection>('collections');
                await collectionBox.clear();
                final box = await Hive.openBox<MemberModel>('members');
                await box.clear();
                final box2 = await Hive.openBox<ReminderModel>('reminders');
                await box2.clear();
                _context!.pushReplacement('login');
              },
              child: const Text('delete'),
            ),
          ],
        );
      },
    );
  }
}
