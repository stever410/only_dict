import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:only_dict/src/models/word.dart';

import 'word_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    this.items = const [],
  });

  static const routeName = '/';

  final List<Word> items;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Autocomplete(
                fieldViewBuilder: (context, textEditingController, focusNode,
                        onFieldSubmitted) =>
                    PlatformTextField(
                  material: (context, platform) => MaterialTextFieldData(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  controller: textController,
                  focusNode: focusNode,
                  onSubmitted: (value) => onFieldSubmitted(),
                  hintText: "Search here",
                ),
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  } else {
                    List<String> matches = <String>[];

                    matches.retainWhere((s) {
                      return s
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                    return matches;
                  }
                },
                onSelected: (String selection) {
                  print('You just selected $selection');
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PlatformText(
                    "Recent",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListView.builder(
                // Providing a restorationId allows the ListView to restore the
                // scroll position when a user leaves and returns to the app after it
                // has been killed while running in the background.
                restorationId: 'sampleItemListView',
                itemCount: items.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];

                  return PlatformListTile(
                      title: PlatformText('SampleItem ${item.id}'),
                      material: (context, platform) => MaterialListTileData(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0.0),
                            visualDensity: VisualDensity.compact,
                          ),
                      onTap: () {
                        // Navigate to the details page. If the user leaves and returns to
                        // the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                          context,
                          WordDetailsScreen.routeName,
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
