// import 'dart:ffi';

// import 'package:final_project/config/themes/app_colors.dart';
// import 'dart:ffi';

import 'package:final_project/models/models.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerBar extends StatefulWidget {
  const TrailerBar({
    super.key,
    required this.size,
    required this.movie,
  });
  final Size size;
  final Movie movie;

  @override
  State<TrailerBar> createState() => _TrailerBarState();
}

class _TrailerBarState extends State<TrailerBar> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    String url = widget.movie.trailer;
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags:
            const YoutubePlayerFlags(autoPlay: false, loop: true, mute: false));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) {
          return Padding(
            padding: const EdgeInsets.only(),
            child: SizedBox(
              height: widget.size.height / 5,
              child: player,
            ),
          );
        },
      ),
    );
  }
}
