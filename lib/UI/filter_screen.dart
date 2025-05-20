import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final int? initialSelectedIndex;
  const FilterScreen({super.key,this.initialSelectedIndex});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}



class _FilterScreenState extends State<FilterScreen> {
  // Define the price range options
  final List<Map<String, dynamic>> priceRanges = [
    {'label': 'All Products', 'min': 0.0, 'max': double.infinity},
    {'label': '\$299 and Below', 'min': 0.0, 'max': 299.0},
    {'label': '\$300 - \$700', 'min': 300.0, 'max': 700.0},
    // {'label': '\$500 - \$700', 'min': 500.0, 'max': 700.0},
    {'label': '\$700 - \$1000', 'min': 700.0, 'max': 1000.0},
    {'label': '\$1000 and Above', 'min': 1000.0, 'max': double.infinity},
  ];

  int? selectedIndex;

  @override
void initState() {
  super.initState();
  selectedIndex = widget.initialSelectedIndex;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter Options")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Price Range", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            ...List.generate(priceRanges.length, (index) {
              return CheckboxListTile(
                title: Text(priceRanges[index]['label']),
                value: selectedIndex == index,
                onChanged: (_) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              );
            }),

            const SizedBox(height: 70),

            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedIndex != null) {
                      final selectedRange = priceRanges[selectedIndex!];
                      Navigator.pop(context, {
                        'minPrice': selectedRange['min'],
                        'maxPrice': selectedRange['max'],
                        'selectedIndex': selectedIndex,
                      });
                    } else {
                      Navigator.pop(context); // No filter selected
                    }
                  },
                  child: const Text("Apply Filter",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 11.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.brown[400],
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
