enum ImageQuality {
  small(name: 'small'),
  medium(name: 'medium'),
  large(name: 'large');

  const ImageQuality({required this.name});
  final String name;
}

class ImageUrlService {
  static String? urlBuilder(String? url, ImageQuality? quality) {
    if (url == null || quality == null) {
      return url;
    }

    // Extract the extension
    final RegExp extensionRegExp = RegExp(r'(\.\w+)$');
    final Match? match = extensionRegExp.firstMatch(url);

    if (match != null) {
      final String extension = match.group(0)!;
      final String baseUrl = url.substring(0, match.start);
      return '$baseUrl-${quality.name}$extension';
    }

    return url;
  }
}
