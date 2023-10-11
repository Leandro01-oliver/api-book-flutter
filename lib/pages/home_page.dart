import 'package:flutter/material.dart';
import 'package:flutter_api/data/models/book_model.dart';
import 'package:flutter_api/data/repositories/book_repositorie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Future<List<Book>>? listApiBook;
  List<Book> data = [];
  List<Book> listaFiltro = [];
  final TextEditingController searchController = TextEditingController();
  void stateApi({required String search}) {
    setState(() {
      listApiBook = BookRepositorie().getAll(search: search);
    });
  }

  void stateTeste({required List<Book> book, required String search}) {
    listaFiltro = search.toLowerCase().trim() != ""
        ? book
            .where((item) =>
                item.title!.toLowerCase().contains(search.toLowerCase().trim()))
            .toList()
        : book.toList();
  }

  @override
  void initState() {
    super.initState();
    listApiBook = BookRepositorie().getAll(search: "");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.black,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.black,
        onSurface: Colors.black,
        error: Colors.black,
        onError: Colors.black,
      )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home",style: TextStyle(color: Colors.white)),centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 15),
              Expanded(
                child: _buildBookList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(150, 0, 0, 0),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 8, 5),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (data.length > 0) {
                    setState(() {
                      stateTeste(book: data, search: searchController.text);
                    });
                  }
                },
                controller: searchController,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.black,
              ),
              child: const Icon(
                Icons.search,
                size: 15,
                color: Colors.white,
              ),
            ),
            onTap: () {
              if (searchController.text.isNotEmpty) {
                stateApi(search: searchController.text);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBookList() {
    return FutureBuilder<List<Book>>(
      future: listApiBook,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.error, color: Colors.red, size: 40),
                SizedBox(height: 10),
                Text('Erro ao carregar os dados!'),
              ],
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Nenhum livro encontrado!'),
          );
        } else {
          final lista = snapshot.data!;
          data = lista;
          stateTeste(book: data, search: searchController.text);
          if (listaFiltro.length == 0) {
            return const Text("Nenhum livro foi encontrado");
          } else {
            return ListView.builder(
              itemCount: listaFiltro.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(150, 0, 0, 0),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "${listaFiltro[index].thumbnail}"),
                                          fit: BoxFit.fill),
                                    ),
                                    child: null),
                              ),
                              ListTile(
                                title: Center(
                                  child: Text(
                                    "${listaFiltro[index].title}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    )
                  ],
                );
              },
            );
          }
        }
      },
    );
  }
}
