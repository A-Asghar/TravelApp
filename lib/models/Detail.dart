class Detail {
  Detail({
    this.data,
  });

  Data? data;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.propertyInfo,
  });

  PropertyInfo? propertyInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        propertyInfo: json["propertyInfo"] == null
            ? null
            : PropertyInfo.fromJson(json["propertyInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "propertyInfo": propertyInfo == null ? null : propertyInfo?.toJson(),
      };
}

class PropertyInfo {
  PropertyInfo({
    this.summary,
    this.propertyGallery,
  });

  Summary? summary;
  PropertyGallery? propertyGallery;

  factory PropertyInfo.fromJson(Map<String, dynamic> json) => PropertyInfo(
        summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        propertyGallery: json["propertyGallery"] == null
            ? null
            : PropertyGallery.fromJson(json["propertyGallery"]),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary == null ? null : summary?.toJson(),
        "propertyGallery": propertyGallery == null ? null : propertyGallery?.toJson(),
      };
}

class PropertyGallery {
  PropertyGallery({
    this.images,
  });

  List<ImageElement>? images;

  factory PropertyGallery.fromJson(Map<String, dynamic> json) =>
      PropertyGallery(
        images: json["images"] == null ? null
            : List<ImageElement>.from(json["images"].map((x) => ImageElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class ImageElement {
  ImageElement({
    this.image,
  });

  ImageImage? image;

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
        image: json["image"] == null ? null : ImageImage.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image?.toJson(),
      };
}

class ImageImage {
  ImageImage({
    this.url,
    this.description,
  });

  String? url;
  String? description;

  factory ImageImage.fromJson(Map<String, dynamic> json) => ImageImage(
        url: json["url"] == null ? null : json["url"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "description": description == null ? null : description,
      };
}

class Summary {
  Summary({
    this.location,
  });

  Location? location;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location?.toJson(),
      };
}

class Location {
  Location({
    this.address,
    this.coordinates,
  });

  Address? address;
  Coordinates? coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        coordinates: json["coordinates"] == null ? null : Coordinates.fromJson(json["coordinates"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address?.toJson(),
        "coordinates": coordinates == null ? null : coordinates?.toJson(),
      };
}

class Address {
  Address({
    this.addressLine,
    this.city,
    this.province,
    this.countryCode,
    this.firstAddressLine,
    this.secondAddressLine,
  });

  String? addressLine;
  String? city;
  String? province;
  String? countryCode;
  String? firstAddressLine;
  String? secondAddressLine;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine: json["addressLine"] == null ? null : json["addressLine"],
        city: json["city"] == null ? null : json["city"],
        province: json["province"] == null ? null : json["province"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        firstAddressLine:json["firstAddressLine"] == null ? null : json["firstAddressLine"],
        secondAddressLine: json["secondAddressLine"] == null ? null : json["secondAddressLine"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine": addressLine == null ? null : addressLine,
        "city": city == null ? null : city,
        "province": province == null ? null : province,
        "countryCode": countryCode == null ? null : countryCode,
        "firstAddressLine": firstAddressLine == null ? null : firstAddressLine,
        "secondAddressLine": secondAddressLine == null ? null : secondAddressLine,
      };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
