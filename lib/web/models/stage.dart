import 'dart:io';

import '../../constants.dart';

class Stage {
  String description = '';
  File? image;
  int duration = 0;
  List<String> products = [];
  String? method;
  String? stageName;
}
//another stage model using enums
class cStage {
  final String name;
  final String description;
  final List<ProductApplication> applicableApplications;
  final List<TargetAreas> targetAreas;

cStage({
    required this.name,
    required this.description,
    required this.applicableApplications,
    required this.targetAreas,
  });
}