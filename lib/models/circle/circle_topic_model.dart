class TopicListModel {
  int totalPage;
  List<TopicModel> list;

  TopicListModel({this.totalPage = 0}) : list = List<TopicModel>();

  TopicListModel.fromJson(Map<String, dynamic> json) {
    list = List<TopicModel>();
    if (json['list'] != null) {
      (json['list'] as List).forEach((element) {
        list.add(TopicModel.fromJson(element));
      });
    }
    totalPage = json['total_page'];
  }
}

class SingleTopicodel {
  TopicModel list;

  SingleTopicodel() : list = TopicModel();

  SingleTopicodel.fromJson(Map<String, dynamic> json) {
    list =
        json['list'] != null ? TopicModel.fromJson(json['list']) : TopicModel();
  }
}

class TopicModel {
  String topicId;
  String title;
  String content;
  String imageUrl;
  String adminUrl;
  int totalNum;
  int join;
  bool showAll;

  TopicModel(
      {this.topicId = '',
      this.title = '',
      this.content = '',
      this.imageUrl = '',
      this.adminUrl = '',
      this.totalNum = 0,
      this.join = 0,
      this.showAll = false});

  TopicModel.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'] ?? '';
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    imageUrl = json['image_url'] ?? '';
    adminUrl = json['admin_url'] ?? '';
    totalNum = json['num'] ?? 0;
    join = json['join'] ?? 0;
    showAll = false;
  }
}
