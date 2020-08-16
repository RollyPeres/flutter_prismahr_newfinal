import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

typedef ImageChanged = void Function(List<Asset> images);

class MultiImagePickerComponent extends StatefulWidget {
  final String subject;
  final int maxImages;
  final bool enableCamera;
  final int crossAxisCount;
  final ImageChanged onImageChanged;

  MultiImagePickerComponent({
    Key key,
    this.maxImages = 6,
    this.crossAxisCount = 3,
    this.enableCamera = true,
    @required this.subject,
    @required this.onImageChanged,
  }) : super(key: key);

  @override
  _MultiImagePickerComponentState createState() =>
      _MultiImagePickerComponentState();
}

class _MultiImagePickerComponentState extends State<MultiImagePickerComponent> {
  List<Asset> images = <Asset>[];

  Future<void> _loadAssets() async {
    List<Asset> resultList;

    try {
      resultList = await MultiImagePicker.pickImages(
        // We need to calculate the limit of image picker based on the maximum
        // images subtracted by the total of current selected images.
        selectedAssets: images,
        maxImages: widget.maxImages,
        enableCamera: widget.enableCamera,
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // If there is any selected images, add the images with the current
    // selected images.
    if (resultList != null) {
      setState(() {
        images = resultList;
      });
      widget.onImageChanged(images);
    }
  }

  void _showOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 300),
                  child: AssetThumb(
                    asset: images[index],
                    height: images[index].originalHeight,
                    width: images[index].originalWidth,
                  ),
                ),
              ),
              Divider(height: 0),
              InkWell(
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Remove this image',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    images.remove(images[index]);
                  });
                  widget.onImageChanged(images);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.isNotEmpty) return _thumbnails(context);
    return _picker(context);
  }

  Widget _thumbnails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.00),
              color: Theme.of(context).cardColor,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.00),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: widget.crossAxisCount,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    children: List.generate(images.length, (int index) {
                      Asset asset = images[index];
                      return GestureDetector(
                        child: AssetThumb(
                          asset: asset,
                          width: 300,
                          height: 300,
                        ),
                        onTap: () => _showOptionsDialog(index),
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: 5.00,
                  right: 10.00,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.00,
                      vertical: 4.00,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10.00),
                    ),
                    child: Center(
                      child: Text(
                        '${images.length}/${widget.maxImages}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5.00,
                  right: 10.00,
                  child: images.length < widget.maxImages
                      ? _addMoreImageButton()
                      : SizedBox(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Text(
              'Tap on the image to remove.',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  Widget _picker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          color: Theme.of(context).cardColor,
          child: InkWell(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 125),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.00),
                      child: Icon(Icons.add_a_photo),
                    ),
                    Text('Add ${widget.subject}')
                  ],
                ),
              ),
            ),
            onTap: _loadAssets,
          ),
        ),
      ),
    );
  }

  Widget _addMoreImageButton() {
    return SizedBox(
      height: 40,
      child: RaisedButton(
        color: Colors.black54,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.00)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.00),
              child: Icon(
                Icons.add_a_photo,
                size: 16,
                color: Colors.white,
              ),
            ),
            Text(
              'Add More ${widget.subject}',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        onPressed: _loadAssets,
      ),
    );
  }
}
