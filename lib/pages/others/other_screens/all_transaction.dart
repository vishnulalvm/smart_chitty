import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/other_screens/transaction_details.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({
    super.key,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
          title: 'Transaction',
          onpresed: (value) {},
          item1: 'Settings',
          item2: 'Info'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                  text: 'All Transactions',
                  color: AppColor.fontColor,
                  size: 15,
                ),
                Consumer<TransactionHistoryProvider>(
                    builder: (context, paymentData, child) {
                      return BoldText(
                        text: paymentData.sortedTransactionData.length.toString(),
                        color: AppColor.fontColor,
                        size: 16,
                      );
                    }),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TransactionHistoryProvider>(
            
              builder: (context, paymentData, child) {
               String formattedDateTime;

                if (paymentData.sortedTransactionData.isNotEmpty) {
                  formattedDateTime = paymentData.sortedTransactionData.first.paymentDate != null
                      ? DateFormat('dd-MM-yyyy HH:mm')
                          .format(paymentData.sortedTransactionData.first.paymentDate!)
                      : 'N/A';
                } else {
                  formattedDateTime = 'No payment data available';
                }
                return ListView.builder(
                  itemCount: paymentData.sortedTransactionData.length,
                  itemBuilder: (context, index) {
                    if (paymentData.sortedTransactionData.isEmpty) {
                      return const Text('No data available');
                    }

                    final data = paymentData.sortedTransactionData[index];
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const TransactionDetails(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      final tween = Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero);
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ));
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.blue,
                              backgroundImage: FileImage(File(data.imagePath)),
                            ),
                            title: ModifiedText(
                              text: formattedDateTime,
                              size: 18,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            subtitle: ModifiedText(
                              text: 'Installment : ${data.installmentCount}',
                              size: 14,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                gap(height: 2),
                                ModifiedText(
                                  text: '₹ ${data.payment}',
                                  size: 18,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                gap(
                                    height:
                                        4), // Add some spacing between text widgets (optional)
                                ModifiedText(
                                    text: 'Member Id : ${data.memberId}%',
                                    size: 12,
                                    color: AppColor.fontColor)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
     
    );
  }
}
