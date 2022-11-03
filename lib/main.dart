import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/modules/observer/bloc_observer.dart';
import 'package:news_app/network/local/cach_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';
import 'package:news_app/news_app/news_layout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //naamlha ki yebda lmain async bch to4monli eli louta lkol yetaaml

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init(); //tsavili e5er haja aamltha fl app

  bool? isDark = CachHelper.getData(key: 'isModeDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.

  final bool? isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getScience()..getSport(),),
        BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..changeMode(x: isDark),)
      ],
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            NewsCubit cubit = NewsCubit.get(context);

            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.deepOrange, //bch tbadali loun loading
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white, //couleur bar notification
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: Colors.white
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )
                ),
              ), //temchi aal app kolha
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('252729'),
                  primarySwatch: Colors.deepOrange, //bch tbadali loun loading
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange,
                  ),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('252729'), //couleur bar notification
                      statusBarIconBrightness: Brightness.light,
                    ),
                    backgroundColor: HexColor('252729'),
                    elevation: 0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    backgroundColor: HexColor('252729'),
                    unselectedItemColor: Colors.white,
                    elevation: 20,
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                      )
                  )
              ),
              themeMode: cubit.isModeDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: NewsLayout(),
            );
          },
        ),
    );
  }
}
