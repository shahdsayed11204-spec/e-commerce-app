
import '../model/favorite_model.dart';

abstract class FavoritesStates {}

class FavoritesInitialState extends FavoritesStates {}

class FavoritesLoadingState extends FavoritesStates {}

class FavoritesSuccessState extends FavoritesStates {
  final List<Product> favorites;

  FavoritesSuccessState(this.favorites);

}

class FavoritesErrorState extends FavoritesStates {
  final String error;

  FavoritesErrorState(this.error);
}

class FavoritesAddLoadingState extends FavoritesStates {}

class FavoritesAddSuccessState extends FavoritesStates {
  final List<Product> favorites;

  FavoritesAddSuccessState(this.favorites);
}

class FavoritesAddErrorState extends FavoritesStates {
  final String error;

  FavoritesAddErrorState(this.error);
}
class FavoritesDeleteLoadingState extends FavoritesStates {}

class FavoritesDeleteSuccessState extends FavoritesStates {
  final List<Product> favorites;

  FavoritesDeleteSuccessState(this.favorites);
}

class FavoritesDeleteErrorState extends FavoritesStates {
  final String error;

  FavoritesDeleteErrorState(this.error);
}