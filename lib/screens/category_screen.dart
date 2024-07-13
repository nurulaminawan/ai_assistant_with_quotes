import 'package:ai_assistant_with_quotes/data/product_data.dart';
import 'package:ai_assistant_with_quotes/models/product.dart';
import 'package:ai_assistant_with_quotes/screens/chat_screen.dart';
import 'package:ai_assistant_with_quotes/screens/quote_screen.dart';
import 'package:ai_assistant_with_quotes/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController mycontroller = TextEditingController();
  String _searchQuery = '';
  TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    super.initState();
  }

  List<Product> get filteredProducts {
    return ProductData.getFilteredProducts(_searchQuery, _selectedTabIndex);
  }

  Widget setPage() {
    return Column(
      children: [
        Container(
          color: AppColors.appBarColor,
          padding: const EdgeInsets.only(left: 20.0, top: 20.0),
          alignment: Alignment.centerLeft,
          height: 90,
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: AppColors.textColorWhite,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          color: AppColors.textColorWhite,
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Search",
              border: InputBorder.none,
              hintStyle: TextStyle(color: AppColors.greyColor),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: AppColors.appBarColor),
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
          ),
        ),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.greyColor[300],
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.buttonColor,
            labelColor: AppColors.buttonColor,
            unselectedLabelColor: AppColors.textColor,
            tabs: [
              Tab(text: 'Ask Questions'),
              Tab(text: 'Quotes'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          setPage(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                showGrid(),
                showGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (BuildContext ctx, index) {
          final product = filteredProducts[index];
          final row = (index / 2).floor();
          final col = index % 2 == 0 ? 0 : 1;
          final isEvenRow = row % 2 == 0;

          final bgColor = isEvenRow
              ? (col == 0 ? AppColors.buttonColor : AppColors.buttonColor2)
              : (col == 0 ? AppColors.buttonColor2 : AppColors.buttonColor);

          return GestureDetector(
            onTap: () {
              if (filteredProducts[index].alert == true) {
                Alert(
                    context: context,
                    title: "Name of the Person to Wish Birthday",
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: mycontroller,
                          decoration: InputDecoration(
                            // icon: Icon(Icons.account_circle),
                            labelText: 'Enter Name Here',
                          ),
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => QuoteScreen(
                                    name: filteredProducts[index].name,
                                    question: filteredProducts[index].question +
                                        mycontroller.text,
                                    bg: filteredProducts[index].bg,
                                  )));
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();
              } else {
                if (filteredProducts[index].userInput == true) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            //ChatScreen
                            name: filteredProducts[index].name,
                            question: filteredProducts[index].question,
                          )));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuoteScreen(
                            name: filteredProducts[index].name,
                            question: filteredProducts[index].question,
                            bg: filteredProducts[index].bg,
                          )));
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    product.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      product.question,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
