import 'package:bloc/bloc.dart';
import 'package:untitled3/features/favorite/data/cubit/state_favoite.dart';
import '../../../../core/services/favorite_services.dart';
import '../model/favorite_model.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit():super(FavoritesInitialState());
   final FavoriteServices favoriteServices=FavoriteServices();
  List<Product>favorites=[];

///get
  Future<void>getFavorite()async{
    emit(FavoritesLoadingState());
   try{
     final response= await favoriteServices.getFavorite();
     favorites= response.data;
     emit(FavoritesSuccessState(favorites));
   }catch(e){
     emit(FavoritesErrorState(e.toString()));
   }
  }
/// add
  Future<void> addFavorite(String productId) async {
    emit(FavoritesAddLoadingState());

    try {
      await favoriteServices.addFavorite(productId);

      final response = await favoriteServices.getFavorite();
      favorites = response.data;

      emit(FavoritesAddSuccessState(favorites));
    } catch (e) {
      emit(FavoritesAddErrorState(e.toString()));
    }
  }
  /// delete
  Future<void>deleteFavorite(String productId)async{
    emit(FavoritesDeleteLoadingState());
    try{
       await favoriteServices.deleteFavorite(productId);
       final response = await favoriteServices.getFavorite();
       favorites = response.data;
      emit(FavoritesDeleteSuccessState(favorites));
    }catch(e){
      emit(FavoritesDeleteErrorState(e.toString()));
    }
  }

  bool isFavorite(String productId) {
    return favorites.any((e) => e.id == productId);
  }}