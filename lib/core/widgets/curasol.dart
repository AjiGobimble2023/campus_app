import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_app/core.dart';
import 'package:campus_app/feature/news/model/news.dart';
import 'package:campus_app/feature/news/view/pages/detail_news_page.dart';

import 'package:flutter/material.dart';

class CarouselCardInformation extends StatelessWidget {
  const CarouselCardInformation({
    super.key,
    required this.informationModel,
  });
  final InformationModel informationModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(ContentInformation(
          informationModel: informationModel,
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: CachedNetworkImage(
          imageUrl: informationModel.imageUrl,
          errorWidget: (context, url, error) => const ImageIcon(
            AppIcons.warning,
            color: AppColors.blue500,
            size: 150,
          ),
          placeholder: (context, url) => const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                color: AppColors.blue500,
              ),
            ),
          ),
          imageBuilder: (context, imageProvider) => Container(
            width: 314,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.49),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 9.5,
                    top: 4,
                    right: 9.5,
                    bottom: 6,
                  ),
                  child: Text(
                    informationModel.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: AppFontWeight.semibold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
