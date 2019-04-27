
import 'package:meta/meta.dart';
import 'package:sample/models/product.dart';

class AppState{
  final List<Product> products;

  AppState({
    @required this.products
  });

  factory AppState.initialState(){
    return AppState(
      products: []
    );
  }

  AppState copyWith({List<Product> products}){
    return AppState(
      products: products ?? this.products
    );
  }

}