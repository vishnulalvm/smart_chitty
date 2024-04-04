import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/memberscreen_features/member_details.dart';
import 'package:smart_chitty/pages/others/other_screens/view_transaction.dart';
import 'package:smart_chitty/services/db%20functions/transctiondata_function.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

String month = '';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late ZoomPanBehavior zoomPanBehavior;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    zoomPanBehavior = ZoomPanBehavior(enablePanning: true);
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
          scrolledUnderElevation: 100,
          bottomOpacity: 5,
          surfaceTintColor: Colors.white,
          forceMaterialTransparency: false,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 5,
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
                width: 500,
                height: 450,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/chart.jpeg'),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        builder: (dynamic data, dynamic point, dynamic series,
                            int pointIndex, int seriesIndex) {
                          final monthlyCollection = data as MonthlyCollection;
                          month = monthlyCollection.month;
                          paymentHistory.fetchTransactionsForMonth(month);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ModifiedText(
                              text: month.toString(),
                              color: Colors.white,
                              size: 12,
                            ),
                          );
                        }),
                    zoomPanBehavior: zoomPanBehavior,
                    selectionType: SelectionType.cluster,
                    onSelectionChanged: (value) {},
                    margin: EdgeInsets.zero,
                    enableAxisAnimation: true,
                    plotAreaBorderWidth: 0,
                    isTransposed: true,
                    primaryXAxis: const CategoryAxis(
                      initialVisibleMinimum: 5,
                      initialVisibleMaximum: 12,
                      interval: 1,
                      arrangeByIndex: true,
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
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
                    series: <CartesianSeries<MonthlyCollection, String>>[
                      BarSeries<MonthlyCollection, String>(
                        dataSource: data,
                        xValueMapper: (MonthlyCollection sales, _) {
                          return sales.month;
                        },
                        yValueMapper: (MonthlyCollection sales, _) {
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
                      text: month,
                      size: 16,
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w500)
                ],
              ),
            ),
            gap(height: 24),
            paymentHistory.specificTransaction.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentHistory.specificTransaction.length,
                    itemBuilder: (BuildContext context, int index) {
                      final payment = paymentHistory.specificTransaction[index];
                      String formattedDateTime = DateFormat('dd-MMM-yy h:mm a')
                          .format(payment.paymentDate!);
                      installmentcount = payment.installmentCount;
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 6, bottom: 4),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ViewTransaction(
                                          index: index,
                                          treansProvider: paymentHistory,
                                          paymentModel: payment,
                                        )));
                              },
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
                : Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: ModifiedText(
                          text: 'Select a Bar Graph to show History',
                          size: 14,
                          color: AppColor.fontColor),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
