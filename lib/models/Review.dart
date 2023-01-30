class Review {
  Review({
    this.data,
  });

  Data? data;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
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
}

class PropertyInfo {
  PropertyInfo({
    this.id,
    this.reviewInfo,
  });

  String? id;
  ReviewInfo? reviewInfo;

  factory PropertyInfo.fromJson(Map<String, dynamic> json) => PropertyInfo(
        id: json["id"] == null ? null : json["id"],
        reviewInfo: json["reviewInfo"] == null
            ? null
            : ReviewInfo.fromJson(json["reviewInfo"]),
      );
}

class ReviewInfo {
  ReviewInfo({
    this.reviews,
  });

  List<ReviewElement>? reviews;

  factory ReviewInfo.fromJson(Map<String, dynamic> json) => ReviewInfo(
        reviews: json["reviews"] == null
            ? null
            : List<ReviewElement>.from(
                json["reviews"].map((x) => ReviewElement.fromJson(x))),
      );
}

class ReviewElement {
  ReviewElement({
    this.id,
    this.reviewScoreWithDescription,
    this.submissionTimeLocalized,
    this.title,
    this.text,
    this.stayDuration,
    this.managementResponses,
  });

  String? id;
  ReviewScoreWithDescription? reviewScoreWithDescription;
  String? submissionTimeLocalized;
  String? title;
  String? text;
  String? stayDuration;
  List<ManagementResponse>? managementResponses;

  factory ReviewElement.fromJson(Map<String, dynamic> json) => ReviewElement(
        id: json["id"] == null ? null : json["id"],
        reviewScoreWithDescription: json["reviewScoreWithDescription"] == null
            ? null
            : ReviewScoreWithDescription.fromJson(
                json["reviewScoreWithDescription"]),
        submissionTimeLocalized: json["submissionTimeLocalized"] == null
            ? null
            : json["submissionTimeLocalized"],
        title: json["title"] == null ? null : json["title"],
        text: json["text"] == null ? null : json["text"],
        stayDuration:
            json["stayDuration"] == null ? null : json["stayDuration"],
        managementResponses: json["managementResponses"] == null
            ? null
            : List<ManagementResponse>.from(json["managementResponses"]
                .map((x) => ManagementResponse.fromJson(x))),
      );
}

class ManagementResponse {
  ManagementResponse({
    this.header,
    this.response,
  });

  Header? header;
  String? response;

  factory ManagementResponse.fromJson(Map<String, dynamic> json) =>
      ManagementResponse(
        header: json["header"] == null ? null : Header.fromJson(json["header"]),
        response: json["response"] == null ? null : json["response"],
      );
}

class Header {
  Header({
    this.text,
  });

  String? text;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        text: json["text"] == null ? null : json["text"],
      );
}

class ReviewScoreWithDescription {
  ReviewScoreWithDescription({
    this.value,
  });

  String? value;

  factory ReviewScoreWithDescription.fromJson(Map<String, dynamic> json) =>
      ReviewScoreWithDescription(
        value: json["value"] == null ? null : json["value"],
      );
}
