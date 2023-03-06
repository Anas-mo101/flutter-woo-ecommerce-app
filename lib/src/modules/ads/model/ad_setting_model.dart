


class AdsSettings {
  String interval;

  AdsSettings({this.interval});

  AdsSettings.fromJson(Map<String, dynamic> json) {
    interval = json['interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['interval'] = this.interval;
    return data;
  }
}
