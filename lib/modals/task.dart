class Task {
  final String id;
  final String title;
  final String description;

  Task({
    required this.id,
    required this.description,
    required this.title,
  });

  factory Task.fromJson(Map<String, dynamic> data) {
    return Task(
        id: data['_id'], description: data['description'], title: data['title']);
  }

 Map<String, dynamic> toJson()
  {
    return {
      'description':description,
      'title':title
    };
  }
}
