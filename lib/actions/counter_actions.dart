
import 'package:sample/models/product.dart';

class AddNewProductAction{
  final Product product;
  AddNewProductAction(this.product);
}

class RemoveProductAction{
  final Product product;
  RemoveProductAction(this.product);
}