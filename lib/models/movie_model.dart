class MovieModel {
  late String posterPath;
  late String title;
  late int id;
  late int qty;

  MovieModel({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.qty,
  });

  // For API
  // MovieModel.fromMap(dynamic map) {
  //   id = map['id'];
  //   posterPath = map['poster_path'];
  //   title = map['title'];
  // }

  // For GET STORAGE
  // MovieModel.fromStorage(dynamic map) {
  //   id = map['id'];
  //   posterPath = map['poster_path'];
  //   title = map['title'];
  //   qty = map['qty'];
  // }

  factory MovieModel.fromMap(dynamic map) {
    dynamic qty;
    if (map['qty'] != null) {
      qty = map['qty'];
    } else {
      qty = 0;
    }
    return MovieModel(
      id: map['id'],
      posterPath: map['poster_path'],
      title: map['title'],
      qty: qty,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'poster_path': posterPath,
        'title': title,
        'qty': qty,
      };
}
