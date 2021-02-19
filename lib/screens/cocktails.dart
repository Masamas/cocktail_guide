import 'package:cocktail_guide/models/cocktail.dart';
import 'package:cocktail_guide/screens/cocktail_detail.dart';
import 'package:cocktail_guide/services/cocktail_service.dart';
import 'package:cocktail_guide/widgets/alcohol_indicator.dart';
import 'package:flutter/material.dart';

class Cocktails extends StatefulWidget {
  @override
  _CocktailsState createState() => _CocktailsState();
}

class _CocktailsState extends State<Cocktails> {
  String searchString = '';
  List<Cocktail> cocktails = [];

  CocktailService cocktailService = CocktailService();

  void _searchCocktails() async {
    List<Cocktail> newCocktails = await cocktailService.getCocktailsByName(searchString);
    this.setState(() {
      cocktails = newCocktails;
    });
  }

  void _onChangeSearch(String text) {
    this.setState(() {
      searchString = text;
    });
  }

  void _goToCocktailDetail(BuildContext context, Cocktail cocktail) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CocktailDetail(cocktail: cocktail)));
  }

  Widget _buildCocktailItem(BuildContext context, int index) {
    Cocktail cocktail = cocktails[index];
    return ListTile(
      title: Text(
        cocktail.name,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      subtitle: Text(cocktail.category),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Hero(
          tag: cocktail.id,
          child: Image.network(cocktail.thumbnailUrl),
        ),
      ),
      trailing: AlcoholIndicator(alcoholic: cocktail.alcoholic),
      onTap: () => _goToCocktailDetail(context, cocktail),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cocktails'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
                onChanged: _onChangeSearch,
                onSubmitted: (value) => _searchCocktails(),
              ),
              trailing: IconButton(
                icon: Icon(Icons.send),
                onPressed: _searchCocktails,
              ),
            ),
            Expanded(
              child: Visibility(
                visible: cocktails.length > 0,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        'Alcoholic',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: _buildCocktailItem,
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: cocktails.length,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
