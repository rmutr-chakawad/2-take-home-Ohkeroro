import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/widgets/product_popup.dart';

// ignore: must_be_immutable
class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context, 
          builder: (context){ 
            return ProductPopup(product: product);
          });
      },
      child: ListTile(
        leading: Text(product.productName),
        title: Text(product.price.toStringAsFixed(2), textAlign: TextAlign.right,),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}