import 'dart:async';

import 'package:rxdart/rxdart.dart';


class ProductBloc{

  //Declare Streams
  final _productName = BehaviorSubject<String>();
  final _productPrice = BehaviorSubject<String>();

  //Get Data from Streams
  Stream<String> get productName => _productName.stream.transform(validateProductName);
  Stream<double> get productPrice => _productPrice.stream.transform(validateProductPrice);
  Stream<bool> get productValid => Observable.combineLatest2(productName, productPrice, (productName,productPrice) => true);

  //Set Data
  Function(String) get changeProductName => _productName.sink.add;
  Function(String) get changeProductPrice => _productPrice.sink.add;

  dispose(){
    _productPrice.close();
    _productName.close();
  }

  //Transformers
  final validateProductName = StreamTransformer<String,String>.fromHandlers(
    handleData: (productName, sink){
      if (productName.length < 4){
        sink.addError('Product Name must be at Least 4 characters');
      } else {
        sink.add(productName);
      }
    }
  );

  final validateProductPrice = StreamTransformer<String, double>.fromHandlers(
    handleData: (productPrice, sink){
      try{
        sink.add(double.parse(productPrice));
      }catch(error){
        sink.addError('Value must be a number');
      }
    }
  );

  //Functions
  submitProduct(){
    print('Product Submitted Name: ${_productName.value} and Price: ${_productPrice.value}');
  }


}