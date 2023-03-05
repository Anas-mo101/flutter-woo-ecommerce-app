


class UserComplainInit {
  String userEmail;
  String userId;
  String message;
  String title;
  String reason;

  UserComplainInit(
      {this.userEmail, this.userId, this.message, this.title, this.reason});

  UserComplainInit.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'];
    userId = json['user_id'];
    message = json['message'];
    title = json['title'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['title'] = this.title;
    data['reason'] = this.reason;
    return data;
  }
}
