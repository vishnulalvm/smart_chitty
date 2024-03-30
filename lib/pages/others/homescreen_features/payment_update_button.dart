import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/providers/memberid_provider.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/dropdown_selectmember.dart';
import 'package:smart_chitty/widgets/global/buttonwidget.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/features/custom_textfield.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

int? installment;
String? selectedSchemeValue;
String? selectedMemberValue;
String selectedMonthString = '';

class PaymentUpdateButton extends StatefulWidget {
  const PaymentUpdateButton({super.key});

  @override
  State<PaymentUpdateButton> createState() => _PaymentUpdateButtonState();
}

class _PaymentUpdateButtonState extends State<PaymentUpdateButton> {
  DateTime? _selectedDate;
  BuildContext? _context;

  final paymetController = TextEditingController();
  final formKeys = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _context = context;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberListProvider>(builder: (context, memberModel, child) {
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gap(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ModifiedText(
                            text: 'Selected Member :',
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          DropdownSelectMember(
                            list: memberModel.memberDatasdrop,
                          ),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          // padding: const EdgeInsets.all(5.0),

                          child: Column(
                            children: [
                              rowText(
                                  firstText: 'Member Name :',
                                  secoundText: memberModel
                                          .memberDatas.isNotEmpty
                                      ? memberModel.memberDatas.first.memberName
                                      : 'N/A'),
                              rowText(
                                  firstText: 'Member id :',
                                  secoundText: memberModel
                                          .memberDatas.isNotEmpty
                                      ? memberModel.memberDatas.first.memberId
                                      : 'N/A'),
                              rowText(
                                firstText: 'Subcription Amount :',
                                secoundText: memberModel.memberDatas.isNotEmpty
                                    ? memberModel.memberDatas.first.schemeModel
                                        .subscription
                                    : 'N/A',
                              ),
                              rowText(
                                  firstText: 'Total Installment :',
                                  secoundText:
                                      '${memberModel.memberDatas.isNotEmpty ? installment : 'N/A'}/${memberModel.memberDatas.isNotEmpty ? memberModel.memberDatas.first.schemeModel.installment : 'N/A'}'),
                              rowText(
                                firstText: 'Scheme id :',
                                secoundText: memberModel.memberDatas.isNotEmpty
                                    ? memberModel.memberDatas.first.schemeId!
                                    : 'N/A',
                              ),
                              gap(height: 12),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () async {
                                    memberModel.fetchMemberData(context);
                                    String memberid = selectedMember == null
                                        ? 'selectedMember'
                                        : selectedMember!;
                                    installment =
                                        await getInstallmentCount(memberid);
                                  },
                                  child: const ModifiedText(
                                      text: 'Get Details',
                                      size: 14,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        gap(height: 20),
                        Form(
                          key: formKeys,
                          child: customTextField(
                            key: formKeys,
                            hintText: 'Enter Amount',
                            title: 'Chit Amount :',
                            controller: paymetController,
                            validator: (value) {
                              if (memberModel.memberDatas.isEmpty) {
                                return 'Member data not available';
                              } else {
                                final subscription = memberModel
                                    .memberDatas.first.schemeModel.subscription;
                                if (value != subscription) {
                                  return 'Enter correct subscription amount';
                                }
                              }
                              return null; // No error
                            },
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        gap(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ModifiedText(
                                text: 'Payment Date :',
                                size: 14,
                                color: AppColor.fontColor,
                                fontWeight: FontWeight.w500,
                              ),
                              // gap(width: 70),
                              SizedBox(
                                width: 195,
                                height: 52,
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
       
          ],
        ),

            floatingActionButton: FloatingActionButton.extended(
              extendedPadding: EdgeInsets.only(left: 40,right: 40),
          label: const Text(
            'Register',
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
            if (formKeys.currentState!.validate()) {
                    collectionToHive();
                    saveSchemeToHive();
                  }
           
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }

  Future<void> saveSchemeToHive() async {
    final member = await Hive.openBox<MemberModel>('members');
    final memberData = member.values.toList();
    final memberid = selectedMember ?? 'a';
    final selectedMemberData =
        memberData.firstWhere((member) => member.memberId == memberid);

    final payment = paymetController.text;
    final imagePath = selectedMemberData.avatar;
    final memberId = selectedMemberData.memberId;
    final schemeId = selectedMemberData.schemeId!;
    DateTime currentDateTime = DateTime.now();

    DateTime now = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      currentDateTime.hour,
      currentDateTime.minute,
    );

    if (payment.isEmpty &&
        imagePath.isEmpty &&
        memberId.isEmpty &&
        schemeId.isEmpty &&
        selectedMember == null) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please check the values.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final installmentCount =
          await getInstallmentCount(selectedMemberData.memberId) + 1;
      await saveInstallmentCount(selectedMemberData.memberId, installmentCount);

      final box = await Hive.openBox<PaymentModel>('payments');

      final paymentModel = PaymentModel(
        paymentMonth: selectedMonthString,
        imagePath: selectedMemberData.avatar,
        installmentCount: installmentCount,
        memberId: selectedMemberData.memberId,
        memberModel: selectedMemberData,
        payment: payment,
        paymentDate: now,
        schemeId: selectedMemberData.schemeId!,
      );
      await box.put(selectedMemberData.memberId, paymentModel);

      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Payment saved successfully.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }

    final paymentModel =
        Provider.of<TransactionHistoryProvider>(_context!, listen: false);
    paymentModel.fetchMemberDatas();
    Navigator.pop(_context!);
  }

  Future<void> saveInstallmentCount(
      String memberId, int installmentCount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('installment_$memberId', installmentCount);
  }

  Future<int> getInstallmentCount(String memberId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('installment_$memberId') ?? 0;
  }

  // store the month

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        currentDate: DateTime.now());

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        selectedMonthString = DateFormat('MM-yy').format(pickedDate);
      });
    }
  }

  Future<void> collectionToHive() async {
    final amount = double.tryParse(paymetController.text) ?? 0;
    final collectionBox = await Hive.openBox<MonthlyCollection>('collections');

    MonthlyCollection? existingData = collectionBox.get(selectedMonthString);
    if (existingData != null) {
      final updatedSales = existingData.sales + amount;

      final updatedCollectionModel =
          MonthlyCollection(month: selectedMonthString, sales: updatedSales);
      await collectionBox.put(selectedMonthString, updatedCollectionModel);
    } else {
      final collectionModel =
          MonthlyCollection(month: selectedMonthString, sales: amount);
      await collectionBox.put(selectedMonthString, collectionModel);
    }
  }
}
