



class WooCountryInfo {
  String code;
  String name;
  List<WooStates> states;

  WooCountryInfo({this.code, this.name, this.states});

  WooCountryInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['states'] != null) {
      states = <WooStates>[];
      json['states'].forEach((v) {
        states.add(new WooStates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WooStates {
  String code;
  String name;

  WooStates({this.code, this.name});

  WooStates.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}
