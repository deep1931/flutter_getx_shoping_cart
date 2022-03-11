import 'package:flutter/material.dart';
import 'package:flutter_getx_shoping_cart/getx/product_controller.dart';
import 'package:get/get.dart';

import '../custom_widgets.dart';

class CartProductsList extends StatefulWidget {
  const CartProductsList({Key? key}) : super(key: key);

  @override
  State<CartProductsList> createState() => _CartProductsListState();
}

class _CartProductsListState extends State<CartProductsList> {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfafafa),
      appBar: AppBar(
        backgroundColor: const Color(0xFFff665e),
        title:
            textView('Cart Product Detail', color: Colors.white, fontSize: 16),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: productController.cartProducts.length,
            itemBuilder: (context, index) {
              final data = productController.cartProducts[index];

              return getListItem(data);
            }),
      ),
    );
  }

  Widget getListItem(data) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: Image.network(data['images'][0]).image,
      ),
      title: textView(data['title'], fontSize: 18),
      subtitle: Row(
        children: <Widget>[
          textView("\$${(data['price'])}",
              color: const Color(0xFF0dc2cd), fontWeight: FontWeight.w500),
          hSpace(10),
          textView("Discount % ${(data['discountPercentage'])}",
              color: Colors.redAccent, fontWeight: FontWeight.w500),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          productController.removeFromCart(data);
        },
        icon: const Icon(Icons.delete_forever),
      ),
    );
  }
}
