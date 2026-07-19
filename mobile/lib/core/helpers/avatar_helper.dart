import '../api_config.dart';

class AvatarHelper {
  const AvatarHelper._();

  static const String baseUrl = ApiConfig.baseUrl;

  /// Avatar bawaan jika user belum memiliki foto.
  static const String defaultAvatar =
      'assets/images/default_avatar.jpeg';

  static String getAvatarUrl({
    required String? avatar,
    String? fallback,
  }) {
    if (avatar == null || avatar.trim().isEmpty) {
      return fallback ?? defaultAvatar;
    }

    final value = avatar.trim();

    // URL penuh (Google, Cloudinary, dsb.)
    if (value.startsWith('http://') ||
        value.startsWith('https://')) {
      return value;
    }

    // Laravel storage
    if (value.startsWith('storage/')) {
      return '${ApiConfig.serverUrl}/$value';
    }

    // Relative path
    return '${ApiConfig.serverUrl}/$value';
  }

  static bool hasAvatar(String? avatar) {
    return avatar != null && avatar.trim().isNotEmpty;
  }
}