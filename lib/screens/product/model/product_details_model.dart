class ProductDetailsModel {
  int? _id;
  String? _title;
  String? _description;
  String? _category;
  double? _price;
  double? _discountPercentage;
  double? _rating;
  int? _stock;
  List<String>? _tags;
  String? _brand;
  String? _sku;
  int? _weight;
  Dimensions? _dimensions;
  String? _warrantyInformation;
  String? _shippingInformation;
  String? _availabilityStatus;
  List<Reviews>? _reviews;
  String? _returnPolicy;
  int? _minimumOrderQuantity;
  Meta? _meta;
  List<String>? _images;
  String? _thumbnail;

  ProductDetailsModel(
      {int? id,
        String? title,
        String? description,
        String? category,
        double? price,
        double? discountPercentage,
        double? rating,
        int? stock,
        List<String>? tags,
        String? brand,
        String? sku,
        int? weight,
        Dimensions? dimensions,
        String? warrantyInformation,
        String? shippingInformation,
        String? availabilityStatus,
        List<Reviews>? reviews,
        String? returnPolicy,
        int? minimumOrderQuantity,
        Meta? meta,
        List<String>? images,
        String? thumbnail}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
    if (category != null) {
      this._category = category;
    }
    if (price != null) {
      this._price = price;
    }
    if (discountPercentage != null) {
      this._discountPercentage = discountPercentage;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (stock != null) {
      this._stock = stock;
    }
    if (tags != null) {
      this._tags = tags;
    }
    if (brand != null) {
      this._brand = brand;
    }
    if (sku != null) {
      this._sku = sku;
    }
    if (weight != null) {
      this._weight = weight;
    }
    if (dimensions != null) {
      this._dimensions = dimensions;
    }
    if (warrantyInformation != null) {
      this._warrantyInformation = warrantyInformation;
    }
    if (shippingInformation != null) {
      this._shippingInformation = shippingInformation;
    }
    if (availabilityStatus != null) {
      this._availabilityStatus = availabilityStatus;
    }
    if (reviews != null) {
      this._reviews = reviews;
    }
    if (returnPolicy != null) {
      this._returnPolicy = returnPolicy;
    }
    if (minimumOrderQuantity != null) {
      this._minimumOrderQuantity = minimumOrderQuantity;
    }
    if (meta != null) {
      this._meta = meta;
    }
    if (images != null) {
      this._images = images;
    }
    if (thumbnail != null) {
      this._thumbnail = thumbnail;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get category => _category;
  set category(String? category) => _category = category;
  double? get price => _price;
  set price(double? price) => _price = price;
  double? get discountPercentage => _discountPercentage;
  set discountPercentage(double? discountPercentage) =>
      _discountPercentage = discountPercentage;
  double? get rating => _rating;
  set rating(double? rating) => _rating = rating;
  int? get stock => _stock;
  set stock(int? stock) => _stock = stock;
  List<String>? get tags => _tags;
  set tags(List<String>? tags) => _tags = tags;
  String? get brand => _brand;
  set brand(String? brand) => _brand = brand;
  String? get sku => _sku;
  set sku(String? sku) => _sku = sku;
  int? get weight => _weight;
  set weight(int? weight) => _weight = weight;
  Dimensions? get dimensions => _dimensions;
  set dimensions(Dimensions? dimensions) => _dimensions = dimensions;
  String? get warrantyInformation => _warrantyInformation;
  set warrantyInformation(String? warrantyInformation) =>
      _warrantyInformation = warrantyInformation;
  String? get shippingInformation => _shippingInformation;
  set shippingInformation(String? shippingInformation) =>
      _shippingInformation = shippingInformation;
  String? get availabilityStatus => _availabilityStatus;
  set availabilityStatus(String? availabilityStatus) =>
      _availabilityStatus = availabilityStatus;
  List<Reviews>? get reviews => _reviews;
  set reviews(List<Reviews>? reviews) => _reviews = reviews;
  String? get returnPolicy => _returnPolicy;
  set returnPolicy(String? returnPolicy) => _returnPolicy = returnPolicy;
  int? get minimumOrderQuantity => _minimumOrderQuantity;
  set minimumOrderQuantity(int? minimumOrderQuantity) =>
      _minimumOrderQuantity = minimumOrderQuantity;
  Meta? get meta => _meta;
  set meta(Meta? meta) => _meta = meta;
  List<String>? get images => _images;
  set images(List<String>? images) => _images = images;
  String? get thumbnail => _thumbnail;
  set thumbnail(String? thumbnail) => _thumbnail = thumbnail;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _category = json['category'];
    _price = json['price'];
    _discountPercentage = json['discountPercentage'];
    _rating = json['rating'];
    _stock = json['stock'];
    _tags = json['tags'].cast<String>();
    _brand = json['brand'];
    _sku = json['sku'];
    _weight = json['weight'];
    _dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    _warrantyInformation = json['warrantyInformation'];
    _shippingInformation = json['shippingInformation'];
    _availabilityStatus = json['availabilityStatus'];
    if (json['reviews'] != null) {
      _reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        _reviews!.add(new Reviews.fromJson(v));
      });
    }
    _returnPolicy = json['returnPolicy'];
    _minimumOrderQuantity = json['minimumOrderQuantity'];
    _meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    _images = json['images'].cast<String>();
    _thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['description'] = this._description;
    data['category'] = this._category;
    data['price'] = this._price;
    data['discountPercentage'] = this._discountPercentage;
    data['rating'] = this._rating;
    data['stock'] = this._stock;
    data['tags'] = this._tags;
    data['brand'] = this._brand;
    data['sku'] = this._sku;
    data['weight'] = this._weight;
    if (this._dimensions != null) {
      data['dimensions'] = this._dimensions!.toJson();
    }
    data['warrantyInformation'] = this._warrantyInformation;
    data['shippingInformation'] = this._shippingInformation;
    data['availabilityStatus'] = this._availabilityStatus;
    if (this._reviews != null) {
      data['reviews'] = this._reviews!.map((v) => v.toJson()).toList();
    }
    data['returnPolicy'] = this._returnPolicy;
    data['minimumOrderQuantity'] = this._minimumOrderQuantity;
    if (this._meta != null) {
      data['meta'] = this._meta!.toJson();
    }
    data['images'] = this._images;
    data['thumbnail'] = this._thumbnail;
    return data;
  }
}

class Dimensions {
  double? _width;
  double? _height;
  double? _depth;

  Dimensions({double? width, double? height, double? depth}) {
    if (width != null) {
      this._width = width;
    }
    if (height != null) {
      this._height = height;
    }
    if (depth != null) {
      this._depth = depth;
    }
  }

  double? get width => _width;
  set width(double? width) => _width = width;
  double? get height => _height;
  set height(double? height) => _height = height;
  double? get depth => _depth;
  set depth(double? depth) => _depth = depth;

  Dimensions.fromJson(Map<String, dynamic> json) {
    _width = json['width'];
    _height = json['height'];
    _depth = json['depth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this._width;
    data['height'] = this._height;
    data['depth'] = this._depth;
    return data;
  }
}

class Reviews {
  int? _rating;
  String? _comment;
  String? _date;
  String? _reviewerName;
  String? _reviewerEmail;

  Reviews(
      {int? rating,
        String? comment,
        String? date,
        String? reviewerName,
        String? reviewerEmail}) {
    if (rating != null) {
      this._rating = rating;
    }
    if (comment != null) {
      this._comment = comment;
    }
    if (date != null) {
      this._date = date;
    }
    if (reviewerName != null) {
      this._reviewerName = reviewerName;
    }
    if (reviewerEmail != null) {
      this._reviewerEmail = reviewerEmail;
    }
  }

  int? get rating => _rating;
  set rating(int? rating) => _rating = rating;
  String? get comment => _comment;
  set comment(String? comment) => _comment = comment;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get reviewerName => _reviewerName;
  set reviewerName(String? reviewerName) => _reviewerName = reviewerName;
  String? get reviewerEmail => _reviewerEmail;
  set reviewerEmail(String? reviewerEmail) => _reviewerEmail = reviewerEmail;

  Reviews.fromJson(Map<String, dynamic> json) {
    _rating = json['rating'];
    _comment = json['comment'];
    _date = json['date'];
    _reviewerName = json['reviewerName'];
    _reviewerEmail = json['reviewerEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this._rating;
    data['comment'] = this._comment;
    data['date'] = this._date;
    data['reviewerName'] = this._reviewerName;
    data['reviewerEmail'] = this._reviewerEmail;
    return data;
  }
}

class Meta {
  String? _createdAt;
  String? _updatedAt;
  String? _barcode;
  String? _qrCode;

  Meta(
      {String? createdAt, String? updatedAt, String? barcode, String? qrCode}) {
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (barcode != null) {
      this._barcode = barcode;
    }
    if (qrCode != null) {
      this._qrCode = qrCode;
    }
  }

  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get barcode => _barcode;
  set barcode(String? barcode) => _barcode = barcode;
  String? get qrCode => _qrCode;
  set qrCode(String? qrCode) => _qrCode = qrCode;

  Meta.fromJson(Map<String, dynamic> json) {
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _barcode = json['barcode'];
    _qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['barcode'] = this._barcode;
    data['qrCode'] = this._qrCode;
    return data;
  }
}
