import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/models/registration_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/textfieldwidget.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class ChangeUserPassword extends StatefulWidget {
  const ChangeUserPassword({super.key});

  @override
  State<ChangeUserPassword> createState() => _ChangeUserPasswordState();
}

class _ChangeUserPasswordState extends State<ChangeUserPassword> {
  String companyname = '';
  String imagePath = '';
  String phoneNumber = '';
  String whatsappLink = '';

  final userIdSignupController = TextEditingController();
  final passwordSignupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
          title: 'Change User Name & Password', onpresed: (value) {},showMenu: false),
      body: Padding(
        padding: const EdgeInsets.only(top: 12,left: 12,right: 12),
        child: ClipRRect(
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
              text: 'Change User Name & Password',
              size: 16,
              color: AppColor.fontColor,
              fontWeight: FontWeight.w500,
            ),
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                height: 260,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
      ),
    );
  }

  void collectDataOnclick(context) async {
    final userId = userIdSignupController.text.trim();
    final password = passwordSignupController.text.trim();

    if (userId.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Text field Can\'t Empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final companyDb = await Hive.openBox<RegistrationModel>('company_data');
    // RegistrationModel? existingModel = companyDb.get('company_data');

    try {
      final updatedModel = RegistrationModel(
        companyName: companyname,
        imagePath: imagePath,
        phoneNumber: phoneNumber,
        whatsappLink: whatsappLink,
        password: password,
        userId: userId,
      );

      await companyDb.put(companyname, updatedModel);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Password & username updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No existing company credentials found'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void getCredentials() async {
    final companyDb = await Hive.openBox<RegistrationModel>('company_data');
    RegistrationModel? existingModel = companyDb.get('company_data');
    if (existingModel != null) {
      companyname = existingModel.companyName;
      imagePath = existingModel.imagePath;
      phoneNumber = existingModel.phoneNumber;
      whatsappLink = existingModel.whatsappLink;
    }
  }
}
