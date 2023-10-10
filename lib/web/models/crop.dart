class Crop {
  final String name;
  final String type;
  final String description;
  bool isSelected;

  Crop({
    required this.name,
    required this.type,
    required this.description,
    this.isSelected = false,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      name: json['name'],
      type: json['type'],
      description: json['description'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'isSelected': isSelected,
    };
  }
}

