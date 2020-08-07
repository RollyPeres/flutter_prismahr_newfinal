class Currency {
  int id;
  String name;
  String namePlural;
  String symbol;
  String symbolNative;
  int decimalDigits;
  int rounding;
  String code;

  Currency({
    id,
    name,
    namePlural,
    symbol,
    symbolNative,
    decimalDigits,
    rounding,
    code,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.namePlural = json['name_plural'];
    this.symbol = json['symbol'];
    this.symbolNative = json['symbol_native'];
    this.decimalDigits = json['decimal_digits'];
    this.rounding = json['rounding'];
    this.code = json['code'];
  }
}
