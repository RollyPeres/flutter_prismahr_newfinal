import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

typedef OnSearchChanged<T> = FutureOr<Iterable<T>> Function(String pattern);
typedef SuggestionsBuilder<T> = Widget Function(BuildContext context, T data);
typedef ChipSelected<T> = void Function(T data);
typedef ChipsBuilder<T> = Widget Function(
    BuildContext context, FormChipsInputState<T> state, T data);

class FormChipsInput<T> extends StatefulWidget {
  final String label;
  final int maxChips;
  final Duration debounceDuration;
  final TextEditingController controller;
  final String hintText;
  final String helperText;
  final Widget prefixIcon;
  final double wrapSpacing;
  final double runSpacing;
  final SuggestionsBuilder<T> suggestionsBuilder;
  final ChipSelected<T> onSuggestionSelected;
  final ChipsBuilder<T> chipBuilder;
  final OnSearchChanged onSearchChanged;

  FormChipsInput({
    Key key,
    this.label,
    this.maxChips = 10,
    this.controller,
    this.hintText,
    this.helperText,
    this.prefixIcon,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.wrapSpacing,
    this.runSpacing,
    @required this.suggestionsBuilder,
    @required this.onSuggestionSelected,
    @required this.onSearchChanged,
    @required this.chipBuilder,
  }) : super(key: key);

  @override
  FormChipsInputState<T> createState() => FormChipsInputState<T>();
}

class FormChipsInputState<T> extends State<FormChipsInput<T>> {
  bool get _hasReachedMaxChips => _chips.length >= widget.maxChips;

  List<dynamic> _chips;

  @override
  void initState() {
    super.initState();
    _chips = List<dynamic>();
  }

  void _onSuggestionSelected(dynamic item) {
    if (!_hasReachedMaxChips) _chips.add(item);
    widget.controller?.clear();

    widget.onSuggestionSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> chipsChildren = _chips
        .map<Widget>((chip) => widget.chipBuilder(context, this, chip))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelAndLimitCounter(),
        _hasReachedMaxChips ? _buildMaxChipsNotifier() : _buildTypeAheadField(),
        _chips.isNotEmpty ? _buildChipsDisplay(chipsChildren) : SizedBox(),
      ],
    );
  }

  Widget _buildLabelAndLimitCounter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${widget.label}'),
          Text('${_chips.length} of ${widget.maxChips}'),
        ],
      ),
    );
  }

  Widget _buildMaxChipsNotifier() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Text(
        'Remove at least one of them to show the search input again.',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _buildTypeAheadField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TypeAheadFormField<T>(
        itemBuilder: widget.suggestionsBuilder,
        debounceDuration: widget.debounceDuration,
        textFieldConfiguration: TextFieldConfiguration(
          controller: widget.controller,
          enabled: !_hasReachedMaxChips,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: widget.hintText,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onSuggestionSelected: _onSuggestionSelected,
        suggestionsCallback: widget.onSearchChanged,
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          elevation: 4.0,
          constraints: BoxConstraints(maxHeight: 300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildChipsDisplay(List<Widget> chipsChildren) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Wrap(
        spacing: widget.wrapSpacing ?? 4.0,
        runSpacing: widget.runSpacing ?? 4.0,
        children: chipsChildren,
      ),
    );
  }
}
