import 'dart:async';
import 'dart:math';
import 'package:flutter_test_list/models/item_model.dart';
import 'package:flutter_test_list/utils/dimens.dart';
import 'package:flutter_test_list/utils/strings.dart';

class ItemRepository {
  final List<ItemModel> _items = [];
  final Random _random = Random();

  final StreamController<List<ItemModel>> _itemsStreamController =
      StreamController<List<ItemModel>>.broadcast();

  Future<void> addItem(String name) async {
    await Future.delayed(const Duration(milliseconds: ThemeDimens.interval));

    if (_random.nextInt(ThemeDimens.randomMistake) == ThemeDimens.none) {
      throw Exception(addMistakeMssg);
    }

    final item = ItemModel(name);

    _items.add(item);
    _itemsStreamController.sink.add(_items);
  }

  Future<void> removeItem() async {
    if (_items.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: ThemeDimens.interval));

      if (_random.nextInt(ThemeDimens.randomMistake) == ThemeDimens.none) {
        throw Exception(removeMistakeMssg);
      }

      _items.removeLast();
      _itemsStreamController.sink.add(_items);
    }
  }

  Future<List<ItemModel>> getItems() async {
    await Future.delayed(const Duration(milliseconds: ThemeDimens.interval));

    if (_random.nextInt(ThemeDimens.randomMistake) == ThemeDimens.none) {
      throw Exception(getMistakeMssg);
    }

    return List<ItemModel>.from(_items);
  }

  Stream<List<ItemModel>> get itemsStream => _itemsStreamController.stream;

  void dispose() {
    _itemsStreamController.close();
  }
}
