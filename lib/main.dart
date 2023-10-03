import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data_buku.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text('DataBuku')
            ),
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: listBuku.length,
                itemBuilder: (context, index) {
                  final DataBuku buku = listBuku[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => detail ( dtbuk : buku )));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width /3 ,
                                child: Image(
                                  image: NetworkImage(buku.imageLink),
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                buku.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ]
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        )
    );
  }
}

class detail extends StatelessWidget {
  const detail({super.key, required this.dtbuk});

  final DataBuku dtbuk;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(dtbuk.title)
        ),
        backgroundColor: Colors.greenAccent,
        foregroundColor: Colors.white,
        actions: <Widget>[
          BookmarkButton(),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/5,
              child: Image.network(dtbuk.imageLink)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Judul dtbuk:',
                  style: TextStyle(
                    color: Colors.redAccent[900],
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                dtbuk.title,
                style: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Pengarang:',
                  style: TextStyle(
                    color: Colors.redAccent[900],
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                dtbuk.author,
                style: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Tahun Terbit:',
                  style: TextStyle(
                    color: Colors.redAccent[900],
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                dtbuk.year.toString(),
                style: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Negara:',
                  style: TextStyle(
                    color: Colors.redAccent[900],
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                dtbuk.country,
                style: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Bahasa:',
                  style: TextStyle(
                    color: Colors.redAccent[900],
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                dtbuk.language,
                style: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 30,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Jumlah Halaman:',
                  style: TextStyle(
                    color: Colors.redAccent[900],
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                dtbuk.pages.toString(),
                style: TextStyle(
                  color: Colors.pink[900],
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launcher(dtbuk.link);
        },
        tooltip: 'Open Web',
        child: Icon(Icons.open_in_browser_outlined),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  Future<void> _launcher(String url) async{
    final Uri _url = Uri.parse(url);
    if(!await launchUrl(_url)){
      throw Exception("gagal membuka url : $_url");
    }
  }
}

class BookmarkButton extends StatefulWidget {
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: _isBookmarked ? Colors.white : null,
      ),
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isBookmarked ? 'Berhasil menambahkan ke favorit.' : 'Berhasil menghapus dari favorit.'),
            backgroundColor : _isBookmarked ? Colors.lightGreen : Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }
}
