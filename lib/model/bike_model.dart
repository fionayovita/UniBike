class BikeResult {
  BikeResult({
    required this.bikes,
  });
// required this.error
  List<Bike> bikes;
  // String error;

  factory BikeResult.fromJson(Map<String, dynamic> json) => BikeResult(
        // bikes: List<Bike>.from(json["bikes"].map((x) => Bike.fromJson(x))),
        bikes: List<Bike>.from((json["bikes"] as List)
            .map((x) => Bike.fromJson(x))
            .where((bike) =>
                bike.frameModel != null &&
                bike.largeImg != null &&
                bike.title != null)),
        // error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "bikes": List<dynamic>.from(bikes.map((x) => x.toJson())),
        // "error": error,
      };
}

class Bike {
  Bike({
    // required this.frameColors,
    required this.frameModel,
    required this.id,
    required this.isStockImg,
    required this.largeImg,
    required this.title,
  });

  // List<String>? frameColors;
  String? frameModel;
  int id;
  bool isStockImg;
  String? largeImg;
  String? title;

  factory Bike.fromJson(Map<String, dynamic> json) => Bike(
        // frameColors: List<String>.from(json["frame_colors"].map((x) => x)),
        frameModel: json["frame_model"],
        id: json["id"],
        isStockImg: json["is_stock_img"],
        largeImg: json["large_img"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        // "frame_colors": List<dynamic>.from(frameColors.map((x) => x)),
        "frame_model": frameModel,
        "id": id,
        "is_stock_img": isStockImg,
        "large_img": largeImg,
        "title": title,
      };
}
