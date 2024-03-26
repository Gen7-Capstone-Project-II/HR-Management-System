import 'package:flutter/material.dart';

class BackdropWidget extends StatefulWidget {
  /// [ backPanel ] ususally the filter content
  final Widget backPanel;

  /// [ frontPanel ] the UI
  final Widget frontPanel;

  /// [ title ] is shown on the AppBar
  final String title;

  /// [ bottomAppBar ]
  final PreferredSize bottomAppBar;

  /// [ callBack ] handle when action button is clicked after the backPanel is closed
  final Function() callBack;

  /// [ floatingActionButton ] by default is SizedBox.shrink()
  final Widget floatingActionButton;

  const BackdropWidget(
      {Key? key,
      required this.title,
      required this.callBack,
      required this.frontPanel,
      required this.backPanel,
      this.bottomAppBar = const PreferredSize(
        preferredSize: Size(0.0, 0.0),
        child: SizedBox.shrink(),
      ),
      this.floatingActionButton = const SizedBox.shrink()})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BackdropWidgetState createState() => _BackdropWidgetState();
}

class _BackdropWidgetState extends State<BackdropWidget> with SingleTickerProviderStateMixin {
  // ignore: constant_identifier_names
  static const HEADER_HEIGHT = 115.0;

  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 100), value: 1.0, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - HEADER_HEIGHT;
    const frontPanelHeight = -HEADER_HEIGHT;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          widget.backPanel,
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 12.0,
              child: widget.frontPanel,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
              if (_isPanelVisible) {
                widget.callBack();
              }
            },
          ),
        ],
        bottom: widget.bottomAppBar,
      ),
      body: LayoutBuilder(
        builder: bothPanels,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
