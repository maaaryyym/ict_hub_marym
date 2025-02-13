import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ict_hub_marym/cubits/products_cubit/states.dart';
import '../../data/data source/ProductsDataSource.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());

  ProductsDataSource productsDataSource = ProductsDataSource();

  void getProducts() async {
    try {
      final products = await productsDataSource.getProducts();
      if (products != null) {
        emit(ProductsLoaded(products));
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
