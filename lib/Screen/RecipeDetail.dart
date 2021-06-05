import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food2fork/model/Recipe.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 500,
                padding: EdgeInsets.only(bottom: 8),
                child: Image.network(
                  recipe.featuredImage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    recipe.rating.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Updated ${recipe.dateUpdated}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              for (String ingredient in recipe.ingredients)
                // SingleChildScrollView(
                //   scrollDirection: Axis.vertical,
                //   child:
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ingredient,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                // ),
            ],
          ),
        ),
      ),
    );
  }
}
