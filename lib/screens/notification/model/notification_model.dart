class NotificationModel {
  String? id;
  String? title;
  String? description;
  String? scheduledTime;
  bool? isScheduled;
  bool? isFired;

  NotificationModel(
      {this.id,
        this.title,
        this.description,
        this.scheduledTime,
        this.isScheduled,
        this.isFired});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    scheduledTime = json['scheduledTime'];
    isScheduled = json['isScheduled'];
    isFired = json['isFired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['scheduledTime'] = this.scheduledTime;
    data['isScheduled'] = this.isScheduled;
    data['isFired'] = this.isFired;
    return data;
  }
}