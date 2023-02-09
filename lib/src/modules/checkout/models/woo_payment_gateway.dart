
class WooPaymentGateway {
  String id;
  String title;
  String description;
  bool enabled;
  String methodTitle;
  String methodDescription;
  List<String> methodSupports;
  Settings settings;

  WooPaymentGateway({this.id, this.title, this.description, this.enabled, this.methodTitle, this.methodDescription, this.methodSupports, this.settings});

  WooPaymentGateway.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    enabled = json['enabled'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    methodSupports = json['method_supports'].cast<String>();
    settings = json['settings'] != null ? new Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['enabled'] = this.enabled;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    data['method_supports'] = this.methodSupports;
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    return data;
  }
}

class Settings {
  Title title;
  Title instructions;

  Settings({this.title, this.instructions});

  Settings.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    instructions = json['instructions'] != null ? new Title.fromJson(json['instructions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.instructions != null) {
      data['instructions'] = this.instructions.toJson();
    }
    return data;
  }
}

class Title {
  String id;
  String label;
  String description;
  String type;
  String value;
  String defaultt;
  String tip;
  String placeholder;

  Title({this.id, this.label, this.description, this.type, this.value, this.defaultt, this.tip, this.placeholder});

  Title.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    defaultt = json['default'];
    tip = json['tip'];
    placeholder = json['placeholder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['description'] = this.description;
    data['type'] = this.type;
    data['value'] = this.value;
    data['default'] = this.defaultt;
    data['tip'] = this.tip;
    data['placeholder'] = this.placeholder;
    return data;
  }
}
