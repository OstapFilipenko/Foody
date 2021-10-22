import 'dart:io';

import 'package:foody/backend/localDatabase.dart';
import 'package:foody/backend/localModels/product_consumed.dart';

final db = LocalDatabase();

Future<String> getFileContent(File file) async {
  return await file.readAsString();
}

Future<void> importFromFile(File file) async {
  String content = await getFileContent(file);
  List<String> settingsLines = [];
  List<String> productLines = [];
  content.split("\n").forEach((line) {
    if (line.startsWith("Personal")) {
      settingsLines.add(line);
    } else if(line.startsWith("Product")) {
      productLines.add(line);
    }else {
      //do nothing
    }
  });
  importSettings(settingsLines);
  importProducts(productLines);
}

void importSettings(List<String> settings) {
  settings.forEach((setting) async {
    if (setting.startsWith("PersonalKcal")) {
      await db.updateKcal(double.parse(setting.split(":")[1]));
    } else if (setting.startsWith("PersonalFats")) {
      await db.updateFats(double.parse(setting.split(":")[1]));
    } else if (setting.startsWith("PersonalCarbohydrates")) {
      await db.updateCarbohydrates(double.parse(setting.split(":")[1]));
    } else if (setting.startsWith("PersonalProtein")) {
      await db.updateProtein(double.parse(setting.split(":")[1]));
    } else if (setting.startsWith("PersonalSugar")) {
      await db.updateSugar(double.parse(setting.split(":")[1]));
    } else if (setting.startsWith("PersonalLanguage")) {
      await db.updateLanguage(double.parse(setting.split(":")[1]));
    } else {
      //do nothing
    }
  });
}

void importProducts(List<String> products) async{
  await db.deleteAllConsumedProducts();  
  products.forEach((product) async {
    List<String> args = product.replaceAll("Product:", "").split("#");
    ProductConsumed pr = ProductConsumed(productID: args[0], eatenAt: args[1], gramm: int.parse(args[2]));
    await db.insertConsumedProduct(pr.toMap());
  });
}
