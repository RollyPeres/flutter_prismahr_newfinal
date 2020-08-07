import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/data/models/industry_model.dart';
import 'package:flutter_prismahr/app/data/repositories/industry_repository.dart';

class FormDropdownIndustry extends StatefulWidget {
  final Industry selectedItem;
  final String errorText;
  final String hintText;
  final Widget suffixIcon;
  final String label;
  final Mode mode;
  final Function(Industry) onChanged;

  const FormDropdownIndustry({
    Key key,
    this.selectedItem,
    this.errorText,
    this.hintText,
    this.suffixIcon,
    this.label,
    this.mode,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _FormDropdownIndustryState createState() => _FormDropdownIndustryState();
}

class _FormDropdownIndustryState extends State<FormDropdownIndustry> {
  IndustryRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = IndustryRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          widget.label != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8),
                  child: Text('${widget.label}'))
              : SizedBox(),
          DropdownSearch<Industry>(
            mode: widget.mode ?? Mode.BOTTOM_SHEET,
            showSearchBox: true,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            popupBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              hintText: 'Find Industry',
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
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
            ),
            selectedItem: widget.selectedItem,
            filterFn: (Industry industry, String value) {
              if (value.isEmpty) return true;
              return industry.name.toLowerCase().contains(value.toLowerCase());
            },
            onFind: (String industry) async {
              return await _repository.find(industry);
            },
            onChanged: widget.onChanged,
            dropdownBuilder: _customDropdownBuilder,
            popupItemBuilder: _customPopupItemBuilder,
          ),
        ],
      ),
    );
  }

  Widget _customDropdownBuilder(
    BuildContext context,
    Industry item,
    String itemDesignation,
  ) {
    return Container(
      child: (item?.name == null)
          ? SizedBox()
          : Text(item.name, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _customPopupItemBuilder(
    BuildContext context,
    Industry industry,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(selected: isSelected, title: Text(industry.name)),
    );
  }
}
