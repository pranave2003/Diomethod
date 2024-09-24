import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'Model.dart';

class ImageListController extends GetxController {

  final String Token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcyNjEyNTUzNCwiZXhwIjoxNzU3NjYxNTM0fQ.WtYYgVWtxVQlbwoIKdd-HcUGGAKRKMIJayaRHzqjtRU";
  final images = RxList<ImageModel>([]);
  final isLoading = RxBool(false);
  final errorMessage = RxString('');

  Future<void> fetchImages() async {
    try {
      isLoading.value = true;
      final dio = Dio();
      dio.options.headers = {"Authorization": "$Token"};

      final response = await dio.post(
          "https://ajcjewel.com:4000/api/global-gallery/list",
          data: {
        "statusArray": [1],
        "screenType": [],
        "responseFormat": [],
        "globalGalleryIds": [],
        "categoryIds": [],
        "docTypes": [],
        "types": [],
        "limit": 10,
        "skip": 0,
        "searchingText": ""
      }

      );

      if (response.statusCode == 201) {
        final data = response.data;
        if (data['message'] == 'success') {
          images.value = (data['data']['list'] as List)
              .map((image) => ImageModel.fromJson(image))
              .toList();
        } else {
          errorMessage.value = "API returned message: ${data['message']}";
        }
      } else {
        errorMessage.value =
        "Failed to fetch images. Status code: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value =
      "Network error or other Dio exception: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }
}