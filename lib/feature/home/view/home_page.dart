import 'package:campus_app/feature/auth/view/login_page.dart';
import 'package:campus_app/feature/events/view/event_page.dart';
import 'package:campus_app/feature/home/Bloc/home_bloc.dart';
import 'package:campus_app/feature/home/view/dashboard.dart';
import 'package:campus_app/feature/news/view/pages/feed_news_page.dart';
import 'package:campus_app/feature/profile/view/profile_page.dart';
import 'package:campus_app/feature/topicDiscus/view/discus_page.dart';
import 'package:flutter/material.dart';
import 'package:campus_app/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.token == '') {
          Future.delayed(Duration.zero, () {
            context.pushAndRemoveUntil(const LoginPage(), (route) => false);
          });
        }
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: const [
              DashboardPage(),
              InformationPage(),
              EventPage(),
              DiscussionListPage(),
              UserProfilePage()
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.primary50,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                _BottomNavCustom(
                  index: 0,
                  label: "Beranda",
                  icon: AppIcons.beranda,
                  state: state.index,
                ),
                _BottomNavCustom(
                  index: 1,
                  label: "News",
                  icon: AppIcons.ecoInfo,
                  state: state.index,
                ),
                _BottomNavCustom(
                  index: 2,
                  label: "Event",
                  icon: AppIcons.pesanan,
                  state: state.index,
                ),
                _BottomNavCustom(
                  index: 3,
                  label: "Topic Diskusi",
                  icon: AppIcons.solidBookmark,
                  state: state.index,
                ),
                _BottomNavCustom(
                  index: 4,
                  label: "Profil",
                  icon: AppIcons.username,
                  state: state.index,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BottomNavCustom extends StatelessWidget {
  final int index;
  final String label;
  final AssetImage icon;
  final int state;

  const _BottomNavCustom({
    required this.index,
    required this.label,
    required this.icon,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const UpdateSharedPreferences());
    return InkWell(
      onTap: () => context.read<HomeBloc>().add(OnBottomNavTap(index)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: state == index ? AppColors.blue300 : Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.primary),
                ),
              ),
              child: ImageIcon(
                icon,
                color: state == index ? AppColors.grey700 : AppColors.grey600,
              ),
            ),
            4.0.height,
            Text(
              label,
              style: TextStyle(
                fontSize: state == index ? 14.0 : 12.0,
                color: state == index ? AppColors.black : AppColors.grey700,
                fontWeight: state == index
                    ? AppFontWeight.semibold
                    : AppFontWeight.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
