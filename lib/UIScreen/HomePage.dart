import 'package:flutter/material.dart';
import 'package:quote_app/myScopedModel/myScopedModel.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //initialized our scope model in our app
  final MyScopedModel myScopedModel = MyScopedModel();
@override
  void initState() {
    // TODO: implement initState
    // call the fetch quote method from myScopedModel to fetch data
    myScopedModel.fetchQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Quote App"),
      ),
      //return ScopedModel in body which isprovided by scoped_model package
      body: ScopedModel(
        model: myScopedModel,
        child: ScopedModelDescendant<MyScopedModel>(
          //this is the builder of scoped model
          builder: (BuildContext context, _, MyScopedModel myScopedModel) =>(
           //this is the content inside scoped model
            myScopedBody(myScopedModel)
          )
        
        ),
      ),
    );
  }

  Widget myScopedBody(model){
     Widget content = Text('Nothing found');
     //model is ou scoped model and isLoading is the loading state defined in myScopedModel
    if(model.isLoading){
      //if loading show CircularProgressIndicator
       content = Center(
        child: CircularProgressIndicator(),
      );
    }else{
      //else show  bodyItems
      content = bodyItems(model);
      }
  return content;
  }
}

Widget bodyItems(model){
return(
 ListView.builder(
   // the length of quotes we fetched
   itemCount: model.quote.length,
   itemBuilder: (BuildContext context, int i) =>(
     GestureDetector(onTap: null,
     child: Container(
         margin: EdgeInsets.all(8.0),
       padding: EdgeInsets.all(4.0),
       decoration: BoxDecoration(
        color: Colors.white,
    borderRadius: BorderRadius.circular(4.0),
     boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 3), // changes position of shadow
      )]
       ),
       child: Column(
         children: <Widget>[

           //diplay quote
           Text(' " ${model.quote[i].quote} "',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
        color: Colors.deepPurple
      ),),

      //display author
            Text(model.quote[i].author,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
        color: Colors.deepPurple
      ),),

         ],
       ),),
     )
   ))
);
}