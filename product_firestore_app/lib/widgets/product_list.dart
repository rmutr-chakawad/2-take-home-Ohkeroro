import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/service/database.dart';
import 'package:product_firestore_app/widgets/product_form.dart';
import 'package:product_firestore_app/widgets/product_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {

    Database db = Database.myInstance;
    Stream<List<ProductModel>> myStream = db.getAllProductStream();



    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: StreamBuilder(
        stream: myStream, 
        builder: (context, snapshot){
          if(snapshot.data!.isEmpty) {
            return const Center(child: Text('ยังไม่มีข้อมูลสินค้า'),);
          }else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return Dismissible(
                  key: UniqueKey(), 
                  //การลบรายการสินค้า
                  onDismissed: (direction){
                    if(direction == DismissDirection.endToStart){
                      db.deleteProduct(product: snapshot.data![index]);
                    }
                  },
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red,),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context, 
                        builder: (context) {
                          return ProductForm(product: snapshot.data![index]);
                        },
                      );
                    },
                    child: ProductItem(product: snapshot.data![index]),
                    ));
              }
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        }),
    );
  }
}