import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent {}

class FetchAllProductsEvent extends ProductEvent {
  final String? search;
  final String? sortBy;
  final String? category;
  final int? skip;
  final num? limit;
  FetchAllProductsEvent({this.search, this.sortBy, this.category, this.skip, this.limit});
}

class FetchProductsEventById extends ProductEvent {
  final int id;
  FetchProductsEventById(this.id);
}

class FetchProductCategoryListEvent extends ProductEvent {}