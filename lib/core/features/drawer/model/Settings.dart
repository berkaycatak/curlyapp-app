class Settings {
  String? appName;
  String? logoUrl;
  String? postStyle;

  Settings({this.appName, this.logoUrl, this.postStyle});

  Settings.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    logoUrl = json['logo_url'];
    postStyle = json['post_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['logo_url'] = this.logoUrl;
    data['post_style'] = this.postStyle;
    return data;
  }
}
