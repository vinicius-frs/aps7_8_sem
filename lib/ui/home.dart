import 'package:flutter/material.dart';
import 'package:aps7_8_sem/lib/getCity.dart';
import 'package:aps7_8_sem/lib/climaCityClass.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

const baseUrlIcon = "http://openweathermap.org/img/wn/#cod_icon#.png";

ClimaCity cidade = ClimaCity('', '', '', '', 0, 0, 0);

class HomeState extends State<Home> {
  final TextEditingController SearchController = TextEditingController();
  String? errorText;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: SearchController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff002163)
                            )
                          ),
                          border: const OutlineInputBorder(),
                          labelText: 'Pesquise uma cidade',
                          hintText: 'Ex. Jundiaí',
                          hintStyle: TextStyle(color: Colors.white),
                          errorText: errorText,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff002163),
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
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
                            if(response['cod'] == 404 || response['cod'] == '404'){
                              errorText = 'Cidade não encontrada';
                            }
                            if(response['cod'] == 200 || response['cod'] == '200'){
                              cidade.nome = response['name'];
                              cidade.pais = response['sys']['country'];
                              cidade.climaDesc = response['weather'][0]['description'];
                              cidade.climaIcon = response['weather'][0]['icon'];
                              cidade.temp = response['main']['temp'];
                              cidade.tempMin = response['main']['temp_min'];
                              cidade.tempMax = response['main']['temp_max'];
                              errorText = null;
                            }
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff002163),
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                            children: [
                              Row(
                                  children: [
                                    cidade.nome.toString().isNotEmpty ?
                                    Text(
                                      cidade.nome + ", " + cidade.pais,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                                    ) : Text('')
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                  children: [
                                    cidade.nome.toString().isNotEmpty ?
                                    Text(
                                      cidade.temp.round().toString() + "\u00b0C",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45, color: Colors.white),
                                    ) : Text(''),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                  children: [
                                    cidade.nome.toString().isNotEmpty ?
                                    Text(
                                      "Min.: " + cidade.tempMin.round().toString() + "\u00b0C / Máx.: " + cidade.tempMax.round().toString() + "\u00b0C",
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ) : Text(''),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Row(
                                  children: [
                                    cidade.nome.toString().isNotEmpty ? Image.network(
                                      baseUrlIcon.replaceAll('#cod_icon#', cidade.climaIcon),
                                      height: 30,
                                      width: 30,
                                    ) : Text(''),
                                    cidade.nome.toString().isNotEmpty ?
                                    Text(
                                      cidade.climaDesc,
                                      style: TextStyle(fontSize: 20, color: Colors.white),
                                    ) : Text(''),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ]
                        ),
                        flex: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xff010012),
      ),
    );
  }
}