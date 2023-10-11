
import 'package:flutter_api/data/http/book_http.dart';
import 'package:flutter_api/data/models/book_model.dart';
import 'package:flutter_api/data/repositories/interface/interface_book_repositorie.dart';

class BookRepositorie implements IbookRepositorie{
  @override
  Future<List<Book>> getAll({required String search}) async{
    List<Book> bookLista = await BookHttp().getAll(search: search);
    return bookLista;
  }


}