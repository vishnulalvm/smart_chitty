import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_chitty/services/db%20functions/memberdata_fuction.dart';
import 'package:smart_chitty/services/db%20functions/registration_function.dart';
import 'package:smart_chitty/services/db%20functions/schemedata_function.dart';
import 'package:smart_chitty/services/models/addmember_model.dart';
import 'package:smart_chitty/services/models/monthly_collection_model.dart';
import 'package:smart_chitty/services/models/payment_details_model.dart';
import 'package:smart_chitty/services/models/registration_model.dart';
import 'package:smart_chitty/services/models/reminder_model.dart';
import 'package:smart_chitty/services/models/scheme_model.dart';
import 'package:smart_chitty/services/providers/filter_member_provider.dart';
import 'package:smart_chitty/services/providers/memberdata_provider.dart';
import 'package:smart_chitty/services/providers/memberid_provider.dart';
import 'package:smart_chitty/services/providers/reminderdata_provider.dart';
import 'package:smart_chitty/services/providers/schemedata_provider.dart';
import 'package:smart_chitty/services/providers/schemeid_provider.dart';
import 'package:smart_chitty/services/providers/transaction.dart';
import 'package:smart_chitty/utils/page_routes.dart';
import 'package:smart_chitty/widgets/features/choice_chips.dart';
int? initScreen;
late Box<MemberModel> membersBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen")??0;
  await prefs.setInt("initScreen", 1);
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
  if (!Hive.isAdapterRegistered(PaymentModelAdapter().typeId)) {
    Hive.registerAdapter(PaymentModelAdapter());
  }
  if (!Hive.isAdapterRegistered(MonthlyCollectionAdapter().typeId)) {
    Hive.registerAdapter(MonthlyCollectionAdapter());
  }
   if (!Hive.isAdapterRegistered(ReminderModelAdapter().typeId)) {
    Hive.registerAdapter(ReminderModelAdapter());
  }


  getUserCredentials();
  getSchemeCredentials();

  await initiHive();
  runApp(const MyApp());
}

Future<void> initiHive() async {
  await Hive.initFlutter();
  membersBox = await Hive.openBox<MemberModel>('members');
  getMemberCredentials(selectedId);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SchemeIdListProvider()),
        ChangeNotifierProvider(create: (context) => MemberListProvider()),
        ChangeNotifierProvider(create: (context) => MemberDataProvider()),
        ChangeNotifierProvider(create: (context) => TransactionHistoryProvider()), 
        ChangeNotifierProvider(create: (context) => SchemeListProvider()), 
         ChangeNotifierProvider(create: (context) => ReminderListProvider()),
         ChangeNotifierProvider(create: (context) => FilterMemberProvider()), 
      ],
      child: MaterialApp.router(
        routerConfig: router,
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
        // initialRoute: '/splash',
        // routes: routes,
      ),
    );
  }
}
