// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductsRecord> _$productsRecordSerializer =
    new _$ProductsRecordSerializer();

class _$ProductsRecordSerializer
    implements StructuredSerializer<ProductsRecord> {
  @override
  final Iterable<Type> types = const [ProductsRecord, _$ProductsRecord];
  @override
  final String wireName = 'ProductsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, ProductsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.barcode;
    if (value != null) {
      result
        ..add('barcode')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.calories;
    if (value != null) {
      result
        ..add('calories')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.carbohydrates;
    if (value != null) {
      result
        ..add('carbohydrates')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fats;
    if (value != null) {
      result
        ..add('fats')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.protein;
    if (value != null) {
      result
        ..add('protein')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.sugar;
    if (value != null) {
      result
        ..add('sugar')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.verified;
    if (value != null) {
      result
        ..add('verified')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  ProductsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'barcode':
          result.barcode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'calories':
          result.calories = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'carbohydrates':
          result.carbohydrates = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fats':
          result.fats = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'protein':
          result.protein = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'sugar':
          result.sugar = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'verified':
          result.verified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductsRecord extends ProductsRecord {
  @override
  final int barcode;
  @override
  final double calories;
  @override
  final double carbohydrates;
  @override
  final String description;
  @override
  final double fats;
  @override
  final String name;
  @override
  final double protein;
  @override
  final double sugar;
  @override
  final bool verified;
  @override
  final DocumentReference<Object> reference;

  factory _$ProductsRecord([void Function(ProductsRecordBuilder) updates]) =>
      (new ProductsRecordBuilder()..update(updates)).build();

  _$ProductsRecord._(
      {this.barcode,
      this.calories,
      this.carbohydrates,
      this.description,
      this.fats,
      this.name,
      this.protein,
      this.sugar,
      this.verified,
      this.reference})
      : super._();

  @override
  ProductsRecord rebuild(void Function(ProductsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductsRecordBuilder toBuilder() =>
      new ProductsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductsRecord &&
        barcode == other.barcode &&
        calories == other.calories &&
        carbohydrates == other.carbohydrates &&
        description == other.description &&
        fats == other.fats &&
        name == other.name &&
        protein == other.protein &&
        sugar == other.sugar &&
        verified == other.verified &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf(
      $jc(
          $jc(
              $jc(
                  $jc(
                      $jc(
                          $jc(
                              $jc(
                                  $jc(
                                      $jc($jc(0, barcode.hashCode),
                                          calories.hashCode),
                                      carbohydrates.hashCode),
                                  description.hashCode),
                              fats.hashCode),
                          name.hashCode),
                      protein.hashCode),
                  sugar.hashCode),
              verified.hashCode),
          reference.hashCode),
    );
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductsRecord')
          ..add('barcode', barcode)
          ..add('calories', calories)
          ..add('carbohydrates', carbohydrates)
          ..add('description', description)
          ..add('fats', fats)
          ..add('name', name)
          ..add('protein', protein)
          ..add('sugar', sugar)
          ..add('verified', verified)
          ..add('reference', reference))
        .toString();
  }
}

class ProductsRecordBuilder
    implements Builder<ProductsRecord, ProductsRecordBuilder> {
  _$ProductsRecord _$v;

  int _barcode;
  int get barcode => _$this._barcode;
  set barcode(int barcode) => _$this._barcode = barcode;

  double _calories;
  double get calories => _$this._calories;
  set calories(double calories) => _$this._calories = calories;

  double _carbohydrates;
  double get carbohydrates => _$this._carbohydrates;
  set carbohydrates(double carbohydrates) =>
      _$this._carbohydrates = carbohydrates;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _fats;
  double get fats => _$this._fats;
  set fats(double fats) => _$this._fats = fats;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  double _protein;
  double get protein => _$this._protein;
  set protein(double protein) => _$this._protein = protein;

  double _sugar;
  double get sugar => _$this._sugar;
  set sugar(double sugar) => _$this._sugar = sugar;

  bool _verified;
  bool get verified => _$this._verified;
  set verified(bool sugar) => _$this._verified = verified;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  ProductsRecordBuilder() {
    ProductsRecord._initializeBuilder(this);
  }

  ProductsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _barcode = $v.barcode;
      _calories = $v.calories;
      _carbohydrates = $v.carbohydrates;
      _description = $v.description;
      _fats = $v.fats;
      _name = $v.name;
      _protein = $v.protein;
      _sugar = $v.sugar;
      _verified = $v.verified;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ProductsRecord;
  }

  @override
  void update(void Function(ProductsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductsRecord build() {
    final _$result = _$v ??
        new _$ProductsRecord._(
            barcode: barcode,
            calories: calories,
            carbohydrates: carbohydrates,
            description: description,
            fats: fats,
            name: name,
            protein: protein,
            sugar: sugar,
            verified: verified,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
