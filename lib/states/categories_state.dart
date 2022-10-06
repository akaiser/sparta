import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/models/category_model.dart';
import 'package:sparta/pages/_shared/network/categories_http_client.dart';
import 'package:sparta/pages/_shared/util/try_and_catch.dart';

abstract class _CategoriesAction extends Equatable {
  const _CategoriesAction();

  @override
  List<Object?> get props => [];
}

class FetchCategoriesAction extends _CategoriesAction {
  const FetchCategoriesAction();
}

class ResultFetchCategoriesAction extends _CategoriesAction {
  const ResultFetchCategoriesAction(this.categories);

  final Iterable<CategoryModel> categories;

  @override
  List<Object?> get props => [categories];
}

class ErrorFetchCategoriesAction extends _CategoriesAction {
  const ErrorFetchCategoriesAction(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}

TypedAppEpic<FetchCategoriesAction> fetchCategoriesEpic(
  CategoriesHttpClient http,
) =>
    TypedAppEpic<FetchCategoriesAction>(
      (actions, _) => actions
          //.where((_) => store.states.categoriesState.isLoading)
          .asyncMap<_CategoriesAction>(
        (_) => tryAndCatch(
          () => http
              .fetchCategories()
              .then((json) => json.map(CategoryModel.fromJson))
              .then(ResultFetchCategoriesAction.new),
          ErrorFetchCategoriesAction.new,
        ),
      ),
    );

CategoriesState categoriesStateReducer(
  CategoriesState old,
  dynamic action,
) {
  if (action is _CategoriesAction) {
    if (action is FetchCategoriesAction) {
      return const CategoriesState(isLoading: true);
    } else if (action is ResultFetchCategoriesAction) {
      return CategoriesState(categories: action.categories);
    } else if (action is ErrorFetchCategoriesAction) {
      // TODO(albert): handle errors in views
      return CategoriesState(exception: action.exception);
    }
  }
  return old;
}

class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.exception,
    this.isLoading = false,
  });

  final Iterable<CategoryModel> categories;
  final Exception? exception;
  final bool isLoading;

  @override
  List<Object?> get props => [
        categories,
        exception,
        isLoading,
      ];
}
