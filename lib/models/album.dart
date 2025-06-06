class Album {
  final int id;
  final String title;
  Album({required this.id, required this.title});
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}