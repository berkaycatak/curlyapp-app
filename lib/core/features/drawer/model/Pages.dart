class Pages {
  String? title;
  String? content;
  String? imGe;

  Pages({this.title, this.content, this.imGe});

  Pages.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    imGe = json['imæge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['imæge'] = this.imGe;
    return data;
  }
}
