// lib/UI/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:ecommerce/Service/cart_service.dart';
import 'package:ecommerce/model/Products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Products> cartItems = CartService().cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];

                return Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,10),
                  child: Stack(
                    children: [
                      Container(
                                           width: 380,
                                            height: 164,
                                            decoration: BoxDecoration(
                         color: Color(0xffFFFFFF),
                         borderRadius: BorderRadius.circular(20),
                         boxShadow: [
                           BoxShadow(
                               color: Color(0x40000000),
                               offset: Offset(1.0, 1.0),
                               blurRadius: 4.0,
                               spreadRadius: 0),
                           BoxShadow(
                               color: Color(0x40000000),
                               offset: Offset(-1.0, -1.0),
                               blurRadius: 4.0,
                               spreadRadius: 0),
                         ]),
                         child: Column(
                           children: [
                             Padding(padding: EdgeInsets.all(10),
                             child: Row(
                      
                               children: [
                                 product.thumbnail != null
      ? Image.network(product.thumbnail!, width: 70, height: 70)
      : const Icon(Icons.image, size: 70),
                      
                                 SizedBox(width: 15,),
                                 Expanded(
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product.title ?? 'No title',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                                       maxLines: 2,
        overflow: TextOverflow.ellipsis,),
                                      
                                      Text(product.brand ?? 'No brand',
                                      style: TextStyle(fontWeight: FontWeight.w400),),
                                                         
                                      SizedBox(height: 10,),
                                      Text('\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,
                                                        color: Color(0xFFEE2126)))
                                    ],
                                   ),
                                 )
                               ],
                             ),),
                             SizedBox(height: 10,),
                             Expanded(child: Container(
                              width: 330,
                              height: 35,
                              
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.grey.shade300, width: 1),
                                ),
                              ),
                              child: TextButton(
                                    onPressed: () { 
                                      
                                       setState(() {
                        CartService().removeFromCart(product);
                      });
                                     },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.delete_forever_outlined,size: 18,color: Color(0xff000000)),
                                        SizedBox(width: 5,),
                                        Text('Remove',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff000000)),),
                                      ],
                                    )
                                  ),
                             ))
                           ],
                         ),
                                            
                                          ),

                    ],
                  ),
                );
                
              },
            ),
    );
  }
}
