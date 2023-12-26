import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
const dummyLink = 'https://imaginemedia.blob.core.windows.net/content/IC22%20Official%20Rules%20and%20Regulations-3691754ecc71.pdf';

class CustomPDFViewer extends StatefulWidget {
  @override
  _CustomPDFViewerState createState() => _CustomPDFViewerState();
}

class _CustomPDFViewerState extends State<CustomPDFViewer> {
  late PDFViewController _pdfViewController;
  int _currentPage = 0;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom PDF Viewer'),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: dummyLink, // Ganti dengan path file PDF Anda
            autoSpacing: true,
            pageFling: true,
            onRender: (pages) {
              setState(() {
                _isLoading = false;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
              print('apa sihhh');
            },
            onPageChanged: ( page,  total) {
              setState(() {
                if(page!= null) {
                  _currentPage = page;
                }
              });
            },
          ),
          _isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Container(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              if (_pdfViewController != null && _currentPage > 0) {
                _pdfViewController.setPage(_currentPage - 1);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () async {
              int? pageCount = await _pdfViewController.getPageCount();

              if (_pdfViewController != null && pageCount!= null && _currentPage < pageCount - 1) {
                _pdfViewController.setPage(_currentPage + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}
