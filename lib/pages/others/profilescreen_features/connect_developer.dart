import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';

class ConnectDeveloper extends StatelessWidget {
  const ConnectDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Excel Convert', onpresed: (value){}),
      body: Center(
        child: ModifiedText(text: 'Add In Future Update', size: 30, color: AppColor.fontColor),
      ),
    );
  }
}