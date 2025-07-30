import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';
import 'package:xpert_flutter/utils/utils.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key, required this.catCubit});
  final CatCubit catCubit;

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.catCubit.getCats(context);
    });
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
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
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
          children: [
            Text(
              'Gatos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _carruselDeImagenes(),
            SizedBox(height: 20),
            Center(
              child: infoText(
                context,
                label: 'Raza',
                value: widget.catCubit.state.cat!.name,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            _buttonsVote(),
          ],
        ),
      ),
    );
  }

  Widget _buttonsVote() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            padding: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () {
                final int currentIndex = widget.catCubit.state.currentIndex;

                if (widget.catCubit.state.cats.length >= currentIndex + 1) {
                  widget.catCubit.changeIndex(
                    context,
                    newIndex: currentIndex + 1,
                  );
                  _carouselController.animateToPage(
                    currentIndex + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              icon: Icon(Icons.thumb_up, color: Colors.white, size: 50),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: IconButton(
              onPressed: () {
                final int currentIndex = widget.catCubit.state.currentIndex;

                if (widget.catCubit.state.cats.length >= currentIndex + 1) {
                  widget.catCubit.changeIndex(
                    context,
                    newIndex: currentIndex + 1,
                  );
                  _carouselController.animateToPage(
                    currentIndex + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              icon: Icon(Icons.thumb_down, color: Colors.white, size: 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _carruselDeImagenes() {
    List<CatModel> cats = widget.catCubit.state.cats;

    return CarouselSlider.builder(
      itemCount: cats.length,
      itemBuilder: (context, index, realIdx) {
        final cat = cats[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            cat.image?.url ?? '',
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Icon(Icons.error)),
          ),
        );
      },
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.4,
        autoPlay: false,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        pageSnapping: true,
        onPageChanged: (index, reason) {
          final currentIndex = widget.catCubit.state.currentIndex;

          if (index == currentIndex + 1) {
            widget.catCubit.changeIndex(context, newIndex: index);
          } else {
            _carouselController.animateToPage(
              currentIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
      carouselController: _carouselController,
    );
  }
}
