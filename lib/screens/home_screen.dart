import 'package:flutter/material.dart';
import 'package:flutter_getx_shoping_cart/getx/product_controller.dart';
import 'package:flutter_getx_shoping_cart/custom_widgets.dart';
import 'package:get/get.dart';

import 'ProductDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFff665e),
        title: const Text('Getx Shopping Store'),
        actions: [
          cartIcon(productController),
        ],
      ),
      body: FutureBuilder<dynamic>(
          future: productController.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.79),
                itemBuilder: (context, index) {
                  final data = snapshot.data.elementAt(index);

                  print(data);
                  return InkWell(
                    onTap: () {
                      productController.selectedProduct = data;

                      Get.to(() => ProductDetailScreen());
                    },
                    child: Stack(
                      children: [
                        Card(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 170,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(data['thumbnail']),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 10),
                                child: textView(data['title']),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5),
                                child: textView("Price \$${data['price']}",
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Obx(
                          () => IconButton(
                            onPressed: () {
                              print('i am fav $index');
                            },
                            icon: productController.favList.contains(data['id'])
                                ? const Icon(Icons.favorite)
                                : const Icon(Icons.favorite_border_outlined),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
