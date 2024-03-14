import 'package:flutter/material.dart';
import 'package:smart_chitty/pages/addmembers.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/appbar.dart';
import 'package:smart_chitty/widgets/fillter_chips.dart';
import 'package:smart_chitty/widgets/widget_gap.dart';
// import 'package:smart_chitty/widgets/scheme_bottomsheet.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({
    super.key,
  });

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  //  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'Members'),
      body: Column(
        children: [
          gap(height: 5),
          const FillterChip(),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldText(
                  text: 'Total Members',
                  color: AppColor.fontColor,
                  size: 15,
                ),
                BoldText(
                  text: '10/40',
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddMemberScreen()));
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
