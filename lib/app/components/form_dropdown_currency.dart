import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/data/models/currency_model.dart';
import 'package:flutter_prismahr/app/data/repositories/currency_repository.dart';

class FormDropdownCurrency extends StatefulWidget {
  final Currency selectedItem;
  final String errorText;
  final String hintText;
  final Widget suffixIcon;
  final String label;
  final Mode mode;
  final Function(Currency) onChanged;

  const FormDropdownCurrency({
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
  _FormDropdownCurrencyState createState() => _FormDropdownCurrencyState();
}

class _FormDropdownCurrencyState extends State<FormDropdownCurrency> {
  CurrencyRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = CurrencyRepository();
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
          DropdownSearch<Currency>(
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
              hintText: 'Find currency by code or country name',
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
            filterFn: (Currency currency, String value) {
              if (value.isEmpty) return true;
              bool nameContainsValue =
                  currency.name.toLowerCase().contains(value.toLowerCase());
              bool codeContainsValue =
                  currency.code.toLowerCase().contains(value.toLowerCase());

              bool filterResult = nameContainsValue || codeContainsValue;
              return filterResult;
            },
            onFind: (String currency) async {
              return await _repository.find(currency);
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
    Currency item,
    String itemDesignation,
  ) {
    return Container(
      child: (item?.code == null)
          ? SizedBox()
          : Text(item.code, style: TextStyle(fontSize: 16)),
    );
  }

  Widget _customPopupItemBuilder(
    BuildContext context,
    Currency currency,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(selected: isSelected, title: Text(currency.code)),
    );
  }
}
