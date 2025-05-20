import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Service/cart_service.dart';
import 'package:ecommerce/model/Products.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  Products? products;
   Details({super.key,required this.products,});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  List<Map<String, dynamic>> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Details'),
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
          Text('${widget.products?.title}',style: TextStyle(fontSize: 25)),
        
          SizedBox(height: 10,),
                    Text('${widget.products?.brand}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey)),
                    Text('${widget.products?.category}',style: TextStyle(fontSize: 15)),
                    SizedBox(height: 30,),
        
        
          
          
           CarouselSlider.builder(itemCount: widget.products!.images!.length,
                     itemBuilder: (BuildContext context, int index, int realIndex) {
                      return Container(
                       
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage("${widget.products?.images! [index]}"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
          
                     }, options: CarouselOptions(
                         height: 190.0,
                         enlargeCenterPage: true,
                         autoPlay: true,
                         aspectRatio: 16/9,
                         autoPlayCurve: Curves.elasticInOut,
                         enableInfiniteScroll: true,
                         autoPlayAnimationDuration: Duration(milliseconds: 800),
                         viewportFraction: 0.8,
                       ),
          
                   ),
          
                    SizedBox(height: 30,),
                    Text('${widget.products?.description}',style: TextStyle(fontSize: 15,),textAlign:TextAlign.left,),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.arrow_downward,color: Colors.green),
                        Text('${widget.products?.discountPercentage}\%',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),textAlign:TextAlign.left,),
        
                      SizedBox(width: 10,),
                      Text('\$${widget.products?.price}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),textAlign:TextAlign.left,),
                      ],
                    ),
                    
                    
                    SizedBox(height: 10,),
                    Text('Rating: ${widget.products?.rating}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                    SizedBox(height: 10,),
                    Text('Stock Available: ${widget.products?.stock}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
        
                    SizedBox(height: 10,),
                    Text('${widget.products?.warrantyInformation}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                    SizedBox(height: 10,),
                    Text('${widget.products?.shippingInformation}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal)),
                    
                   
                  
                      SizedBox(height: 70,),
                   Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                     final cartService = CartService();
  final isAlreadyInCart = cartService.cartItems.any(
    (item) => item.id == widget.products!.id,
  );

  if (isAlreadyInCart) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Already added to cart'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.orange[800],
      ),
    );
  } else {
    cartService.addToCart(widget.products!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to Cart'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  }
                      },
                
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 11.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.brown[400],
                          ),
                    
                  child:Text("Add to Cart",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                ),
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  

}