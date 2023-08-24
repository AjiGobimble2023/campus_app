import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_app/core.dart';
import 'package:campus_app/feature/events/bloc/event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'event_detail_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String _searchQuery = '';

  @override
  void initState() {
    context.read<EventBloc>().add(const GetEvent(search: '', page: 1));
    super.initState();
  }

  Future<void> _refreshData() async {
    context.read<EventBloc>().add(const GetEvent(search: '', page: 1));
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
                'Tranding',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: AppFontWeight.semibold,
                  color: AppColors.black,
                ),
              ),
              Text(
                'EVENTS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: AppFontWeight.semibold,
                  color: AppColors.blue500,
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
                  context
                      .read<EventBloc>()
                      .add(GetEvent(search: _searchQuery, page: 1));
                },
                decoration: const InputDecoration(
                  hintText: 'Search Event...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            BlocBuilder<EventBloc, EventState>(
              builder: (context, state) {
                if (state is EventLoading) {
                  return const EcoLoading();
                } else if (state is EventSuccess) {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: state.data.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == state.data.length) {
                          if (state.hasMorePages) {
                            return TextButton(
                              onPressed: () {
                                context.read<EventBloc>().add(GetMoreEvent(
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
                          return InkWell(
                              onTap: () {
                                context.push(
                                    EventDetailPage(event: state.data[index]));
                              },
                              child: Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 100,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    leading: state.data[index].imageurl != null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                state.data[index].imageurl!,
                                            width: 80,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                        : const SizedBox.shrink(),
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(state.data[index].title),
                                                const SizedBox(width: 8),
                                              ],
                                            ),
                                            Text(
                                              DateFormat.yMMMMd().format(
                                                DateTime.parse(
                                                    state.data[index].date),
                                              ),
                                              style: const TextStyle(
                                                  color: AppColors.grey500),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    color: AppColors.grey500),
                                                const SizedBox(width: 4),
                                                Text(
                                                  state.data[index].location!,
                                                  style: const TextStyle(
                                                      color: AppColors.grey500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
