// Method to extract YouTube video ID from URL
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String? getVideoId(String url) {
  return YoutubePlayer.convertUrlToId(url);
}

// Method to get thumbnail URL using the video ID
String getThumbnailUrl(String videoId) {
  return 'https://img.youtube.com/vi/$videoId/0.jpg'; // Thumbnail URL pattern
}
