
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';




class CatScreen extends StatefulWidget {
  const CatScreen({
    super.key,
    required this.catCubit,
  });
  final CatCubit catCubit;

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatCubit, CatState>(
      bloc: widget.catCubit,
      builder: (BuildContext context, CatState state) {
        return Scaffold(
          key: _key,
          body: Stack(
            children: [
              _body(context, state),
              if (state.isLoading)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withAlpha(200),
                  child: Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.teal),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, CatState state) {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Gatos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          // Agrega aquí más contenido
        ],
      ),
    ),
  );
}

}
