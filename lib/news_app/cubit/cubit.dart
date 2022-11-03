import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/busniss/busniss_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/news_app/cubit/states.dart';

import '../../network/local/cach_helper.dart';
import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
// BottomNavBar
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.settings,
    //   ),
    //   label: 'Settings',
    // ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];
  void changeIndex(int index){
    currentIndex = index;
    // if(currentIndex == 0) getBusiness();
     if (currentIndex == 1) getSport();
    else if(currentIndex == 2) getScience();
    emit(NewsBottomNavigationState());
  }

  //getingArticles
  List business = [];
  List sport = [];
  List science = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0){ // bch n5alih yaaml reload mara wahda
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'business',
          'apiKey':'03a0d5d55bff45aaac4d0e5bf5b7c757',
        },
      ).then((value){
        // print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusiniessErrorState(error));
      });
    }else{
      emit(NewsGetBusinessSuccessState());
    }
  }
  void getSport(){
    emit(NewsGetSportLoadingState());

    if(sport.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'03a0d5d55bff45aaac4d0e5bf5b7c757',
        },
      ).then((value){
        // print(value.data['articles'][0]['title']);
        sport = value.data['articles'];
        print(sport[0]['title']);
        emit(NewsGetSportSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportErrorState(error));
      });
    }else {
      emit(NewsGetSportSuccessState());
    }
  }
  void getScience(){
    emit(NewsGetScienceLoadingState());

    if(science.length == 0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apiKey':'03a0d5d55bff45aaac4d0e5bf5b7c757',
        },
      ).then((value){
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  // darkMode
  bool isModeDark = false;

  void changeMode({bool? x,}){
    if(x != null) {
      isModeDark = x;
    } else {
      isModeDark = !isModeDark;
      CachHelper.putData(key: 'isModeDark', value: isModeDark).then((value){
        emit(NewsChangeModeState());
      });
    }
  }
  // search

  List<dynamic> search = [];

  void getSearch(String value){

    emit(NewsGetSearchLoadingState());

    // search = [];

    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apiKey':'03a0d5d55bff45aaac4d0e5bf5b7c757',
        },
      ).then((value){
        search = value.data['articles'];
        print(search[0]['title']);
        emit(NewsSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsSearchErrorState(error));
      });
  }
}