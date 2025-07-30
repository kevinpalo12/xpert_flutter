import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';
import 'package:xpert_flutter/src/features/cat/data/models/cat_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xpert_flutter/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.catCubit});
  final CatCubit catCubit;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            _filtros(context),
            SizedBox(height: 20),
            if (state.catImages.isNotEmpty && state.cat != null) ...[
              _carruselDeImagenes(state.catImages),
              SizedBox(height: 20),

              _info(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _info(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Column(
          children: [
            infoText(
              context,
              label: 'Raza',
              value: widget.catCubit.state.cat!.name,
            ),
            infoText(
              context,
              label: 'Expectativa de vida',
              value: '${widget.catCubit.state.cat!.lifeSpan} años',
            ),
            infoText(
              context,
              label: 'Inteligencia',
              value: widget.catCubit.state.cat!.intelligence.toString(),
            ),
            infoText(
              context,
              label: 'Origen',
              value: widget.catCubit.state.cat!.origin,
            ),

            SizedBox(height: 20),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _descripcionExpandable(widget.catCubit.state.cat!.description),
            SizedBox(height: 20),
            _link(widget.catCubit.state.cat!.wikipediaUrl),
          ],
        ),
      ),
    );
  }

  Widget _link(String url) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: () async {
          final uri = Uri.tryParse(url);
          if (uri != null && await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          elevation: 5,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Wikipedia',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_circle_right_outlined,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _descripcionExpandable(String descripcion) {
    const int maxLinesPreview = 2;
    bool isExpanded = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textAlign: TextAlign.justify,
              descripcion,
              maxLines: isExpanded ? null : maxLinesPreview,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Leer menos' : 'Leer más',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  Widget _filtros(BuildContext context) {
    final state = widget.catCubit.state;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Razas:", style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 2),
              ),
            ),
            value: state.selectedCat,
            items: state.cats
                .map(
                  (cat) =>
                      DropdownMenuItem(value: cat.id, child: Text(cat.name)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                widget.catCubit.changeCat(context, selectedCat: value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _carruselDeImagenes(List<CatImageModel> images) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
      ),
      items: images.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl.url,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.error)),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
