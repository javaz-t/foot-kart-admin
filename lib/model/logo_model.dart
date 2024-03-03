class LogoModel {
  final String id;
  final String logoName;
  final String logoUrl;

  LogoModel({this.id = '', required this.logoName, required this.logoUrl});

  // fromJson method
  factory LogoModel.fromJson(Map<String, dynamic> json) {
    return LogoModel(
      id: json['id'],
      logoName: json['logoName'],
      logoUrl: json['logoUrl'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logoName': logoName,
      'logoUrl': logoUrl,
    };
  }
}
