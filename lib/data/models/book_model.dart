class Book{
  String? thumbnail;
  String? title;
  String? description;

  Book({this.title,this.description, this.thumbnail});
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

    factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      description: json['description'],
    );
  }
}