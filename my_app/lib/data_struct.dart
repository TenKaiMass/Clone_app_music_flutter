class MyData {
  int id;
  String titre;
  String artiste;
  String musicUrl;
  String coverUrl;

  MyData(this.id, this.titre, this.artiste, this.musicUrl, this.coverUrl);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'artiste': artiste,
      'chemin_music': musicUrl,
      'cover': coverUrl
    };
  }
  factory MyData.fromMap(Map<String, dynamic> map) => MyData(
    map['title'],
    map['id'],
    map['artiste'],
    map['musicUrl'],
    map['coverUrl'],
  );
}
