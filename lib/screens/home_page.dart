import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_list/bloc/bloc.dart';
import 'package:flutter_test_list/bloc/state.dart';
import 'package:flutter_test_list/utils/dimens.dart';
import 'package:flutter_test_list/utils/strings.dart';

class HomeScreen extends StatelessWidget {
  final _itemBloc = ItemBloc();
  final bool innnerBox = true;
  final TextEditingController _textEditingController = TextEditingController();

  void _removeItem(BuildContext context) async {
    _itemBloc.removeItem();
  }

  void dispose() {
    _itemBloc.close();
  }

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              expandedHeight: ThemeDimens.appBarHeight,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(ThemeDimens.spaceHuge),
                child: FlutterLogo(
                  size: ThemeDimens.logoSize,
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<ItemBloc, ItemState>(
                bloc: _itemBloc,
                builder: (context, state) {
                  if (state is ItemLoadedState) {
                    return Expanded(
                      flex: ThemeDimens.spaceSmallInt,
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: state.items.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.0,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: Center(
                              child: Text(state.items[index].name),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ItemErrorState) {
                    return Expanded(
                      flex: ThemeDimens.spaceSmallInt,
                      child: Center(
                        child: Text('$errorString: ${state.errorMessage}'),
                      ),
                    );
                  } else if (state is ItemLoading) {
                    return const Expanded(
                      flex: ThemeDimens.spaceSmallInt,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => _addItem(context),
              tooltip: floatingActionAddItem,
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: ThemeDimens.spaceBig),
            FloatingActionButton(
              onPressed: () => _removeItem(context),
              tooltip: floatingActionRemoveItem,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      );

  void _addItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(titleOfDialog),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: hintTextForDialog),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text(cancelButon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text(okButton),
              onPressed: () {
                String name = _textEditingController.text;
                _itemBloc.addItem(name);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
