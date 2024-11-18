import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_112/Products/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'General';
  String brand = 'Unbranded';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  addProduct()  {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        brand: brand,
        description: productDescriptionCtrl.text,
        image: productImgCtrl.text,
        offer: offer,
        price: double.tryParse(productPriceCtrl.text) ?? 00,
        category: category,
        id: doc.id,
        name: productNameCtrl.text,
      );
      final productJson = product.toJson();
       doc.set(productJson);
      update();
      Get.snackbar('success', 'Product added successfully',
          colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapShot = await productCollection.get();
      final List<Product> retrievedproducts = productSnapShot.docs
              .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
      products.clear();
      products.assignAll(retrievedproducts);
      update();
      print("Number of products fetched: ${products.length}");
      update();
      Get.snackbar('Success', 'Product fetched Successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }
 deleteProduct(String id) async {
   try {
     await productCollection.doc(id).delete();
     fetchProducts();
   } catch (e) {
     Get.snackbar('error', e.toString(), colorText: Colors.red);
     print(e);
   }finally{
     update();
   }
 }
  setValuesDefault() {
    productNameCtrl.clear();
    productImgCtrl.clear();
    productDescriptionCtrl.clear();
    productPriceCtrl.clear();

    category = 'General';
    brand = 'Unbranded';
    offer = false;

    update();
  }
}
