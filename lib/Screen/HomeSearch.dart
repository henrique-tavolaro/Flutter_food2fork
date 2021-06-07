import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food2fork/Network/NetworkService.dart';
import 'package:food2fork/SearchBloc.dart';
import 'package:food2fork/model/Recipe.dart';

import 'RecipeDetail.dart';

class HomeSearch extends StatefulWidget {
  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  final TextEditingController _searchRecipeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  NetworkService networkService = NetworkService();
  bool isSelected = false;
  var page = 1;
  List<Recipe> recipeList = [];
  String query = "";
  String lastSearched = "";

  List<String> listCategories = [
    'Chicken',
    'Beef',
    'Soup',
    'Vegetarian',
    'Dessert',
    'Milk',
    'Vegan',
    'Pizza',
    'Donut',
  ];
  late RecipeBloc recipeBloc;

  @override
  void initState() {
    super.initState();
    recipeBloc = BlocProvider.of<RecipeBloc>(context);
    recipeBloc.add(RecipeSearchEvent(query, page));

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          page++;
          print('page1 $page');
          recipeBloc.add(RecipeSearchEvent(query, page));
        }
        if(_scrollController.position.pixels == _scrollController.position.pixels) {
          query = _searchRecipeController.text;
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('start: ${isSelected.toString()}');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 120,
          title: Column(
            children: [
              TextField(
                controller: _searchRecipeController,
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Search recipe',
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (query) {
                  print('recipeList1: $recipeList');
                  recipeList.clear();
                  page = 1;
                  print('page: $page');
                  // query = _searchRecipeController.text;
                  setState(() {
                    query = _searchRecipeController.text;
                  });
                  recipeBloc.add(RecipeSearchEvent(query, page));

                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 4),
                child: Row(children: [
                  ChoiceChipWidget(
                      listCategories, _searchRecipeController, page, () {
                    recipeList.clear();
                    page = 1;
                    query = _searchRecipeController.text;
                    setState(() {
                      query = _searchRecipeController.text;
                    });

                  })
                ]),
              )
            ],
          ),
          elevation: 8,

          // actions: [
          //   Icon(
          //     Icons.wb_incandescent_outlined,
          //     color: Colors.blue,
          //   )
          // ],
        ),
        body: BlocBuilder<RecipeBloc, SearchState>(
          builder: (context, state) {
            if (state is RecipeInitialState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RecipeIsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RecipeLoadedState) {
              recipeList.addAll(state.recipesList);
              return ListView.builder(
                  controller: _scrollController,
                  key: _searchRecipeController.text.toLowerCase() == query.toLowerCase()
                      ? PageStorageKey<String>('page')
                      : ObjectKey(recipeList[0]),
                  itemCount: recipeList.length,
                  itemBuilder: (context, index) {
                    final item = recipeList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RecipeDetail(item),
                          ),
                        );
                      },
                      child: RecipeCard(item.featuredImage.toString(),
                          item.title, item.rating),
                    );
                  });
            } else if (state is RecipeErrorState) {
              return Text('error');
            } else {
              return Text('error');
            }
          },
        ));
  }
}

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

class ChoiceChipWidget extends StatefulWidget {
  late final List<String> foodCategories;
  final TextEditingController searchController;
  late final int page;
  final Function onClick;

  ChoiceChipWidget(
      this.foodCategories, this.searchController, this.page, this.onClick);

  @override
  _ChoiceChipWidgetState createState() => new _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  String selectedChoice = "";
  String query = "";

  _buildChoiceList() {
    List<Widget> categories = [];
    widget.foodCategories.forEach((item) {
      categories.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
          backgroundColor: Colors.blue,
          selectedColor: Colors.grey.shade400,
          selected: selectedChoice == item,
          onSelected: (selected) {
            widget.onClick();
            BlocProvider.of<RecipeBloc>(context)
                .add(RecipeSearchEvent(item, widget.page));
            setState(() {
              widget.searchController.text = item;
              selectedChoice = item;
              // query = item;
              // print('sss $query');
            });
          },
        ),
      ));
    });
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
