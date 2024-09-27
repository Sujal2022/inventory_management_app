import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:inventory_management_app/screens/AddProducts/scannerscreen.dart';
import 'package:inventory_management_app/screens/scannerscreen.dart';

import '../database/dbhelper.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({super.key});

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  TextEditingController pname = TextEditingController();
  TextEditingController pcategory = TextEditingController();
  TextEditingController pprice = TextEditingController();
  TextEditingController pnumber = TextEditingController();
  TextEditingController pscanner = TextEditingController();
  final dbHelper = DbHelper.instance;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Product",
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.brown,
                  Colors.purple,
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      title: const Text(
                        'Product Name:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: TextFormField(
                        controller: pname,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Enter product name',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: const Text(
                        'Product Category:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: TextFormField(
                        controller: pcategory,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Enter category',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter category';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: const Text(
                        'Product Price:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: TextFormField(
                        controller: pprice,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Enter price',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the price';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Please enter only numbers';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: const Text(
                        'Product Number:',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: TextFormField(
                        controller: pnumber,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Enter Bar/QR Code number',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter product number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: const Text(
                        'Scanner Details(Optional):',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Container(
                            height: 100,
                        child: TextFormField(
                          controller: pscanner,
                          maxLines: null, // Allows the TextField to grow vertically as the user types
                          expands: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Scanner Detail(Optional)',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),

                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate to QR Scanner Page and wait for the result
                        final scannedData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScannerPage(),
                          ),
                        );

                        // Populate the text fields with the scanned data
                        if (scannedData != null) {
                          setState(() {
                            pscanner.text = scannedData;
                            // If the scannedData contains more details like name, category, etc.,
                            // you can parse and set them to other fields as well.
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffA1C349),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Scan Bar/ QR Code",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formGlobalKey.currentState!.validate()) {
                          _insertproduct();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xffA1C349),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Add Items",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _insertproduct() async {
    Map<String, dynamic> row = {
      DbHelper.ProductName: pname.text,
      DbHelper.ProductCategory: pcategory.text,
      DbHelper.ProductPrice: pprice.text,
      DbHelper.ProductNumber: pnumber.text,
    };

    final id = await dbHelper.insertproduct(row);

    if (kDebugMode) {
      print('Inserted row id: $id');
    }
    if (id != null && id > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product is Added Successfully!")),
      );

      pname.clear();
      pcategory.clear();
      pprice.clear();
      pnumber.clear();
      pscanner.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("To add product is Failed! Please try again...."),
        ),
      );
    }
  }
}
