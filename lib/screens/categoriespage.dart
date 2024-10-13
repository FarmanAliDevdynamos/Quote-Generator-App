import 'package:flutter/material.dart';
import 'package:auto_quote_generator_app/models/grid_model.dart';
import 'dart:math';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart'; // Google Fonts
import 'package:animate_do/animate_do.dart'; // For new animations

class CategoryPage extends StatefulWidget {
  final GridModel category;

  const CategoryPage({super.key, required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? _currentQuote;
  bool _isWhite = false;

  void _generateQuote() {
    final randomIndex = Random().nextInt(widget.category.quotes.length);
    setState(() {
      _currentQuote = widget.category.quotes[randomIndex].text;
    });
  }

  Future<void> _showQuoteDialog() async {
    _generateQuote();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                'Generated Quote',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.merriweather(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                          text: '“',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(
                          text: _currentQuote ?? 'No quote available',
                        ),
                        const TextSpan(
                          text: '”',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isWhite = false; // Reset button to blue
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _dimBackground();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          _generateQuote();
                          setState(() {});
                        });
                      },
                      child: Text(
                        'Next Quote',
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.blue),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: _currentQuote ?? 'No quote available'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Quote copied to clipboard!')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.blue),
                      onPressed: _shareQuote,
                    ),
                  ],
                ),
              ],
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollable: true,
            );
          },
        );
      },
    );
  }

  void _shareQuote() {
    if (_currentQuote != null && _currentQuote!.isNotEmpty) {
      Share.share(_currentQuote!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No quote available to share!')),
      );
    }
  }

  void _dimBackground() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return false;
          },
          child: Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pop();
    });
  }

  void _handleButtonPress() {
    setState(() {
      _isWhite = true;
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isWhite = false;
      });
    });

    _showQuoteDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 81, 146),
        title: Text(
          widget.category.title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
            ),
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    widget.category.image,
                    height: constraints.maxWidth > 600
                        ? 400
                        : 250, // Adjust height for larger screens
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.category.title,
                  style: GoogleFonts.poppins(
                    fontSize: constraints.maxWidth > 600
                        ? 36
                        : 28, // Adjust font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Here are some inspiring ${widget.category.title.toLowerCase()} that will help you get through your day with positivity and motivation.',
                  style: GoogleFonts.merriweather(
                    fontSize: constraints.maxWidth > 600
                        ? 22
                        : 18, // Adjust font size
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ZoomIn(
                  // Using ZoomIn animation from animate_do
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isWhite
                          ? Colors.white
                          : Colors.blue, // Updated property
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    onPressed: _handleButtonPress,
                    child: Text(
                      'Generate Quote',
                      style: GoogleFonts.poppins(
                        fontSize: constraints.maxWidth > 600
                            ? 22
                            : 18, // Adjust font size
                        color: _isWhite ? Colors.blue : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
