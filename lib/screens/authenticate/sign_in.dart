import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/shared/loading.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
       margin: const EdgeInsets.only(top:25,),

      decoration:new BoxDecoration(
          image:  new DecorationImage(
            image: new AssetImage("images/city.jpg"),
            fit: BoxFit.cover,)
      ),


      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.85),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: AppBar(
            centerTitle: true,
            title:
            Text("Rate & Review", style: TextStyle(color: Colors.white, fontSize: 25,),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(100),
                top:  Radius.circular(100),
              ),
            ),
            backgroundColor: Colors.white12,
          ),
        ),

        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white24,
          color: Colors.white12,
          height: 60,
          items: <Widget>[
            Icon(Icons.person, color:Colors.white,size: 30, ),
            Icon(Icons.person_add,color: Colors.white, size: 30),
          ],

          onTap: (index) {
            //Handle button tap
            print('$index');
          },
        ),

        body:
          Column(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: <Widget>[

              Padding(

                padding: const EdgeInsets.all(10.0),

                child: Container(
                  child: Center(
                    child: Text('Login',
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
                          validator: (val) => val.isEmpty ? 'Enter valid Email' : null,

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


                              icon: Icon(Icons.mail, color: Colors.white,size: 40,),
                              hintText: 'Mail id',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                              errorStyle: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
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
                          obscureText: true,
                          validator: (val) => val.length <6 ? 'Enter valid password' : null,

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


                            icon: Icon(Icons.vpn_key, color: Colors.white,size: 40,),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                              errorStyle: TextStyle(
                              fontSize: 10.0,
                              color: Colors.tealAccent,
                            ),

                          ),

                          onChanged: (val){
                            setState(() => password = val);
                          },
                        ),
                      ),

                      SizedBox(
                        height: 5,
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
                                'Sign In',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),

                              onPressed: () async{
                                if(_formKey.currentState.validate()){
                                  setState(() => loading =true );
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

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
                      Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton.icon(
                          color: Colors.transparent,

                          icon: Icon(Icons.person_add, color: Colors.red,size: 15,),
                          label: Text('New user',
                            style: TextStyle(color: Colors.redAccent, fontSize: 12,
                              decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,),
                          ),
                          onPressed: () async{
                            widget.toggleView();
                          },
                        ),
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
