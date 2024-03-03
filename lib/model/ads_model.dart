class AdsModel {
  final String id;
  final List<String> adUrl;

  AdsModel({required this.id, required this.adUrl});

  // Convert model to a Map for serialization
  Map<String, dynamic> toJson() => {
        'id': id,
        'adUrl': adUrl,
      };

  // Create an AdsModel object from a Map
  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        id: json['id'] ,
        adUrl: json['adUrl'] ,
      );
}
