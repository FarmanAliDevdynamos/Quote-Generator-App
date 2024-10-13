// lib/models/grid_model.dart
import 'quote_model.dart';

class GridModel {
  final String title;
  final String image;
  final int cardId;
  final List<QuoteModel> quotes;

  GridModel({
    required this.title,
    required this.image,
    required this.cardId,
    required this.quotes,
  });
}
