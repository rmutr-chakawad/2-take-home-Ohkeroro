import 'package:flutter/material.dart';
import 'package:product_firestore_app/models/product_model.dart';
import 'package:product_firestore_app/service/database.dart';

// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  final ProductModel? product;
  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  Database db = Database.myInstance;
  var nameController = TextEditingController();
  var priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      nameController.text = widget.product!.productName;
      priceController.text = widget.product!.price.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.product != null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(isEditing ? 'แก้ไขสินค้า ${widget.product!.productName}' : 'เพิ่มสินค้า'),
        TextField(
          controller: nameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(labelText: 'ชื่อสินค้า'),
        ),
        TextField(
          controller: priceController,
          keyboardType: TextInputType.number, // ใช้ number เพื่อป้องกันปัญหาข้อมูลไม่ถูกต้อง
          decoration: const InputDecoration(labelText: 'ราคาสินค้า'),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showBtnOk(context, isEditing),
            const SizedBox(width: 10),
            showBtnCancel(context),
          ],
        )
      ],
    );
  }

  Widget showBtnOk(BuildContext context, bool isEditing) {
    return ElevatedButton(
      onPressed: () async {
        String newId = isEditing ? widget.product!.id : 'PD${DateTime.now().millisecondsSinceEpoch}';

        ProductModel newProduct = ProductModel(
          id: newId,
          productName: nameController.text.trim(),
          price: double.tryParse(priceController.text) ?? 0,
        );

        await db.setProduct(product: newProduct);

        nameController.clear();
        priceController.clear();

        Navigator.of(context).pop();
      },
      child: Text(isEditing ? 'บันทึก' : 'เพิ่ม'),
    );
  }

  Widget showBtnCancel(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('ปิด'),
    );
  }
}
