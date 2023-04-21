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
  int selectedTimeLot = -1;
  int selectedTimeCGV = -1;
  int selectedTimeBHD = -1;

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
          screening.startTime.day == uniqueDatesOfScreenings[selectedDate].day)
        validScreenings.add(screening);
    }
    return validScreenings;
  }

  String getScreeningDuration(Screening screening) {
    return (screening.startTime.hour.toString() +
        ":" +
        screening.startTime.minute.toString() +
        " ~ " +
        screening.endTime.hour.toString() +
        ":" +
        screening.endTime.minute.toString());
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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

                                print(theatersWithSelectedDateAndFilm.length);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: size.height / 8,
                              width: size.width / 5,
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
                                      (uniqueDatesOfScreenings[index]
                                              .day
                                              .toString() +
                                          " - " +
                                          uniqueDatesOfScreenings[index]
                                              .month
                                              .toString()),
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

              SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: theatersWithSelectedDateAndFilm.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Screening> selectedTheaterScreenings =
                          getScreeningsOfTheaterAndSelectedDate(
                              theatersWithSelectedDateAndFilm[index]);
                      return Column(
                        children: [
                          buildTitle(
                              theatersWithSelectedDateAndFilm[index].name),
                          Container(
                            margin: const EdgeInsets.only(top: 8, bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: size.height / 15,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedTheaterScreenings.length,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTimeLot = index;
                                    selectedTimeBHD = -1;
                                    selectedTimeCGV = -1;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 14),
                                  alignment: Alignment.center,
                                  width: size.width / 3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: selectedTimeLot == index
                                        ? AppColors.blueMain
                                        : AppColors.darkBackground,
                                  ),
                                  child: Text(
                                    getScreeningDuration(
                                        selectedTheaterScreenings[index]),
                                    style: AppTextStyles.heading18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),

              // if (checkTheaterGroup("lotte")) buildTitle('Rạp Lotteria'),

              // //Time bar of Lotteria cinema
              // if (checkTheaterGroup("lotte"))
              //   Container(
              //     margin: const EdgeInsets.only(top: 8, bottom: 16),
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     height: size.height / 15,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: times.length,
              //       itemBuilder: (context, index) => GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             selectedTimeLot = index;
              //             selectedTimeBHD = -1;
              //             selectedTimeCGV = -1;
              //           });
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.only(right: 14),
              //           alignment: Alignment.center,
              //           width: size.width / 4,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(14),
              //             color: selectedTimeLot == index
              //                 ? AppColors.blueMain
              //                 : AppColors.darkBackground,
              //           ),
              //           child: Text(
              //             times[index].time,
              //             style: AppTextStyles.heading20,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),

              // if (checkTheaterGroup("cgv")) buildTitle('Rạp CGV'),
              // //Time bar of CGV cinema
              // if (checkTheaterGroup("cgv"))
              //   Container(
              //     margin: const EdgeInsets.only(top: 8, bottom: 16),
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     height: size.height / 15,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: times.length,
              //       itemBuilder: (context, index) => GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             selectedTimeLot = -1;
              //             selectedTimeBHD = -1;
              //             selectedTimeCGV = index;
              //           });
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.only(right: 14),
              //           alignment: Alignment.center,
              //           width: size.width / 4,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(14),
              //             color: selectedTimeCGV == index
              //                 ? AppColors.blueMain
              //                 : AppColors.darkBackground,
              //           ),
              //           child: Text(
              //             times[index].time,
              //             style: AppTextStyles.heading20,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),

              // if (checkTheaterGroup("bhd")) buildTitle('Rạp BHD Star'),
              // //Time bar of CGV cinema
              // if (checkTheaterGroup("bhd"))
              //   Container(
              //     margin: const EdgeInsets.only(top: 8, bottom: 16),
              //     padding: const EdgeInsets.symmetric(horizontal: 20),
              //     height: size.height / 15,
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemCount: times.length,
              //       itemBuilder: (context, index) => GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             selectedTimeLot = -1;
              //             selectedTimeBHD = index;
              //             selectedTimeCGV = -1;
              //           });
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.only(right: 14),
              //           alignment: Alignment.center,
              //           width: size.width / 4,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(14),
              //             color: selectedTimeBHD == index
              //                 ? AppColors.blueMain
              //                 : AppColors.darkBackground,
              //           ),
              //           child: Text(
              //             times[index].time,
              //             style: AppTextStyles.heading20,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),

              //button next page
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedTimeLot != -1 ||
                        selectedTimeCGV != -1 ||
                        selectedTimeBHD != -1) {
                      if (selectedDate == -1) {
                        toast('Vui lòng chọn ngày');
                      } else {
                        toast('Chọn ghế');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectSeatPage(
                                  movie: widget.movie,
                                  cinema: selectedTimeLot != -1
                                      ? 'Lotteria'
                                      : (selectedTimeCGV != -1
                                          ? 'CGV'
                                          : 'BHD Star')),
                            ));
                      }
                    } else {
                      if (selectedDate == -1) {
                        toast('Không được để trống thông tin');
                      } else {
                        toast('Vui lòng chọn rạp và giờ');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          (selectedDate != -1 && selectedTimeLot != -1 ||
                                  selectedDate != -1 && selectedTimeCGV != -1 ||
                                  selectedDate != -1 && selectedTimeBHD != -1)
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
