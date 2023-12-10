class Curriculum {
  final int? key;
  final dynamic id;
  final String? type;
  final String? title;
  final int? duration;
  final String? content;
  final List? meta;
  final int? status;
  final String? onlineVideoLink;
  final String? offlineVideoLink;

  Curriculum({
    required this.key,
    required this.id,
    required this.type,
    required this.title,
    required this.duration,
    required this.content,
    required this.meta,
    required this.status,
    required this.onlineVideoLink,
    required this.offlineVideoLink,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) => Curriculum(
        key: json["key"],
        id: json["id"],
        type: json["type"],
        title: json["title"],
        duration: json["duration"],
        content: json["content"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
        status: json["status"],
        onlineVideoLink: json["online_video_link"],
        offlineVideoLink: json["offline_video_link"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "id": id,
        "type": type,
        "title": title,
        "duration": duration,
        "content": content,
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "status": status,
        "online_video_link": onlineVideoLink,
        "offline_video_link": offlineVideoLink,
      };
}
