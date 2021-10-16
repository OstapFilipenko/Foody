import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/backend/schema/products_record.dart';

Future<String> findBarcode(String barcode) async {
  String idOfPruduct;
  QuerySnapshot<Map<String, dynamic>> snapshot = await ProductsRecord.collection
      .where("barcode", isEqualTo: int.parse(barcode))
      .get();

  if (snapshot.docs.isEmpty) {
    return null;
  }

  List<QueryDocumentSnapshot> docs = snapshot.docs;
  for (var doc in docs) {
    if (doc.data() != null) {
      idOfPruduct = doc.id;
    }
  }

  return idOfPruduct;
}
