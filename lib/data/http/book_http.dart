import 'package:flutter_api/data/models/book_model.dart';
import 'package:googleapis/books/v1.dart';
import 'package:googleapis_auth/auth.dart';

class BookHttp {
  Future<List<Book>> getAll({required String search}) async {
    const apiKey = 'AIzaSyBzaja4KfW8p9m9nwLRkzXrZl3UJspqm4U'; // Replace with your actual API key
    final httpClient = clientViaApiKey(apiKey);
    final booksApi = BooksApi(httpClient);
    final List<Book> books = [];
    final response = await booksApi.volumes.list(search);
    if (response.items != null) {
      for (final item in response.items!) {
        final volumeInfo = item.volumeInfo;
        final title = volumeInfo?.title;
        final description = volumeInfo?.description;
        final thumbnail = volumeInfo?.imageLinks?.thumbnail == null ? "https://img.freepik.com/vetores-gratis/pilha-de-livros-de-design-plano-desenhado-a-mao_23-2149334862.jpg?size=626&ext=jpg" : volumeInfo?.imageLinks?.thumbnail;

        if (title != null || description != null) {
          books.add(Book(title: title, description: description,thumbnail: thumbnail));
        }
      }
    }
    return books;
  }
}
