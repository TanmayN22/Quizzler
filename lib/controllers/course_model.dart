class YouTubeVideo {
  final String id;
  final String title;

  YouTubeVideo({
    required this.id,
    required this.title,
  });
}

class CourseTopic {
  final String name;
  final List<YouTubeVideo> videos;

  CourseTopic({
    required this.name,
    required this.videos,
  });
}
