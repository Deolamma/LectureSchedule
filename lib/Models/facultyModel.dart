import './DepartmentModel.dart';

class Faculty {
  String? id;
  String? name;
  String? uid;
  String? bgImage;
  List<Department>? departments;

  Faculty({
    this.id,
    this.name,
    this.uid,
    this.bgImage,
    this.departments,
  });

  Faculty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uid = json['uid'];
    bgImage = json['bgImage'];
    if (json['departments'] != null) {
      departments = [];
      json['departments'].forEach((v) {
        departments!.add(Department.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['uid'] = this.uid;
    data['bgImage'] = this.bgImage;
    if (this.departments != null) {
      data['departments'] = this.departments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
