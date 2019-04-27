
import 'package:sample/actions/counter_actions.dart';
import 'package:sample/redux/app_state.dart';

AppState productsReducer(AppState state, dynamic action){

  if(action is AddNewProductAction){
    state.products..add(action.product);

    return state.copyWith(
      products: state.products
    );
  }else if(action is RemoveProductAction){
    state.products.remove(action.product);

    return state.copyWith(
      products: state.products
    );
  }
  return state;
}
