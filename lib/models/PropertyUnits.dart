class PropertyUnits {
  PropertyUnits({
    this.units,
  });

  // List of hotel Rooms
  List<Unit>? units;

  factory PropertyUnits.fromJson(Map<String, dynamic> json) => PropertyUnits(
    units: json["units"] == null ? null : List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "units": units == null ? null : List<dynamic>.from(units!.map((x) => x.toJson())),
  };
}

class Unit {

  // Singular Hotel Room
  Unit({
    this.typename,
    this.description,
    this.id,
    this.header,
    this.unitGallery,
    this.ratePlans,
    this.roomAmenities,
  });

  String? typename;
  String? description;
  String? id;
  Header?header;
  UnitGallery? unitGallery;
  List<RatePlan>? ratePlans;
  RoomAmenities? roomAmenities;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    typename: json["__typename"] == null ? null : json["__typename"],
    description: json["description"] == null ? null : json["description"],
    id: json["id"] == null ? null : json["id"],
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    unitGallery: json["unitGallery"] == null ? null : UnitGallery.fromJson(json["unitGallery"]),
    ratePlans: json["ratePlans"] == null ? null : List<RatePlan>.from(json["ratePlans"].map((x) => RatePlan.fromJson(x))),
    roomAmenities: json["roomAmenities"] == null ? null : RoomAmenities.fromJson(json["roomAmenities"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "description": description == null ? null : description,
    "id": id == null ? null : id,
    "header": header == null ? null : header?.toJson(),
    "unitGallery": unitGallery == null ? null : unitGallery?.toJson(),
    "ratePlans": ratePlans == null ? null : List<dynamic>.from(ratePlans!.map((x) => x.toJson())),
    "roomAmenities": roomAmenities == null ? null : roomAmenities?.toJson(),
  };
}

class Header {
  Header({
    this.typename,
    this.text,
  });

  HeaderTypename? typename;
  String? text;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    typename: json["__typename"] == null ? null : headerTypenameValues.map![json["__typename"]],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : headerTypenameValues.reverse![typename],
    "text": text == null ? null : text,
  };
}

enum HeaderTypename { LODGING_HEADER, MARKUP_TEXT }

final headerTypenameValues = EnumValues({
  "LodgingHeader": HeaderTypename.LODGING_HEADER,
  "MarkupText": HeaderTypename.MARKUP_TEXT
});

class RatePlan {
  RatePlan({
    this.typename,
    this.id,
    this.amenities,
    this.highlightedMessages,
    this.priceDetails,
  });

  String? typename;
  String? id;
  List<Amenity>? amenities;
  List<HighlightedMessage>? highlightedMessages;
  List<PriceDetail>? priceDetails;

  factory RatePlan.fromJson(Map<String, dynamic> json) => RatePlan(
    typename: json["__typename"] == null ? null : json["__typename"],
    id: json["id"] == null ? null : json["id"],
    amenities: json["amenities"] == null ? null : List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
    highlightedMessages: json["highlightedMessages"] == null ? null : List<HighlightedMessage>.from(json["highlightedMessages"].map((x) => HighlightedMessage.fromJson(x))),
    priceDetails: json["priceDetails"] == null ? null : List<PriceDetail>.from(json["priceDetails"].map((x) => PriceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "id": id == null ? null : id,
    "amenities": amenities == null ? null : List<dynamic>.from(amenities!.map((x) => x.toJson())),
    "highlightedMessages": highlightedMessages == null ? null : List<dynamic>.from(highlightedMessages!.map((x) => x.toJson())),
    "priceDetails": priceDetails == null ? null : List<dynamic>.from(priceDetails!.map((x) => x.toJson())),
  };
}

class Amenity {
  Amenity({
    this.typename,
    this.category,
    this.description,
  });

  String? typename;
  String? category;
  String? description;

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
    typename: json["__typename"] == null ? null : json["__typename"],
    category: json["category"] == null ? null : json["category"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "category": category == null ? null : category,
    "description": description == null ? null : description,
  };
}

class HighlightedMessage {
  HighlightedMessage({
    this.typename,
    this.content,
  });

  String? typename;
  List<String>? content;

  factory HighlightedMessage.fromJson(Map<String, dynamic> json) => HighlightedMessage(
    typename: json["__typename"] == null ? null : json["__typename"],
    content: json["content"] == null ? null : List<String>.from(json["content"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "content": content == null ? null : List<dynamic>.from(content!.map((x) => x)),
  };
}

class PriceDetail {
  PriceDetail({
    this.typename,
    this.availability,
    this.cancellationPolicy,
    this.noCreditCard,
    this.price,
    this.totalPriceMessage,
  });

  String? typename;
  Availability? availability;
  CancellationPolicy? cancellationPolicy;
  bool? noCreditCard;
  Price? price;
  String? totalPriceMessage;

  factory PriceDetail.fromJson(Map<String, dynamic> json) => PriceDetail(
    typename: json["__typename"] == null ? null : json["__typename"],
    availability: json["availability"] == null ? null : Availability.fromJson(json["availability"]),
    cancellationPolicy: json["cancellationPolicy"] == null ? null : CancellationPolicy.fromJson(json["cancellationPolicy"]),
    noCreditCard: json["noCreditCard"] == null ? null : json["noCreditCard"],
    price: json["price"] == null ? null : Price.fromJson(json["price"]),
    totalPriceMessage: json["totalPriceMessage"] == null ? null : json["totalPriceMessage"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "availability": availability == null ? null : availability?.toJson(),
    "cancellationPolicy": cancellationPolicy == null ? null : cancellationPolicy?.toJson(),
    "noCreditCard": noCreditCard == null ? null : noCreditCard,
    "price": price == null ? null : price?.toJson(),
    "totalPriceMessage": totalPriceMessage == null ? null : totalPriceMessage,
  };
}

class Availability {
  Availability({
    this.typename,
    this.available,
    this.minRoomsLeft,
    this.scarcityMessage,
  });

  String? typename;
  bool? available;
  int? minRoomsLeft;
  String? scarcityMessage;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    typename: json["__typename"] == null ? null : json["__typename"],
    available: json["available"] == null ? null : json["available"],
    minRoomsLeft: json["minRoomsLeft"] == null ? null : json["minRoomsLeft"],
    scarcityMessage: json["scarcityMessage"] == null ? null : json["scarcityMessage"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "available": available == null ? null : available,
    "minRoomsLeft": minRoomsLeft == null ? null : minRoomsLeft,
    "scarcityMessage": scarcityMessage == null ? null : scarcityMessage,
  };
}

class CancellationPolicy {
  CancellationPolicy({
    this.typename,
    this.cancellationWindow,
    this.type,
  });

  String? typename;
  CancellationWindow? cancellationWindow;
  String? type;

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) => CancellationPolicy(
    typename: json["__typename"] == null ? null : json["__typename"],
    cancellationWindow: json["cancellationWindow"] == null ? null : CancellationWindow.fromJson(json["cancellationWindow"]),
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "cancellationWindow": cancellationWindow == null ? null : cancellationWindow?.toJson(),
    "type": type == null ? null : type,
  };
}

class CancellationWindow {
  CancellationWindow({
    this.typename,
    this.day,
    this.hour,
    this.minute,
    this.month,
    this.year,
    this.fullDateFormat,
  });

  String? typename;
  int? day;
  int? hour;
  int? minute;
  int? month;
  int? year;
  String? fullDateFormat;

  factory CancellationWindow.fromJson(Map<String, dynamic> json) => CancellationWindow(
    typename: json["__typename"] == null ? null : json["__typename"],
    day: json["day"] == null ? null : json["day"],
    hour: json["hour"] == null ? null : json["hour"],
    minute: json["minute"] == null ? null : json["minute"],
    month: json["month"] == null ? null : json["month"],
    year: json["year"] == null ? null : json["year"],
    fullDateFormat: json["fullDateFormat"] == null ? null : json["fullDateFormat"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "day": day == null ? null : day,
    "hour": hour == null ? null : hour,
    "minute": minute == null ? null : minute,
    "month": month == null ? null : month,
    "year": year == null ? null : year,
    "fullDateFormat": fullDateFormat == null ? null : fullDateFormat,
  };
}

class Price {
  Price({
    this.typename,
    this.lead,
    this.roomNightMessage,
    this.strikeOutType,
    this.total,
    this.priceMessaging,
  });

  String? typename;
  Lead? lead;
  String? roomNightMessage;
  String? strikeOutType;
  Total? total;
  dynamic priceMessaging;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    typename: json["__typename"] == null ? null : json["__typename"],
    lead: json["lead"] == null ? null : Lead.fromJson(json["lead"]),
    roomNightMessage: json["roomNightMessage"] == null ? null : json["roomNightMessage"],
    strikeOutType: json["strikeOutType"] == null ? null : json["strikeOutType"],
    total: json["total"] == null ? null : Total.fromJson(json["total"]),
    priceMessaging: json["priceMessaging"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "lead": lead == null ? null : lead?.toJson(),
    "roomNightMessage": roomNightMessage == null ? null : roomNightMessage,
    "strikeOutType": strikeOutType == null ? null : strikeOutType,
    "total": total == null ? null : total?.toJson(),
    "priceMessaging": priceMessaging,
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
  var amount;
  CurrencyInfo? currencyInfo;
  String? formatted;

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
    typename: json["__typename"] == null ? null : json["__typename"],
    amount: json["amount"] == null ? null : json["amount"],
    currencyInfo: json["currencyInfo"] == null ? null : CurrencyInfo.fromJson(json["currencyInfo"]),
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

class Total {
  Total({
    this.typename,
    this.amount,
  });

  String? typename;
  double? amount;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
    typename: json["__typename"] == null ? null : json["__typename"],
    amount: json["amount"] == null ? null : json["amount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "amount": amount == null ? null : amount,
  };
}

class RoomAmenities {
  RoomAmenities({
    this.typename,
    this.bodySubSections,
  });

  String? typename;
  List<BodySubSection>? bodySubSections;

  factory RoomAmenities.fromJson(Map<String, dynamic> json) => RoomAmenities(
    typename: json["__typename"] == null ? null : json["__typename"],
    bodySubSections: json["bodySubSections"] == null ? null : List<BodySubSection>.from(json["bodySubSections"].map((x) => BodySubSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "bodySubSections": bodySubSections == null ? null : List<dynamic>.from(bodySubSections!.map((x) => x.toJson())),
  };
}

class BodySubSection {
  BodySubSection({
    this.typename,
    this.contents,
  });

  String? typename;
  List<Content>? contents;

  factory BodySubSection.fromJson(Map<String, dynamic> json) => BodySubSection(
    typename: json["__typename"] == null ? null : json["__typename"],
    contents: json["contents"] == null ? null : List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "contents": contents == null ? null : List<dynamic>.from(contents!.map((x) => x.toJson())),
  };
}

class Content {
  Content({
    this.typename,
    this.header,
    this.items,
  });

  PurpleTypename? typename;
  Header? header;
  List<Item>? items;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    typename: json["__typename"] == null ? null : purpleTypenameValues.map![json["__typename"]],
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : purpleTypenameValues.reverse![typename],
    "header": header == null ? null : header?.toJson(),
    "items": items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.typename,
    this.content,
  });

  ItemTypename? typename;
  Header? content;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    typename: json["__typename"] == null ? null : itemTypenameValues.map![json["__typename"]],
    content: json["content"] == null ? null : Header.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : itemTypenameValues.reverse![typename],
    "content": content == null ? null : content?.toJson(),
  };
}

enum ItemTypename { PROPERTY_CONTENT_ITEM_MARKUP }

final itemTypenameValues = EnumValues({
  "PropertyContentItemMarkup": ItemTypename.PROPERTY_CONTENT_ITEM_MARKUP
});

enum PurpleTypename { PROPERTY_CONTENT }

final purpleTypenameValues = EnumValues({
  "PropertyContent": PurpleTypename.PROPERTY_CONTENT
});

class UnitGallery {
  UnitGallery({
    this.typename,
    this.gallery,
  });

  String? typename;
  List<Gallery>? gallery;

  factory UnitGallery.fromJson(Map<String, dynamic> json) => UnitGallery(
    typename: json["__typename"] == null ? null : json["__typename"],
    gallery: json["gallery"] == null ? null : List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "gallery": gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x.toJson())),
  };
}

class Gallery {
  Gallery({
    this.typename,
    this.image,
  });

  String? typename;
  Image? image;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    typename: json["__typename"] == null ? null : json["__typename"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "image": image == null ? null : image?.toJson(),
  };
}

class Image {
  Image({
    this.typename,
    this.url,
  });

  String? typename;
  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    typename: json["__typename"] == null ? null : json["__typename"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "__typename": typename == null ? null : typename,
    "url": url == null ? null : url,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
