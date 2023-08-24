import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_app/feature/news/bloc/news_bloc.dart';
import 'package:campus_app/feature/news/model/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../core.dart';

class ContentInformation extends StatefulWidget {
  const ContentInformation({super.key, required this.informationModel});
  final InformationModel informationModel;

  @override
  State<ContentInformation> createState() => _ContentNewsState();
}

class _ContentNewsState extends State<ContentInformation> {
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 14, right: 18),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is InformationLoading) {
              return const EcoLoading();
            } else if (state is NewsSuccess) {
              return ListView(
                controller: _scrollController,
                children: [
                  16.0.height,
                  Text(
                    widget.informationModel.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: AppFontWeight.semibold,
                      color: AppColors.black,
                    ),
                  ),
                  8.0.height,
                  Text(
                    'by ecoInfo  |  ${DateFormat.yMMMMd().format(DateTime.parse(widget.informationModel.createdAt))}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: AppFontWeight.regular,
                      color: AppColors.grey500,
                    ),
                  ),
                  16.0.height,
                  CachedNetworkImage(
                    imageUrl: widget.informationModel.imageUrl,
                    errorWidget: (context, url, error) => const ImageIcon(
                      AppIcons.warning,
                      color: AppColors.blue500,
                      size: 50,
                    ),
                  ),
                  16.0.height,
                  Html(
                    data: widget.informationModel.content,
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
