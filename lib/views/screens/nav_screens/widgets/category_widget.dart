import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/category_controller.dart';
import 'package:mac_store_app/models/category.dart';
import 'package:mac_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryItemWidget extends StatefulWidget {
  const CategoryItemWidget({super.key});

  @override
  State<CategoryItemWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryItemWidget> {
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTextWidget(title: 'Categories', subtitle: 'View all'),
        FutureBuilder(future: futureCategories, 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Errr: ${snapshot.error}'),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return const Center(child: Text('No categories') ,);
          }else{
            final categories = snapshot.data!;
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:categories.length,
              gridDelegate:  const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, 
                mainAxisSpacing: 8, 
                crossAxisSpacing: 8
                ),
                itemBuilder: (context, index){
                  final category = categories[index];
                  return Column(children: [
                    Image.network(category.image, height: 100, width: 100,),
                    Text(category.name),
                  ],);
                }
                );
          }
        }),
      ],
    );
  }
}