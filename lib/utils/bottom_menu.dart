import 'package:flutter/material.dart';
import 'package:xpert_flutter/src/features/cat/ui/home_screen.dart';
import 'package:xpert_flutter/src/features/cat/ui/cat_screen.dart';
import 'package:xpert_flutter/src/features/cat/cubit/cat_cubit.dart';

class BottomMenu extends StatefulWidget {
  final CatCubit catCubit;

  const BottomMenu({super.key, required this.catCubit});

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(catCubit: widget.catCubit),
      CatScreen(catCubit: widget.catCubit),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Razas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Votar'),
        ],
      ),
    );
  }
}
