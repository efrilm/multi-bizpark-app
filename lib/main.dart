import 'package:flutter/material.dart';
import 'package:multibizpark/const.dart';
import 'package:multibizpark/pages/absen/absen_page.dart';
import 'package:multibizpark/pages/absen/add_absen_page.dart';
import 'package:multibizpark/pages/absen/add_pamit_page.dart';
import 'package:multibizpark/pages/auth/code_page.dart';
import 'package:multibizpark/pages/auth/sign_in_page.dart';
import 'package:multibizpark/pages/auth/sign_up_page.dart';
import 'package:multibizpark/pages/insight/all_lead/all_lead_page.dart';
import 'package:multibizpark/pages/insight/users/lead_markom_page.dart';
import 'package:multibizpark/pages/insight/users/lead_sales_page.dart';
import 'package:multibizpark/pages/markom/action/add_lead_page.dart';
import 'package:multibizpark/pages/markom/main_page.dart';
import 'package:multibizpark/pages/markom/utils_sold/cash_bertahap_page.dart';
import 'package:multibizpark/pages/markom/utils_sold/cash_keras_page.dart';
import 'package:multibizpark/pages/markom/utils_sold/kpr_page.dart';
import 'package:multibizpark/pages/master_stock/stock_available_page.dart';
import 'package:multibizpark/pages/master_stock/master_stock_page.dart';
import 'package:multibizpark/pages/master_stock/stock_booking_page.dart';
import 'package:multibizpark/pages/master_stock/stock_reservasi_page.dart';
import 'package:multibizpark/pages/master_stock/stock_sold_page.dart';
import 'package:multibizpark/pages/notification/notification_page.dart';
import 'package:multibizpark/pages/owner/utils_sold/cash_bertahap_page.dart';
import 'package:multibizpark/pages/owner/utils_sold/cash_keras_page.dart';
import 'package:multibizpark/pages/owner/utils_sold/kpr_page.dart';
import 'package:multibizpark/pages/profile/change_image_page.dart';
import 'package:multibizpark/pages/profile/change_password_page.dart';
import 'package:multibizpark/pages/profile/profile_page.dart';
import 'package:multibizpark/pages/sales_page/main_page.dart';
import 'package:multibizpark/pages/sales_page/utils_sold/cash_bertahap_page.dart';
import 'package:multibizpark/pages/sales_page/utils_sold/cash_keras_page.dart';
import 'package:multibizpark/pages/sales_page/utils_sold/kpr_page.dart';
import 'package:multibizpark/pages/splash/splash_page.dart';
import 'package:multibizpark/pages/utilities/antrian_page.dart';
import 'package:multibizpark/pages/utilities/list_sales_page.dart';
import 'package:multibizpark/pages/utilities/privacy_police_page.dart';
import 'package:multibizpark/pages/utilities/sales_request_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:multibizpark/pages/utilities/terms_and_condition_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(AppCode.notificationId);

  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Bizpark',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/code': (context) => CodePage(),
        '/sign-up': (context) => SignUpPage(),
        '/sales-main': (context) => SMainPage(),
        '/profile': (context) => ProfilePage(),
        '/change-password': (context) => ChangePasswordPage(),
        '/change-image': (context) => ChangeImagePage(),
        '/master-stock': (context) => MasterStockPage(),
        '/available': (context) => StockAvailablePage(),
        '/reservasi': (context) => StockReservasiPage(),
        '/booking': (context) => StockBookingPage(),
        '/sold': (context) => StockSoldPage(),
        '/antrian': (context) => AntrianPage(),
        '/s-kpr': (context) => SKprPage(),
        '/s-cash-bertahap': (context) => SCashBertahapPage(),
        '/s-cash-keras': (context) => SCashKerasPage(),
        '/absen': (context) => AbsenPage(),
        '/add-absen': (context) => AddAbsenPage(),
        '/add-pamit': (context) => AddPamitPage(),
        '/notification': (context) => NotificationPage(),
        '/markom-main': (context) => MMainPage(),
        '/m-kpr': (context) => MKprPage(),
        '/m-cash-bertahap': (context) => MCashBertahapPage(),
        '/m-cash-keras': (context) => MCashKerasPage(),
        '/o-kpr': (context) => OKprPage(),
        '/o-cash-keras': (context) => OCashKerasPage(),
        '/o-cash-bertahap': (context) => OCashBertahapPage(),
        '/list-sales': (context) => ListSales(),
        '/add-lead': (context) => AddLeadPage(),
        '/sales-request': (context) => SalesRequestPage(),
        '/all-lead': (context) => AllLeadPage(),
        '/lead-markom': (context) => LeadMarkomPage(),
        '/lead-sales': (context) => LeadSalesPage(),
        '/privacy-policy': (context) => PrivacyPolicyPage(),
        '/term-conditions': (context) => TermConditionPage(),
      },
    );
  }
}
