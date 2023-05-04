import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/checkOut/check_out_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSeatPage extends StatefulWidget {
  final Movie movie;
  final Theater theater;
  final Screening screening;
  const SelectSeatPage(
      {super.key,
      required this.movie,
      required this.theater,
      required this.screening});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> rows = [];
  List<int> columns = [];
  List<Ticket> tickets = [];

  Color availableSeatColor = AppColors.darkBackground;
  Color unavaliableSeatColor = AppColors.greyBackground;
  Color selectedSeatColor = AppColors.blueMain;

  List<String> selectedSeats = [];

  String calculateTotalPrice() {
    String price = "";
    price = (widget.screening.price * selectedSeats.length).toString() + " đ";
    return price;
  }

  bool isSeatAvailable(String row, int column) {
    String seat = row + column.toString();
    for (Ticket ticket in tickets) {
      if (ticket.seat == seat) return false;
    }
    return true;
  }

  bool isSeatSelectedForCharging(String row, int column) {
    String seat = row + column.toString();
    return selectedSeats.contains(seat);
  }

  @override
  void initState() {
    super.initState();
    rows.clear();
    columns.clear();

    for (int i = 0; i < widget.theater.seatRows; i++) {
      rows.add(String.fromCharCode(i + 65).toUpperCase());
    }
    rows = rows.reversed.toList();

    for (int i = 0; i < widget.theater.seatColumns; i++) {
      columns.add(i + 1);
    }

    getAllTicketsOfScreening(widget.screening.id).then((value) {
      setState(() {
        tickets = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Movie title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        widget.movie.name,
                        style: AppTextStyles.heading20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.theater.name,
                        style: AppTextStyles.heading18.copyWith(
                            fontStyle: FontStyle.italic, color: AppColors.grey),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildSeatStatus(
                          color: AppColors.darkBackground, status: 'Còn trống'),
                      buildSeatStatus(
                          color: AppColors.blueMain, status: 'Bạn chọn'),
                      buildSeatStatus(
                          color: AppColors.greyBackground, status: 'Đã đặt'),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: rows
                          .map((row) => Builder(
                                builder: (context) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: columns
                                      .map((number) => Builder(
                                            builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 44,
                                                width: 44,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      String seat = row +
                                                          number.toString();
                                                      if (isSeatAvailable(
                                                          row, number)) {
                                                        if (!selectedSeats
                                                            .contains(seat)) {
                                                          selectedSeats
                                                              .add(seat);
                                                        } else {
                                                          selectedSeats
                                                              .remove(seat);
                                                        }
                                                      }
                                                    });
                                                    for (String tempSeat
                                                        in selectedSeats) {
                                                      print(tempSeat);
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                AppColors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: isSeatAvailable(
                                                                row, number)
                                                            ? (isSeatSelectedForCharging(
                                                                    row, number)
                                                                ? selectedSeatColor
                                                                : availableSeatColor)
                                                            : unavaliableSeatColor),
                                                    child: Text(
                                                      row + number.toString(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Màn hình',
                    style:
                        AppTextStyles.heading18.copyWith(color: AppColors.grey),
                  ),
                ),
                Center(child: Image.asset(AssetPath.screen)),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tổng giá:',
                            style: AppTextStyles.normal16
                                .copyWith(color: AppColors.green),
                          ),
                          Text(
                            calculateTotalPrice(),
                            style: AppTextStyles.heading18,
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          if (selectedSeats.length == 0) {
                            toast("Bạn chưa chọn ghế");
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckOutPage(
                                      movie: widget.movie, theater: widget.theater, screening: widget.screening, seatsToCheckOut: selectedSeats),
                                ));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height / 16,
                          width: size.width / 3,
                          decoration: BoxDecoration(
                              color: AppColors.blueMain,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Text(
                            'Thanh toán',
                            style: AppTextStyles.heading20,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Row buildSeatStatus({required String status, required Color color}) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            status,
            style: AppTextStyles.heading18,
          ),
        ),
      ],
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
