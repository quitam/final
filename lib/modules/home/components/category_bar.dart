import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/models.dart';
import 'package:flutter/material.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    super.key,
  });

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StreamBuilder(
        stream: getGenres(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final genres = snapshot.data!;
            return Container(
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      width: 90,
                      decoration: selectedTab == index
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightBlue,
                            )
                          : const BoxDecoration(color: Colors.transparent),
                      child: Text(
                        //to uppercase first letter of genre
                        genres[index].id[0].toUpperCase() +
                            genres[index].id.substring(1).toLowerCase(),
                        style: AppTextStyles.normal15,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Spacer();
          }
        },
      ),
    );
  }
}

Stream<List<Genre>> getGenres() =>
    FirebaseFirestore.instance.collection("Genre").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => Genre.fromJson(e.data())).toList());
