import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/modules/ticket/qr_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'package:intl/intl.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});
  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  List<Ticket> tickets = [];
  List<Movie> movies = [];
  List<Screening> screenings = [];
  List<Theater> theaters = [];

  String getQRCodeDataOfScreening(Screening screening) {
    String data = "";
    data += FirebaseAuth.instance.currentUser?.uid ?? "unknown";
    data += "&" + screening.id + "&";
    data += getQRSeatsData(screening);
    return data;
  }

  String getQRSeatsData(Screening screening) {
    String data = "";
    List<Ticket> selectedTickets = [];
    for (Ticket tempTicket in tickets) {
      if (tempTicket.screeningId == screening.id) {
        selectedTickets.add(tempTicket);
      }
    }
    selectedTickets.sort(
      (a, b) => a.seat.compareTo(b.seat),
    );
    for (Ticket tempTicket in selectedTickets) {
      if (tempTicket.screeningId == screening.id) {
        data += tempTicket.seat + "_";
      }
    }
    return (data.isNotEmpty) ? data.substring(0, data.length - 1) : "no_seats_avaiable";
  }

  String getScreeningSeatsAsString(List<Ticket> tickets, Screening screening) {
    List<Ticket> selectedTickets = [];
    String seats = "";
    for (Ticket tempTicket in tickets) {
      if (tempTicket.screeningId == screening.id) {
        selectedTickets.add(tempTicket);
      }
    }
    selectedTickets.sort(
      (a, b) => a.seat.compareTo(b.seat),
    );
    for (Ticket tempTicket in selectedTickets) {
      if (tempTicket.screeningId == screening.id) {
        seats += tempTicket.seat + ", ";
      }
    }
    return (seats.isNotEmpty) ? seats.substring(0, seats.length - 1) : "không tìm thấy ghế";
  }

  Theater? getTheaterOfScreening(Screening screening) {
    for (Theater tempTheater in theaters) {
      if (tempTheater.id == screening.theaterId) return tempTheater;
    }
    return null;
  }

  Movie? getMovieOfScreening(Screening screening) {
    for (Movie tempMovie in movies) {
      if (tempMovie.id == screening.filmId) {
        return tempMovie;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getUserTickets(FirebaseAuth.instance.currentUser?.uid ?? "").then((value) {
      setState(() {
        tickets = value;
        getUniqueScreeningsFromTickets(tickets).then((value) {
          setState(() {
            screenings = value;
            getUniqueMoviesFromScreenings(screenings).then((value) {
              setState(() {
                movies = value;
              });
            });
          });
        });
      });
    });

    getAllTheaters().then((value) {
      setState(() {
        theaters = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground,
        elevation: 0,
        title: const Text(
          'My ticket',
          style: AppTextStyles.heading28,
        ),
      ),
      body: StreamBuilder(
        stream: getPlayingMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            final ticket = snapshot.data!;
            return Container(
              padding: const EdgeInsets.only(left: 20, top: 20),
              height: size.height,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: screenings.length,
                itemBuilder: (context, index) {
                  Movie? screeningMovie =
                      getMovieOfScreening(screenings[index]);
                  String formattedDate = DateFormat('EEEE, MMM d, yyyy')
                      .format(screenings[index].startTime);
                  String formattedTime =
                      DateFormat('h:mm a').format(screenings[index].startTime);
                  String seatString =
                      getScreeningSeatsAsString(tickets, screenings[index]);
                  Theater? theater = getTheaterOfScreening(screenings[index]);
                  String theaterName =
                      (theater != null) ? theater.name : "Unknown";
                  String qrCode = getQRCodeDataOfScreening(screenings[index]);

                  return (screeningMovie == null)
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRCode(
                                  qrData: qrCode,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FutureBuilder(
                                  future: getImageUrl(screeningMovie.posterUrl),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasError &&
                                        snapshot.hasData) {
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
                                          padding: const EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          width: size.width,
                                          child: Text(
                                            screeningMovie.name,
                                            style: AppTextStyles.heading20,
                                          )),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 8),
                                        width: size.width,
                                        child: Text(
                                            "Thời lượng: " +
                                                screeningMovie.duration
                                                    .toString() +
                                                " phút",
                                            style: AppTextStyles.normal16
                                                .copyWith(
                                                    color: AppColors.grey)),
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          child: Text(
                                            formattedDate,
                                            style: AppTextStyles.normal16
                                                .copyWith(
                                                    color: AppColors.grey),
                                          )),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          child: Text(
                                            "at " + formattedTime,
                                            style: AppTextStyles.normal16
                                                .copyWith(
                                                    color: AppColors.grey),
                                          )),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          child: Text(
                                            "Ghế ngồi: " + seatString,
                                            style: AppTextStyles.normal16
                                                .copyWith(
                                                    color: AppColors.grey),
                                          )),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 8, bottom: 8),
                                        width: size.width,
                                        child: Text(
                                          'Rạp: ' + theaterName,
                                          style: AppTextStyles.heading18
                                              .copyWith(color: AppColors.green),
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.only(
                                              left: 8, bottom: 8),
                                          child: Text(
                                            (theater == null)
                                                ? ""
                                                : theater.address,
                                            style: AppTextStyles.normal16
                                                .copyWith(
                                                    color: AppColors.grey),
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                })));

    // body: StreamBuilder(
    //   stream: getPlayingMovies(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData && !snapshot.hasError) {
    //       final ticket = snapshot.data!;
    //       return Container(
    //         padding: const EdgeInsets.only(left: 20, top: 20),
    //         height: size.height,
    //         child: ListView.builder(
    //           scrollDirection: Axis.vertical,
    //           itemCount: ticket.length,
    //           itemBuilder: (context, index) {
    //             return Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 10),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   FutureBuilder(
    //                     future: getImageUrl(ticket[index].posterUrl),
    //                     builder: (context, snapshot) {
    //                       if (!snapshot.hasError && snapshot.hasData) {
    //                         String imageURL = snapshot.data ?? "";
    //                         return Container(
    //                           alignment: Alignment.centerLeft,
    //                           width: size.width / 3.5,
    //                           child: Image(
    //                             image: NetworkImage(imageURL),
    //                             fit: BoxFit.cover,
    //                           ),
    //                         );
    //                       } else {
    //                         return const CircularProgressIndicator();
    //                       }
    //                     },
    //                   ),
    //                   const SizedBox(
    //                     width: 14,
    //                   ),
    //                   Expanded(
    //                     child: Column(
    //                       children: [
    //                         Container(
    //                             padding:
    //                                 const EdgeInsets.only(left: 8, bottom: 8),
    //                             width: size.width,
    //                             child: Text(
    //                               ticket[index].name,
    //                               style: AppTextStyles.heading20,
    //                             )),
    //                         Container(
    //                           padding:
    //                               const EdgeInsets.only(left: 8, bottom: 8),
    //                           width: size.width,
    //                           child: Text(
    //                               'Thời lượng: ${ticket[index].duration} phút',
    //                               style: AppTextStyles.normal16
    //                                   .copyWith(color: AppColors.grey)),
    //                         ),
    //                         Container(
    //                             alignment: Alignment.centerLeft,
    //                             margin:
    //                                 const EdgeInsets.only(left: 8, bottom: 8),
    //                             child: Text(
    //                               '13:00, Sun April 23',
    //                               style: AppTextStyles.heading18
    //                                   .copyWith(color: AppColors.grey),
    //                             )),
    //                         Container(
    //                           padding:
    //                               const EdgeInsets.only(left: 8, bottom: 8),
    //                           width: size.width,
    //                           child: Text(
    //                             'Rạp: Lotteria',
    //                             style: AppTextStyles.heading18
    //                                 .copyWith(color: AppColors.green),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       );
    //     } else {
    //       return const SizedBox(height: 0, width: 0);
    //     }
    //   },
    // ),
  }
}
