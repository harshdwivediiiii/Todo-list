class Task {
  String title;
  bool isCompleted;
  String category;
  String tagColor;
  
  Task({required this.title, this.isCompleted = false, required this.category, required this.tagColor});

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'category': category,
      'tagColor': tagColor,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'],
      category: json['category'],
      tagColor: json['tagColor'],
    );
  }
}
