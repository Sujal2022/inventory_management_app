/*
import 'package:flutter/material.dart';
import '../database/dbhelper.dart';

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
      ),
      body: allCategoryData.isEmpty
          ? Center(child: Text("No products available."))
          : ListView.builder(
        itemCount: allCategoryData.length,
        itemBuilder: (context, index) {
          var item = allCategoryData[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              title: Text(
                item['pname'] ?? "No Name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category: ${item['pcategory']}"),
                  SizedBox(height: 5),
                  */
/* Text("Price: ${item['pprice']}"),
                  SizedBox(height: 5),
                  Text("Number: ${item['pnumber']}"),*//*

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/
