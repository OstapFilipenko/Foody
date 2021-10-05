class Statistics {
  double _kcal;
  double _fats;
  double _carb;
  double _protein;

  Statistics(double kcal, double fats, double carb, double protein) {
    this._kcal = kcal;
    this._fats = fats;
    this._carb = carb;
    this._protein = protein;
  }

  double getKcal() => this._kcal;

  setKcal(double kcal) => this._kcal = kcal;

  double getFats() => this._fats;

  setFats(double fats) => this._fats = fats;

  double getCarb() => this._carb;

  setCarb(double carb) => this._carb = carb;

  double getProtein() => this._carb;

  setProtein(double protein) => this._protein = protein; 

}