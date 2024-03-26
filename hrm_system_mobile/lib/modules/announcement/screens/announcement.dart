import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:human_resource_management_system/core/enums/enums.dart';
import 'package:human_resource_management_system/modules/announcement/stores/announcement_store.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:human_resource_management_system/utils/widgets/loading.dart';
import 'package:human_resource_management_system/utils/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        await context.read<AnnouncementStore>().getAnnouncement();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AnnouncementStore store = context.watch<AnnouncementStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          'Announcement',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
      ),
      body: _buildLoadingStatus(store),
    );
  }
}

Widget _buildLoadingStatus(AnnouncementStore store) {
  return Observer(
    builder: (context) {
      LoadingStatus status = context.watch<AnnouncementStore>().status;
      switch (status) {
        case LoadingStatus.none:
        case LoadingStatus.loading:
          return const LoadingScreen();
        case LoadingStatus.error:
          return const NoDataScreen();
        case LoadingStatus.done:
          return _buildBody(context, store);
      }
    },
  );
}

Widget _buildBody(BuildContext context, AnnouncementStore store) {
  return RefreshIndicator(
    onRefresh: () async {
      await store.getAnnouncement(); 
    },
    child: ListView.builder(
      itemCount: store.announcementModel.data?.length ?? 0,
      itemBuilder: (context, index) {
        return _buildCard(store, index);
      },
    ),
  );
}

Widget _buildCard(AnnouncementStore store, int index) {
  String? attachmentPic = store.announcementModel.data![index].attachment;
  String defaultPic =
      'https://www.survivorsuk.org/wp-content/uploads/2017/01/no-image.jpg';
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: white,
        elevation: 4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              child: Image.network(
                attachmentPic ?? defaultPic,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    defaultPic,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${store.announcementModel.data![index].title}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    DateFormat('dd-MMM-yyyy').format(
                      DateTime.parse(
                          store.announcementModel.data?[index].createdAt ?? ""),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft, // Align to bottom right
                    child: ReadMoreText(
                      '${store.announcementModel.data![index].description}',
                      trimLines: 5,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Read more',
                      trimExpandedText: ' Read less',
                      colorClickableText: primaryColor,
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
