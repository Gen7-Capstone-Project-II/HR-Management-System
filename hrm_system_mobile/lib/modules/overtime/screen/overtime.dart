import 'package:flutter/material.dart';
import 'package:flutter_tabbar_page/flutter_tabbar_page.dart';
import 'package:human_resource_management_system/core/consts/color_const.dart';
import 'package:human_resource_management_system/modules/overtime/screen/filter_overtime_screen.dart';
import 'package:human_resource_management_system/modules/overtime/screen/overtime_request.dart';
import 'package:human_resource_management_system/utils/style/colors.dart';

class Overtime extends StatefulWidget {
  const Overtime({super.key});

  @override
  State<Overtime> createState() => _OvertimeState();
}

class _OvertimeState extends State<Overtime> {
  List<PageTabItemModel> lstPages = <PageTabItemModel>[];
  final TabPageController _controller = TabPageController();
  @override
  void initState() {
    super.initState();

    lstPages.add(PageTabItemModel(
        title: "All", page: const FilterOvertimeScreen(approve: '')));
    lstPages.add(PageTabItemModel(
        title: "Pending", page: const FilterOvertimeScreen(approve: null)));
    lstPages.add(PageTabItemModel(
        title: "Approved", page: const FilterOvertimeScreen(approve: 1)));
    lstPages.add(PageTabItemModel(
        title: "Rejected", page: const FilterOvertimeScreen(approve: 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: white),
        title: const Text(
          "Overtime",
          style: TextStyle(color: white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OvertimeRequest(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: TabBarPage(
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
              },
            ),
          )
        ],
      ),
    );
  }

  Widget formatStatus(int? isApprove) {
    if (isApprove == null) {
      return const Text(
        'Pending',
        style: TextStyle(color: Colors.orange),
      );
    } else if (isApprove == 1) {
      return const Text(
        'Approved',
        style: TextStyle(color: Colors.white),
      );
    } else {
      return const Text(
        'Rejected',
        style: TextStyle(color: Colors.red),
      );
    }
  }
}
