class Social {
  String? instagram;
  String? twitter;
  String? facebook;
  String? pinterest;

  Social({this.instagram, this.twitter, this.facebook, this.pinterest});

  Social.fromJson(Map<String, dynamic> json) {
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    pinterest = json['pinterest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['pinterest'] = this.pinterest;
    return data;
  }
}
