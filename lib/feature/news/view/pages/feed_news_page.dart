import 'package:campus_app/core.dart';
import 'package:campus_app/feature/news/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/list_news_widget.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  String _searchQuery = '';
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
    return RefreshIndicator(
        onRefresh: _refreshData,
        child:Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'HOT',
              style: TextStyle(
                fontSize: 28,
                fontWeight: AppFontWeight.semibold,
                color: AppColors.error500,
              ),
            ),
            Text(
              'News',
              style: TextStyle(
                fontSize: 28,
                fontWeight: AppFontWeight.semibold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                context.read<NewsBloc>().add(
                      GetNewsEvent(search: _searchQuery, page: 1),
                    );
              },
              decoration: const InputDecoration(
                hintText: 'Search news...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          30.0.height,
          BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is InformationLoading) {
                return const EcoLoading();
              } else if (state is NewsSuccess) {
                return Expanded(
                    child: state.data.isNotEmpty
                        ? ListView.separated(
                            itemCount: state.data.length + 1,
                            itemBuilder: (context, index) {
                              if (index == state.data.length) {
                                if (state.hasMorePages) {
                                  return TextButton(
                                    onPressed: () {
                                      context.read<NewsBloc>().add(
                                          GetMoreNewsEvent(
                                              search: _searchQuery,
                                              page: state.currentPage + 1));
                                    },
                                    child: const Text(
                                      'Read More',
                                      style: TextStyle(
                                        color: AppColors.blue500,
                                        fontSize: 20,
                                        fontWeight: AppFontWeight.semibold,
                                      ),
                                    ),
                                  );
                                }
                                return 10.0.height;
                              } else {
                                return ListInformation(
                                  key: UniqueKey(),
                                  informationModel: state.data[index],
                                );
                              }
                            },
                            separatorBuilder: (context, index) => const Divider(
                              height: 16,
                            ),
                          )
                        : const EcoEmpty(
                            massage: 'Berita Yang anda Cari Tidak Ada',
                            image: AppImages.emptyKeranjang,
                            height: 200));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          16.0.height,
        ],
      ),
    ));
  }
}
