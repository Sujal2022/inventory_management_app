import 'package:flutter/material.dart';
import '../../database/dbhelper.dart';

class ViewInventory extends StatefulWidget {
  const ViewInventory({super.key});

  @override
  State<ViewInventory> createState() => _ViewInventoryState();
}

class _ViewInventoryState extends State<ViewInventory> {
  List<Map<String, dynamic>> allCategoryData = [];
  final dbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRowsaddproducts();
    setState(() {
      allCategoryData = allRows;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        backgroundColor: Color(0xFF4E65FF), // Blue color for the AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4E65FF), // Dark blue color
              Color(0xFF92EFFD)  // Light cyan color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: allCategoryData.isEmpty
            ? Center(
          child: Text(
            "No products available.",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
            : ListView.builder(
          itemCount: allCategoryData.length,
          itemBuilder: (context, index) {
            var item = allCategoryData[index];
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF92EFFD), // Light cyan color
                      Colors.white // Blending with white
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(15.0),
                  title: Text(
                    item['pname'] ?? "No Name",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4E65FF), // Dark blue color for text
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category: ${item['pcategory']}",
                        style: TextStyle(color: Color(0xFF4E65FF)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Price: ${item['pprice']}",
                        style: TextStyle(color: Color(0xFF4E65FF)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Number: ${item['pnumber']}",
                        style: TextStyle(color: Color(0xFF4E65FF)),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: Color(0xFF4E65FF)),
                    onPressed: () {
                      _showEditDialog(item); // Show edit dialog
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  void _showEditDialog(Map<String, dynamic> product) {
    // Create controllers with existing values
    TextEditingController nameController =
    TextEditingController(text: product['pname']);
    TextEditingController categoryController =
    TextEditingController(text: product['pcategory']);
    TextEditingController priceController =
    TextEditingController(text: product['pprice'].toString());
    TextEditingController numberController =
    TextEditingController(text: product['pnumber'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Edit Product",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4E65FF), // Dark blue color for title
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameController, 'Product Name', Icons.production_quantity_limits),
                SizedBox(height: 10),
                _buildTextField(categoryController, 'Category', Icons.category),
                SizedBox(height: 10),
                _buildTextField(priceController, 'Price', Icons.attach_money, keyboardType: TextInputType.number),
                SizedBox(height: 10),
                _buildTextField(numberController, 'Number', Icons.format_list_numbered, keyboardType: TextInputType.number),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Cancel",
                style: TextStyle(color: Color(0xFF4E65FF)), // Match with the theme color
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _updateProduct(
                  id: product['id1'],
                  name: nameController.text,
                  category: categoryController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  number: int.tryParse(numberController.text) ?? 0,
                );
              },
              child: Text("Update"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4E65FF), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Color(0xFF4E65FF)), // Icon color
      ),
      keyboardType: keyboardType,
    );
  }

  // Update Code
  void _updateProduct({
    required int id,
    required String name,
    required String category,
    required double price,
    required int number,
  }) async {
    // Update product in database
    await dbHelper.updateProduct({
      'id1': id,
      'pname': name,
      'pcategory': category,
      'pprice': price,
      'pnumber': number,
    });

    // Refresh the list after update
    _query();
    Navigator.of(context).pop(); // Close the dialog box
  }
}
