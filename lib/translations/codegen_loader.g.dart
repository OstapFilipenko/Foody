// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> de = {
  "titleHome": "Aktivitäten",
  "name": "Name",
  "calories": "Kalorien",
  "carbohydrates": "Kohlenhydrate",
  "sugar": "Zucker",
  "kcal": "Kcal",
  "fats": "Fette",
  "carb": "Kohl.",
  "protein": "Proteine",
  "nd": "Keine Daten",
  "titleSettings": "Einstellungen",
  "amountKcal": "Menge @:kcal / Tag",
  "amountFats": "Menge @:fats / Tag",
  "amountCarb": "Menge @:carb / Tag",
  "amountProtein": "Menge @:protein / Tag",
  "amountSugar": "Menge @:sugar / Tag",
  "save": "Speichern",
  "required": "Dies ist ein Pflichtfeld",
  "titleDetails": "Nährwertangaben pro 100g",
  "titleScan": "Produkt einscannen",
  "barcodeNumber": "Barcode",
  "enterAmount": "Menge eingeben (in g)",
  "add": "Hinzufügen",
  "language": "Sprache",
  "at": "um",
  "popUpTitle": "Produkt nicht gefunden",
  "popUpText": "Möchtest du es zur Datenbank hinzufügen?",
  "popUpAnswerYes": "Ja",
  "popUpAnswerNo": "Nein",
  "search": "Suchen",
  "emptyBarcodeField": "Bitte geben Sie einen Barcode ein!",
  "shortBarcodeField": "Geben Sie mindestens 2 Zeichen ein!",
  "onlyNumbers": "Bitte nur Zahlen eingeben"
};
static const Map<String,dynamic> en = {
  "titleHome": "Activity",
  "name": "Name",
  "calories": "Calories",
  "carbohydrates": "Carbohydrates",
  "sugar": "Sugar",
  "kcal": "Kcal",
  "fats": "Fats",
  "carb": "Carb.",
  "protein": "Protein",
  "nd": "No Data",
  "titleSettings": "Settings",
  "amountKcal": "Amount kcal / day",
  "amountFats": "Amount fats / day",
  "amountCarb": "Amount carb. / day",
  "amountProtein": "Amount protein / day",
  "amountSugar": "Amount sugar / day",
  "save": "Save",
  "required": "This field is required",
  "titleDetails": "Nutritional information per 100g",
  "titleScan": "Scan the product",
  "barcodeNumber": "Barcode",
  "enterAmount": "Enter amount (in g)",
  "add": "Add",
  "language": "Language",
  "at": "at",
  "popUpTitle": "Product not found",
  "popUpText": "Do you want to add it to the database?",
  "popUpAnswerYes": "Yes",
  "popUpAnswerNo": "No",
  "search": "Search",
  "emptyBarcodeField": "Please enter a barcode number!",
  "shortBarcodeField": "Requires at least 2 characters!",
  "onlyNumbers": "Only numbers allowed"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en};
}
