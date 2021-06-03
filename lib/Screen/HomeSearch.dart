import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food2fork/Network/NetworkService.dart';
import 'package:food2fork/SearchBloc.dart';
import 'package:food2fork/model/Recipe.dart';

class HomeSearch extends StatefulWidget {
  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  final TextEditingController _searchRecipeController = TextEditingController();
  NetworkService networkService = NetworkService();
  late Future<List> _futureRecipe;
  List list = [];
  late RecipeBloc recipeBloc;

  @override
  void initState() {
    super.initState();
    recipeBloc = BlocProvider.of<RecipeBloc>(context);
    recipeBloc.add(RecipeSearchEvent());
  }

  @override
  Widget build(BuildContext context) {
    // final ze = ;
    print('futureRecipe : $list');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextField(
            controller: _searchRecipeController,
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              labelText: 'Search recipe',
            ),
          ),
          elevation: 8,
          actions: [
            Icon(
              Icons.wb_incandescent_outlined,
              color: Colors.blue,
            )
          ],
        ),
        body: BlocBuilder<RecipeBloc, SearchState>(
          builder: (context, state){
            if(state is RecipeInitialState){
              return Center(child: CircularProgressIndicator());
            } else if (state is RecipeIsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RecipeLoadedState) {
              final List<Recipe> recipeList = state.recipesList;
              return ListView.builder(
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    final item = recipeList[index];
                    return RecipeCard(
                        item.featuredImage.toString(), item.title, item.rating);
                  });
                          } else if (state is RecipeErrorState){
              return Text('error');
            } else {
              return Text('error');
            }
          },
        )



          );
  }
}

// class RecipesList extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     FutureBuilder<List<Recipe>>(
//       future: future
//     )
//     return ListView.builder(
//       itemCount: ,
//       itemBuilder: (BuildContext context, int index) {
//         return RecipeCard();
//       },
//
//     );
//   }
// }

class RecipeCard extends StatelessWidget {
  final String image;
  final String title;
  final int rating;

  RecipeCard(this.image, this.title, this.rating);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              height: 200,
              width: 500,
              child: Image.network(image, fit: BoxFit.fitWidth)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Text(rating.toString())],
            ),
          )
        ],
      ),
    );
  }
}
