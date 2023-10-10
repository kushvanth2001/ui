import 'package:flutter/material.dart';

/// Its is an statefull widget
class WindowStyleDropdownMenu extends StatefulWidget {
  String buttonTitle;

  TextStyle? buttonTitleStyle;

  double? dropdownWidth;
  Widget titleWidget;

  Color? dropdownBackgroundColor;

  /// Dropdown items to be shown in the menu
  ///
  /// expects list of [ListTile] class
  List<ListTile> dropdownItems;

  WindowStyleDropdownMenu(
      {Key? key,
      required this.buttonTitle,
      required this.dropdownItems,
      required this.titleWidget,
      this.buttonTitleStyle,
      this.dropdownWidth,
      this.dropdownBackgroundColor})
      : super(key: key);

  @override
  State<WindowStyleDropdownMenu> createState() =>
      _WindowStyleDropdownMenuState();
}

class _WindowStyleDropdownMenuState extends State<WindowStyleDropdownMenu> {
  OverlayEntry? _overlayEntry;
  FocusNode textFocusNode = FocusNode();
  bool showOverlay = false;
  bool isdropeddown = false;

  @override
  void initState() {
    super.initState();
    textFocusNode.addListener(() {
      if (textFocusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry!);
        // _showOverlay(context, 0);
        setState(() {
          isdropeddown = true;
        });
      } else {
        setState(() {
          isdropeddown = false;
        });
        removeOverlay();
      }
    });
  }

  void removeOverlay() {
    _overlayEntry!.remove();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        focusNode: textFocusNode,
        onHover: (val) {
          if (val) {
            textFocusNode.requestFocus();
            showOverlay = true;
          }
        },
        onPressed: () {
          setState(() {
            showOverlay = !showOverlay;
          });
        },
        child: Row(
          children: [
            widget.titleWidget,
            AnimatedContainer(
                duration: Duration(seconds: 3),
                child: new RotationTransition(
                  turns: isdropeddown
                      ? AlwaysStoppedAnimation(90 / 360)
                      : new AlwaysStoppedAnimation(270 / 360),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                  ),
                ))
          ],
        ));
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        maintainState: true,
        builder: (context) => Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: widget.dropdownWidth ?? 200,
              child: TextButton(
                onPressed: () {},
                onHover: (val) {
                  if (val && showOverlay) {
                    textFocusNode.requestFocus();
                  } else {
                    textFocusNode.unfocus();
                  }
                },
                child: Material(
                  color: Colors.green.shade100,
                  elevation: 4.0,
                  child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: widget.dropdownItems),
                ),
              ),
            ));
  }
}
