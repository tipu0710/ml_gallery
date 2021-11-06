import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ml_gallery/ui/home/controller/image_library_controller.dart';
import 'package:ml_gallery/ui/home/model/image_info_model.dart';
import 'package:ml_gallery/ui/home/view/photo_card.dart';

class PhotoLibrary extends StatefulWidget {
  const PhotoLibrary({Key? key}) : super(key: key);

  @override
  _PhotoLibraryState createState() => _PhotoLibraryState();
}

class _PhotoLibraryState extends State<PhotoLibrary> {
  int _page = 1;

  List<ImageInfoModel> imageList = <ImageInfoModel>[];

  late final PagingController<int, ImageInfoModel> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: _page);
    _pagingController.addPageRequestListener((pageKey) {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 40 / 70,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
      ),
      builderDelegate: PagedChildBuilderDelegate<ImageInfoModel>(
        itemBuilder: (_, model, index) => PhotoCard(imageInfoModel: model,),
        newPageProgressIndicatorBuilder: (_) =>  Container(
          height: 70,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
      ),
          child: const Center(
            child: SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 1,
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  getData() async {
    var list = await ImageLibraryController().getImageList(_page);
    imageList.addAll(list);
    if (mounted && list.isNotEmpty) {
      _page++;
      _pagingController.appendPage(list, _page);
    }
  }
}