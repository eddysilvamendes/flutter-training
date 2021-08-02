class PhotosModel {
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  SrcModel? src;

  PhotosModel({
    this.url,
    this.photographer,
    this.photographerId,
    this.photographerUrl,
    this.src,
  });

  factory PhotosModel.fromMap(Map<String, dynamic> parsedJson) {
    return PhotosModel(
        url: parsedJson["url"],
        photographer: parsedJson["photographer"],
        photographerId: parsedJson["photographer_id"],
        photographerUrl: parsedJson["photographer_url"],
        src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({
    required this.original,
    required this.portrait,
    required this.small,
  });
  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        // portrait: srcJson["portrait"],
        // large: srcJson["large"],
        // landscape: srcJson["landscape"],
        // medium: srcJson["medium"]);
        portrait: srcJson["portrait"],
        original: srcJson["original"],
        small: srcJson["small"]);
  }
}
