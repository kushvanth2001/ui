import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/web/models/products.dart';
import 'package:http/http.dart' as http;

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  String _name = '';
  String _description = '';
  double _price = 0.0;
  var uuid = Uuid();
  int _imagesize = 0;
  List<String> _imageUrls = [];
  int _maximagesize = 2000000;
  File? _selectedImage;
  List<File> _selectedImageList = [];
  List<String> _base64ImageList = [];
  late Uint8List bytes = Uint8List(5);
  List<String> cropTypeStringList = cropTypeList;
  String _category = "Vegetables";

  String _base64Image = '';

  List<String> _encoderToBase64(List<File> list) {
    List<String> result = [];
    for (int i = 0; i < list!.length; i++) {
      List<int> imageBytes = list[i].readAsBytesSync();

      String base64Image = base64Encode(imageBytes);
      result.add(base64Image);
    }
    return result;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create a Product object with the entered data
      final product = Product(
        id: uuid.v1(),
        name: _name,
        description: _description,
        price: _price,
        imageUrls: _imageUrls,
        category: _category,
      );

      // Convert the product object to JSON
      final productJson = product.toJson();
      try {
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/product'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(productJson),
        );

        if (response.statusCode == 200) {
          // Request was successful, handle the response if needed
        } else {
          // Handle errors
          print('Error sending data to backend: ${response.statusCode}');
        }
      } catch (e) {
        // Handle exceptions
        print('Exception occurred while sending data: $e');
      }
      setState(() {});

      print('Product JSON: $productJson');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 50),
            constraints:
                BoxConstraints(maxWidth: double.maxFinite, minWidth: 300),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/productbgimg.png"),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product form",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 140,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Enter the Product name ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: ScreenUtil().screenHeight * 0.5,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                      hintText: 'Enter name',
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _name = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the product name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Enter the Product price in numbers ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: ScreenUtil().screenHeight * 0.5,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Price',
                                      hintText: 'Enter price',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        _price = double.tryParse(value) ?? 0.0;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the product price';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 140,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Enter the Product category ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: ScreenUtil().screenHeight * 0.5,
                                  child: DropdownButton(
                                    hint: Text("select a category"),
                                    value: _category,
                                    icon: Icon(Icons.arrow_drop_down),
                                    items:
                                        cropTypeStringList.map((String item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _category = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Enter the product description ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '*',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 150,
                                    width: 80,
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      textAlignVertical: TextAlignVertical.top,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Description',
                                        hintText: 'Enter description',
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (value) {
                                        setState(() {
                                          _description = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the product description';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            FilePickerResult? pickerResult =
                                await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );

                            if (pickerResult != null) {
                              PlatformFile imageFile = pickerResult.files.first;
                              List<int> imageBytes = await imageFile.bytes!;

                              String base64String = base64Encode(imageBytes);
                              setState(() {
                                _base64Image = base64String;
                                _base64ImageList.add(base64String);
                                bytes = imageFile.bytes!;
                                _imageUrls.add(_base64Image);
                                _imagesize = imageFile.bytes!.length;
                              });
                              debugPrint(_imagesize.toString());
                            }
                          },
                          child: Text('Upload product Image'),
                        ),
                      ),
                      if (_imagesize < _maximagesize)
                        _base64Image.isNotEmpty
                            ? Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 100,
                                  width: 50,
                                  child: Image.memory(bytes),
                                ),
                              )
                            : Container()
                      else
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Your image size is more than 2 Mb select another picture",
                            style: TextStyle(color: Colors.black, fontSize: 26),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
