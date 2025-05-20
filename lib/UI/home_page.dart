import 'package:ecommerce/Service/api_service.dart';
import 'package:ecommerce/UI/cart_screen.dart';
import 'package:ecommerce/UI/details.dart';
import 'package:ecommerce/UI/filter_screen.dart';
import 'package:ecommerce/UI/search_screen.dart';
import 'package:ecommerce/model/Products.dart';
import 'package:ecommerce/model/ResponseMain.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double? minPrice;
  double? maxPrice;
   late Future<List<Products>?> productsFuture;
   int? currentSelectedIndex; 
   int _selectedSortOption = 0;

  @override
  void initState() {
    super.initState();
    productsFuture = ApiService().fetchProducts(); // initial fetch
  }

  void fetchProducts() {
    productsFuture = ApiService().fetchProducts();
  }

  void applyFilter(double min, double max) {
  setState(() {
    minPrice = min;
    maxPrice = max;
    productsFuture = ApiService().fetchProducts(); // Re-fetch data
  });
}


  void openFilterScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) =>  FilterScreen(initialSelectedIndex: currentSelectedIndex)),
    );

    if (result != null && result is Map<String, dynamic>) {
  double min = result['minPrice'];
  double max = result['maxPrice'];
  applyFilter(min, max); // <- This must re-filter your product list
  setState(() {
      currentSelectedIndex = (result['selectedIndex'] ?? currentSelectedIndex);
      // Now apply your filtering logic
    });
}
  }


  void showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("SORT BY", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey)),
                const Divider(),
                RadioListTile(
                  title: const Text("Price: Low to High"),
                  value: 1,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setStateSheet(() => _selectedSortOption = value!);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                RadioListTile(
                  title: const Text("Price: High to Low"),
                  value: 2,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setStateSheet(() => _selectedSortOption = value!);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                RadioListTile(
                  title: const Text("Alphabetical: A to Z"),
                  value: 3,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setStateSheet(() => _selectedSortOption = value!);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
                RadioListTile(
                  title: const Text("Alphabetical: Z to A"),
                  value: 4,
                  groupValue: _selectedSortOption,
                  onChanged: (value) {
                    setStateSheet(() => _selectedSortOption = value!);
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final products=ApiService().fetchProducts();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
           
          leading: IconButton(onPressed: (){
            Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
          },
           icon: Icon(Icons.search)),
             title: GestureDetector(
              onTap: (){
                Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
              },
               child: Text('Search Products...',
               style: TextStyle(fontSize: 18,
               color: Colors.grey,
               fontWeight: FontWeight.normal),),
             ),
          titleSpacing:0,
          actions: [
            
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(onPressed: (){
                     Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        );
                  },
                   icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,)),
                ),
                

            
          ],
        ),
      ),
      body: FutureBuilder(future:productsFuture, 
      builder: (BuildContext context, AsyncSnapshot<List<Products>?> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          List<Products> filtered = snapshot.data!;
          if (minPrice != null && maxPrice != null) {
            filtered = filtered
                .where((product) =>
                    (product.price ?? 0) >= minPrice! &&
                    (product.price ?? 0) <= maxPrice!)
                .toList();
          }

          // Apply sort
          if (_selectedSortOption == 1) {
            filtered.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
          } else if (_selectedSortOption == 2) {
            filtered.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
          } else if (_selectedSortOption == 3) {
            filtered.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
          } else if (_selectedSortOption == 4) {
            filtered.sort((a, b) => (b.title ?? '').compareTo(a.title ?? ''));
          }
print(snapshot.data?.length);
        if(snapshot.hasData){
          
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (BuildContext context, int index) {  
                    Products p=filtered[index];
                     return Container(
                      

                      decoration: BoxDecoration(
                                    border: Border(
                                         top: BorderSide(width: 0.5, color: Colors.black12),
                                       
                                       ),
                                  ),

                       child: ListTile(
                                   leading: Image.network(p.thumbnail ?? '', width: 50, height: 50, errorBuilder: (_, __, ___) => Icon(Icons.image)),
                                   title: Text(p.title ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                   subtitle: Text('\$${p.price}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.red[400])),
                                   onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(products:p),
                              ),
                            );
                          },
                                 ),
                     );
                    
                  },
                  ),
              ),
                 Container(
                  
                                  decoration: BoxDecoration(
                                    border: Border(
                                         top: BorderSide(width: 1.0, color: Colors.black26),
                                         bottom: BorderSide(width: 1.0, color: Colors.black26),
                                       ),
                                  ),
                                   child: Padding(
                                     padding: const EdgeInsets.fromLTRB(10,10,10,10),
                                     child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.sort,color: Colors.grey[700],),
                                            TextButton(onPressed: showSortOptions, child: Text('Sort',style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.bold,fontSize: 17))),
                                          ],
                                        ),
                                        Container(width: 1,height: 25,color: Colors.black26,),
                                         Row(
                                           children: [
                                            Icon(Icons.filter_alt_outlined,color: Colors.grey[700],),
                                             TextButton(onPressed: openFilterScreen, child: Text('Filter',style: TextStyle(color: Colors.blue[800],fontWeight: FontWeight.bold,fontSize: 17),)),
                                           ],
                                         )
                                      ],
                                     ),
                                   ),
                                 )
            ],
          );
        }
        else{
          return Text('no data');
        }
        } ,
      ),
    );
  }
}