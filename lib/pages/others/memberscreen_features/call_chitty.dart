import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/features/custom_textfield.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class CallChitty extends StatefulWidget {
  final String schemeId;
  final String memberId;
  const CallChitty({super.key, required this.schemeId, required this.memberId});

  @override
  State<CallChitty> createState() => _CallChittyState();
}

class _CallChittyState extends State<CallChitty> {
  final poolAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Call Chitty', onpresed: (va) {}),
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              rowText(firstText: 'Pool Amount :', secoundText: '₹300000'),
              rowText(firstText: 'Member Id:', secoundText: widget.memberId),
              rowText(firstText: 'Scheme Id :', secoundText: widget.schemeId),
              gap(height: 12),
              customTextField(
                  controller: poolAmountController,
                  hintText: 'Enter your Amount',
                  title: 'Your Pool Amount : ',
                  validator: (value) =>
                      value!.isEmpty // Adjust validation logic
                          ? 'Enter the Amount'
                          : null,
                  keyboardType: TextInputType.number),
                  gap(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    
                    padding: const EdgeInsets.only(left: 30,right: 30,top: 12,bottom: 12),
                    backgroundColor: Colors.blue,
                  ),
                  child: const ModifiedText(
                      text: 'Call Chitty', size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
