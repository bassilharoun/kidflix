class VideoModel {
  final bool? status;
  final List<VideoLink>? videos;

  VideoModel({
    required this.status,
    required this.videos,
  });

  // Factory constructor to create an instance from a JSON map
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      status: json['status'],
      videos: (json['data'] as List)
          .map((video) => VideoLink.fromJson(video))
          .toList(),
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': videos?.map((video) => video.toJson()).toList(),
    };
  }
}

class VideoLink {
  final int id;
  final String link;

  VideoLink({
    required this.id,
    required this.link,
  });

  // Factory constructor to create an instance from a JSON map
  factory VideoLink.fromJson(Map<String, dynamic> json) {
    return VideoLink(
      id: json['id'],
      link: json['link'],
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
    };
  }
}

// empty video model

VideoModel emptyVideoModel = VideoModel(
  status: false,
  videos: [],
);
