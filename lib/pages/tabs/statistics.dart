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
  List<TransactionData> data = [
    TransactionData('Jan', 31500),
    TransactionData('Feb', 12800),
    TransactionData('Mar', 3400),
    TransactionData('Apr', 13200),
    TransactionData('May', 40000),
    TransactionData('Jun', 34800),
    TransactionData('Jul', 42000),
    TransactionData('Aug', 13200),
    TransactionData('Sep', 40000),
    TransactionData('Oct', 34800),
    TransactionData('Nov', 42000),
    TransactionData('Dec', 45000),
  ];

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 800,
                height: 450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/chart.jpeg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: SfCartesianChart(
                    onSelectionChanged: (value) {
                      getdata(value,context);
                      //  cc
                    },
                    margin: EdgeInsets.zero,
                    enableAxisAnimation: true,
                    plotAreaBorderWidth: 0,
                    isTransposed: true,
                    primaryXAxis: const CategoryAxis(
                      arrangeByIndex: true,
                      labelStyle: TextStyle(fontWeight: FontWeight.w500),
                      autoScrollingMode: AutoScrollingMode.start,
                      autoScrollingDelta: 12,
                      axisLine: AxisLine(
                          width: 2, color: Color.fromRGBO(1, 80, 136, 1)),
                      majorGridLines: MajorGridLines(
                        width: 0,
                      ),
                      majorTickLines: MajorTickLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.simpleCurrency(
                          decimalDigits: 0, locale: 'hi_IN'),
                      edgeLabelPlacement: EdgeLabelPlacement.hide,
                      autoScrollingMode: AutoScrollingMode.start,
                      isVisible: false,
                      axisLine: const AxisLine(
                        width: 0,
                      ),
                      axisBorderType: AxisBorderType.withoutTopAndBottom,
                      majorGridLines: const MajorGridLines(width: 0),
                      minorGridLines: const MinorGridLines(width: 0),
                      isInversed: false,
                    ),
                    series: <CartesianSeries<TransactionData, String>>[
                      BarSeries<TransactionData, String>(
                        dataSource: data,
                        xValueMapper: (TransactionData sales, _) {
                          return sales.year;
                        },
                        yValueMapper: (TransactionData sales, _) {
                          return sales.sales;
                        },
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
            ),
            gap(height: 20),
            const Divider(
              thickness: 5,
              color: Colors.white,
            ),
            gap(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ModifiedText(
                      text: 'Monthly Transactions',
                      size: 16,
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w500),
                  ModifiedText(
                      text: 'March',
                      size: 16,
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

  void getdata(SelectionArgs value,BuildContext context) {
    final paymentModel =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    paymentModel.fetchTransactionsForMonth(value.pointIndex + 1);
  }
}

class TransactionData {
  TransactionData(this.year, this.sales);
  final String year;
  final double sales;
}
