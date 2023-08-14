import 'package:flutter/material.dart';
import 'package:nata_food/model/resep.api.dart';
import 'package:nata_food/views/detail_resep.dart';
import 'package:nata_food/views/widget/resep_card.dart';

import '../model/resep.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Resep> _resep;
  bool _isLoading = true;
  List<Resep> _resepOriginal = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getResep();
  }

  void onSearchTextChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        // Jika kotak pencarian kosong, tampilkan semua data resep
        _resep = List.from(_resepOriginal);
      } else {
        // Jika kotak pencarian berisi, lakukan pencarian berdasarkan kata kunci
        String searchKeyword = value.toLowerCase();
        _resep = _resepOriginal.where((resepmakanan) {
          String title = resepmakanan.name.toLowerCase();
          return title.contains(searchKeyword);
        }).toList();
      }
    });
  }

  Future<void> getResep() async {
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
      _resepOriginal =
          List.from(_resep); // Simpan data _resep ke _resepOriginal
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Nata Food')
          ],
        ),
      ),
      body: Column(
        children: [
          // Kotak Pencarian
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Callback ketika nilai pencarian berubah
                onSearchTextChanged(value);
              },
              decoration: InputDecoration(
                hintText: 'Cari resep makanan...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          // Tampilkan hasil pencarian jika ada, jika tidak, tampilkan daftar resep awal
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : (_resep != null && _resep.isNotEmpty)
                    ? ListView.builder(
                        itemCount: _resep.length,
                        itemBuilder: (context, index) {
                          // Tampilkan ResepCard seperti sebelumnya
                          return GestureDetector(
                            child: ResepCard(
                              title: _resep[index].name,
                              cookTime: _resep[index].totalTime,
                              rating: _resep[index].rating.toString(),
                              thumnailUrl: _resep[index].images,
                              videoUrl: _resep[index].videoUrl,
                              instructions: _resep[index].instructions,
                            ),
                            onTap: () {
                              // Navigasi ke halaman detail resep
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailResep(
                                    name: _resep[index].name,
                                    totalTime: _resep[index].totalTime,
                                    rating: _resep[index].rating.toString(),
                                    images: _resep[index].images,
                                    description: _resep[index].descroption,
                                    videoUrl: _resep[index].videoUrl,
                                    instructions: _resep[index].instructions,
                                    sections: _resep[index].sections,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                            'Tidak ada resep yang cocok dengan kata kunci tersebut.'),
                      ),
          ),
        ],
      ),
    );
  }
}
