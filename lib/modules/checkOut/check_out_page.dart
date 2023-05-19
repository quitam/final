import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/home/bottom_nav.dart';
import 'package:final_project/modules/movieDetail/movie_detail_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CheckOutPage extends StatelessWidget {
  final Movie movie;
  final Theater theater;
  final Screening screening;
  final List<String> seatsToCheckOut;
  const CheckOutPage(
      {super.key,
      required this.movie,
      required this.theater,
      required this.screening,
      required this.seatsToCheckOut});

  String getQRData()
  {
    String data = "";
    data += FirebaseAuth.instance.currentUser?.uid ?? "";
    data += "&" + screening.id + "&";
    data += getSeatsQRData();
    return data;
  }

  String getSeatsQRData()
  {
    String data = "";
    seatsToCheckOut.sort((a, b) => a.compareTo(b),);
    for(String tempSeat in seatsToCheckOut)
    {
      data += tempSeat + "." ;
    }
    return ((data.isNotEmpty) ? data.substring(0, data.length - 1) : "");
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, MMM d, yyyy').format(screening.startTime);
    String formattedTime = DateFormat('h:mm a').format(screening.startTime);
    String seatsAsString = "";
    String price =
        screening.price.toString() + " x" + seatsToCheckOut.length.toString();
    String totalPrice =
        (seatsToCheckOut.length * screening.price).toString() + " VND";

    for (String tempSeat in seatsToCheckOut) {
      seatsAsString = "$seatsAsString $tempSeat";
    }

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Thanh toán',
          style: AppTextStyles.heading28,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColors.white, width: 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: getImageUrl(movie.posterUrl),
                  builder: (context, snapshot) {
                    if (!snapshot.hasError && snapshot.hasData) {
                      String imageURL = snapshot.data ?? "";
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: size.width / 3.5,
                        child: Image(
                          image: NetworkImage(imageURL),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          width: size.width,
                          child: Text(
                            movie.name,
                            style: AppTextStyles.heading20,
                          )),
                      Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 8),
                          child: Row(
                            children: const [Text('5000 votes')],
                          )),
                      Container(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        width: size.width,
                        child: StreamBuilder(
                          stream: getGenres(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasError && snapshot.hasData) {
                              List<Genre> genres = snapshot.data!;
                              return Text(
                                getGenresAsSingleString(movie, genres),
                                style: AppTextStyles.normal16
                                    .copyWith(color: AppColors.green),
                              );
                            } else {
                              return const Text("N/A");
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        width: size.width,
                        child: Text('Thời lượng: ${movie.duration} phút',
                            style: AppTextStyles.normal16
                                .copyWith(color: AppColors.grey)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColors.white, width: 2))),
            child: Column(
              children: [
                buildPriceDetail('ID', '11012001'),
                buildPriceDetail('Rạp', theater.name),
                buildPriceDetail(
                    'Ngày và giờ', '$formattedDate \nat $formattedTime'),
                buildPriceDetail('Số ghế', seatsAsString),
                buildPriceDetail('Giá', price),
              ],
            ),
          ),
          buildTotalPrice(totalPrice),
          Expanded(
              child: Center(
            child: GestureDetector(
              onTap: () {
                // String qrData = getQRData();
                if (FirebaseAuth.instance.currentUser != null) {
                  String? userId = FirebaseAuth.instance.currentUser?.uid;
                  for(String tempSeat in seatsToCheckOut)
                  {
                    addNewTicketDocumentation("", screening.id, tempSeat, userId ?? "");
                  }
                  toast('Thanh toán thành công');
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const BottomNav(),
                      ),
                      (route) => false);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: size.height / 16,
                width: size.width / 2,
                decoration: BoxDecoration(
                    color: AppColors.blueMain,
                    borderRadius: BorderRadius.circular(16)),
                child: const Text(
                  'Thanh toán',
                  style: AppTextStyles.heading20,
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }

  Container buildTotalPrice(String content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Tổng:',
            style: AppTextStyles.heading18,
          ),
          Text(
            content,
            style: AppTextStyles.heading18.copyWith(
                color: AppColors.blueMain, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Container buildPriceDetail(String title, String detail) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.normal16,
          ),
          Text(
            textAlign: TextAlign.right,
            detail,
            style: AppTextStyles.normal16,
            overflow: TextOverflow.clip,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}

bool addNewTicketDocumentation(
    String id, String screeningId, String seat, String userId) {
  DocumentReference ticketDoc =
      FirebaseFirestore.instance.collection("Ticket").doc();
  Map<String, dynamic> ticketData = {
    'id': id,
    'screening': screeningId,
    'seat': seat,
    'user': userId,
  };
  bool result = true;
  ticketDoc.set(ticketData).then((value) {}).catchError((error) {
    result = false;
    print("Khong the them document cho ticket voi loi: $error");
  });
  return result;
}
