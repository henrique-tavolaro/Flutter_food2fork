


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food2fork/Network/NetworkService.dart';
import 'package:meta/meta.dart';

import 'model/Recipe.dart';

abstract class SearchEvent extends Equatable{}

class RecipeSearchEvent extends SearchEvent{
  final String query;
  final int page;

  RecipeSearchEvent(this.query, this.page);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

abstract class SearchState extends Equatable{}

class RecipeInitialState extends SearchState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class RecipeIsLoadingState extends SearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class RecipeLoadedState extends SearchState{

  final List<Recipe> recipesList;

  RecipeLoadedState({required this.recipesList});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RecipeErrorState extends SearchState {

  final String message;

  RecipeErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class RecipeBloc extends Bloc<SearchEvent, SearchState>{

  final NetworkService networkService;

  RecipeBloc(this.networkService) : super(RecipeInitialState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if(event is RecipeSearchEvent){
      yield RecipeIsLoadingState();
      try{
        List<Recipe> recipeList = await networkService.getRecipes(event.query, event.page);
        print('asasd $recipeList');
        yield RecipeLoadedState(recipesList: recipeList);
      } catch (e){
        print('asasd $e');
        yield RecipeErrorState(message: e.toString());
      }
    }
  }
}