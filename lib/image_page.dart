import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:unsplash_flutter/models.dart';
import 'package:unsplash_flutter/widget/info_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:unsplash_flutter/unsplash_image_provider.dart';

/// Screen for showing an individual [UnsplashImage].
class ImagePage extends StatefulWidget {
  final String imageId, imageUrl;

  ImagePage(this.imageId, this.imageUrl, {Key key}) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

/// Provide a state for [ImagePage].
class _ImagePageState extends State<ImagePage> {
  /// create global key to show info bottom sheet
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// Bottomsheet controller
  PersistentBottomSheetController bottomSheetController;

  /// Displayed image.
  UnsplashImage image;

  @override
  void initState() {
    super.initState();
    // load image
    _loadImage();
  }

  /// Reloads the image from unsplash to get extra data, like: exif, location, ...
  _loadImage() async {
    UnsplashImage image = await UnsplashImageProvider.loadImage(widget.imageId);
    setState(() {
      this.image = image;
      // reload bottom sheet if open
      if (bottomSheetController != null) {
        _showInfoBottomSheet();
      }
    });
  }

  /// Returns AppBar.
  Widget _buildAppBar() => AppBar(
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    leading:
    // back button
    IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context)),
    actions: <Widget>[
      // show image info
      IconButton(
          icon: Icon(
            Icons.info_outline,
            color: Colors.white,

          ),
          tooltip: 'Image Info',
          onPressed: () => bottomSheetController = _showInfoBottomSheet()),
      // open in browser icon button
      IconButton(
          icon: Icon(
            Icons.open_in_browser,
            color: Colors.white,
          ),
          tooltip: 'open in browser',
          onPressed: () => launch (image?. getDownloadLink())),
    ],
  );

  /// Returns PhotoView around given [imageId] & [imageUrl].
  Widget _buildPhotoView(String imageId, String imageUrl) => PhotoView(
    imageProvider: NetworkImage(imageUrl),
    initialScale: PhotoViewComputedScale.covered,
    minScale: PhotoViewComputedScale.covered,
    maxScale: PhotoViewComputedScale.covered,
    loadingChild: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
        )),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(  floatingActionButton: FloatingActionButton.extended(
      onPressed: () {

        // Add your onPressed code here!
      },
      label: Text('Download',style: TextStyle(color: Colors.white,),),
      icon: Icon(FontAwesomeIcons.download,color: Colors.white,),
      backgroundColor: Colors.pink,
    ),
      // set the global key
      key: _scaffoldKey,
     // backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildPhotoView(widget.imageId, widget.imageUrl),
          // wrap in Positioned to not use entire screen
          Positioned(top: 0.0, left: 0.0, right: 0.0, child: _buildAppBar()),
        ],
      ),
    );
  }

  /// Shows a BottomSheet containing image info.
  PersistentBottomSheetController _showInfoBottomSheet() {
    return _scaffoldKey.currentState.showBottomSheet(
          (context) => InfoSheet(image),
    );
  }
}
