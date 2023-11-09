import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import '../../widgets/input_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Stage {
  String description = '';
  File? image;
  int duration = 0;
  List<String> products = [];
  String? method;
  late String stageName;
}
class Schedule {
  String description = '';
  File? image;
  int duration = 0;
  List<String> products = [];
  String? method;
  late String scheduleName;
}

Color darkGreen = Color(0xFF006400);

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _crop_name = '';
  String _crop_type = '';
  String _basic_information = '';
  List<Schedule> _crop_schedule = [Schedule(), Schedule()];
   List<Stage> _stages = [];
  // List<Stage> _stages = [Stage(), Stage()];
  File? _selectedImage;
  String _base64Image = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      setState(() {
        _selectedImage = imageFile;
        _base64Image = base64Image;
      });
    }
  }

  // void _submitForm() {
  //
  //   if (_formKey.currentState!.validate()) {
  //     print('Crop Name: $_crop_name');
  //     print('Crop Type: $_crop_type');
  //     print('Basic Description: $_basic_information');
  //     print('Base64 Image: $_base64Image');
  //
  //     for (int i = 0; i < _crop_schedule.length; i++) {
  //       print('Schedule $i Description: ${_crop_schedule[i].description}');
  //       print('Schedule $i Duration: ${_crop_schedule[i].duration}');
  //       print('Schedule $i Products: ${_crop_schedule[i].products.join(', ')}');
  //       if (i >= 2) {
  //         print('Schedule $i Schedule Name: ${_crop_schedule[i].stageName}');
  //
  //       }
  //       print('Schedule $i Method: ${_crop_schedule[i].method}');
  //     }
  //     for (int i = 0; i < _stages.length; i++) {
  //       print('Stage $i Stage Name: ${_crop_schedule[i].stageName}');
  //       print('Stage $i Description: ${_stages[i].description}');
  //       print('Stage $i Duration: ${_stages[i].duration}');
  //       print('Stage $i Products: ${_stages[i].products.join(', ')}');
  //
  //
  //
  //     }
  //
  //   }
  // }
  Future<void> _sendFormData() async {
    if (_formKey.currentState!.validate()) {
      // Prepare your form data to send to the backend
      Map<String, dynamic> cropScheduleObject = {};
      _crop_schedule[0].scheduleName="Soil preparation";
      _crop_schedule[1].scheduleName="Bed preparation";
      for (int i = 0; i < _crop_schedule.length; i++) {
        cropScheduleObject[_crop_schedule[i].scheduleName] = {
          //'description': _crop_schedule[i].description,
          'duration': _crop_schedule[i].duration,
          'products': _crop_schedule[i].products,
          'method': _crop_schedule[i].method,
           'image': _base64Image,

          //'stageName': _crop_schedule[i].stageName,
          // Add other properties as needed
        };
      }
      Map<String, dynamic> stagesObject = {};

      for (int i = 0; i < _stages.length; i++) {
        stagesObject[_stages[i].stageName] = {
          'description': _stages[i].description,
          'duration': _stages[i].duration,
          'products': _stages[i].products,
          //'stageName': _stages[i].stageName,
           'image': _base64Image,
          'image': Image.network('https://www.w3schools.com/w3css/img_lights.jpg')
          // Add other properties as needed
        };
      }

// Now, you can use stagesObject as an object instead of an array


// Now, you can use cropScheduleObject as an object instead of an array

      final formData = {
        'cropName': _crop_name,
        'cropType': _crop_type,
        'basicDescription': _basic_information,

        // 'cropSchedule': _crop_schedule.map((stage) {
        //   return {
        //     //'description': stage.description,
        //     'duration': stage.duration,
        //     'products': stage.products,
        //     'method': stage.method,
        //    // 'base64Image': _base64Image,
        //     //'stageName': stage.stageName,
        //     // Add other properties as needed
        //   };
        // }).toList(),

        'cropSchedule': cropScheduleObject,
        // 'stages': _stages.map((stage) {
        //   return {
        //     'description': stage.description,
        //     'duration': stage.duration,
        //     'products': stage.products,
        //
        //     //'stageName': stage.stageName,
        //     'image': _base64Image,
        //     // Add other properties as needed
        //   };
        // }).toList(),
        'stages': stagesObject,
      };

      try {
        print('this is prince');
        final response = await http.post(

          Uri.parse('http://localhost:8080/api/crops'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(formData),
        );
        print('this is ankit');
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
    }
  }

  Widget _buildCropScheduleInputFields(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                index == 0
                    ? 'Soil preparation'
                    : index == 1
                        ? 'Bed preparation'
                        : '',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.green), // Set text color to green
              ),
            ),
            if (index >= 2)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _crop_schedule.removeAt(index);
                  });
                },
              ),
          ],
        ),


        if(index>=2)
          InputField(
            labelText: 'Schedule Name',
            hintText: 'Enter stage name for stage ${index + 1}',
            onChanged: (value) {
              setState(() {
                _crop_schedule[index].scheduleName = value;
              });
            },
          ),
        InputField(
          labelText: 'Method',
          hintText: 'Enter method for stage ${index + 1}',
          onChanged: (value) {
            setState(() {
              _crop_schedule[index].method = value;
            });
          },
        ),
        InputField(
          labelText: 'Description',
          hintText: 'Enter description for stage ${index + 1}',
          onChanged: (value) {
            setState(() {
              _crop_schedule[index].description = value;
            });
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Duration',
            hintText: 'Enter duration for stage ${index + 1} in months',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              _crop_schedule[index].duration = int.tryParse(value) ?? 0;
            });
          },
        ),
        InputField(
          labelText: 'Products',
          hintText: 'Enter products for stage ${index + 1} (comma-separated)',
          onChanged: (value) {
            setState(() {
              _crop_schedule[index].products =
                  value.split(',').map((e) => e.trim()).toList();
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
                _crop_schedule[index].image = imageFile;
              });
            }
          },
          child: Text('Upload Stage Image'),
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // Button color
            onPrimary: Colors.white, // Text color
          ),
        ),
        if (_crop_schedule[index].image != null) Image.file(_crop_schedule[index].image!),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStageInputFields(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                index == 0
                    ? ''
                    : index == 1
                    ? ''
                    : '',
                style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.green), // Set text color to green
              ),
            ),

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
            labelText: 'Stage Name',
            hintText: 'Enter stage name for stage ${index + 1}',
            onChanged: (value) {
              setState(() {
                _stages[index].stageName = value;
              });
            },
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
            hintText: 'Enter duration for stage ${index + 1} in months',
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
              _stages[index].products =
                  value.split(',').map((e) => e.trim()).toList();
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
          style: ElevatedButton.styleFrom(
            primary: Colors.green, // Button color
            onPrimary: Colors.white, // Text color
          ),
        ),
        if (_stages[index].image != null) Image.file(_stages[index].image!),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
    padding: EdgeInsets.only(top: 30.0), // Add padding to the top
    child: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.green[100], // Lighter shade of green
          borderRadius: BorderRadius.circular(16.0),
        ),

          child: SingleChildScrollView(
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Button color
                      onPrimary: Colors.white, // Text color
                    ),
                  ),
                  if (_selectedImage != null) Image.file(_selectedImage!),
                  SizedBox(height: 20),
                  ListView.builder(
                    itemCount: _crop_schedule.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildCropScheduleInputFields(index);
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _crop_schedule.add(Schedule());
                      });
                    },
                    child: Text('Add Crop Schedule'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Button color
                      onPrimary: Colors.white, // Text color
                    ),
                  ),
                  SizedBox(height: 20),
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Button color
                      onPrimary: Colors.white, // Text color
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _sendFormData,
                    style: ElevatedButton.styleFrom(
                      primary: darkGreen, // Button color
                      onPrimary: Colors.white, // Text color
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: FormScreen()));
