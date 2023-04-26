abstract class ItemEvent {}

class AddItemEvent extends ItemEvent {
  final String name;

  AddItemEvent(this.name);
}

class RemoveItemEvent extends ItemEvent {}
