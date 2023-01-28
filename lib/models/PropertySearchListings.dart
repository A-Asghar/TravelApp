class PropertySearchListing {
  // This is the "Hotel" Object
  PropertySearchListing({
    this.typename,
    this.id,
    this.name,
    this.availability,
    this.propertyImage,
    this.mapMarker,
    this.price,
    this.reviews,
    this.regionId,
    this.priceMetadata,
  });

  String? typename;
  String? id;
  String? name;
  Availability? availability;
  PropertyImage? propertyImage;
  MapMarker? mapMarker;
  Price? price;
  PropertyReviews? reviews;
  String? regionId;
  PriceMetadata? priceMetadata;

  factory PropertySearchListing.fromJson(Map<String, dynamic> json) =>
      PropertySearchListing(
        typename: json["__typename"] == null ? null : json["__typename"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        propertyImage: json["propertyImage"] == null
            ? null
            : PropertyImage.fromJson(json["propertyImage"]),
        mapMarker: json["mapMarker"] == null
            ? null
            : MapMarker.fromJson(json["mapMarker"]),
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        reviews: json["reviews"] == null
            ? null
            : PropertyReviews.fromJson(json["reviews"]),
        regionId: json["regionId"] == null ? null : json["regionId"],
        priceMetadata: json["priceMetadata"] == null
            ? null
            : PriceMetadata.fromJson(json["priceMetadata"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "availability": availability == null ? null : availability?.toJson(),
        "propertyImage": propertyImage == null ? null : propertyImage?.toJson(),
        "mapMarker": mapMarker == null ? null : mapMarker?.toJson(),
        "price": price == null ? null : price?.toJson(),
        "reviews": reviews == null ? null : reviews?.toJson(),
        "regionId": regionId == null ? null : regionId,
        "priceMetadata": priceMetadata == null ? null : priceMetadata?.toJson(),
      };
}

class Availability {
  Availability({
    this.typename,
    this.available,
    this.minRoomsLeft,
  });

  String? typename;
  bool? available;
  int? minRoomsLeft;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        typename: json["__typename"] == null ? null : json["__typename"],
        available: json["available"] == null ? null : json["available"],
        minRoomsLeft:
            json["minRoomsLeft"] == null ? null : json["minRoomsLeft"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "available": available == null ? null : available,
        "minRoomsLeft": minRoomsLeft == null ? null : minRoomsLeft,
      };
}

class MapMarker {
  MapMarker({
    this.latLong,
  });

  LatLong? latLong;

  factory MapMarker.fromJson(Map<String, dynamic> json) => MapMarker(
        latLong:
            json["latLong"] == null ? null : LatLong.fromJson(json["latLong"]),
      );

  Map<String, dynamic> toJson() => {
        "latLong": latLong == null ? null : latLong?.toJson(),
      };
}

class LatLong {
  LatLong({
    this.typename,
    this.latitude,
    this.longitude,
  });

  String? typename;
  double? latitude;
  double? longitude;

  factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
        typename: json["__typename"] == null ? null : json["__typename"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}

class Price {
  Price({
    this.typename,
    this.options,
    this.lead,
    this.strikeOut,
  });

  String? typename;
  List<Option>? options;
  Lead? lead;
  Lead? strikeOut;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        typename: json["__typename"] == null ? null : json["__typename"],
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
        strikeOut:
            json["strikeOut"] == null ? null : Lead.fromJson(json["strikeOut"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "lead": lead == null ? null : lead?.toJson(),
        "strikeOut": strikeOut == null ? null : strikeOut?.toJson(),
      };
}

class Lead {
  Lead({
    this.typename,
    this.amount,
    this.currencyInfo,
    this.formatted,
  });

  String? typename;
  double? amount;
  CurrencyInfo? currencyInfo;
  String? formatted;

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
        typename: json["__typename"] == null ? null : json["__typename"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        currencyInfo: json["currencyInfo"] == null
            ? null
            : CurrencyInfo.fromJson(json["currencyInfo"]),
        formatted: json["formatted"] == null ? null : json["formatted"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "amount": amount == null ? null : amount,
        "currencyInfo": currencyInfo == null ? null : currencyInfo?.toJson(),
        "formatted": formatted == null ? null : formatted,
      };
}

class CurrencyInfo {
  CurrencyInfo({
    this.typename,
    this.code,
    this.symbol,
  });

  String? typename;
  String? code;
  String? symbol;

  factory CurrencyInfo.fromJson(Map<String, dynamic> json) => CurrencyInfo(
        typename: json["__typename"] == null ? null : json["__typename"],
        code: json["code"] == null ? null : json["code"],
        symbol: json["symbol"] == null ? null : json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "code": code == null ? null : code,
        "symbol": symbol == null ? null : symbol,
      };
}

class Option {
  Option({
    this.typename,
    this.strikeOut,
    this.formattedDisplayPrice,
  });

  String? typename;
  Lead? strikeOut;
  String? formattedDisplayPrice;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        typename: json["__typename"] == null ? null : json["__typename"],
        strikeOut:
            json["strikeOut"] == null ? null : Lead.fromJson(json["strikeOut"]),
        formattedDisplayPrice: json["formattedDisplayPrice"] == null
            ? null
            : json["formattedDisplayPrice"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "strikeOut": strikeOut == null ? null : strikeOut?.toJson(),
        "formattedDisplayPrice":
            formattedDisplayPrice == null ? null : formattedDisplayPrice,
      };
}

class PriceMetadata {
  PriceMetadata({
    this.typename,
    this.totalDiscountPercentage,
  });

  String? typename;
  int? totalDiscountPercentage;

  factory PriceMetadata.fromJson(Map<String, dynamic> json) => PriceMetadata(
        typename: json["__typename"] == null ? null : json["__typename"],
        totalDiscountPercentage: json["totalDiscountPercentage"] == null
            ? null
            : json["totalDiscountPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "totalDiscountPercentage":
            totalDiscountPercentage == null ? null : totalDiscountPercentage,
      };
}

class PropertyImage {
  PropertyImage({
    this.typename,
    this.image,
  });

  String? typename;
  ImageUrl? image;

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
        typename: json["__typename"] == null ? null : json["__typename"],
        image: json["image"] == null ? null : ImageUrl.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "image": image == null ? null : image?.toJson(),
      };
}

class ImageUrl {
  ImageUrl({
    this.typename,
    this.url,
  });

  String? typename;
  String? url;

  factory ImageUrl.fromJson(Map<String, dynamic> json) => ImageUrl(
        typename: json["__typename"] == null ? null : json["__typename"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "url": url == null ? null : url,
      };
}

class PropertyReviews {
  PropertyReviews({
    this.typename,
    this.score,
    this.total,
  });

  String? typename;
  var score;
  int? total;

  factory PropertyReviews.fromJson(Map<String, dynamic> json) =>
      PropertyReviews(
        typename: json["__typename"] == null ? null : json["__typename"],
        score: json["score"] == null ? null : json["score"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename == null ? null : typename,
        "score": score == null ? null : score,
        "total": total == null ? null : total,
      };
}
