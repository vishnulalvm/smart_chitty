import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_chitty/services/db%20functions/payment_function.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/utils/images.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/buttonwidget.dart';
import 'package:smart_chitty/widgets/features/dropdown_addmember.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/features/textfield_schem.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class PaymentUpdateButton extends StatefulWidget {
  const PaymentUpdateButton({super.key});

  @override
  State<PaymentUpdateButton> createState() => _PaymentUpdateButtonState();
}

class _PaymentUpdateButtonState extends State<PaymentUpdateButton> {
  BuildContext? _context;
  List<MemberModel> memberDatas = [];
  List<String> schemeIds = [];
  List<String> memberIds = [];
  final paymetController = TextEditingController();
  final formKeys = GlobalKey<FormState>();
   final _schemeDropdownKey = GlobalKey<DropdownButtonSchemeState>();
  final _memberDropdownKey = GlobalKey<DropdownButtonSchemeState>();

  String? selectedSchemeValue;
  String? selectedMemberValue;
  @override
  void initState() {
    super.initState();
     _context = context;
    getSchemeIds();
    getMemberIds();
  }

    void getSelectedSchemeValue() {
    final dropdownSchemeState = _schemeDropdownKey.currentState;
    if (dropdownSchemeState != null) {
      selectedSchemeValue = dropdownSchemeState.selectedValue;
      
     
    }
  }

  void getSelectedMemberValue() {
    final dropdownMemberState = _memberDropdownKey.currentState;
    if (dropdownMemberState != null) {
      selectedMemberValue = dropdownMemberState.selectedValue;
     
    }
  }

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ModifiedText(
                            text: 'Selected Scheme :',
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          DropdownButtonScheme(list: schemeIds),
                        ],
                      ),
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
                          DropdownButtonScheme(list: memberIds),
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
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          // padding: const EdgeInsets.all(5.0),

                          child: Column(
                            children: [
                              rowText(
                                  firstText: 'Member Name :',
                                  secoundText: memberDatas.isNotEmpty
                                      ? memberDatas.first.memberName
                                      : 'N/A'),
                              rowText(
                                firstText: 'Subcription Amount :',
                                secoundText: memberDatas.isNotEmpty
                                    ? memberDatas.first.schemeModel.subscription
                                    : 'N/A',
                              ),
                              rowText(
                                  firstText: 'Total Installment :',
                                  secoundText:
                                      '${allPaymentData.isNotEmpty?allPaymentData.first.installmentCount:'N/A'}/${memberDatas.isNotEmpty ? memberDatas.first.schemeModel.installment : 'N/A'}'),
                              rowText(
                                firstText: 'Member id :',
                                secoundText: memberDatas.isNotEmpty
                                    ? memberDatas.first.memberId
                                    : 'N/A',
                              ),
                            ],
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
                        gap(height: 12),
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

  Future<void> saveSchemeToHive() async {
     final payment = paymetController.text;


        if (payment.isEmpty ) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          const SnackBar(
            content: Text('Invalid input. Please check the values.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }



  }

  Future<void> getSchemeIds() async {
    final box = await Hive.openBox<SchemeModel>('schemes');
    final schemeData = box.values.toList();
    setState(() {
      schemeIds = schemeData.map((scheme) => scheme.schemeId).toList();
    });
  }

  Future<void> getMemberIds() async {
    final box = await Hive.openBox<MemberModel>('members');
    final memberData = box.values.toList();

    setState(() {
      memberIds = memberData.map((member) => member.memberId).toList();

      if (dropdownValue != null) {
        memberDatas = memberData
            .where((member) => member.memberId == dropdownValue)
            .toList();
      } else {
        memberDatas = [];
      }
    });
  }
}
