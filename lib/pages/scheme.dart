import 'package:flutter/material.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/appbar.dart';
import 'package:smart_chitty/widgets/scheme_bottomsheet.dart';
// import 'package:smart_chitty/widgets/scheme_bottomsheet.dart';

class SchemeButtonHome extends StatefulWidget {
  const SchemeButtonHome({
    super.key,
  });

  @override
  State<SchemeButtonHome> createState() => _SchemeButtonHomeState();
}

class _SchemeButtonHomeState extends State<SchemeButtonHome> {
  //  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'Scheme'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                  text: 'Total Schemes',
                  color: AppColor.fontColor,
                  size: 15,
                ),
                BoldText(
                  text: '10',
                  color: AppColor.fontColor,
                  size: 16,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(left: 6, right: 6, bottom: 4),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          // backgroundImage: AssetImage(item.imagePath), // Use your image path
                        ),
                        title: Text("item.title"),
                        subtitle: Text('item.subtitle'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('item.trailingText1'),
                            SizedBox(
                                height:
                                    15), // Add some spacing between text widgets (optional)
                            Text('item.trailingText2'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) => AddSchemeBottomSheet());
        },
        child: const Icon(
          Icons.add,
          weight: 800,
          color: Colors.white,
        ),
      ),
    );
  }
}
