// ignore_for_file: avoid_print

import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  List<Movie> listMovies = [];
  List<Movie> resultSearch = [];

  @override
  void initState() {
    super.initState();
    getAllMovieNames().then((list) {
      setState(() {
        movieNames = list;
      });
    });
    getAllMovie().then((list) {
      setState(() {
        listMovies = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: SizedBox(
        height: widget.size.height / 15,
        child: Expanded(
            child: Container(
          height: widget.size.height / 15,
          decoration: BoxDecoration(
              color: AppColors.darkBackground,
              borderRadius: BorderRadius.circular(28)),
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
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: 'Tìm tên phim',
                      hintStyle: AppTextStyles.hint15,
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
                  final Size size = MediaQuery.of(context).size;
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        color: AppColors.darkBackground,
                        elevation: 4.0,
                        child: SizedBox(
                          width: size.width * 0.7,
                          child: ListView.builder(
                            shrinkWrap: true,
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
                                  child: Text(
                                    option,
                                    style: const TextStyle(color: Colors.white),
                                  ),
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
      ),
    );
  }
}
