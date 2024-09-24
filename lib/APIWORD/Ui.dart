import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';


import 'ControllGetx.dart';

class ImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ImageListController controller = Get.put(ImageListController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Image List'),
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : controller.errorMessage.value.isNotEmpty
          ? Center(child: Text(controller.errorMessage.value))
          : ListView.builder(
        itemCount: controller.images.length,
        itemBuilder: (context, index) {
          final image = controller.images[index];
          return Card(
            child: ListTile(
              title: Text(image.name),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Text('UID: ${image.uid}'),
                    ],
                  ),
                  Row(
                    children: [
                      Text(' DocType: ${image.docType}'),
                    ],
                  ),
                ],
              ),
              trailing:
              Image.network(image.url, width: 100, height: 100),
            ),
          );
        },
      )),
    );
  }
}