

import 'package:flutter_api/data/models/book_model.dart';

abstract class IbookRepositorie{
  Future<List<Book>> getAll({required String search});
}