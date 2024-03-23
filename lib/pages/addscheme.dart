import 'dart:core';
import 'package:flutter/material.dart'; // Assuming this is correct
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/models/scheme_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/dropdown_timeperiod.dart';
import 'package:smart_chitty/widgets/textfield_schem.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSchemeBottomSheet extends StatefulWidget {
  const AddSchemeBottomSheet({super.key});

  @override
  State<AddSchemeBottomSheet> createState() => _AddSchemeBottomSheetState();
}

class _AddSchemeBottomSheetState extends State<AddSchemeBottomSheet> {
  int lastGeneratedId = 100;
  final noOfInstallmentController = TextEditingController();
  final totalMembersController = TextEditingController();
  final subscriptionController = TextEditingController();
  final commissionController = TextEditingController();
  DateTime? _selectedDate;
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context;
  }

  final formKey = GlobalKey<FormState>();
  var selectedTimePeriodType = 'Daily';

  Future<int> getLastGeneratedId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastGeneratedId') ?? 100;
  }

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: BoldText(
                          text: 'New Schemes',
                          color: AppColor.fontColor,
                          size: 24,
                        ),
                      ),
                      gap(height: 20),
                      customTextField(
                        hintText: 'No.Of Installment in Months',
                        title: 'No.Of Installment :',
                        controller: noOfInstallmentController,
                        validator: (value) =>
                            value!.isEmpty ? 'add no.of installment' : null,
                        keyboardType: TextInputType.phone,
                      ),
                      gap(height: 20),
                      customTextField(
                        hintText: 'Number of Members',
                        title: 'Total Members :',
                        controller: totalMembersController,
                        validator: (value) =>
                            value!.isEmpty ? 'add member count' : null,
                        keyboardType: TextInputType.phone,
                      ),
                      gap(height: 20),
                      customTextField(
                        hintText: 'Subcription Amount',
                        title: 'Subcription Amount :',
                        controller: subscriptionController,
                        validator: (value) =>
                            value!.isEmpty // Adjust validation logic
                                ? 'Enter the Amount'
                                : null,
                        keyboardType: TextInputType.phone, // Set keyboard type
                      ),
                      gap(height: 20),
                      customTextField(
                        hintText: '% Pool Cummission',
                        title: 'Pool Cummission :',
                        controller: commissionController,
                        validator: (value) => value!.isEmpty
                            ? 'Pool Cummission b/n 05-10%'
                            : null,
                        keyboardType: TextInputType.phone,
                      ),
                      gap(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ModifiedText(
                            text: 'Installment Type :',
                            size: 14,
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          gap(width: 77),
                          DropdownTimePreriod(
                            onTimePeriodChanged: (value) {
                              setState(() {
                                selectedTimePeriodType = value;
                              });
                            },
                          ),
                        ],
                      ),
                      gap(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ModifiedText(
                            text: 'Proposed Start Date :',
                            size: 14,
                            color: AppColor.fontColor,
                            fontWeight: FontWeight.w500,
                          ),
                          gap(width: 57),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () => _selectDate(context),
                              child: ModifiedText(
                                text: _selectedDate == null
                                    ? 'Select Date'
                                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                                size: 16,
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    label: const Text('Add New Scheme'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        saveSchemeToHive();

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

  Future<void> saveSchemeToHive() async {
    try {
      final installment = noOfInstallmentController.text;
      final totalMembers = totalMembersController.text;
      final subscription = subscriptionController.text;
      final commission = commissionController.text;
      final installmentType = selectedTimePeriodType;
      final proposeDate = _selectedDate;

      if (installment.isEmpty &&
          totalMembers.isEmpty &&
          subscription.isEmpty &&
          commission.isEmpty &&
          installmentType.isEmpty) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          const SnackBar(
            content: Text('Invalid input. Please check the values.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      lastGeneratedId = await getLastGeneratedId();
      final uniqueId = lastGeneratedId.toString().padLeft(4, '0');
      int members = int.parse(totalMembers);
      int subscriptionAmount = int.parse(subscription);
      final pooL = (members) * (subscriptionAmount);
      final pool = pooL.toString();

      final scheme = SchemeModel(
        poolAmount: pool,
        schemeId: uniqueId,
        installment: installment,
        totalMembers: totalMembers,
        subscription: subscription,
        commission: commission,
        installmentType: installmentType,
        proposeDate: proposeDate,
      );
      final box = await Hive.openBox<SchemeModel>('schemes');
      // await box.add(scheme);
      await box.put(uniqueId, scheme);
      // adding value to v
      // addScheme(scheme);
      getSchemeCredentials();
      await saveLastGeneratedId(lastGeneratedId + 1);

      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Scheme added successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Failed to add scheme'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> saveLastGeneratedId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastGeneratedId', id);
  }
}
