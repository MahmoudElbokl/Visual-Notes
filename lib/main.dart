import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'injector.dart' as di;
import 'package:get/get.dart';

import 'features/visual_notes_operations/presentation/ui/visual_notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // screen util for handling responsive design
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: () {
        return MaterialApp(
          title: 'Visual Notes Demo',
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xfff8f7f7),
            primarySwatch: Colors.blue,
            primaryColor: const Color(0xffe0b488),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5.w,
                    ),
                  ),
                ),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5.w,
                    ),
                  ),
                ),
                textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.button),
                backgroundColor: MaterialStateProperty.all(const Color(0xffe0b488)),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: Theme.of(context).textTheme.bodyText2,
              contentPadding: const EdgeInsets.all(8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Color(0xffd4d4d4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Color(0xffd4d4d4),
                ),
              ),
            ),
          ),
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          home: VisualNotesScreen(),
        );
      },
    );
  }
}
