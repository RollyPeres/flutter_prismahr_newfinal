class ImageModel {
  String path;
  String url;

  ImageModel({path, url});

  ImageModel.fromJson(Map<String, dynamic> json) {
    this.path = json['path'];
    this.url = json['url'];
  }
}
