import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_list/data/item_repository.dart';
import 'event.dart';
import 'state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _itemRepository = ItemRepository();

  ItemBloc() : super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is AddItemEvent) {
      yield ItemLoading();
      try {
        await _itemRepository.addItem(event.name);
        final items = await _itemRepository.getItems();
        yield ItemLoadedState(items);
      } catch (e) {
        yield ItemErrorState(e.toString());
      }
    } else if (event is RemoveItemEvent) {
      yield ItemLoading();
      try {
        await _itemRepository.removeItem();
        final items = await _itemRepository.getItems();
        yield ItemLoadedState(items);
      } catch (e) {
        yield ItemErrorState(e.toString());
      }
    }
  }

  void addItem(String name) {
    add(AddItemEvent(name));
  }

  void removeItem() {
    add(RemoveItemEvent());
  }

  @override
  Future<void> close() {
    _itemRepository.dispose();
    return super.close();
  }
}
