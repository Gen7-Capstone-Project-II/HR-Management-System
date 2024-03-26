import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/consts/color_const.dart';
import 'package:human_resource_management_system/modules/mission/screen/listview_mission.dart';
import 'package:human_resource_management_system/modules/mission/screen/mission_request.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:flutter_tabbar_page/flutter_tabbar_page.dart';

class Mission extends StatefulWidget {
  const Mission({Key? key}) : super(key: key);

  @override
  State<Mission> createState() => _MissionState();
}

class _MissionState extends State<Mission> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    if (mounted) {
      setState(() {
        lstPages.add(PageTabItemModel(
            title: "All", page: const ListviewExapnadable(approve: '')));
        lstPages.add(PageTabItemModel(
            title: "Pending", page: const ListviewExapnadable(approve: null)));
        lstPages.add(PageTabItemModel(
            title: "Approved", page: const ListviewExapnadable(approve: 1)));
        lstPages.add(PageTabItemModel(
            title: "Rejected", page: const ListviewExapnadable(approve: 0)));
      });
    }
  }

  List<PageTabItemModel> lstPages = <PageTabItemModel>[];
  final TabPageController _controller = TabPageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: const IconThemeData(color: white),
          title: const Text(
            'Mission',
            style: TextStyle(color: white),
          ),
          backgroundColor: primaryColor,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButton: FloatingActionButton(
           shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MissionRequest(),
              ),
            );
          },
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
        body: _buildSideBar());
  }

  Widget _buildSideBar() {
    return TabBarPage(
        controller: _controller,
        pages: lstPages,
        isSwipable: true,
        tabBackgroundColor: primaryColor,
        tabitemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _controller.onTabTap(index);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width / lstPages.length,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: Text(
                      lstPages[index].title ?? "",
                      style: TextStyle(
                        fontWeight: _controller.currentIndex == index
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: _controller.currentIndex == index
                            ? white
                            : ColorConst.GREY_300,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _controller.currentIndex == index
                          ? white
                          : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
