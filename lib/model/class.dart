class Class {
  int id;
  String name;
  String description;

  Class();

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class()
        ..id = json['id']
        ..name = json['name']
        ..description = json['description'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description
    };
  }

  @override
  String toString() {
    return 'Class{name: $name, description: $description}';
  }
}