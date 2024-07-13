import 'dart:io';

import 'package:ai_assistant_with_quotes/services/api_services.dart';
import 'package:ai_assistant_with_quotes/utils/app_colors.dart';
import 'package:ai_assistant_with_quotes/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class QuoteScreen extends StatefulWidget {
  final String name;
  final String question;
  final String bg;

  const QuoteScreen(
      {Key? key, required this.name, required this.question, required this.bg})
      : super(key: key);

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  String quote = "typing please wait...";
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    imageUrl = Constants.IMAGE_URL;
  }

  void _generateResponse(String prompt) async {
    setState(() {
      quote = "Loading...";
    });
    try {
      final response = await ApiService.generateResponse(prompt);
      setState(() {
        quote = response;
      });
    } catch (e) {
      setState(() {
        quote = "Failed to load response";
      });
    }
  }

  void _fetchImage(String searchTerm) async {
    try {
      final photoUrl = await ApiService.fetchImage(searchTerm);
      setState(() {
        imageUrl = photoUrl;
      });
    } catch (e) {
      // handle error
    }
  }

  Future<void> _captureAndSaveSC() async {
    try {
      final image = await screenshotController.capture();
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/screenshot.png');
      await file.writeAsBytes(image!);
      await ImageGallerySaver.saveImage(image);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Saved to Gallery')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.textColor.withOpacity(0.3),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (quote == "typing please wait..." || quote.isEmpty)
                  SpinKitThreeBounce(
                    color: AppColors.textColorWhite,
                    size: 50.0,
                  ),
                if (quote != "typing please wait..." && quote.isNotEmpty)
                  Card(
                    elevation: 0,
                    color: AppColors.greyColor.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        quote,
                        style: TextStyle(
                          color: AppColors.textColorWhite,
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          _buildFloatingActionButton(
            AppColors.redColor,
            Icons.copy,
            "Copy",
            () async {
              await Clipboard.setData(ClipboardData(text: quote));
            },
          ),
          SizedBox(width: 5),
          _buildFloatingActionButton(
            AppColors.buttonColor,
            Icons.refresh,
            "Text",
            () {
              _generateResponse(widget.question);
            },
          ),
          SizedBox(width: 5),
          _buildFloatingActionButton(
            AppColors.purpleColor,
            Icons.change_circle,
            "BG",
            () {
              _fetchImage(widget.name);
            },
          ),
          SizedBox(width: 5),
          _buildFloatingActionButton(
            AppColors.orangeDeepColor,
            Icons.download,
            "Save",
            _captureAndSaveSC,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(
      Color color, IconData icon, String text, VoidCallback onPressed) {
    return SizedBox.fromSize(
      size: Size(56, 56),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: AppColors.greenColor,
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: Colors.white),
                Text(text, style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
