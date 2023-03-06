import '../../domain/entities/places.dart';

class PlacesModel {
  PlacesModel({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
    this.status,
  });

  final List<dynamic>? htmlAttributions;
  final String? nextPageToken;
  final List<ResultModel>? results;
  final String? status;

  factory PlacesModel.fromJson(Map<String, dynamic> json) => PlacesModel(
        htmlAttributions: json["html_attributions"] == null
            ? []
            : List<dynamic>.from(json["html_attributions"]!.map((x) => x)),
        nextPageToken: json["next_page_token"],
        results: json["results"] == null
            ? []
            : List<ResultModel>.from(
                json["results"]!.map((x) => ResultModel.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions == null
            ? []
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "next_page_token": nextPageToken,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "status": status,
      };

  Places toEntity() {
    return Places(
      htmlAttributions: htmlAttributions,
      nextPageToken: nextPageToken,
      results: results,
      status: status,
    );
  }
}

class ResultModel {
  ResultModel({
    this.businessStatus,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
  });

  final String? businessStatus;
  final GeometryModel? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? name;
  final OpeningHoursModel? openingHours;
  final List<PhotoModel>? photos;
  final String? placeId;
  final PlusCodeModel? plusCode;
  final double? rating;
  final String? reference;
  final String? scope;
  final List<String>? types;
  final int? userRatingsTotal;
  final String? vicinity;

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        businessStatus: json["business_status"],
        geometry: json["geometry"] == null
            ? null
            : GeometryModel.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        openingHours: json["opening_hours"] == null
            ? null
            : OpeningHoursModel.fromJson(json["opening_hours"]),
        photos: json["photos"] == null
            ? []
            : List<PhotoModel>.from(
                json["photos"]!.map((x) => PhotoModel.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] == null
            ? null
            : PlusCodeModel.fromJson(json["plus_code"]),
        rating: json["rating"]?.toDouble(),
        reference: json["reference"],
        scope: json["scope"],
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatus,
        "geometry": geometry?.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "opening_hours": openingHours?.toJson(),
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "rating": rating,
        "reference": reference,
        "scope": scope,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
      };
}

class GeometryModel {
  GeometryModel({
    this.location,
    this.viewport,
  });

  final LocationModel? location;
  final ViewportModel? viewport;

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
        location: json["location"] == null
            ? null
            : LocationModel.fromJson(json["location"]),
        viewport: json["viewport"] == null
            ? null
            : ViewportModel.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "viewport": viewport?.toJson(),
      };
}

class LocationModel {
  LocationModel({
    this.lat,
    this.lng,
  });

  final double? lat;
  final double? lng;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class ViewportModel {
  ViewportModel({
    this.northeast,
    this.southwest,
  });

  final LocationModel? northeast;
  final LocationModel? southwest;

  factory ViewportModel.fromJson(Map<String, dynamic> json) => ViewportModel(
        northeast: json["northeast"] == null
            ? null
            : LocationModel.fromJson(json["northeast"]),
        southwest: json["southwest"] == null
            ? null
            : LocationModel.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast?.toJson(),
        "southwest": southwest?.toJson(),
      };
}

class OpeningHoursModel {
  OpeningHoursModel({
    this.openNow,
  });

  final bool? openNow;

  factory OpeningHoursModel.fromJson(Map<String, dynamic> json) =>
      OpeningHoursModel(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class PhotoModel {
  PhotoModel({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  final int? height;
  final List<String>? htmlAttributions;
  final String? photoReference;
  final int? width;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        height: json["height"],
        htmlAttributions: json["html_attributions"] == null
            ? []
            : List<String>.from(json["html_attributions"]!.map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": htmlAttributions == null
            ? []
            : List<dynamic>.from(htmlAttributions!.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class PlusCodeModel {
  PlusCodeModel({
    this.compoundCode,
    this.globalCode,
  });

  final String? compoundCode;
  final String? globalCode;

  factory PlusCodeModel.fromJson(Map<String, dynamic> json) => PlusCodeModel(
        compoundCode: json["compound_code"],
        globalCode: json["global_code"],
      );

  Map<String, dynamic> toJson() => {
        "compound_code": compoundCode,
        "global_code": globalCode,
      };
}
