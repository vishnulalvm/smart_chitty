import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class ViewTransaction extends StatefulWidget {
  final PaymentModel paymentModel;

  const ViewTransaction({super.key, required this.paymentModel});

  @override
  State<ViewTransaction> createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDateTime =
        DateFormat('dd-MM-yyyy HH:mm').format(widget.paymentModel.paymentDate!);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'Transaction Details', onpresed: (value) {}),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              gap(height: 20),
              rowText(
                  firstText: 'Payment Date :', secoundText: formattedDateTime),
              rowText(
                  firstText: 'Chitty ID :',
                  secoundText: widget.paymentModel.schemeId),
              rowText(
                firstText: 'Subcription Amount :',
                secoundText: widget.paymentModel.payment,
              ),

              rowText(
                  firstText: 'No.Of. Installment :',
                  secoundText: widget.paymentModel.installmentCount.toString()),
              rowText(
                firstText: 'Commission :',
                secoundText: widget.paymentModel.memberId,
              ),

              gap(height: 80),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    showLogoutDialog(context);
                  },
                  child: const ModifiedText(
                      text: 'Delete', size: 14, color: Colors.white)),
              // rowText(
              //     firstText: 'Total Members :',
              //     secoundText: widget.chittyMembers),
              // rowText(
              //     firstText: 'Pool Amount :',
              //     secoundText: widget.pool),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final box = await Hive.openBox<PaymentModel>('payments');
                box.delete(widget.paymentModel.memberId);
                final amount =
                    double.tryParse(widget.paymentModel.payment) ?? 0;
                final collectionBox =
                    await Hive.openBox<MonthlyCollection>('collections');

                MonthlyCollection? existingData =
                    collectionBox.get(widget.paymentModel.paymentMonth);
                if (existingData != null) {
                  final updatedSales = existingData.sales - amount;

                  final updatedCollectionModel = MonthlyCollection(
                      month: widget.paymentModel.paymentMonth,
                      sales: updatedSales);
                  await collectionBox.put(
                      widget.paymentModel.paymentMonth, updatedCollectionModel);
                } else {
                  final collectionModel = MonthlyCollection(
                      month: widget.paymentModel.paymentMonth, sales: amount);
                  await collectionBox.put(
                      widget.paymentModel.paymentMonth, collectionModel);
                }
                final paymentHistory = Provider.of<TransactionHistoryProvider>(
                    _context!,
                    listen: false);
                paymentHistory.fetchMemberDatas();

                final installmentCount =
                    await getInstallmentCount(widget.paymentModel.memberId) - 1;
                await saveInstallmentCount(
                    widget.paymentModel.memberId, installmentCount);

                Navigator.of(_context!).pop();
              },
              child: const Text('delete'),
            ),
          ],
        );
      },
    );
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
