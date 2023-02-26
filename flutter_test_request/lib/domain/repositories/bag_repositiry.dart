import '../models/bag_model.dart';

class BagRepository {
  BagRepository._private();

  static final BagRepository _instance = BagRepository._private();
  static BagRepository get instance => _instance;

  final BagModel model = BagModel();

  BagRepository() {}

  BagModel getPizzaListInfo() {
    BagModel model = this.model;
    return model;
  }
}
