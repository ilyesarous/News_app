abstract class NewsStates{}

class NewsInitialState extends NewsStates{}
class NewsBottomNavigationState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusiniessErrorState extends NewsStates{
  final String error;
  NewsGetBusiniessErrorState(this.error);
}
class NewsGetSportSuccessState extends NewsStates{}
class NewsGetSportErrorState extends NewsStates{
  final String error;
  NewsGetSportErrorState(this.error);
}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceErrorState extends NewsStates{
  final String error;
  NewsGetScienceErrorState(this.error);
}

class NewsSearchSuccessState extends NewsStates{}
class NewsSearchErrorState extends NewsStates{
  final String error;
  NewsSearchErrorState(this.error);
}

class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetSportLoadingState extends NewsStates{}
class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetSearchLoadingState extends NewsStates{}

class NewsChangeModeState extends NewsStates{}