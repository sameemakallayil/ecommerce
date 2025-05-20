import 'package:ecommerce/Service/api_service.dart';
import 'package:ecommerce/UI/details.dart';
import 'package:ecommerce/model/Products.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Products> _allProducts = [];
  List<Products> _filteredProducts = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final products = await ApiService().fetchProducts();
    setState(() {
      _allProducts = products!;
      _filteredProducts = products;
      _isLoading = false;
    });
  }

  void _searchProducts(String query) {
    final results = _allProducts.where((product) =>
      product.title!.toLowerCase().contains(query.toLowerCase())
    ).toList();

    setState(() {
      _filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          onChanged: _searchProducts,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredProducts.isEmpty
              ? const Center(child: Text('No matching products found'))
              : ListView.builder(
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return Container(
                       decoration: BoxDecoration(
                                    border: Border(
                                         top: BorderSide(width: 0.5, color: Colors.black12),
                                       
                                       ),
                                  ),
                      child: ListTile(
                        leading: Image.network(
                          product.thumbnail ?? '',
                          width: 50,
                          height: 50,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image),
                        ),
                        title: Text(product.title ?? ''),
                        subtitle: Text('\$${product.price}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Details(products: product),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}