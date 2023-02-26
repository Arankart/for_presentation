import 'package:bloc/bloc.dart';
import 'package:flutter_test_request/domain/models/bag_model.dart';
import 'package:flutter_test_request/domain/models/pizza_model.dart';
import 'package:flutter_test_request/domain/repositories/bag_repositiry.dart';

part 'bag_page_state.dart';

class BagPageCubit extends Cubit<BagPageState> {
  final BagRepository bagRepository = BagRepository.instance;

  BagPageCubit() : super(BagPageInitial());

  Future<void> getBag() async {
    try {
      emit(BagPageLoading());
      final BagModel _loadedBag = await bagRepository.getPizzaListInfo();
    } catch (_) {
      emit(BagPageError());
    }
  }

  Future<void> cleanBag() async {
    bagRepository.model.pizzesInBag = [];
  }

  Future<void> addPizzaToBag(PizzaModel model) async {
    bagRepository.model.pizzesInBag.add(model);
    print('pizza added');
    bagRepository.model.pizzesInBag.forEach((pizza) => print('${pizza.title}'));
  }

  PizzaModel changePizzaPrice(PizzaModel model) {
    int pizzaPriceValue = int.parse(model.price);
    model.price = (pizzaPriceValue * 2).toString();
    return model;
  }

  void deletePizzeFromList(int index) {
    bagRepository.model.pizzesInBag.removeAt(index);
    emit(BagPageLoaded(model: bagRepository.model));
  }
}
