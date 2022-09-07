import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constant.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/model/cubit/cubit.dart';
import 'package:todo_app/model/cubit/states.dart';
import 'package:bloc/bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 await sharedHelper.init();
  final bool isDark = await sharedHelper().getDate(key: "isDark");
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
 final bool val;
   MyApp ( this.val);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [

          BlocProvider(
              create: (BuildContext context) => AppCubit()..changeDarkMode(
                  value: val
              )
          ),
          BlocProvider(
              create: (BuildContext context) => AppCubit()..createdDatabase()
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TODO APP',
//              theme: ThemeData(
//                  scaffoldBackgroundColor: Colors.white,
//                  appBarTheme: const AppBarTheme(
//                      backwardsCompatibility: false,
//                      elevation: 0.0,
//                      systemOverlayStyle: SystemUiOverlayStyle(
//                          statusBarColor: Colors.black,
//                          statusBarBrightness: Brightness.dark),
//                      color: Colors.white,
//                      centerTitle: true,
//                      titleTextStyle: TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20.0,
//                      ),
//                      iconTheme: IconThemeData(color: Colors.black)),
//                  floatingActionButtonTheme: FloatingActionButtonThemeData(
//                      backgroundColor: Colors.deepOrange),
//                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
//                    selectedItemColor: Colors.deepOrange,
//                    backgroundColor: Colors.white,
//                    type: BottomNavigationBarType.fixed,
//                    elevation: 20.0,
//                    unselectedItemColor: Colors.grey,
//                  ),
//                  textTheme: const TextTheme(
//                    bodyText1: TextStyle(
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.w500,
//                        color: Colors.black),
//                    bodyText2: TextStyle(
//                        fontSize: 10.0,
//                        color: Colors.black,
//                        fontWeight: FontWeight.bold),
//                  )),
//              darkTheme: ThemeData(
//                  scaffoldBackgroundColor: HexColor('333739'),
//                  appBarTheme: const AppBarTheme(
//                      backwardsCompatibility: false,
//                      backgroundColor: Color(0xFF333739),
//                      elevation: 0.0,
//                      systemOverlayStyle: SystemUiOverlayStyle(
//                          statusBarColor: Colors.black,
//                          statusBarBrightness: Brightness.dark),
//                      centerTitle: true,
//                      titleTextStyle: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 20.0,
//                      ),
//                      iconTheme: IconThemeData(color: Colors.white)),
//                  floatingActionButtonTheme: FloatingActionButtonThemeData(
//                    backgroundColor: Colors.deepOrange,
//                  ),
//                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
//                    selectedItemColor: Colors.deepOrange,
//                    type: BottomNavigationBarType.fixed,
//                    elevation: 20.0,
//                    unselectedItemColor: Colors.grey,
//                  ),
//                  textTheme: const TextTheme(
//                    bodyText1: TextStyle(
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.w500,
//                        color: Colors.white),
//                    bodyText2: TextStyle(
//                        fontSize: 10.0,
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold),
//                  )),
//              themeMode: AppCubit.get(context).isDark
//                  ? ThemeMode.dark
//                  : ThemeMode.light,
              home: HomeScreen(),
            );
          },
        ));
  }
}

