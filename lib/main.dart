import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_chitty/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/db%20functions/registration_function.dart';
import 'package:smart_chitty/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/models/addmember_model.dart';
import 'package:smart_chitty/models/registration_model.dart';
import 'package:smart_chitty/models/scheme_model.dart';
import 'package:smart_chitty/utils/const.dart';
import 'package:smart_chitty/widgets/choice_chips.dart';

late Box<MemberModel> membersBox;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(RegistrationModelAdapter().typeId)) {
    Hive.registerAdapter(RegistrationModelAdapter());
  }
  if (!Hive.isAdapterRegistered(SchemeModelAdapter().typeId)) {
    Hive.registerAdapter(SchemeModelAdapter());
  }
  if (!Hive.isAdapterRegistered(MemberModelAdapter().typeId)) {
    Hive.registerAdapter(MemberModelAdapter());
  }

  getUserCredentials();
  getSchemeCredentials();
 


  await initiHive();
  runApp(const MyApp());
}

Future<void> initiHive() async {
  await Hive.initFlutter();
  membersBox = await Hive.openBox<MemberModel>('members');
   getSchemeIds();
  getMemberCredentials(selectedId);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/splash', 
      routes: routes,
    );
  }
}
