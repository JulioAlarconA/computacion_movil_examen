import 'package:examen_alarconjulio/services/category_service.dart';
import 'package:examen_alarconjulio/widgets/categoria_card.dart';
import 'package:flutter/material.dart';
import 'package:examen_alarconjulio/models/categoria.dart';
import 'package:provider/provider.dart';
import 'package:examen_alarconjulio/screen/screen.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Listado de categoria'),
      ),
      body: ListView.builder(
        itemCount: categoryService.category.length,
        itemBuilder: (BuildContext context, index) => GestureDetector(
          onTap: () {
            categoryService.SelectCategoria =
                categoryService.category[index].copy();
            Navigator.pushNamed(context, 'edit_category');
          },
          child: CategoryCard(category: categoryService.category[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoryService.SelectCategoria = Listado_cat(
               CategoryId: 0,
               CategoryName: '',
               CategoryState: 'Activo');
          Navigator.pushNamed(context, 'edit_category');
        },
      ),


    );
  }
}
