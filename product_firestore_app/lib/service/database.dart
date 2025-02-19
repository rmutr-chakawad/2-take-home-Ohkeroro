import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:product_firestore_app/models/product_model.dart';

class Database {
  static Database myInstance = Database();

  Stream<List<ProductModel>> getAllProductStream(){
    var reference = FirebaseFirestore.instance.collection('products');

    Query query = reference.orderBy('id', descending: true);

    var querySnapshot = query.snapshots();

    return querySnapshot.map((snapshot){
        return snapshot.docs.map((doc){
          return ProductModel.formMap(doc.data() as Map<String, dynamic>);}).toList();
      });
  }

  Future<void> setProduct({required ProductModel product}) async{
    var reference = FirebaseFirestore.instance.doc('products/${product.id}');
    try{
      await reference.set(product.toMap());
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteProduct({required ProductModel product}) async{
    var reference = FirebaseFirestore.instance.doc('products/${product.id}');
    try{
      await reference.delete();
    } catch (e) {
      rethrow;
    }
  }
}