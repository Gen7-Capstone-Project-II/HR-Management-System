
import 'package:flutter/material.dart';
import 'package:card_stack_widget/card_stack_widget.dart';

class TestScreen extends StatefulWidget {
  static const routeName = '/test'; 
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ Colors.orange, Colors.orange[100]! ]
        ),
      ),
      child: CardStackWidget.builder(
        opacityChangeOnDrag: true,
        reverseOrder: true,
        positionFactor: 1.5,
        scaleFactor: 1,
        count: 3,
        builder: (index) {
          return _page(index);
        }
      ),
    );
  }

  CardModel _page(int index) {
    return CardModel(
      backgroundColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2),
      shadowBlurRadius: 10,
      radius: const Radius.circular(2),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
          child: _buildPage(index),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    Widget _page = const SizedBox.shrink();
    switch (++index) {
      case 1:
        _page = _page1();
        break;
      case 2:
        _page = _page2();
        break;
      case 3:
        _page = _page3();
        break;
    }
    return _page;
  } 

  Widget _page1() {
    return Column(
      children: [
        _menu(),
        const Text('page 1')
      ],
    );
  }

  Widget _page2() {
    return Column(
      children: [
        _menu(),
        const Text('page 2')
      ],
    );
  }

  Widget _page3() {
    return Column(
      children: [
        _menu(),
        const Text('page 3')
      ],
    );
  }

  Widget _menu() {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)
            ),
            const SizedBox(width: 5),
            const Text('MENU')
          ],
        ),
      ],
    );
  }

}