import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/row_text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class ViewTransaction extends StatefulWidget {
  final PaymentModel paymentModel;
  final int index;
  final TransactionHistoryProvider treansProvider;

  const ViewTransaction(
      {super.key,
      required this.paymentModel,
      required this.index,
      required this.treansProvider});

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
        DateFormat('dd-MMM-yy h:mm a').format(widget.paymentModel.paymentDate!);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
          title: 'Transaction Details',
          onpresed: (value) {
            if (value == 1) {
            } else if (value == 2) {
              showLogoutDialog(context);
            }
          },
          item1: 'Edit',
          item2: 'Delete'),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
        child: Container(
          height: 350,
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
                  firstText: 'Month Of Installment :',
                  secoundText: widget.paymentModel.paymentMonth),
              rowText(
                  firstText: 'No.Of. Installment :',
                  secoundText: widget.paymentModel.installmentCount.toString()),
              rowText(
                firstText: 'Member Id :',
                secoundText: widget.paymentModel.memberId,
              ),
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
                final paymentHistory = Provider.of<TransactionHistoryProvider>(
                    context,
                    listen: false);

                paymentHistory.deleteTransaction(
                    widget.paymentModel.key, widget.index);
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

                paymentHistory.fetchMemberDatas();

                final installmentCount =
                    await getInstallmentCount(widget.paymentModel.memberId) - 1;
                await saveInstallmentCount(
                    widget.paymentModel.memberId, installmentCount);

                _context!.pushReplacement('/');
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
