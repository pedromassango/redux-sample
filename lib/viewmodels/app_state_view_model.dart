
import 'package:redux/redux.dart';
import 'package:sample/actions/counter_actions.dart';
import 'package:sample/models/product.dart';
import 'package:sample/redux/app_state.dart';

class AppStateViewModel{
  final List<Product> products;
  final Function(Product) onAddNewProduct;
  final Function(Product) onRemoveProduct;

  AppStateViewModel({
    this.products,
    this.onAddNewProduct,
    this.onRemoveProduct
  });

  factory AppStateViewModel.fromStore(Store<AppState> store){
    return AppStateViewModel(
      products: store.state.products,
      onAddNewProduct: (product){
        store.dispatch( AddNewProductAction(product));
      },
      onRemoveProduct: (product){
        store.dispatch(RemoveProductAction(product));
      }
    );
  }
}