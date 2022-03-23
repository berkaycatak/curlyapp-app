class Home {
  int? id;
  String? title;
  String? url;
  String? appName;
  String? logoUrl;
  String? postStyle;
  String? content;
  String? thumbnailSmall;
  String? thumbnailFull;
  String? date;
  int? catId;
  String? catName;
  String? authorName;
  String? authorImage;

  Home(
      {this.id,
      this.title,
      this.url,
      this.appName,
      this.logoUrl,
      this.postStyle,
      this.content,
      this.thumbnailSmall,
      this.thumbnailFull,
      this.date,
      this.catId,
      this.catName,
      this.authorName,
      this.authorImage});

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    appName = json['app_name'];
    logoUrl = json['logo_url'];
    postStyle = json['post_style'];
    content = json['content'];
    thumbnailSmall = json['thumbnail_small'];
    thumbnailFull = json['thumbnail_full'];
    date = json['date'];
    catId = json['cat_id'];
    catName = json['cat_name'];
    authorName = json['author_name'];
    authorImage = json['author_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['app_name'] = this.appName;
    data['logo_url'] = this.logoUrl;
    data['post_style'] = this.postStyle;
    data['content'] = this.content;
    data['thumbnail_small'] = this.thumbnailSmall;
    data['thumbnail_full'] = this.thumbnailFull;
    data['date'] = this.date;
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['author_name'] = this.authorName;
    data['author_image'] = this.authorImage;
    return data;
  }
}
