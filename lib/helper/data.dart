import 'package:newsapp/models/categoryModels.dart';

List<CategoryModels> getCategories() {
  List<CategoryModels> categories = <CategoryModels>[];
  CategoryModels categoryModels = CategoryModels();

  categoryModels.categoryName = 'Business';
  categoryModels.imageUrl =
      "https://images.pexels.com/photos/17485352/pexels-photo-17485352/free-photo-of-biurko-z-laptopem-na-ktorym-otwarty-jest-edytor-graficzny-sklepu-internetowego-na-platformie-shoper.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModels.channelName = 'the-wall-street-journal';
  categories.add(categoryModels);

  categoryModels = CategoryModels();
  categoryModels.categoryName = 'Entertainment';
  categoryModels.imageUrl =
      "https://images.pexels.com/photos/1190298/pexels-photo-1190298.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModels.channelName = 'entertainment-weekly';
  categories.add(categoryModels);

  categoryModels = CategoryModels();
  categoryModels.categoryName = 'Health';
  categoryModels.imageUrl =
      "https://images.pexels.com/photos/313716/pexels-photo-313716.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModels.channelName = 'medical-news-today';
  categories.add(categoryModels);

  categoryModels = CategoryModels();
  categoryModels.categoryName = 'Science';
  categoryModels.imageUrl =
      "https://images.pexels.com/photos/2280571/pexels-photo-2280571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModels.channelName = 'new-scientist';
  categories.add(categoryModels);

  categoryModels = CategoryModels();
  categoryModels.categoryName = 'Technology';
  categoryModels.imageUrl =
      "https://images.pexels.com/photos/3862632/pexels-photo-3862632.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categoryModels.channelName = 'techcrunch';
  categories.add(categoryModels);

  return categories;
}
