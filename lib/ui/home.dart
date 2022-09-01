import 'package:flutter/material.dart';
import 'package:aps7_8_sem/lib/getCity.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

const baseUrlIcon = "http://openweathermap.org/img/wn/#cod_icon#.png";

Map<String, dynamic> dadosCidade = {
  'nome': '',
  'pais': '',
  'clima_desc': '',
  'clima_icon': '',
  'temp': 0,
  'temp_min': 0,
  'temp_max': 0,
};

class HomeState extends State<Home> {
  final TextEditingController SearchController = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();
    getCity("Varzea Paulista").then((response){
      dadosCidade['nome'] = response['name'];
      dadosCidade['pais'] = response['sys']['country'];
      dadosCidade['clima_desc'] = response['weather'][0]['description'];
      dadosCidade['clima_icon'] = response['weather'][0]['icon'];
      dadosCidade['temp'] = response['main']['temp'];
      dadosCidade['temp_min'] = response['main']['temp_min'];
      dadosCidade['temp_max'] = response['main']['temp_max'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: SearchController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Pesquise uma cidade',
                          hintText: 'Ex. Jundiaí',
                          errorText: errorText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff00d7f3),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Color(0xff00d7f3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = SearchController.text;

                        if(text.isEmpty){
                          setState(() {
                            errorText = 'A pesquisa não pode ser vazia!';
                          });
                          return;
                        }
                        getCity(text).then((response){
                          setState(() {
                            dadosCidade['nome'] = response['name'];
                            dadosCidade['pais'] = response['sys']['country'];
                            dadosCidade['clima_desc'] = response['weather'][0]['description'];
                            dadosCidade['clima_icon'] = response['weather'][0]['icon'];
                            dadosCidade['temp'] = response['main']['temp'];
                            dadosCidade['temp_min'] = response['main']['temp_min'];
                            dadosCidade['temp_max'] = response['main']['temp_max'];
                            errorText = null;
                          });
                          print(dadosCidade);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff00d7f3),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                      dadosCidade['nome'].toString().isNotEmpty ? Text(dadosCidade['nome'] + ", " + dadosCidade['pais']) : Text(''),
                      dadosCidade['nome'].toString().isNotEmpty ? Text(dadosCidade['temp'].toString()) : Text(''),
                      dadosCidade['nome'].toString().isNotEmpty ? Image.network(
                        baseUrlIcon.replaceAll('#cod_icon#', dadosCidade['clima_icon']),
                        height: 20,
                        width: 20,
                      ) : Text(''),
                      dadosCidade['nome'].toString().isNotEmpty ? Text(dadosCidade['clima_desc']) : Text(''),
                      dadosCidade['nome'].toString().isNotEmpty ? Text("Min.: " + dadosCidade['temp_min'].toString() + " / Máx.: " + dadosCidade['temp_max'].toString()) : Text(''),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}