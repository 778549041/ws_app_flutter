class Emoji {
  String? name;
  int? unicode;

  Emoji({this.name, this.unicode});

  Emoji.fromJson(Map json) {
    name = json['name'] as String;
    unicode = json['unicode'] as int;
  }
}
