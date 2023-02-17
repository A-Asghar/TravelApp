class Cities {
  Cities({
    this.data,
    this.meta,
  });

  List<City>? data;
  Meta? meta;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        data: json["data"] == null
            ? []
            : List<City>.from(json["data"]!.map((x) => City.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );
}

class City {
  City({
    this.subtype,
    this.name,
    this.iataCode,
    this.geoCode,
    this.type,
    this.relevance,
  });

  String? subtype;
  String? name;
  String? iataCode;
  GeoCode? geoCode;
  String? type;
  double? relevance;

  factory City.fromJson(Map<String, dynamic> json) => City(
        subtype: json["subtype"],
        name: json["name"],
        iataCode: json["iataCode"],
        geoCode:
            json["geoCode"] == null ? null : GeoCode.fromJson(json["geoCode"]),
        type: json["type"],
        relevance: json["relevance"]?.toDouble(),
      );
}

class GeoCode {
  GeoCode({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory GeoCode.fromJson(Map<String, dynamic> json) => GeoCode(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );
}

class Meta {
  Meta({
    this.count,
    this.links,
  });

  int? count;
  Links? links;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        count: json["count"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );
}

class Links {
  Links({
    this.self,
  });

  String? self;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
      );
}
