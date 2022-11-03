import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var search = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text(
                        'search',
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => NewsCubit.get(context).getSearch(value),
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'enter ur search';
                      }
                      return null;
                    },
                    controller: searchController,
                  )
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => mySeperator(),
                    itemCount: search.length,
                    itemBuilder: (context, index) => defaultArticle(search[index], context,),
                  ),
                ),
              ],
            ),
        );
      },
    );
  }
}
