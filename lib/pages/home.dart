import 'package:flutter/material.dart';
import 'package:flutter_giphy_search/services/gif_service.dart';
import 'package:flutter_giphy_search/widgets/gif_table.dart';

const GIF_TITLE_URL =
    "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final gifService = GifService();

  final formKey = GlobalKey<FormState>();
  final TextEditingController searchInputController = TextEditingController();

  String search = '';
  int offset = 0;

  void onLoadMore() {
    print('more');
    setState(() {
      offset += 19;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(GIF_TITLE_URL),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira um texto";
                  }

                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    search = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    'Pesquise aqui',
                    style: TextStyle(color: Colors.white),
                  ),
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.white),
                controller: searchInputController,
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: gifService.getGifs(offset, search),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(strokeWidth: 5),
                        ),
                      );

                    default:
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Erro ao carregar dados :( \n\n ${snapshot.error.toString()}',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsetsGeometry.only(top: 12),
                        child: GifTable(
                          gifs: snapshot.data ?? [],
                          onLoadMore: onLoadMore,
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
