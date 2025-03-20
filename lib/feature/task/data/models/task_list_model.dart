import '../../domain/entities/task_entity.dart';

class TaskListModel {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskListModel({this.sId, this.title, this.description, this.status, this.createdDate});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'description': description,
      'status': status,
      'createdDate': createdDate,
    };
  }


}

extension TaskListModelMapper on TaskListModel {
  TaskEntity toEntity() {
    return TaskEntity(
      id: sId ?? '',
      title: title ?? '',
      description: description ?? '',
      status: status ?? '',
      createdDate: DateTime.parse(createdDate ?? '1970-01-01'), // or use a default date
    );
  }
}

extension TaskListEntityMapper on TaskEntity {
  TaskListModel toModel() {
    return TaskListModel(
      sId: id,
      title: title,
      description: description,
      status: status,
      createdDate: createdDate.toIso8601String(),
    );
  }
}

