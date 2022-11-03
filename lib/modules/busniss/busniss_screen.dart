import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);

        return ConditionalBuilder(
            condition: state is! NewsGetBusinessLoadingState,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => defaultArticle(cubit.business[index], context),
              separatorBuilder: (context, index) => mySeperator(),
              itemCount: cubit.business.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
