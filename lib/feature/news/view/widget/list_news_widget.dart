import 'package:campus_app/feature/news/model/news.dart';
import 'package:campus_app/feature/news/view/pages/detail_news_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core.dart';

class ListInformation extends StatelessWidget {
  const ListInformation({super.key, required this.informationModel});
  final InformationModel informationModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(ContentInformation(
          informationModel: informationModel,
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 357,
        height: 148,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: informationModel.imageUrl,
              width: 127,
              height: 148,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const ImageIcon(
                AppIcons.warning,
                color: AppColors.blue500,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.parse(
                    informationModel.createdAt,
                  )),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: AppFontWeight.regular,
                    color: AppColors.grey500,
                  ),
                ),
                16.0.height,
                Container(
                  alignment: Alignment.centerLeft,
                  width: context.fullWidth - 160.0,
                  child: Text(
                    informationModel.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: AppFontWeight.semibold,
                      color: AppColors.grey700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
