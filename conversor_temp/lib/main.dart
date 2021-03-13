import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double temperature;
  double resultado;
  List<String> unidadeTemperatura = ['Fahrenheit','Kelvin','Reaumur','Rankine'];   
  String unidadeSelecionada;
  final GlobalKey<FormState>_formkey = GlobalKey();

  void initState() {
    unidadeSelecionada = unidadeTemperatura[0];
    temperature = 0;
    resultado = 0;
    super.initState();
  }

  void calcularTemperatura() {
    if (_formkey.currentState.validate()){
      _formkey.currentState.save();

      setState(() {
        switch (unidadeSelecionada) {
          case 'Fahrenheit':
            resultado = (temperature * 9 / 5) + 32; 
            break;
          case 'Kelvin':
            resultado = temperature + 273.15;
            break;
          case 'Reaumur':
            resultado = temperature - (temperature/5);
            break;
          case 'Rankine':
            resultado = (temperature + 273.15) * 9 / 5;
            break;
          default:
            resultado = -1;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text('Conversor de Temperatura')),

      body: Center(
              
        child: Form(
          key: _formkey,
                  
          child: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(

                children: [
                  const SizedBox (height: 20,),
                  const Text('Escolha a unidade'),
                  
                  DropdownButton <String> (
                    value: unidadeSelecionada,
                    underline: Container(height: 5, color: Colors.cyan,),
                    onChanged: (value){
                      setState(() {
                        unidadeSelecionada = value;
                      });
                    },
                    items: unidadeTemperatura.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                  ),

                  TextFormField(
                    initialValue: temperature.toString(),
                    decoration: InputDecoration(labelText: 'C'),
                    keyboardType: TextInputType.number,
                    onSaved: (value){
                      temperature = double.parse(value);
                    },
                    validator: (value){
                      if(value.isEmpty)
                        return 'Entrada inválida, por favor digite uma temperatura.';
                      
                      else if(double.tryParse(value) == null)
                        return 'Por favor, digite um número';
                      
                      return null;
                    },
                  ),

                  RaisedButton(
                    child: const Text('Calcular'),
                    color: Theme.of(context).primaryColor,
                    onPressed: calcularTemperatura,
                  ),

                  Card(
                    child: Text('Conversão' + ' $resultado', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    color: Theme.of(context).primaryColor,
                  )

                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}