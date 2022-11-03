import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/web_view/webview_screen.dart';
import 'package:news_app/news_app/cubit/cubit.dart';
import 'package:news_app/news_app/cubit/states.dart';

Widget defaultArticle(article, context){
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(article['url']),
          )
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                )
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget mySeperator(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey[300],
    ),
  );
}

Widget defaultInput ({

  required String title,
  required IconData preIcon,
  required TextEditingController textController,
  required TextInputType type,
  var validate,
  var sufIcon,
  var sufIconPressed,
  bool obscure = false,
  var onTap,
  var onChange,

}) => TextFormField(
  decoration: InputDecoration(
      label: Text(
        title,
      ),
      border: OutlineInputBorder(),
      prefixIcon: Icon(
        preIcon,
      ),
      suffixIcon: MaterialButton(
          onPressed: (){
            sufIconPressed;
          },
          child: Icon(
            sufIcon,
          )
      )
  ),
  obscureText: obscure,
  keyboardType: type,
  onTap: onTap,
  controller: textController,
  validator: validate,
  onChanged: onChange,

);