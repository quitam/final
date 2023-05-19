import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 56),
            height: size.height * 0.2 - 27,
            width: size.width,
            decoration: const BoxDecoration(
                color: AppColors.blueMain,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(36))),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Lập trình di động nâng cao',
                  style: AppTextStyles.heading28.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightBlue)),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'GVHD: Nguyễn Thủy An',
                  style: AppTextStyles.heading20,
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
