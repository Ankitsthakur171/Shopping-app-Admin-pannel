import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project_112/Widgets/dropdown_button.dart';
import 'package:project_112/controller/home_controller.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      assignId: true,
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('add product'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Add New Product',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  TextField(
                    controller: ctrl.productNameCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Product name'),
                      hintText: 'Enter Product Name',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: ctrl.productDescriptionCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Description'),
                      hintText: 'Enter Product Description',
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: ctrl.productImgCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Image URL'),
                      hintText: 'Enter Image URL',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: ctrl.productPriceCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Product Price'),
                      hintText: 'Enter Product Price',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: DropdownBtn(
                          items: const ['Boots', 'Sneakers', 'Classic', 'High Heels', 'Crocs'],
                          selectedItemsText: ctrl.category,
                          onSelected: (selectedValue) {
                            ctrl.category = selectedValue ?? 'General';
                            ctrl.update();
                          },
                        ),
                      ),
                      Flexible(
                        child: DropdownBtn(
                          items: const ['Puma', 'Sketchers', 'Adidas', 'Clarks'],
                          selectedItemsText:ctrl.brand,
                          onSelected: (selectedValue) {
                            ctrl.brand = selectedValue ?? 'Unbranded';
                            ctrl.update();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("offer Product ?"),
                  DropdownBtn(
                    items: const ['true', 'false'],
                    selectedItemsText: ctrl.offer.toString(),
                    onSelected: (selectedValue) {
                      ctrl.offer =
                          bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();

                    },

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add Product'),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
