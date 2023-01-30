class PropertyUnits {
  PropertyUnits({
    this.units,
  });

  // List of hotel Rooms
  List<Unit>? units;

  factory PropertyUnits.fromJson(Map<String, dynamic> json) => PropertyUnits(
        units: json["units"] == null
            ? null
            : List<Unit>.from(json["units"].map((x) => Unit.fromJson(x))),
      );
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
  Header? header;
  UnitGallery? unitGallery;
  List<RatePlan>? ratePlans;
  RoomAmenities? roomAmenities;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        typename: json["__typename"] == null ? null : json["__typename"],
        description: json["description"] == null ? null : json["description"],
        id: json["id"] == null ? null : json["id"],
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        unitGallery: json["unitGallery"] == null
            ? null
            : UnitGallery.fromJson(json["unitGallery"]),
        ratePlans: json["ratePlans"] == null
            ? null
            : List<RatePlan>.from(
                json["ratePlans"].map((x) => RatePlan.fromJson(x))),
        roomAmenities: json["roomAmenities"] == null
            ? null
            : RoomAmenities.fromJson(json["roomAmenities"]),
      );
}

class Header {
  Header({
    this.typename,
    this.text,
  });

  HeaderTypename? typename;
  String? text;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        typename: json["__typename"] == null
            ? null
            : headerTypenameValues.map![json["__typename"]],
        text: json["text"] == null ? null : json["text"],
      );
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
        amenities: json["amenities"] == null
            ? null
            : List<Amenity>.from(
                json["amenities"].map((x) => Amenity.fromJson(x))),
        highlightedMessages: json["highlightedMessages"] == null
            ? null
            : List<HighlightedMessage>.from(json["highlightedMessages"]
                .map((x) => HighlightedMessage.fromJson(x))),
        priceDetails: json["priceDetails"] == null
            ? null
            : List<PriceDetail>.from(
                json["priceDetails"].map((x) => PriceDetail.fromJson(x))),
      );
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
}

class HighlightedMessage {
  HighlightedMessage({
    this.typename,
    this.content,
  });

  String? typename;
  List<String>? content;

  factory HighlightedMessage.fromJson(Map<String, dynamic> json) =>
      HighlightedMessage(
        typename: json["__typename"] == null ? null : json["__typename"],
        content: json["content"] == null
            ? null
            : List<String>.from(json["content"].map((x) => x)),
      );
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
        availability: json["availability"] == null
            ? null
            : Availability.fromJson(json["availability"]),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : CancellationPolicy.fromJson(json["cancellationPolicy"]),
        noCreditCard:
            json["noCreditCard"] == null ? null : json["noCreditCard"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
        totalPriceMessage: json["totalPriceMessage"] == null
            ? null
            : json["totalPriceMessage"],
      );
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
        minRoomsLeft:
            json["minRoomsLeft"] == null ? null : json["minRoomsLeft"],
        scarcityMessage:
            json["scarcityMessage"] == null ? null : json["scarcityMessage"],
      );
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

  factory CancellationPolicy.fromJson(Map<String, dynamic> json) =>
      CancellationPolicy(
        typename: json["__typename"] == null ? null : json["__typename"],
        cancellationWindow: json["cancellationWindow"] == null
            ? null
            : CancellationWindow.fromJson(json["cancellationWindow"]),
        type: json["type"] == null ? null : json["type"],
      );
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

  factory CancellationWindow.fromJson(Map<String, dynamic> json) =>
      CancellationWindow(
        typename: json["__typename"] == null ? null : json["__typename"],
        day: json["day"] == null ? null : json["day"],
        hour: json["hour"] == null ? null : json["hour"],
        minute: json["minute"] == null ? null : json["minute"],
        month: json["month"] == null ? null : json["month"],
        year: json["year"] == null ? null : json["year"],
        fullDateFormat:
            json["fullDateFormat"] == null ? null : json["fullDateFormat"],
      );
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
        roomNightMessage:
            json["roomNightMessage"] == null ? null : json["roomNightMessage"],
        strikeOutType:
            json["strikeOutType"] == null ? null : json["strikeOutType"],
        total: json["total"] == null ? null : Total.fromJson(json["total"]),
        priceMessaging: json["priceMessaging"],
      );
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
        currencyInfo: json["currencyInfo"] == null
            ? null
            : CurrencyInfo.fromJson(json["currencyInfo"]),
        formatted: json["formatted"] == null ? null : json["formatted"],
      );
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
        bodySubSections: json["bodySubSections"] == null
            ? null
            : List<BodySubSection>.from(
                json["bodySubSections"].map((x) => BodySubSection.fromJson(x))),
      );
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
        contents: json["contents"] == null
            ? null
            : List<Content>.from(
                json["contents"].map((x) => Content.fromJson(x))),
      );
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
        typename: json["__typename"] == null
            ? null
            : purpleTypenameValues.map![json["__typename"]],
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  Item({
    this.typename,
    this.content,
  });

  ItemTypename? typename;
  Header? content;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        typename: json["__typename"] == null
            ? null
            : itemTypenameValues.map![json["__typename"]],
        content:
            json["content"] == null ? null : Header.fromJson(json["content"]),
      );
}

enum ItemTypename { PROPERTY_CONTENT_ITEM_MARKUP }

final itemTypenameValues = EnumValues(
    {"PropertyContentItemMarkup": ItemTypename.PROPERTY_CONTENT_ITEM_MARKUP});

enum PurpleTypename { PROPERTY_CONTENT }

final purpleTypenameValues =
    EnumValues({"PropertyContent": PurpleTypename.PROPERTY_CONTENT});

class UnitGallery {
  UnitGallery({
    this.typename,
    this.gallery,
  });

  String? typename;
  List<Gallery>? gallery;

  factory UnitGallery.fromJson(Map<String, dynamic> json) => UnitGallery(
        typename: json["__typename"] == null ? null : json["__typename"],
        gallery: json["gallery"] == null
            ? null
            : List<Gallery>.from(
                json["gallery"].map((x) => Gallery.fromJson(x))),
      );
}

class Gallery {
  Gallery({
    this.typename,
    this.image,
  });

  String? typename;
  UnitImage? image;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        typename: json["__typename"] == null ? null : json["__typename"],
        image: json["image"] == null ? null : UnitImage.fromJson(json["image"]),
      );
}

class UnitImage {
  UnitImage({
    this.typename,
    this.url,
  });

  String? typename;
  String? url;

  factory UnitImage.fromJson(Map<String, dynamic> json) => UnitImage(
        typename: json["__typename"] == null ? null : json["__typename"],
        url: json["url"] == null ? null : json["url"],
      );
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
