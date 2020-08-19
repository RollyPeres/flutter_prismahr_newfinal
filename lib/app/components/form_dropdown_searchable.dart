import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class FormDropdownSearchable<T> extends StatefulWidget {
  FormDropdownSearchable({
    Key key,
    this.selectedItem,
    this.errorText,
    this.hintText,
    this.searchBoxHintText,
    this.searchBoxSuffixIcon = const Icon(Icons.search),
    this.label,
    this.mode = Mode.BOTTOM_SHEET,
    @required this.onChanged,
    @required this.filterFn,
    @required this.onFind,
    this.dropdownBuilder,
    this.popupItemBuilder,
    this.itemAsString,
    this.showSearchBox = true,
    this.maxHeight,
  }) : super(key: key);

  final T selectedItem;

  final String label;

  final String errorText;

  final String hintText;

  final String searchBoxHintText;

  final Widget searchBoxSuffixIcon;

  final Mode mode;

  final ValueChanged<T> onChanged;

  final bool Function(T, String) filterFn;

  final Future<List<T>> Function(String) onFind;

  final Widget Function(BuildContext, T, String) dropdownBuilder;

  final Widget Function(BuildContext, T, bool) popupItemBuilder;

  final String Function(T) itemAsString;

  final bool showSearchBox;

  final double maxHeight;

  @override
  _ForSearchablemDropdownState<T> createState() =>
      _ForSearchablemDropdownState();
}

class _ForSearchablemDropdownState<T> extends State<FormDropdownSearchable<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(),
          DropdownSearch<T>(
            mode: widget.mode,
            showSearchBox: widget.showSearchBox,
            maxHeight:
                widget.maxHeight ?? MediaQuery.of(context).size.height * 0.5,
            popupBackgroundColor: Theme.of(context).cardColor,
            popupTitle: SizedBox(height: 10),
            searchBoxDecoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              hintText: widget.searchBoxHintText,
              prefixIcon: Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
            ),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              errorText: widget.errorText,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              hintText: widget.hintText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
            ),
            selectedItem: widget.selectedItem,
            filterFn: widget.filterFn,
            onFind: widget.onFind,
            onChanged: widget.onChanged,
            dropdownBuilder: widget.dropdownBuilder,
            popupItemBuilder: widget.popupItemBuilder,
            itemAsString: widget.itemAsString,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    if (widget.label == null) return SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Text('${widget.label}'),
    );
  }
}
