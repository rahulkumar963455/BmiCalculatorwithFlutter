// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, unused_import, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget{
  const BMICalculator({super.key});
  
  @override
  Widget build(Object context) {
     return MaterialApp(
      title: "BMI Calculator",
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const BMIScreen(),
     );
  }
}

class BMIScreen extends StatefulWidget{
  const BMIScreen({super.key});
  
  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController textheightcontroller=TextEditingController();
  final TextEditingController textweightcontoller=TextEditingController();
  double? bmi;
  String category="";
  String gender="male";
  void calculateBMI(){
    double height=double.parse(textheightcontroller.text)/100;
    double Weight=double.parse(textweightcontoller.text);

    setState(() {
      bmi=Weight/pow(height, 2);

      if(bmi! < 18.5){
        category="Underweight";
      }else if(bmi! >18.5 && bmi!<24.9){
        category="Normal";
      }else if(bmi! >=25 && bmi! <29.9){
         category="OverWeight";
      }else{
        category="Obese";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("BMI Calculator"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 174, 13, 202), const Color.fromARGB(255, 136, 43, 153),const Color.fromARGB(255, 138, 71, 150)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text("Enter your detail ",style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
            ),
            SizedBox(height: 20,),
            _builderGenderToggle(),
            SizedBox(height: 20,),
            _builderInputFields(controller: textheightcontroller, label:"Height(cm)", icon: Icons.height),

            SizedBox(height: 20,),
            _builderInputFields(controller: textweightcontoller, label: "Weight(kg)", icon: Icons.line_weight),

            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                calculateBMI();
                
              },style:ElevatedButton.styleFrom(
                backgroundColor: Colors.purple
              ),
               child: Text("Calculate",style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
               ),)
               ),
               SizedBox(height: 10,),
               if(bmi!=null)_builderResultCard()
          ],
        ),
      ),
    );
  }

 Widget _builderGenderButton (String label, IconData icon, bool isSelected){
  return GestureDetector(
    onTap: () {
      setState(() {
        gender=label;
      });

    },
    child: AnimatedContainer(
      duration: Duration( microseconds: 300),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
      decoration:BoxDecoration(
        color: isSelected ? Colors.white:Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),

      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: isSelected? Colors.white:Colors.white.withOpacity(0.2),),
            SizedBox(
              width: 20,
            ),
            Text(label,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.deepPurple:Colors.white
            ),)
          ],
        ),
     ),
     
  );
 }
 Widget _builderGenderToggle(){
  return Row(
   children: [
    _builderGenderButton("Male", Icons.male, gender =="Male"),
    SizedBox(
      width: 20,
    ),
    _builderGenderButton("Female", Icons.female, gender =="Female")
   ],
  );
 }
 Widget _builderInputFields({
 required TextEditingController controller,
 required String label,
 required IconData icon,
 }){
     return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon,color: Colors.white,),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
      ),
     );
 }
 Widget _builderResultCard(){
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all( 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Your BMI:${bmi!.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,

            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Your Category:${category}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,

            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Your Gender:${gender!}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.purple,

            ),
          ),
        ],
      ),
    ),
  );
 }
}