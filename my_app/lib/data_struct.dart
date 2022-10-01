class MyData {
  int id;
  String titre;
  String artiste;
  String chemin_music;
  String cover;


  MyData(this.id, this.titre, this.artiste, this.chemin_music, this.cover);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'artiste': artiste,
      'chemin_music': chemin_music,
      'cover': cover,
    };
  }

  factory MyData.fromMap(Map<String, dynamic> map) => MyData(
        map['id'],
        map['titre'],
        map['artiste'],
        map['chemin_music'],
        map['cover'],
      );
}
