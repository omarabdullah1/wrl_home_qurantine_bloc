// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/test/cubit/test_cubit.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/test/test_layout.dart';
import 'package:wrl_home_qurantine_bloc/layout/wrl_app/wifi_layout/scanning_layout.dart';
import 'package:wrl_home_qurantine_bloc/shared/bloc_observer.dart';
import 'package:wrl_home_qurantine_bloc/shared/components/constants.dart';
import 'package:wrl_home_qurantine_bloc/shared/network/local/cache_helper.dart';
import 'package:wrl_home_qurantine_bloc/shared/network/remote/dio_helper.dart';
import 'package:wrl_home_qurantine_bloc/shared/styles/colors.dart';

import 'layout/wrl_app/login/cubit/login_cubit.dart';
import 'layout/wrl_app/login/cubit/login_states.dart';
import 'layout/wrl_app/login/wrl_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  bool isDone = CacheHelper.getData(key: 'DoneScanning');

  Widget widget;

  token = CacheHelper.getData(key: 'token');
  print(token);

  if (token != null) {
    if (isDone != null) {
      widget = const TestLayout();
    } else {
      widget = const ScanningLayout();
    }
  } else {
    widget = const HomeQuarantineLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool isDark;
  final Widget startWidget;

  // ignore: use_key_in_widget_constructors
  const MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => HomeQuarantineLoginCubit(),
          ),
          BlocProvider(
            create: (context) => TestCubit(),
          ),
        ],
        child:
            BlocConsumer<HomeQuarantineLoginCubit, HomeQuarantineLoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: defaultColor,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20.0,
                  // ignore: deprecated_member_use
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.indigo[900],
                    statusBarIconBrightness: Brightness.light,
                  ),
                  elevation: 0.0,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // darkTheme: darkTheme,
              // themeMode:
              //     AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: startWidget,
            );
          },
        ),
      ),
    );
  }
}
