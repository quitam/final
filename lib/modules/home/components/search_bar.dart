import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<String> movieNames = [];

  @override
  void initState() {
    super.initState();
    getAllMovieNames().then((list) {
      setState(() {
        movieNames = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: widget.size.height / 15,
        child: Row(children: [
          Expanded(
              child: Container(
            height: widget.size.height / 15,
            decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(20)),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 12),
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AppColors.white,
                ),
              ),
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == "") {
                      return const Iterable<String>.empty();
                    }
                    return movieNames.where((String movieName) => movieName
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (String movieName) {
                    print(movieName);
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: 'Type something',
                        hintStyle: TextStyle(
                          color: Colors.white30,
                        ),
                      ),
                      onChanged: (String value) {
                        // Do something as the user types
                      },
                      onSubmitted: (String value) {
                        onFieldSubmitted();
                      },
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<String> onSelected,
                      Iterable<String> options) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          color: AppColors.darkBackground,
                          elevation: 4.0,
                          child: Container(
                            height: 200.0,
                            width: 200.0,
                            child: ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    color: Colors.lightBlue.withOpacity(0),
                                    child: Text(option, style: const TextStyle(color: Colors.white),),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          )),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              width: widget.size.height / 15,
              height: widget.size.height / 15,
              decoration: BoxDecoration(
                  color: AppColors.blueMain,
                  borderRadius: BorderRadius.circular(14)),
              child: const FaIcon(
                FontAwesomeIcons.sliders,
                color: AppColors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
