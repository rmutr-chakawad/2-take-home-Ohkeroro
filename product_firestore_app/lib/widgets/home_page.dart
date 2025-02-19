import 'package:flutter/material.dart';
import 'package:product_firestore_app/widgets/product_list.dart';
import 'package:product_firestore_app/widgets/product_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prodct List'),
        backgroundColor: const Color.fromARGB(255, 242, 171, 255),
        actions: [
          IconButton(
            onPressed: (){
              showModalBottomSheet(
                isScrollControlled: true,
                context: context, 
                builder: (context)=> ProductPopup());
            }, 
            icon: const Icon(Icons.add))
        ],
      ),
      body: const ProductList(),
    );
  }
}