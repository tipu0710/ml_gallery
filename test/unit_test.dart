import 'package:flutter_test/flutter_test.dart';
import 'package:ml_gallery/utils/constants.dart';

void main() {
  group("image library", () {
    test("url change", () {
      String url = "https://picsum.photos/id/0/5616/3744";
      List<String> list = url.split("/");
      expect("$baseUrl/id/${list[4]}/300/200",
          "https://picsum.photos/id/0/300/200");
    });

    test("url path", () {
      String url = "https://picsum.photos/v2/list?page=2&limit=100";
      url = url.replaceAll(baseUrl, "");
      url = url.replaceFirst(RegExp(r"\?[^]*"), "");
      expect(url,
          "/v2/list");
    });
  });
}
