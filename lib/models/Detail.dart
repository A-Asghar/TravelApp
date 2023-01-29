// To parse this JSON data, do
//
//     final detail = detailFromJson(jsonString);

import 'dart:convert';

Detail detailFromJson(String str) => Detail.fromJson(json.decode(str));

String detailToJson(Detail data) => json.encode(data.toJson());

class Detail {
  Detail({
    this.data,
  });

  Data? data;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.propertyInfo,
  });

  PropertyInfo? propertyInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    propertyInfo: json["propertyInfo"] == null ? null : PropertyInfo.fromJson(json["propertyInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "propertyInfo": propertyInfo?.toJson(),
  };
}

class PropertyInfo {
  PropertyInfo({
    this.summary,
    this.propertyGallery,
    this.propertyContentSectionGroups,
  });

  Summary? summary;
  PropertyGallery? propertyGallery;
  PropertyContentSectionGroups? propertyContentSectionGroups;

  factory PropertyInfo.fromJson(Map<String, dynamic> json) => PropertyInfo(
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    propertyGallery: json["propertyGallery"] == null ? null : PropertyGallery.fromJson(json["propertyGallery"]),
    propertyContentSectionGroups: json["propertyContentSectionGroups"] == null ? null : PropertyContentSectionGroups.fromJson(json["propertyContentSectionGroups"]),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary?.toJson(),
    "propertyGallery": propertyGallery?.toJson(),
    "propertyContentSectionGroups": propertyContentSectionGroups?.toJson(),
  };
}

class PropertyContentSectionGroups {
  PropertyContentSectionGroups({
    this.aboutThisProperty,
  });

  AboutThisProperty? aboutThisProperty;

  factory PropertyContentSectionGroups.fromJson(Map<String, dynamic> json) => PropertyContentSectionGroups(
    aboutThisProperty: json["aboutThisProperty"] == null ? null : AboutThisProperty.fromJson(json["aboutThisProperty"]),
  );

  Map<String, dynamic> toJson() => {
    "aboutThisProperty": aboutThisProperty?.toJson(),
  };
}

class AboutThisProperty {
  AboutThisProperty({
    this.sections,
  });

  List<Section>? sections;

  factory AboutThisProperty.fromJson(Map<String, dynamic> json) => AboutThisProperty(
    sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class Section {
  Section({
    this.bodySubSections,
  });

  List<BodySubSection>? bodySubSections;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    bodySubSections: json["bodySubSections"] == null ? [] : List<BodySubSection>.from(json["bodySubSections"]!.map((x) => BodySubSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bodySubSections": bodySubSections == null ? [] : List<dynamic>.from(bodySubSections!.map((x) => x.toJson())),
  };
}

class BodySubSection {
  BodySubSection({
    this.elements,
  });

  List<Element>? elements;

  factory BodySubSection.fromJson(Map<String, dynamic> json) => BodySubSection(
    elements: json["elements"] == null ? [] : List<Element>.from(json["elements"]!.map((x) => Element.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "elements": elements == null ? [] : List<dynamic>.from(elements!.map((x) => x.toJson())),
  };
}

class Element {
  Element({
    this.items,
  });

  List<ElementItem>? items;

  factory Element.fromJson(Map<String, dynamic> json) => Element(
    items: json["items"] == null ? [] : List<ElementItem>.from(json["items"]!.map((x) => ElementItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class ElementItem {
  ElementItem({
    this.content,
  });

  Content? content;

  factory ElementItem.fromJson(Map<String, dynamic> json) => ElementItem(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "content": content?.toJson(),
  };
}

class Content {
  Content({
    this.text,
  });

  String? text;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
  };
}

class PropertyGallery {
  PropertyGallery({
    this.images,
  });

  List<ImageElement>? images;

  factory PropertyGallery.fromJson(Map<String, dynamic> json) => PropertyGallery(
    images: json["images"] == null ? [] : List<ImageElement>.from(json["images"]!.map((x) => ImageElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
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
    "image": image?.toJson(),
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
    url: json["url"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "description": description,
  };
}

class Summary {
  Summary({
    this.amenities,
    this.location,
  });

  Amenities? amenities;
  Location? location;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    amenities: json["amenities"] == null ? null : Amenities.fromJson(json["amenities"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "amenities": amenities?.toJson(),
    "location": location?.toJson(),
  };
}

class Amenities {
  Amenities({
    this.topAmenities,
  });

  TopAmenities? topAmenities;

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
    topAmenities: json["topAmenities"] == null ? null : TopAmenities.fromJson(json["topAmenities"]),
  );

  Map<String, dynamic> toJson() => {
    "topAmenities": topAmenities?.toJson(),
  };
}

class TopAmenities {
  TopAmenities({
    this.items,
  });

  List<TopAmenitiesItem>? items;

  factory TopAmenities.fromJson(Map<String, dynamic> json) => TopAmenities(
    items: json["items"] == null ? [] : List<TopAmenitiesItem>.from(json["items"]!.map((x) => TopAmenitiesItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class TopAmenitiesItem {
  TopAmenitiesItem({
    this.text,
    this.icon,
  });

  String? text;
  AmnetyIcon? icon;

  factory TopAmenitiesItem.fromJson(Map<String, dynamic> json) => TopAmenitiesItem(
    text: json["text"],
    icon: json["icon"] == null ? null : AmnetyIcon.fromJson(json["icon"]),
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "icon": icon?.toJson(),
  };
}

class AmnetyIcon {
  AmnetyIcon({
    this.id,
  });

  String? id;

  factory AmnetyIcon.fromJson(Map<String, dynamic> json) => AmnetyIcon(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "address": address?.toJson(),
    "coordinates": coordinates?.toJson(),
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
    addressLine: json["addressLine"],
    city: json["city"],
    province: json["province"],
    countryCode: json["countryCode"],
    firstAddressLine: json["firstAddressLine"],
    secondAddressLine: json["secondAddressLine"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine": addressLine,
    "city": city,
    "province": province,
    "countryCode": countryCode,
    "firstAddressLine": firstAddressLine,
    "secondAddressLine": secondAddressLine,
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
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}
