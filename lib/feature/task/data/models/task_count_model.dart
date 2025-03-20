import '../../domain/entities/task_count_entity.dart';

class TaskCountModel {
  String? sId;
  int? sum;

  TaskCountModel({this.sId, this.sum});

  TaskCountModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }

  // Convert Model to Entity
  TaskCountEntity toEntity() {
    return TaskCountEntity(
      id: this.sId ?? '',
      sum: this.sum ?? 0,
    );
  }
}