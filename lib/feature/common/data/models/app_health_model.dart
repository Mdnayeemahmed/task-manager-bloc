import 'package:sm_app/features/common/domain/entities/app_health.dart';

class AppHealthModel {
  String? appName;
  String? version;

  AppHealthModel({this.appName, this.version});

  AppHealthModel.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['version'] = version;
    return data;
  }

  AppHealth toEntity() => AppHealth(
    appName: appName ?? '',
    version: version ?? '',
  );
}