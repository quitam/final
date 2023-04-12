import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/models/test_models.dart';
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
              buildTitle('Choose date'),
              //Date bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height / 8,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = index;
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
                              days[index].day,
                              style: AppTextStyles.heading28,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                days[index].dd.toString().padLeft(2, '0'),
                                style: AppTextStyles.heading28,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              buildTitle('Lotteria'),
              //Time bar of Lotteria cinema
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height / 15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
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
                      width: size.width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: selectedTimeLot == index
                            ? AppColors.blueMain
                            : AppColors.darkBackground,
                      ),
                      child: Text(
                        times[index].time,
                        style: AppTextStyles.heading20,
                      ),
                    ),
                  ),
                ),
              ),

              buildTitle('CGV'),
              //Time bar of CGV cinema
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height / 15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeLot = -1;
                        selectedTimeBHD = -1;
                        selectedTimeCGV = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      alignment: Alignment.center,
                      width: size.width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: selectedTimeCGV == index
                            ? AppColors.blueMain
                            : AppColors.darkBackground,
                      ),
                      child: Text(
                        times[index].time,
                        style: AppTextStyles.heading20,
                      ),
                    ),
                  ),
                ),
              ),

              buildTitle('BHD Star'),
              //Time bar of CGV cinema
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: size.height / 15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTimeLot = -1;
                        selectedTimeBHD = index;
                        selectedTimeCGV = -1;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      alignment: Alignment.center,
                      width: size.width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: selectedTimeBHD == index
                            ? AppColors.blueMain
                            : AppColors.darkBackground,
                      ),
                      child: Text(
                        times[index].time,
                        style: AppTextStyles.heading20,
                      ),
                    ),
                  ),
                ),
              ),

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
