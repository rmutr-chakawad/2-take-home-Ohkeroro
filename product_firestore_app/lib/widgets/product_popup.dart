import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/widgets/product_form.dart';

// ignore: must_be_immutable
class ProductPopup extends StatelessWidget {
  ProductModel? product;
  ProductPopup({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)
            ),
            color: Color.fromARGB(255, 250, 199, 215)
          ),
          height: MediaQuery.of(context).size.height * 0.3,
          child: ProductForm(product: product,),
        ),
    );
  }
}