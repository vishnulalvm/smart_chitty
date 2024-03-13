import 'package:flutter/material.dart'; // Assuming this is correct
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/dropdown_scheme.dart';
import 'package:smart_chitty/widgets/textfield_schem.dart';

class AddSchemeBottomSheet extends StatefulWidget {
  const AddSchemeBottomSheet({super.key});

  @override
  State<AddSchemeBottomSheet> createState() => _AddSchemeBottomSheetState();
}

class _AddSchemeBottomSheetState extends State<AddSchemeBottomSheet> {
  final timePeriodController = TextEditingController();
  final chitAmountController = TextEditingController();
  final subscribersController = TextEditingController();
  final commissionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.1,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scroll) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: AppColor.primaryColor, // Change this to your desired color
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scroll,
                padding: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    // Use Column for vertical layout
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoldText(
                              text: 'New Schemes',
                              color: AppColor.fontColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      customTextField(
                        hintText: 'Enter Period',
                        title: 'Time Period :',
                        controller: timePeriodController,
                        validator: (value) => value!.length < 3
                            ? 'Name should be 3 characters'
                            : null,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 40),
                      customTextField(
                        hintText:
                            'Enter Amount', // Assuming "Amount" is intended
                        title: 'Chit Amount :',
                        controller: chitAmountController,
                        validator: (value) =>
                            value!.length < 3 // Adjust validation logic
                                ? 'Amount should be 3 characters'
                                : null,
                        keyboardType: TextInputType.number, // Set keyboard type
                      ),
                      SizedBox(height: 40),
                      customTextField(
                        hintText:
                            'Enter Amount', // Assuming "Amount" is intended
                        title: 'Chit Amount :',
                        controller: chitAmountController,
                        validator: (value) =>
                            value!.length < 3 // Adjust validation logic
                                ? 'Amount should be 3 characters'
                                : null,
                        keyboardType: TextInputType.number, // Set keyboard type
                      ),
                      SizedBox(height: 40),
                      customTextField(
                        hintText:
                            'Enter Amount', // Assuming "Amount" is intended
                        title: 'Chit Amount :',
                        controller: chitAmountController,
                        validator: (value) =>
                            value!.length < 3 // Adjust validation logic
                                ? 'Amount should be 3 characters'
                                : null,
                        keyboardType: TextInputType.number, // Set keyboard type
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Time Period :'),
                          DropdownTimePreriod(),
                        ],
                      ),
                      // ... Add more customTextField widgets for subscribers and commission
                      const SizedBox(height: 30),
                      const ExpansionTile(
                        shape: Border(),
                        trailing: Icon(Icons.arrow_drop_down),
                        title: Text('Additional Details'),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                           BoldText(text: 'Total Collections :', size: 20, color: Colors.black),
                            BoldText(text: '₹300000', size: 24, color: Colors.black),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                           BoldText(text: 'Total Collections :', size: 20, color: Colors.black),
                            BoldText(text: '₹300000', size: 24, color: Colors.black),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 15,
                  left: 10,
                  right: 10,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    label: Text('Add New Scheme'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                       Navigator.pop(context);
                    }
                      // Button action
                    },
                  )),
              Positioned(
                  top: 25,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ))),
            ],
          ),
        );
      },
    );
  }
}
