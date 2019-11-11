import 'package:flutter/material.dart';
import './product_bloc.dart';
export './product_bloc.dart';

class ProductProvider extends InheritedWidget{
  final ProductBloc bloc;

  ProductProvider({Key key, Widget child})
    :bloc = ProductBloc(),
    super(key : key, child : child);

    bool updateShouldNotify(_) => true;

    static ProductBloc of (BuildContext context){
      return (context.inheritFromWidgetOfExactType(ProductProvider) as ProductProvider)
      .bloc;
    }

}