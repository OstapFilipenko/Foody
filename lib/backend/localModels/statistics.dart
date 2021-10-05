class Statistics {
  double _kcal = 0;
  double _fats = 0;
  double _carb = 0;
  double _protein = 0;

  Statistics.empty();

  Statistics(this._kcal, this._fats, this._carb, this._protein);

  double getKcal() => this._kcal;

  setKcal(double kcal) => this._kcal = kcal;

  double getFats() => this._fats;

  setFats(double fats) => this._fats = fats;

  double getCarb() => this._carb;

  setCarb(double carb) => this._carb = carb;

  double getProtein() => this._protein;

  setProtein(double protein) => this._protein = protein; 

}