import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sample/models/product.dart';
import 'package:sample/redux/app_state.dart';
import 'package:sample/viewmodels/app_state_view_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Center(
          child: Text("Hello Redux"),
        ),
      ),
      body: Column(
        children: <Widget>[]
        ..add(StoreConnector<AppState, AppStateViewModel>(
          converter: (store) => AppStateViewModel.fromStore(store),
          builder: (BuildContext c, AppStateViewModel model){
            return TextField(
              onSubmitted: (text){
                model.onAddNewProduct(
                    Product(id: "1", name: text)
                );
              },
            );
          },
        ))
        ..add(Expanded(
          child: StoreConnector<AppState, AppStateViewModel>(
            converter: (store) => AppStateViewModel.fromStore(store),
            builder: (BuildContext context,
                AppStateViewModel appStateViewModel) {

              return appStateViewModel.products.isEmpty ?
              Center(child: Text("No Products to show!"),) :
              ListView.builder(
                itemCount: appStateViewModel.products.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  final product = appStateViewModel.products.elementAt(index);

                  return ListTile(
                    title: Text(product.name),
                    trailing: IconButton(icon: Icon(Icons.delete),
                      onPressed: ()=> appStateViewModel.onRemoveProduct(product),
                    ),
                  );
                },
              );
            },
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}
