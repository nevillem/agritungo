class BreedModel{
  String id;
  String colorName;
  BreedModel({required this.id, required this.colorName});

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] as String,
      colorName: json['name'] as String,
    );
  }
}