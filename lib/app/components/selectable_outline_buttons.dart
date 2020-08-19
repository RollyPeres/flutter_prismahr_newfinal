import 'package:flutter/material.dart';

class SelectableOutlineButtons<T> extends StatefulWidget {
  SelectableOutlineButtons({
    Key key,
    this.buttonHeight = 50.0,
    this.buttonWidth,
    this.buttonColor,
    this.buttonActiveColor,
    this.buttonBorderRadius,
    this.buttonBorderColor,
    this.buttonBorderWidth = 1.0,
    this.controller,
    @required this.items,
    @required this.buttonChildBuilder,
    @required this.onChanged,
  }) : super(key: key);

  final ScrollController controller;

  final List<T> items;

  final double buttonHeight;

  final double buttonWidth;

  final double buttonBorderWidth;

  final Color buttonActiveColor;

  final Color buttonBorderColor;

  final Color buttonColor;

  final BorderRadiusGeometry buttonBorderRadius;

  final Widget Function(T) buttonChildBuilder;

  final Function(T) onChanged;

  @override
  _SelectableOutlineButtonsState<T> createState() =>
      _SelectableOutlineButtonsState<T>();
}

class _SelectableOutlineButtonsState<T>
    extends State<SelectableOutlineButtons<T>> {
  ScrollController _controller;
  int _selectedButtonIndex;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        controller: widget.controller,
        itemCount: widget.items.length,
        itemBuilder: _buildSelectableButtons,
      ),
    );
  }

  Widget _buildSelectableButtons(BuildContext context, int index) {
    return _SelectableButton(
      isActive: index == _selectedButtonIndex,
      height: widget.buttonHeight,
      width: widget.buttonWidth,
      activeColor: widget.buttonActiveColor,
      borderWidth: widget.buttonBorderWidth,
      borderColor: widget.buttonBorderColor ?? Theme.of(context).canvasColor,
      borderRadius: widget.buttonBorderRadius,
      color: widget.buttonColor,
      child: Center(
        child: widget.buttonChildBuilder(widget.items[index]),
      ),
      onTap: () {
        setState(() {
          _selectedButtonIndex = index;
        });
        widget.onChanged(
          widget.items[_selectedButtonIndex],
        );
      },
    );
  }
}

class _SelectableButton extends StatelessWidget {
  const _SelectableButton({
    Key key,
    this.height,
    this.width,
    this.activeColor,
    this.borderRadius,
    this.borderColor,
    this.color,
    this.borderWidth,
    @required this.child,
    @required this.onTap,
    @required this.isActive,
  }) : super(key: key);

  final double height;
  final double width;
  final bool isActive;
  final Color activeColor;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      margin: EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: this.borderColor,
          width: this.borderWidth,
          style: this.isActive ? BorderStyle.none : BorderStyle.solid,
        ),
        borderRadius: this.borderRadius ?? BorderRadius.circular(10.0),
        color: this.isActive
            ? this.activeColor
            : this.color ?? Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: this.child,
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: this.borderRadius ?? BorderRadius.circular(10.0),
                onTap: this.onTap,
              ),
            ),
          )
        ],
      ),
    );
  }
}
