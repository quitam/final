// ignore_for_file: avoid_print

import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/selectCinema/components/header.dart';
import 'package:final_project/modules/selectSeat/select_seat_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectCinemaPage extends StatefulWidget {
  final Movie movie;
  const SelectCinemaPage({super.key, required this.movie});

  @override
  State<SelectCinemaPage> createState() => _SelectCinemaPageState();
}

class _SelectCinemaPageState extends State<SelectCinemaPage> {
  int selectedDate = -1;
  Screening selectedScreening = Screening(
    id: "",
    filmId: "",
    theaterId: "",
    endTime: DateTime.now(),
    startTime: DateTime.now(),
    price: 0,
  );
  late Theater selectedTheater;
  late DateTime today;
  List<Screening> screenings = [];
  List<Screening> screeningsOfSelectedDateAndFilm = [];
  List<DateTime> uniqueDatesOfScreenings = [];
  List<Theater> theatersWithSelectedDateAndFilm = [];
  List<Theater> allTheaters = [];

  bool checkTheaterGroup(String id) {
    for (Theater theater in theatersWithSelectedDateAndFilm) {
      if (theater.groupId == id) return true;
    }
    return false;
  }

  List<Screening> getScreeningsOfTheaterAndSelectedDate(Theater theater) {
    List<Screening> validScreenings = [];
    for (Screening screening in screenings) {
      if (screening.theaterId == theater.id &&
          screening.startTime.day ==
              uniqueDatesOfScreenings[selectedDate].day) {
        validScreenings.add(screening);
      }
    }
    return validScreenings;
  }

  String getScreeningDuration(Screening screening) {
    return ("${screening.startTime.hour}:${screening.startTime.minute} ~ ${screening.endTime.hour}:${screening.endTime.minute}");
  }

  @override
  void initState() {
    super.initState();
    getAllScreeningsOfMovie(widget.movie.id).then((value) {
      setState(() {
        screenings = value;
        uniqueDatesOfScreenings = getUniqueScreeningDates(screenings);
      });
    });

    getAllTheaters().then((value) {
      setState(() {
        allTheaters = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Header(
                    size: size,
                    title: widget.movie.name,
                  ),
                  //buildAppBar(context)
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                height: size.height / 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.white),
                ),
                child: Row(children: const [
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Ho Chi Minh',
                        hintStyle: AppTextStyles.heading20,
                        icon: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.white,
                          ),
                        )),
                  )),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      size: 32,
                      Icons.keyboard_arrow_down,
                      color: AppColors.white,
                    ),
                  )
                ]),
              ),

              buildTitle('Chọn ngày'),
              //Date bar
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: size.height / 8,
                child: uniqueDatesOfScreenings.isEmpty
                    ? const SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: uniqueDatesOfScreenings.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = index;
                                List<String> uniqueTheaterIds =
                                    getTheaterUniqueIdsFromScreeningsAndInDate(
                                        screenings,
                                        uniqueDatesOfScreenings[index]);
                                uniqueTheaterIds.sort((a, b) => a.compareTo(b));
                                theatersWithSelectedDateAndFilm =
                                    getTheatersFromIds(
                                        uniqueTheaterIds, allTheaters);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: size.height / 8,
                              width: size.width / 4,
                              decoration: BoxDecoration(
                                  color: selectedDate == index
                                      ? AppColors.blueMain
                                      : AppColors.darkBackground,
                                  borderRadius: BorderRadius.circular(14)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    daysOfWeek[
                                        uniqueDatesOfScreenings[index].weekday -
                                            1],
                                    style: AppTextStyles.heading20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      ("${uniqueDatesOfScreenings[index].day} - ${uniqueDatesOfScreenings[index].month}"),
                                      style: AppTextStyles.heading20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: theatersWithSelectedDateAndFilm.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Screening> selectedTheaterScreenings =
                            getScreeningsOfTheaterAndSelectedDate(
                                theatersWithSelectedDateAndFilm[index]);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildMovieHeader(
                                theatersWithSelectedDateAndFilm[index].name),
                            buildText(
                                theatersWithSelectedDateAndFilm[index].address),
                            Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 25),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              height: size.height / 15,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedTheaterScreenings.length,
                                itemBuilder: (context, index2) =>
                                    GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedScreening =
                                          selectedTheaterScreenings[index2];
                                      selectedTheater =
                                          theatersWithSelectedDateAndFilm[
                                              index];
                                      print(selectedTheater.name);
                                      print(selectedScreening.id);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 14),
                                    alignment: Alignment.center,
                                    width: size.width / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: selectedScreening.id ==
                                              selectedTheaterScreenings[index2]
                                                  .id
                                          ? AppColors.blueMain
                                          : AppColors.darkBackground,
                                    ),
                                    child: Text(
                                      getScreeningDuration(
                                          selectedTheaterScreenings[index2]),
                                      style: AppTextStyles.heading18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              //button next page
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedScreening.id != "") {
                      toast('Chọn ghế');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectSeatPage(
                              movie: widget.movie,
                              screening: selectedScreening,
                              theater: selectedTheater),
                        ),
                      );
                    } else {
                      toast('Vui lòng chọn rạp và giờ');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (selectedScreening.id != "")
                          ? AppColors.blueMain
                          : AppColors.darkBackground,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(18)),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(
        title,
        style: AppTextStyles.heading20
            .copyWith(fontStyle: FontStyle.italic, color: AppColors.grey),
      ),
    );
  }

  Container buildMovieHeader(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(title, style: AppTextStyles.heading20),
    );
  }

  Container buildText(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(
        text,
        style: AppTextStyles.normal16
            .copyWith(fontStyle: FontStyle.italic, color: AppColors.grey),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
