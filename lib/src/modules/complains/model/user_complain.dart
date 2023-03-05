

class UserComplain {
  String complainID;
  String userEmail;
  String userId;
  String userTitle;
  String userReason;
  List<UserMessages> userMessages;
  String complainStatus;

  UserComplain(
      {
        this.complainID,
        this.userEmail,
        this.userId,
        this.userTitle,
        this.userReason,
        this.userMessages,
        this.complainStatus});

  UserComplain.fromJson(Map<String, dynamic> json) {
    userEmail = json['user_email'].toString();
    complainID = json['complain_id'].toString();
    userId = json['user_id'].toString();
    userTitle = json['user_title'].toString();
    userReason = json['user_reason'].toString();
    if (json['user_messages'] != null) {
      userMessages = <UserMessages>[];
      json['user_messages'].forEach((v) {
        userMessages.add(new UserMessages.fromJson(v));
      });
    }
    complainStatus = json['complain_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.userEmail;
    data['complain_id'] = this.complainID;
    data['user_id'] = this.userId;
    data['user_title'] = this.userTitle;
    data['user_reason'] = this.userReason;
    if (this.userMessages != null) {
      data['user_messages'] = this.userMessages.map((v) => v.toJson()).toList();
    }
    data['complain_status'] = this.complainStatus;
    return data;
  }
}

class UserMessages {
  String sender;
  String senderId;
  String message;
  String sendingDatetime;

  UserMessages(
      {this.sender, this.senderId, this.message, this.sendingDatetime});

  UserMessages.fromJson(Map<String, dynamic> json) {
    sender = json['sender'].toString();
    senderId = json['sender_id'].toString();
    message = json['message'].toString();
    sendingDatetime = json['sending_datetime'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender'] = this.sender;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    data['sending_datetime'] = this.sendingDatetime;
    return data;
  }
}
