import 'package:bayat/features/cv_apply/presentation/pages/cv_apply.dart';
import 'package:bayat/features/homepage/presentation/pages/homepage_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter_localizations/flutter_localizations.dart'; // ✅ مهم

class BayatAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // نحدد designSize حسب نوع الجهاز
    final Size designSize;

    if (kIsWeb) {
      // للويب
      designSize = const Size(1440, 1024);
    } else {
      // نعتمد على العرض
      final width = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
          WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

      if (width < 600) {
        // موبايل
        designSize = const Size(375, 812);
      } else {
        // تابلت / ديسكتوب
        designSize = const Size(1024, 768);
      }
    }

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Bayat App",
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          home: CvApply(),
        );
      },
    );
  }
}
