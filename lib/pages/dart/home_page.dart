import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_112/controller/home_controller.dart';
import 'package:project_112/pages/dart/add_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("footware admin")),
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:  Text(ctrl.products[index].name ?? ''),
                subtitle:  Text((ctrl.products[index].price ?? 0).toString()),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ctrl.deleteProduct(ctrl.products[index].id ?? '' );
                    ctrl.fetchProducts();
                  },
                ),

              );

            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const AddProductPage());

          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
