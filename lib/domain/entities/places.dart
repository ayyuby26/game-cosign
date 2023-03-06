import 'package:equatable/equatable.dart';
import '../../data/models/places_model.dart';

class Places extends Equatable {
  const Places({
    this.htmlAttributions,
    this.nextPageToken,
    this.results,
    this.status,
  });

  final List<dynamic>? htmlAttributions;
  final String? nextPageToken;
  final List<ResultModel>? results;
  final String? status;

  factory Places.fromJson(Map<String, dynamic> json) => Places(
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

  @override
  List<Object?> get props => [
        htmlAttributions ?? [],
        nextPageToken ?? '',
        results,
        status,
      ];
}
