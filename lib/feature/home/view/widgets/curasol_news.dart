import 'package:campus_app/core.dart';
import 'package:campus_app/core/widgets/curasol.dart';
import 'package:campus_app/feature/news/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InformationCarousel extends StatefulWidget {
  const InformationCarousel({super.key});

  @override
  State<InformationCarousel> createState() => _InformationCarouselState();
}

class _InformationCarouselState extends State<InformationCarousel> {
  final CarouselController _controllerinfo = CarouselController();
  int _currentinfo = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is InformationLoading) {
              return const EcoLoading();
            } else if (state is NewsSuccess) {
              final informationList = state.data.take(3).toList();
              return Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: informationList.length,
                    itemBuilder: (context, index, realIndex) {
                      return CarouselCardInformation(
                        informationModel: informationList[index],
                      );
                    },
                    carouselController: _controllerinfo,
                    options: CarouselOptions(
                      height: 150,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      disableCenter: true,
                      viewportFraction: 0.94,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentinfo = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: AppSizes.primary),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: informationList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controllerinfo.animateToPage(entry.key),
                        child: Container(
                          width: 12.0,
                          height: 12.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentinfo == entry.key
                                ? AppColors.blue500
                                : const Color(0xffD9D9D9),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
