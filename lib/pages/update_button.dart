import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/buttonwidget.dart';
import 'package:smart_chitty/widgets/dropdown_addmember.dart';
import 'package:smart_chitty/widgets/textfield_schem.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';

class UpdateButton extends StatefulWidget {
  const UpdateButton({super.key});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  final chitAmountController = TextEditingController();
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
                decoration:  BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        backgroundImage,
                      ),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ModifiedText(
                            text: 'Selected Scheme :',
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          DropdownButtonScheme(list: list),
                        ],
                      ),
                      gap(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ModifiedText(
                            text: 'Selected Subscriber :',
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          DropdownButtonScheme(list: list),
                        ],
                      ),
                    ],
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
                            text: 'Payment Details',
                            size: 20,
                            color: AppColor.fontColor),
                        gap(height: 20),
                         customTextField(
                        hintText:
                            'Enter Amount', // Assuming "Amount" is intended
                        title: 'Chit Amount :',
                        // controller: chitAmountController,
                        validator: (value) =>
                            value!.length < 3 // Adjust validation logic
                                ? 'Amount should be 3 characters'
                                : null,
                        keyboardType: TextInputType.number, // Set keyboard type
                      ),
                        gap(height: 12),
                         customTextField(
                        hintText:
                            'Enter Amount', // Assuming "Amount" is intended
                        title: 'Chit Amount :',
                        // controller: chitAmountController,
                        validator: (value) =>
                            value!.length < 3 // Adjust validation logic
                                ? 'Amount should be 3 characters'
                                : null,
                        keyboardType: TextInputType.number, // Set keyboard type
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
              left: 100,
              right: 100,
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
