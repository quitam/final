import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

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
                itemCount: ticket.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder(
                          future: getImageUrl(ticket[index].posterUrl),
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
                                  padding:
                                      const EdgeInsets.only(left: 8, bottom: 8),
                                  width: size.width,
                                  child: Text(
                                    ticket[index].name,
                                    style: AppTextStyles.heading20,
                                  )),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                width: size.width,
                                child: Text(
                                    'Thời lượng: ${ticket[index].duration} phút',
                                    style: AppTextStyles.normal16
                                        .copyWith(color: AppColors.grey)),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin:
                                      const EdgeInsets.only(left: 8, bottom: 8),
                                  child: Text(
                                    '13:00, Sun April 23',
                                    style: AppTextStyles.heading18
                                        .copyWith(color: AppColors.grey),
                                  )),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                width: size.width,
                                child: Text(
                                  'Rạp: Lotteria',
                                  style: AppTextStyles.heading18
                                      .copyWith(color: AppColors.green),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const SizedBox(height: 0, width: 0);
          }
        },
      ),
    );
  }
}
