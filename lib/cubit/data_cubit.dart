import 'package:cubit_demo/api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit() : super(DataInitial(1, [], false, false));
  final ApiRepository apiRepository = ApiRepository();

  Future<void> fetchPost() async {
    try {
      if (state.postList.isNotEmpty) {
        state.fetch = true;
        state.apiFlag = false;
      }
      if (state.postList.isEmpty) {
        emit(DataLoading(state.pageNo, state.postList, false, state.apiFlag));
      }
      final postList = await apiRepository.fetchPost(state.pageNo);
      if (postList.isNotEmpty && postList != null) {
        state.postList.addAll(postList);
        state.pageNo = state.pageNo + 1;
        state.apiFlag = true;
        emit(DataLoaded(
            state.pageNo, state.postList, state.fetch, state.apiFlag));
        Future.delayed(const Duration(milliseconds: 500), () {
          state.fetch = false;
          emit(DataLoaded(
              state.pageNo, state.postList, state.fetch, state.apiFlag));
        });
      }
    } catch (e) {
      debugPrint("777$e");
      emit(DataError(state.pageNo, state.postList, state.fetch, state.apiFlag));
    }
  }
}
