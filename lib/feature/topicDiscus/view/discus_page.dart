import 'package:campus_app/core.dart';
import 'package:campus_app/feature/topicDiscus/bloc/discus_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'discus_detail_page.dart';

class DiscussionListPage extends StatefulWidget {
  const DiscussionListPage({super.key});

  @override
  State<DiscussionListPage> createState() => _DiscussionListPageState();
}

class _DiscussionListPageState extends State<DiscussionListPage> {
  @override
  void initState() {
    context.read<DiscusBloc>().add(const GetDiscus(search: '', page: 1));
    super.initState();
  }

  String _searchQuery = '';
  Future<void> _refreshData() async {
    context.read<DiscusBloc>().add(const GetDiscus(search: '', page: 1));
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshData,
        child: Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'DISCUSSION',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: AppFontWeight.semibold,
                    color: AppColors.blue500,
                  ),
                ),
                Text(
                  'TOPICS',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                    context.read<DiscusBloc>().add(
                          GetDiscus(search: _searchQuery, page: 1),
                        );
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search news...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              BlocBuilder<DiscusBloc, DiscusState>(
                builder: (context, state) {
                  if (state is DiscusLoading) {
                    return const EcoLoading();
                  } else if (state is DiscusSuccess) {
                    return Expanded(
                        child: state.data.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.data.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == state.data.length) {
                                    if (state.hasMorePages) {
                                      return TextButton(
                                        onPressed: () {
                                          context.read<DiscusBloc>().add(
                                              GetMoreDiscus(
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
                                    } else {
                                      return 10.0.height;
                                    }
                                  } else {
                                    final topic = state.data[index];
                                    return Card(
                                      elevation: 3,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(topic.imageUrl),
                                        ),
                                        title: Text(topic.title),
                                        subtitle: Text(
                                            'by ${topic.author["full_name"]}'),
                                        trailing:
                                            const Icon(Icons.arrow_forward_ios),
                                        onTap: () {
                                          context.push(DiscussionTopicPage( topic:state.data[index],));
                                        },
                                      ),
                                    );
                                  }
                                },
                              )
                            : const Center(
                                child: EcoEmpty(
                                    massage:
                                        ' Diskusi Yang anda Cari Tidak Ada',
                                    image: AppImages.emptyKeranjang,
                                    height: 200),
                              ));
                  }
                  return 10.0.height;
                },
              )
            ],
          ),
        ));
  }
}
