import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import '../../widgets/input_field.dart';
import 'package:http/http.dart' as http;


class Stage {
  String description = '';
  File? image;
  int duration = 0;
  List<String> products = [];
  String? method;
  String? stageName;
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _crop_name = '';
  String _crop_type = '';
  String _basic_information = '';
  List<Stage> _stages = [Stage(), Stage()];
  File? _selectedImage;
  String _base64Image = '';
  Uint8List? _selectedImageBytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      
      final imageByte = await pickedFile.readAsBytes();

      setState(() {
        _selectedImage = imageFile;
        _base64Image = base64Image;
        _selectedImageBytes=Uint8List.fromList(imageBytes);
      });
    }
  }
Future<String> postData() async {
  final apiUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts');


  final Map<String, dynamic> data = {
    'title': 'Sample Title',
    'body': 'Sample Body',
    'userId': 1,
  };

  // Send the POST request
  final response = await http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data), // Convert data to JSON format
  );

  // Check the response from the API
  if (response.statusCode == 201) {
    print('Data successfully posted!');
    print('Response body: ${response.body}');
    return "sucess";
  } else {
    print('Failed to post data. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return "failure";
  }
}
  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      print('Crop Name: $_crop_name');
      print('Crop Type: $_crop_type');
      print('Basic Description: $_basic_information');
      print('Base64 Image: $_base64Image');
      
 print(await postData());
      for (int i = 0; i < _stages.length; i++) {
        print('Stage $i Description: ${_stages[i].description}');
        print('Stage $i Duration: ${_stages[i].duration}');
        print('Stage $i Products: ${_stages[i].products.join(', ')}');
        if (i < 2) {
          print('Stage $i Method: ${_stages[i].method}');
        } else {
          print('Stage $i Stage Name: ${_stages[i].stageName}');
        }
      }
    }
  }

  Widget _buildStageInputFields(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Stage ${index + 1}'),
            ),
            if (index >= 2)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _stages.removeAt(index);
                  });
                },
              ),
          ],
        ),
        InputField(
          labelText: 'Description',
          hintText: 'Enter description for stage ${index + 1}',
          onChanged: (value) {
            setState(() {
              _stages[index].description = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Duration',
            hintText: 'Enter duration for stage ${index + 1}',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _stages[index].duration = int.tryParse(value) ?? 0;
            });
          },
        ),
        InputField(
          labelText: 'Products',
          hintText: 'Enter products for stage ${index + 1} (comma-separated)',
          onChanged: (value) {
            setState(() {
              _stages[index].products = value.split(',').map((e) => e.trim()).toList();
            });
          },
        ),
        if (index < 2)
          InputField(
            labelText: 'Method',
            hintText: 'Enter method for stage ${index + 1}',
            onChanged: (value) {
              setState(() {
                _stages[index].method = value;
              });
            },
          ),
        if (index >= 2)
          InputField(
            labelText: 'Stage Name',
            hintText: 'Enter stage name for stage ${index + 1}',
            onChanged: (value) {
              setState(() {
                _stages[index].stageName = value;
              });
            },
          ),
        ElevatedButton(
          onPressed: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.getImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              File imageFile = File(pickedFile.path);
              setState(() {
                _stages[index].image = imageFile;
              });
            }
          },
          child: Text('Upload Stage Image'),
        ),
        if (_stages[index].image != null) Image.network(_stages[index].image!.path),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Details'),
      ),
      body: Center( // Centering the form
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75, // 75% width
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.green[50], // Light shade of green
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView( // Adding a SingleChildScrollView
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputField(
                    labelText: 'Crop Name',
                    hintText: 'Enter crop name',
                    onChanged: (value) {
                      setState(() {
                        _crop_name = value;
                      });
                    },
                  ),
                  InputField(
                    labelText: 'Crop Type',
                    hintText: 'Enter crop type',
                    onChanged: (value) {
                      setState(() {
                        _crop_type = value;
                      });
                    },
                  ),
                  InputField(
                    labelText: 'Basic Description',
                    hintText: 'Enter basic description',
                    onChanged: (value) {
                      setState(() {
                        _basic_information = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Upload Crop Image'),
                  ),
                  if (_selectedImage != null) Image.network(_selectedImage!.path),
                  ListView.builder(
                    itemCount: _stages.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildStageInputFields(index);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _stages.add(Stage());
                      });
                    },
                    child: Text('Add Stage'),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Medium shade of green
                      textStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

