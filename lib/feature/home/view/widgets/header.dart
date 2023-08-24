import 'package:campus_app/core.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 155,
          decoration: const BoxDecoration(
            color: AppColors.blue500,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(AppImages.logo),
                  height: 100,
                ),
                10.0.width,
                const Column(
                  children: [
                    Text(
                      "Welcome to Institut",
                      style: TextStyle(
                        fontSize: AppSizes.secondary,
                        fontWeight: AppFontWeight.extrabold,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      "Teknologi Bandung",
                      style: TextStyle(
                        fontSize: AppSizes.secondary,
                        fontWeight: AppFontWeight.extrabold,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.primary),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
