part of 'data_cubit.dart';

abstract class DataState {
  int pageNo = 1;
  List postList = [];
  bool fetch = false;
  bool apiFlag = false;

  DataState(this.pageNo, this.postList, this.fetch, this.apiFlag);
}

class DataInitial extends DataState {
  DataInitial(super.pageNo, super.postList, super.fetch, super.apiFlag);
}

class DataLoading extends DataState {
  DataLoading(super.pageNo, super.postList, super.fetch, super.apiFlag);
}

class DataLoaded extends DataState {
  DataLoaded(super.pageNo, super.postList, super.fetch, super.apiFlag);
}

class DataError extends DataState {
  DataError(super.pageNo, super.postList, super.fetch, super.apiFlag);
}
