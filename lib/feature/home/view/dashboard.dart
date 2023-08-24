import 'package:campus_app/core.dart';
import 'package:campus_app/feature/events/bloc/event_bloc.dart';
import 'package:campus_app/feature/home/view/widgets/header.dart';
import 'package:campus_app/feature/news/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/curasol.dart';
import 'widgets/curasol_news.dart'; // Gantikan dengan jalur yang sesuai

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<NewsBloc>().add(const GetNewsEvent(search: '', page: 1));
    super.initState();
  }

  Future<void> _refreshData() async {
    context.read<NewsBloc>().add(const GetNewsEvent(search: '', page: 1));
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderWidget(),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HOT NEWS!",
                      style: TextStyle(
                        fontSize: AppSizes.primary,
                        fontWeight: AppFontWeight.extrabold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "Inilah Berita Terupdate Pekan ini. yuk baca! ",
                      style: TextStyle(
                          color: AppColors.grey500, fontSize: AppSizes.primary),
                    ),
                  ],
                ),
              ),
              const InformationCarousel(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event!",
                      style: TextStyle(
                        fontSize: AppSizes.primary,
                        fontWeight: AppFontWeight.extrabold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "Inilah Event-Event Menarik Yang Akan Datang",
                      style: TextStyle(
                          color: AppColors.grey500, fontSize: AppSizes.primary),
                    ),
                  ],
                ),
              ),
              BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventSuccess) {
                  return CarouselGambar(imageList: [state.data[0].imageurl!,state.data[1].imageurl! ,state.data[2].imageurl!]);
                } else if (state is EventLoading) {
                 
                } else if (state is EventError) {
                 
                }
                return Container();
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
