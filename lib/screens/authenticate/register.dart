import 'package:flutter/material.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/shared/loading.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email ='';
  String password ='';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Container(
      margin: const EdgeInsets.only(top:1,),
      decoration:new BoxDecoration(
          image:  new DecorationImage(
            image: new AssetImage("images/city.jpg"),
            fit: BoxFit.cover,)
      ),

      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),

        appBar: AppBar(
          centerTitle: true,
          title:
          Text("Room Service", style: TextStyle(color: Colors.white, fontSize: 25,),),

          backgroundColor: Colors.white12,
        ),

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white24,
          color: Colors.white12,
          height: 60,
          index: 1,
          animationDuration: Duration(seconds: 1),
          items: <Widget>[
            Icon(Icons.person, color:Colors.white,size: 30, ),
            Icon(Icons.person_add,color: Colors.white, size: 30),
          ],

          onTap: (index) {
            //Handle button tap
            if(index == 0){
              Future.delayed(Duration(milliseconds: 980), () {
                setState(() {
                  widget.toggleView();
                });

              });
//              widget.toggleView();

            }
          },
        ),

        body:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),

              child:

              Container(
            child: Center(
            child: Text('Register',
              style: TextStyle(color: Colors.white, fontSize: 35,
              ),
            ),
      ),
    ),

            ),

            SizedBox(
              height: 5,
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(

                key: _formKey,

                child:  Column(
                  children: <Widget>[

                    Container(
                      color: Colors.transparent,
                      child: TextFormField(

                        validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                            icon: Icon(Icons.contact_mail, color: Colors.white,size: 40,),
                            hintText: 'Mail id',
                            hintStyle: TextStyle(color: Colors.grey, fontSize:18),
                            errorStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.tealAccent,
                          ),
                        ),

                        onChanged: (val){
                          setState(() => email = val);
                        },
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      color: Colors.transparent,
                      child: TextFormField(

                        validator: (val) => val.length <6 ? 'Enter valid password' : null,

                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                            icon: Icon(Icons.lock, color: Colors.white,size: 40,),
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          errorStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.tealAccent,
                          ),

                        ),


                        onChanged: (val){
                          setState(() => password = val);
                        },
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),




                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                          Text(
                            error,
                            style: TextStyle(color:Colors.tealAccent, fontSize: 12),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: RaisedButton(
                            color: Colors.black.withOpacity(0.3),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white,),
                            ),

                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),

                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                setState(() => loading =true );
                                dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                                if(result == null){
                                  setState(() {
                                    error =
                                    'Could not Sign In with the credentials';
                                    loading = false;
                                  }
                                  );
                                }

                              }
                            },

                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
