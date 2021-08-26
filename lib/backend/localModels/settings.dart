class Settings{
  double kcal;
  double fats;
  double carbohydrates;
  double protein;
  double sugar;
  double weightStarted;

  Settings(
    this.kcal,
    this.fats,
    this.carbohydrates,
    this.protein,
    this.sugar,
    this.weightStarted
  );

  double getKcal(){
    return this.kcal;
  }
  void setKcal(double kc){
    this.kcal = kc;
  }

  double getFats(){
    return this.fats;
  }
  void setFats(double fa){
    this.fats = fa;
  }

  double getCarbohydrates(){
    return this.carbohydrates;
  }
  void setCarbohydrates(double ca){
    this.carbohydrates = ca;
  }

  double getProtein(){
    return this.protein;
  }
  void setProtein(double pr){
    this.protein = pr;
  }

  double getSugar(){
    return this.sugar;
  }
  void setSugar(double su){
    this.sugar = su;
  }

  double getWeightStarted(){
    return this.weightStarted;
  }
  void setWeightStarted(double ws){
    this.weightStarted = ws;
  }

  Map<String, dynamic> toMap(){
    return {
      'kcal': kcal,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'protein': protein,
      'sugar': sugar,
      'weightStarted': weightStarted,
    };
  }

  @override
  String toString() {
    return super.toString();
  }

}