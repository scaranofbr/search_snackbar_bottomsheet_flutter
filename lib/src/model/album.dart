class Album {
  final int userId;
  final int id;
  final String title;
  bool favourited;

  Album(this.userId, this.id, this.title) : this.favourited = false;

  Album.fromJson(Map<String, dynamic> json)
      : this.userId = json['userId'],
        this.id = json['id'],
        this.title = json['title'],
        this.favourited = false;
}
