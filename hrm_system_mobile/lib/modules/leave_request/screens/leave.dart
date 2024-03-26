import 'package:flutter/material.dart';
import 'package:human_resource_management_system/core/consts/color_const.dart';
import 'package:human_resource_management_system/modules/leave_request/screens/listview_expand.dart';
import 'package:human_resource_management_system/my_home.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';
import 'package:flutter_tabbar_page/flutter_tabbar_page.dart';
import 'leav_request.dart';

class Leave extends StatefulWidget {
  const Leave({Key? key}) : super(key: key);

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  final List<String> items = List.generate(20, (index) => 'Item $index');

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
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const MyHome();
              }));
            },
            icon: const Icon(Icons.arrow_back, color: white),
          ),
          title: const Text(
            'Leave',
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
                builder: (context) => const LeaveRequest(),
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
