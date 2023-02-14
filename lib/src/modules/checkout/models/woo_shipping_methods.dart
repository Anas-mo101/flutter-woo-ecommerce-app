

class WooShippingMethods {
  int instanceId;
  String title;
  int order;
  bool enabled;
  String methodId;
  String methodTitle;
  String methodDescription;

  WooShippingMethods({
    this.instanceId,
    this.title,
    this.order,
    this.enabled,
    this.methodId,
    this.methodTitle,
    this.methodDescription
  });

  WooShippingMethods.fromJson(Map<String, dynamic> json) {
    instanceId = json['instance_id'];
    title = json['title'];
    order = json['order'];
    enabled = json['enabled'];
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instance_id'] = this.instanceId;
    data['title'] = this.title;
    data['order'] = this.order;
    data['enabled'] = this.enabled;
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    return data;
  }
}
