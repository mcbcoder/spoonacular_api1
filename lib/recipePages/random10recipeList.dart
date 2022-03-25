//import 'package:best_before/recipePages/checkboxPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:best_before/navBarTest/menu_widget.dart';

class random10recipelist extends StatefulWidget {
  @override
  _random10recipelistState createState() => _random10recipelistState();
}

class _random10recipelistState extends State<random10recipelist> {
String recipeURL = "https://api.spoonacular.com/recipes/random?number=30&apiKey=a7fa14d84b6546c6b9426be7e6f11000";
List? listResponse;
Map? mapResponse;
List? listOfResults;

Future fetchData() async {
  http.Response response;
  response = await http 
  .get(Uri.parse(recipeURL));

  if (response.statusCode == 200) {
    setState(() {
      mapResponse = json.decode(response.body);
      listOfResults = mapResponse!['recipes'];
    });
  }
}
@override
void initState(){
  fetchData();
  super.initState();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
               appBar: AppBar(
            title:Text('Random recipes to try',
              style: TextStyle(
              fontFamily: 'Fredoka',
              ),
              ),
            backgroundColor: Colors.teal,
            elevation: 20,
            leading: MenuWidget(),
           //leading: checkboxPage(),
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.qr_code_2_rounded),
            //     tooltip: 'Search',
            //     onPressed:(){
            //       Navigator.push(
            //         context, 
            //         MaterialPageRoute(builder: (context) => BarcodePage()));
            //     },
              // )],
              ),
    body:
    mapResponse==null?Container(): SingleChildScrollView(
      child:Column(
      children: <Widget> [
      // Text(
      // mapResponse['recipes'].toString(),
      // style: TextStyle(fontSize: 30),
      // ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        //SHRINKWRAP ADJUSTS THE BOXES TO FIT THE SCREEN
        shrinkWrap: true,
        itemBuilder: (context,index){
        return Container(
          
        //RECIPE PAGE LAYOUT DESIGN
        //EACH RECIPE IS SHOWN WITH ITS TITLE & CALORIES IN A LITTLE RECTANGLE WITH IMAGE 
        //SETTING UP EACH RECIPE RECTANGLE PLACE HOLDER
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: Offset(0.0,10.0,),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          //EACH RECIPES IMAGE GOES HERE
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
             Colors.black.withOpacity(0.35),
             BlendMode.multiply,
            ),
            //IMAGE IS FETCHED FROM API
            image: NetworkImage(listOfResults![index]['image']),
            fit: BoxFit.cover,
          ),),

          //EACH RECIPES TITLE IS HERE
          child: Stack(
           children: [
           Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                //TITLE IS FETCHED FROM API
                listOfResults![index]['title'],
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white.withOpacity(1.0)
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            alignment: Alignment.center,
          ),

          
          //EACH RECIPES CALORIES IS HERE
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.star,color: Colors.yellow,size: 18),
                      SizedBox(width: 7),
                      Text(
                           //CALORIES IS FETCHED FROM API
                            listOfResults![index]['spoonacularScore'].toString(),
                            style: TextStyle(
                            color: Colors.white.withOpacity(1.0)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.yellow,
                        size: 18,
                      ),
                      SizedBox(width: 7),
                      Text(listOfResults![index]['readyInMinutes'].toString(),
                      style: TextStyle(
                      color: Colors.white.withOpacity(1.0)),),
                    ],
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          )]
         ) );
      },
      //IF THE LIST OF RESULTS RETIREVED FROM API IS NONE, ITEMCOUNT IS EQUAL TO 0. OTHERWISE ITEMCOUNT IS EQUAL TO LENGTH OF THE LIST OF RESULTS
      itemCount: listOfResults==null ? 0 : listOfResults!.length)
    ],
  ),
  ));
}
}