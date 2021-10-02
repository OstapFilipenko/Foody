class ProductFirestore {
  int _barcode;
  double _calories;
  double _carbohydrates;
  String _description;
  double _fats;
  String _name;
  double _protein;
  double _sugar;

  ProductFirestore(int barcode, String name, double calories, double carbohydrates, String description, double fats,
      double protein, double sugar) {
    this._barcode = barcode;
    this._name = name;
    this._calories = calories;
    this._carbohydrates = carbohydrates;
    this._description = description;
    this._fats = fats;
    this._protein = protein;
    this._sugar = sugar;
  }

  int get barcode => _barcode;

  double get calories => _calories;

  double get carbohydrates => _carbohydrates;

  String get descrition => _description;

  String get name => _name;

  double get fats => _fats;

  double get protein => _protein;

  double get sugar => _sugar;

  @override
  String toString() {
    return super.toString();
  }
}
