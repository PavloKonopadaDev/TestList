import 'package:flutter_test_list/models/item_model.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoadedState extends ItemState {
  final List<ItemModel> items;

  ItemLoadedState(this.items);
}

class ItemErrorState extends ItemState {
  final String errorMessage;

  ItemErrorState(this.errorMessage);
}
