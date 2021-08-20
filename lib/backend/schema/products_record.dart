import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'products_record.g.dart';

abstract class ProductsRecord
    implements Built<ProductsRecord, ProductsRecordBuilder> {
  static Serializer<ProductsRecord> get serializer =>
      _$productsRecordSerializer;

  @nullable
  int get barcode;

  @nullable
  double get calories;

  @nullable
  double get carbohydrates;

  @nullable
  String get description;

  @nullable
  double get fats;

  @nullable
  String get name;

  @nullable
  double get protein;

  @nullable
  double get sugar;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ProductsRecordBuilder builder) => builder
    ..barcode = 0
    ..calories = 0.0
    ..carbohydrates = 0.0
    ..description = ''
    ..fats = 0.0
    ..name = ''
    ..protein = 0.0
    ..sugar = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('products');

  static Stream<ProductsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ProductsRecord._();
  factory ProductsRecord([void Function(ProductsRecordBuilder) updates]) =
      _$ProductsRecord;

  static ProductsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createProductsRecordData({
  int barcode,
  double calories,
  double carbohydrates,
  String description,
  double fats,
  String name,
  double protein,
  double sugar,
}) =>
    serializers.toFirestore(
        ProductsRecord.serializer,
        ProductsRecord((p) => p
          ..barcode = barcode
          ..calories = calories
          ..carbohydrates = carbohydrates
          ..description = description
          ..fats = fats
          ..name = name
          ..protein = protein
          ..sugar = sugar));
