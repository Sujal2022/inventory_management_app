import 'package:flutter/material.dart';
import '../../database/dbhelper.dart';

class DeleteProducts extends StatefulWidget {
  @override
  _DeleteProductsState createState() => _DeleteProductsState();
}

class _DeleteProductsState extends State<DeleteProducts> {
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
        title: Text("Delete Product"),
        backgroundColor: Colors.lightBlueAccent, // Custom AppBar color
      ),
      // Remove the default AppBar and replace with a custom AppBar
      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Colors.indigo.shade900,
              Colors.blueAccent,
              Colors.tealAccent],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Expanded(
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
                  final int? id = item['id1']; // Ensure that id is an int

                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade100,
                            Colors.purple.shade50
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Category: ${item['pcategory']}",
                              style: TextStyle(
                                  color: Colors.blueAccent),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            if (id != null) {
                              _showDeleteConfirmationDialog(
                                  id); // Call delete confirmation with non-null id
                            } else {
                              // Handle the case when id is null (show error or debug)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Unable to delete: Invalid product ID"),
                                ),
                              );
                            }
                          },
                          // Customize the delete icon with color and shadow
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Colors.redAccent,
                            size: 28,
                          ),
                          tooltip: 'Delete this product',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade50,
                Colors.purple.shade50,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                color: Colors.redAccent,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                "Delete Confirmation",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Are you sure you want to delete this product?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Call the delete function with the product ID
                      _delete(id);

                      // Close the dialog
                      Navigator.of(context).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _delete(int id) async {
    final rowsDeleted = await dbHelper.deleteProduct(id);
    print('Deleted $rowsDeleted row(s): row $id');
    _query(); // Refresh the list after deletion
  }
}
