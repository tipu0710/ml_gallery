import 'package:ml_gallery/utils/constants.dart';

extension ChangeUrl on String {
  changeUrl({int? height, int? width}) {
    String url = this;
    List<String> list = url.split("/");
    return "$baseUrl/id/${list[4]}/${height ?? 300}/${width ?? 200}";
  }

  getPath() {
    String url = this;
    url = url.replaceAll(baseUrl, "");
    url = url.replaceAll(baseUrl, "");
    url = url.replaceFirst(RegExp(r"\?[^]*"), "");
    return url;
  }
}
