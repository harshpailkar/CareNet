import 'package:carenet/Screens/homePage.dart';
import 'package:carenet/Screens/heart_rate_monitor/heartRateMonitor.dart';
import 'package:carenet/Screens/launchPage.dart';
import 'package:carenet/Screens/prom_disc.dart';
import 'package:carenet/Theming/customTheme.dart';
import 'package:carenet/authentication/google_sign_in.dart';
import 'package:carenet/screens/extras.dart';
import 'package:carenet/Theming/customTheme.dart';
import 'package:carenet/authentication/google_sign_in.dart';
import 'package:carenet/storage/cloudStorageTest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carenet/Theming/customColors.dart';
import 'package:carenet/Theming/customTheme.dart';
import 'package:carenet/screens/reminder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Screens/locationPage.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'Theming/themes.dart';
import 'authentication/util_showSnackBar.dart';

// Making sure Firebase services activate before app execution
Future main() async {
  // Binding Code
  WidgetsFlutterBinding.ensureInitialized();

  // Lock in Portrait Mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  AwesomeNotifications().initialize(
    'resource://mipmap-hdpi/ic_launcher',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: CustomColors.bluebell,
        locked: true,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_notification',
        channelDescription: 'Scheduled Notifications for Reminder',
      ),
    ],
  );

  // Initialize Firebase Class
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: ScreenUtilInit(
            designSize: Size(390, 844),
            splitScreenMode: true,
            minTextAdapt: true,
            builder: () => MaterialApp(
                scaffoldMessengerKey: Utils.messengerKey,
                navigatorKey: navigatorKey,
                title: "CareNet",
                debugShowCheckedModeBanner: false,
                theme: CustomTheme.lightTheme,
                home: SafeArea(child: LaunchPage()))));
  }
}
