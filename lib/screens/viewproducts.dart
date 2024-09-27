import 'package:flutter/material.dart';
import '../../database/dbhelper.dart';

class ViewProducts extends StatefulWidget {
  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
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
        backgroundColor: Colors.deepPurple, // Custom AppBar color
      ),
      body: Container(
        // Background linear gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
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
                    colors: [Colors.purple[100]!, Colors.purple[50]!],
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
                      color: Colors.deepPurple,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category: ${item['pcategory']}",
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                      SizedBox(height: 5),
                      /*// Uncomment the following if you want to show more details
                      Text(
                        "Price: ${item['pprice']}",
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Number: ${item['pnumber']}",
                        style: TextStyle(color: Colors.deepPurpleAccent),
                      ),*/
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
