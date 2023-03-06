

class Ads {
  int adId;
  String title;
  String content;
  String image;
  String link;

  Ads({this.adId, this.title, this.content, this.image, this.link});

  Ads.fromJson(Map<String, dynamic> json) {
    adId = json['ad_id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad_id'] = this.adId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
