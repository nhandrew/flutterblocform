import 'package:flutter/material.dart';
import './src/blocs/product_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProductProvider(
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    final bloc = ProductProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          productName(bloc),
          productPrice(bloc),
          saveButton(bloc),
        ],)
      )
    );
  }

  Widget productName(ProductBloc bloc){
    return StreamBuilder<String>(
          stream: bloc.productName,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            labelText: 'Product Name',
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeProductName,
        );
      }
    );
  }

  Widget productPrice(ProductBloc bloc){
    return StreamBuilder<double>(
      stream: bloc.productPrice,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Product Price',
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeProductPrice,
        );
      }
    );
  }

  Widget saveButton(ProductBloc bloc){
    return StreamBuilder<bool>(
      stream: bloc.productValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Save Product'),
          onPressed: !snapshot.hasData ? null : bloc.submitProduct,
        );
      }
    );
  }
}