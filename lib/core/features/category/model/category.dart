class Category {
  int? id;
  String? title;
  String? url;
  String? logourl;
  String? postStil;
  String? icerik;
  String? thumbnailSmall;
  String? thumbnailFull;
  String? date;
  int? catId;
  String? catName;
  String? authorName;
  String? authorImage;

  Category(
      {this.id,
      this.title,
      this.url,
      this.logourl,
      this.postStil,
      this.icerik,
      this.thumbnailSmall,
      this.thumbnailFull,
      this.date,
      this.catId,
      this.catName,
      this.authorName,
      this.authorImage});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    logourl = json['logourl'];
    postStil = json['postStil'];
    icerik = json['icerik'];
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
    data['logourl'] = this.logourl;
    data['postStil'] = this.postStil;
    data['icerik'] = this.icerik;
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
