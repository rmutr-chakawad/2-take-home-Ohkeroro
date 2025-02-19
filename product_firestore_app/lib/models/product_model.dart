class ProductModel {
  String id;
  String productName;
  double price;

  ProductModel({required this.id, required this.productName, required this.price});

  factory ProductModel.formMap(Map<String, dynamic> product){
    if(product.isEmpty){
      throw ArgumentError('ไม่พบ');
    }else{
      var obj = ProductModel(
        id: product['id'],
        productName:  product['productName'],
        price: product['price']);
        return obj;
    }
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> data;
    data = {'id' : id, 
            'productName' : productName, 
            'price' : price};
    return data;
  }
}