import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/dropdown_timeperiod.dart';
import 'package:smart_chitty/widgets/features/custom_textfield.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditschemeScreen extends StatefulWidget {
  final String chittyPattern;
  final String chittySubcription;
  final String chittyIstallment;
  final String chittyMembers;
  final String commission;
  final DateTime? dateTime;
  final String schemeId;
  final String pool;

  const EditschemeScreen(
      {super.key,
      required this.chittyPattern,
      required this.chittySubcription,
      required this.chittyIstallment,
      required this.chittyMembers,
      required this.commission,
      this.dateTime,
      required this.schemeId,
      required this.pool});

  @override
  State<EditschemeScreen> createState() => _EditschemeScreenState();
}

class _EditschemeScreenState extends State<EditschemeScreen> {
  late final TextEditingController noOfInstallmentController;
  late final TextEditingController totalMembersController;
  late final TextEditingController subscriptionController;
  late final TextEditingController commissionController;

  int lastGeneratedId = 100;

  DateTime? _selectedDate;
  BuildContext? _context;
  @override
  void initState() {
    noOfInstallmentController =
        TextEditingController(text: widget.chittyIstallment);
    totalMembersController = TextEditingController(text: widget.chittyMembers);
    subscriptionController =
        TextEditingController(text: widget.chittySubcription);
    commissionController = TextEditingController(text: widget.commission);

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
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
          title: 'Edit Chitty', onpresed: (value) {}, showMenu: false),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextField(
                    context: context,
                    hintText: 'No.Of Installment in Months',
                    title: 'No.Of Installment :',
                    controller: noOfInstallmentController,
                    validator: (value) =>
                        value!.isEmpty ? 'add no.of installment' : null,
                    keyboardType: TextInputType.phone,
                  ),
                  gap(height: 20),
                  customTextField(
                    context: context,
                    hintText: 'Number of Members',
                    title: 'Total Members :',
                    controller: totalMembersController,
                    validator: (value) =>
                        value!.isEmpty ? 'add member count' : null,
                    keyboardType: TextInputType.phone,
                  ),
                  gap(height: 20),
                  customTextField(
                    context: context,
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
                    context: context,
                    hintText: '% Pool Cummission',
                    title: 'Pool Cummission :',
                    controller: commissionController,
                    validator: (value) =>
                        value!.isEmpty ? 'Pool Cummission b/n 05-10%' : null,
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
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          extendedPadding: const EdgeInsets.only(left: 30, right: 30),
          label: const Text(
            'Update Chitty',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            weight: 800,
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Adjust radius as needed
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              saveSchemeToHive();

              Navigator.pop(context);
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      final uniqueId = 'S${(lastGeneratedId + 1).toString().padLeft(4, '0')}';
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
      await box.put(widget.schemeId, scheme);
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
