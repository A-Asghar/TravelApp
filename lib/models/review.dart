class Review {
  String reviewId;
  String reviewerId;
  String reviewerName;
  String reviewDate;
  String reviewText;
  double reviewRating;
  String reviewerPhoto;

  Review({
    required this.reviewId,
    required this.reviewerId,
    required this.reviewerName,
    required this.reviewDate,
    required this.reviewText,
    required this.reviewRating,
    required this.reviewerPhoto,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['reviewId'] as String,
      reviewerId: json['reviewerId'] as String,
      reviewerName: json['reviewerName'] as String,
      reviewDate: json['reviewDate'] as String,
      reviewText: json['reviewText'] as String,
      reviewRating: (json['reviewRating'] as num).toDouble(),
      reviewerPhoto: json['reviewerPhoto'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'reviewerId': reviewerId,
      'reviewerName': reviewerName,
      'reviewDate': reviewDate,
      'reviewText': reviewText,
      'reviewRating': reviewRating,
      'reviewerPhoto': reviewerPhoto,
    };
  }
}
