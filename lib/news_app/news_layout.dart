import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        )
                    );
                  },
                  icon: Icon(
                      Icons.search,
                  ),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeMode();
                },
                icon: Icon(
                  Icons.brightness_4_rounded,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (value) => cubit.changeIndex(value),
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
