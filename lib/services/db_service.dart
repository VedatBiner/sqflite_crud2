import '../utils/db_helper.dart';
import '../models/product_model.dart';

class DBService {
  // veri tabanından veri alacak metot
  Future<List<ProductModel>> getProducts() async {
    // veri tabanı açık mı değil mi?
    await DBHelper.init();
    List<Map<String, dynamic>> products =
        await DBHelper.query(ProductModel.table);
    return products.map((item) => ProductModel.fromMap(item)).toList();
  }

  // veri tabanına veri ekleyecek metot
  Future<bool> addProduct(ProductModel model) async {
    await DBHelper.init();
    int ret = await DBHelper.insert(ProductModel.table, model);
    return ret == 1 ? true : false; // 1 ise veri eklendi (true)
  }

  // veri tabanını güncelleyecek metot
  Future<bool> updateProduct(ProductModel model) async {
    await DBHelper.init();
    int ret = await DBHelper.update(ProductModel.table, model);
    return ret == 1 ? true : false; // 1 ise veri update edildi (true)
  }

  // veri tabanından veri silecek metot
  Future<bool> deleteProduct(ProductModel model) async {
    await DBHelper.init();
    int ret = await DBHelper.update(ProductModel.table, model);
    return ret == 1 ? true : false; // 1 ise veri update edildi (true)
  }

}
