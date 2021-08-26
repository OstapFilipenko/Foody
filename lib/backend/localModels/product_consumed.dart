class ProductConsumed{
  final String productID;
  final String eatenAt;
  int gramm;
  
  ProductConsumed(
    this.productID,
    this.eatenAt,
    this.gramm
  );

  String getProductID(){
    return this.productID;
  }

  String getEatenAt(){
    return this.eatenAt;
  }

  int getGramm(){
    return this.gramm;
  }

  void setGramm(int gr){
    this.gramm = gr;
  }

  Map<String, dynamic> toMap(){
    return {
      'productID': productID,
      'eatenAt': eatenAt,
      'gramm': gramm,
    };
  }

  @override
    String toString() {
      return super.toString();
    }

}