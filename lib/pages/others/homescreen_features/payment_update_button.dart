import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/providers/memberid_provider.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/dropdown_selectmember.dart';
import 'package:smart_chitty/widgets/global/buttonwidget.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/features/textfield_schem.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

int? installment;
String? selectedSchemeValue;
String? selectedMemberValue;

class PaymentUpdateButton extends StatefulWidget {
  const PaymentUpdateButton({super.key});

  @override
  State<PaymentUpdateButton> createState() => _PaymentUpdateButtonState();
}

class _PaymentUpdateButtonState extends State<PaymentUpdateButton> {
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

                          child: Form(
                            key: formKeys,
                            child: Column(
                              children: [
                                rowText(
                                    firstText: 'Member Name :',
                                    secoundText:
                                        memberModel.memberDatas.isNotEmpty
                                            ? memberModel
                                                .memberDatas.first.memberName
                                            : 'N/A'),
                                rowText(
                                    firstText: 'Member id :',
                                    secoundText: memberModel
                                            .memberDatas.isNotEmpty
                                        ? memberModel.memberDatas.first.memberId
                                        : 'N/A'),
                                rowText(
                                  firstText: 'Subcription Amount :',
                                  secoundText:
                                      memberModel.memberDatas.isNotEmpty
                                          ? memberModel.memberDatas.first
                                              .schemeModel.subscription
                                          : 'N/A',
                                ),
                                rowText(
                                    firstText: 'Total Installment :',
                                    secoundText:
                                        '${memberModel.memberDatas.isNotEmpty ? installment : 'N/A'}/${memberModel.memberDatas.isNotEmpty ? memberModel.memberDatas.first.schemeModel.installment : 'N/A'}'),
                                rowText(
                                  firstText: 'Scheme id :',
                                  secoundText: memberModel
                                          .memberDatas.isNotEmpty
                                      ? memberModel.memberDatas.first.schemeId!
                                      : 'N/A',
                                ),
                                gap(height: 12),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    onPressed: () async {
                                      memberModel.fetchMemberData(context);
                                      installment = await getInstallmentCount(
                                          selectedMember!);
                                    },
                                    child: const ModifiedText(
                                        text: 'Get Details',
                                        size: 14,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                        gap(height: 20),
                        customTextField(
                          hintText: 'Enter Amount',
                          title: 'Chit Amount :',
                          controller: paymetController,
                          validator: (value) => value!.isEmpty
                              ? 'Amount should be 3 characters'
                              : null,
                          keyboardType: TextInputType.number,
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
                    saveSchemeToHive();
                  }

                  Navigator.pop(context);
                },
                buttonName: 'Register',
                color: const Color.fromRGBO(0, 205, 255, 1),
              ),
            )
          ],
        ),
      );
    });
  }

  Future<void> saveSchemeToHive() async {
    final member = await Hive.openBox<MemberModel>('members');
    final memberData = member.values.toList();
    final selectedMemberData =
        memberData.firstWhere((member) => member.memberId == selectedMember);

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

// final formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(now);

    if (payment.isEmpty &&
        imagePath.isEmpty &&
        memberId.isEmpty &&
        schemeId.isEmpty) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please check the values.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    } else {
      final installmentCount =
          await getInstallmentCount(selectedMemberData.memberId) + 1;
      await saveInstallmentCount(selectedMemberData.memberId, installmentCount);

      final box = await Hive.openBox<PaymentModel>('payments');

      final paymentModel = PaymentModel(
        imagePath: selectedMemberData.avatar,
        installmentCount: installmentCount,
        memberId: selectedMemberData.memberId,
        memberModel: selectedMemberData,
        payment: payment,
        paymentDate: now,
        schemeId: selectedMemberData.schemeId!,
      );
      await box.add(paymentModel);

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
}
