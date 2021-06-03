import 'package:flutter/foundation.dart';
import 'package:food2fork/Network/NetworkService.dart';
import 'package:json_annotation/json_annotation.dart';

class Recipe {
  int pk;
  String title;
  String publisher;
  String featuredImage;
  int rating;
  String sourceUrl;
  String description;
  dynamic cookingInstructions;
  List<String> ingredients;
  String dateAdded;
  String dateUpdated;
  int longDateAdded;
  int longDateUpdated;

  Recipe(
      this.pk,
      this.title,
      this.publisher,
      this.featuredImage,
      this.rating,
      this.sourceUrl,
      this.description,
      this.cookingInstructions,
      this.ingredients,
      this.dateAdded,
      this.dateUpdated,
      this.longDateAdded,
      this.longDateUpdated);

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      json["pk"],
      json["title"],
      json["publisher"],
      json["featured_image"],
      json["rating"],
      json["source_url"],
      json["description"],
      json["cooking_instructions"],
      json["ingredients"] != null ? json["ingredients"].cast<String>() : [],
      json["date_added"],
      json["date_updated"],
      json["long_date_added"],
      json["long_date_updated"],
    );
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["pk"] = pk;
    map["title"] = title;
    map["publisher"] = publisher;
    map["featured_image"] = featuredImage;
    map["rating"] = rating;
    map["source_url"] = sourceUrl;
    map["description"] = description;
    map["cooking_instructions"] = cookingInstructions;
    map["ingredients"] = ingredients;
    map["date_added"] = dateAdded;
    map["date_updated"] = dateUpdated;
    map["long_date_added"] = longDateAdded;
    map["long_date_updated"] = longDateUpdated;
    return map;
  }
}