import 'package:flutter/material.dart';
import 'package:rateandreview/services/auth.dart';
import 'package:rateandreview/shared/loading.dart';

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
      decoration:new BoxDecoration(
          image:  new DecorationImage(
            image: new AssetImage("images/city.jpg"),
            fit: BoxFit.cover,)
      ),

      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.85),

        appBar: AppBar(
          title:
          Align(alignment:Alignment.center, child: Text("Rate & Review")),

          backgroundColor: Colors.transparent,

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
                  child: Text('Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 25,
                      decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,),
                  ),
                ),
              ),

            ),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(

                key: _formKey,

                child:  Column(
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),

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
                            icon: Icon(Icons.vpn_key, color: Colors.white,size: 40,),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton.icon(
                        color: Colors.transparent,

                        icon: Icon(Icons.arrow_back, color: Colors.red,size: 15,),
                        label: Text('Sign In',
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
