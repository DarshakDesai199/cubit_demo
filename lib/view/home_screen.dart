import 'package:cubit_demo/cubit/data_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    BlocProvider.of<DataCubit>(context).fetchPost();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        BlocProvider.of<DataCubit>(context).fetchPost();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text("Cubit Demo", style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.black),
        body: BlocBuilder<DataCubit, DataState>(builder: (context, state) {
          if (state is DataInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DataLoaded) {
            return Column(children: [
              Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0),
                      controller: scrollController,
                      itemCount: state.postList.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Text(
                                          "${state.postList[index]["id"]}."),
                                      title: Text(
                                          "${state.postList[index]["title"]}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2),
                                      subtitle: Text(
                                        "${state.postList[index]["body"]}",
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 0)
                                ]));
                      })),
              state.fetch == true
                  ? const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Center(
                        child: CupertinoActivityIndicator(color: Colors.black),
                      ))
                  : const SizedBox()
            ]);
          } else if (state is DataError) {
            return const Center(
              child: Text("Error!"),
            );
          } else {
            return const Center(child: Text("Unknown Error!"));
          }
        }));
  }
}
