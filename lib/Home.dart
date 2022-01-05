import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _imagemApp = AssetImage("Imagens/padrao.png", );
  var _mensagemResultado = "";
  bool primeiraExecucao = true;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "Sons/");

  _musicaPadrao() async {

    if( primeiraExecucao ){
      audioPlayer = await audioCache.loop("som_padrao.mp3");
      primeiraExecucao = false;
    }
  }

  jokenpo() async{
    audioPlayer = await audioCache.play("jokenpo.mp3");
  }

  void opcaoSelecionada(String escolhaUsuario){

     Future.delayed(Duration(milliseconds: 1400), () {

       var opcoes = ["pedra", "papel", "tesoura"];
       var numero = Random().nextInt(3);
       var escolhaApp = opcoes[numero];

       switch(escolhaApp){

         case "pedra" :
           setState(() {
             this._imagemApp = AssetImage("Imagens/pedra.png", );
           });
           break;

         case "papel" :
           setState(() {
             this._imagemApp = AssetImage("Imagens/papel.png", );
           });
           break;

         case "tesoura" :
           setState(() {
             this._imagemApp = AssetImage("Imagens/tesoura.png", );
           });
           break;
       }

       // se o usuario ganhar
       if(
       (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
           (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
           (escolhaUsuario == "papel" && escolhaApp == "pedra")
       ){
         setState(() {
           this._mensagemResultado = "Parabéns você ganhou!";
         });
       }

       // se o app ganhar
       else if(
       (escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
           (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
           (escolhaApp == "papel" && escolhaUsuario == "pedra")
       ){
         setState(() {
           this._mensagemResultado = "Que pena você perdeu:(";
         });
       }else{
         setState(() {
           this._mensagemResultado = "Empate!";
         });
       }

     });
  }

  @override

  Widget build(BuildContext context) {
    _musicaPadrao();

    return Scaffold(
      appBar: AppBar(
        title: Text("Jokenpô"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: Container(
            child: Column(
              children: [
              Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 16),
                  child: Text("Escolha do App:",
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Image(image: _imagemApp, height: 110,),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 16),
                  child: Text("Escolha uma opção abaixo:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       GestureDetector(
                            child: Image.asset("Imagens/papel.png", height: 100,),
                          onTap: () => opcaoSelecionada("papel"),
                        ),
                    GestureDetector(
                        child: Image.asset("Imagens/tesoura.png", height: 100,),
                      onTap: () => opcaoSelecionada("tesoura"),
                    ),
                    GestureDetector(
                        child: Image.asset("Imagens/pedra.png", height: 100,),
                      onTap: () => opcaoSelecionada("pedra"),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 16),
                  child: Text(this._mensagemResultado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      color: Colors.purple
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}