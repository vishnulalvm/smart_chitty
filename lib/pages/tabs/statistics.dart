import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  ScrollController scrollController = ScrollController();
  List<_SalesData> data = [
    _SalesData('Jan', 3500),
    _SalesData('Feb', 2800),
    _SalesData('Mar', 3400),
    _SalesData('Apr', 3200),
    _SalesData('May', 4000)
  ];

  List<String> transactionHistory = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionHistoryProvider>(
        builder: (context, paymentHistory, child) {
      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ModifiedText(
              text: 'Statistics', size: 20, color: AppColor.fontColor),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          controller: scrollController,
          children: [
            Container(
              width: double.maxFinite,
              height: 450,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/chart.jpeg'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: SfCartesianChart(
                  isTransposed: true,
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0, color: Colors.red),
                    majorTickLines: MajorTickLines(width: 0),
                  ),
                  primaryYAxis: const NumericAxis(
                    isInversed: false,
                  ),
                  series: <CartesianSeries<_SalesData, String>>[
                    BarSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      color: const Color.fromRGBO(0, 185, 184, 1),
                      selectionBehavior: SelectionBehavior(
                        selectedOpacity: 1,
                        unselectedOpacity: 1,
                        // selectionController: ,
                        enable: true,
                        selectedColor: const Color.fromRGBO(1, 80, 136, 1),
                        unselectedColor: const Color.fromRGBO(0, 185, 184, 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
            gap(height: 20),
            const Divider(
              thickness: 5,
              color: Color.fromRGBO(0, 185, 184, 1),
            ),
            gap(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ModifiedText(
                      text: 'Monthly Transactions',
                      size: 18,
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w500),
                  ModifiedText(
                      text: 'March',
                      size: 18,
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w500)
                ],
              ),
            ),
            gap(height: 24),
            Expanded(
              child: paymentHistory.specificTransaction.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentHistory.specificTransaction.length,
                      itemBuilder: (BuildContext context, int index) {
                        final payment =
                            paymentHistory.specificTransaction[index];
                        String formattedDateTime =
                            DateFormat('dd-MM-yyyy HH:mm')
                                .format(payment.paymentDate!);
                        installmentcount = payment.installmentCount;
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 6, right: 6, bottom: 4),
                          child: Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      FileImage(File(payment.imagePath)),
                                  backgroundColor: Colors.blue,
                                ),
                                title: ModifiedText(
                                  text: formattedDateTime,
                                  size: 18,
                                  color: AppColor.fontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                subtitle: ModifiedText(
                                  text:
                                      'Installment: ${payment.installmentCount}', // Replace with the actual member ID field from PaymentModel
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
                                      text:
                                          '₹ ${payment.payment}', // Replace with the actual amount field from PaymentModel
                                      size: 18,
                                      color: AppColor.fontColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    gap(height: 4),
                                    ModifiedText(
                                      text:
                                          'scheme : ${payment.schemeId}', // Replace with the actual payment mode field from PaymentModel
                                      size: 12,
                                      color: AppColor.fontColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No transaction history'),
                    ),
            ),
          ],
        ),
      );
    });
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
