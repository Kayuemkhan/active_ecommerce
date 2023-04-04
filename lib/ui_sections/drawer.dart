import 'package:flutter/material.dart';

import 'package:active_ecommerce_flutter/screens/main.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/wishlist.dart';

import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/screens/messenger_list.dart';
import 'package:active_ecommerce_flutter/screens/wallet.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/auth_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

import '../custom/toast_component.dart';
import '../my_theme.dart';
import '../repositories/auth_repository.dart';
import '../repositories/category_repository.dart';
import '../screens/category_list.dart';
import '../screens/category_products.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onTapLogout(context) async {
    AuthHelper().clearUserData();

    var logoutResponse = await AuthRepository().getLogoutResponse();

    if (logoutResponse.result == true) {
      ToastComponent.showDialog(logoutResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return Main();
    }),(route)=>false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection:
            app_language_rtl.$ ?
            TextDirection.rtl :
            TextDirection.ltr
        ,
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                is_logged_in.$ == true
                    ? ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                             "${avatar_original.$}",
                          ),
                        ),
                        title: Text("${user_name.$}"),
                        subtitle: Text(
                          //if user email is not available then check user phone if user phone is not available use empty string
                          "${user_email.$ != "" && user_email.$ != null ? user_email.$ : user_phone.$ != "" && user_phone.$ != null ? user_phone.$ : ''}",
                        ))
                    : Text(
                        AppLocalizations.of(context).main_drawer_not_logged_in,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                Divider(),
                // ListTile(
                //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                //     leading: Image.asset("assets/language.png",
                //         height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                //     title: Text(
                //         AppLocalizations.of(context)
                //             .main_drawer_change_language,
                //         style: TextStyle(
                //             color: Color.fromRGBO(153, 153, 153, 1),
                //             fontSize: 14)),
                //     onTap: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) {
                //         return ChangeLanguage();
                //       }));
                //     }),
                ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    leading: Image.asset("assets/home.png",
                        height: 16, color: Color.fromRGBO(153, 153, 153, 1)),
                    title: Text(AppLocalizations.of(context).main_drawer_home,
                        style: TextStyle(
                            color: Color.fromRGBO(153, 153, 153, 1),
                            fontSize: 14)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Main();
                      }));
                    }),

                is_logged_in.$ == true
                    ? Column(
                        children: [
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/profile.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)
                                      .main_drawer_profile,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Profile(show_back_button: true);
                                }));
                              }),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/order.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)
                                      .main_drawer_orders,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OrderList(from_checkout: false);
                                }));
                              }),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/heart.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)
                                      .main_drawer_my_wishlist,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Wishlist();
                                }));
                              }),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              leading: Image.asset("assets/chat.png",
                                  height: 16,
                                  color: Color.fromRGBO(153, 153, 153, 1)),
                              title: Text(
                                  AppLocalizations.of(context)
                                      .main_drawer_messages,
                                  style: TextStyle(
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                      fontSize: 14)),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MessengerList();
                                }));
                              }),
                          wallet_system_status.$
                              ?
                          ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  leading: Image.asset("assets/wallet.png",
                                      height: 16,
                                      color: Color.fromRGBO(153, 153, 153, 1)),
                                  title: Text(
                                      AppLocalizations.of(context)
                                          .main_drawer_wallet,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                          fontSize: 14)),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Wallet();
                                    }));
                                  })
                              : Container(),
                        ],
                      )
                    : Container(),
                Divider(height: 24),
                is_logged_in.$
                    == false
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/login.png",
                            height: 16,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        title: Text(
                            AppLocalizations.of(context).main_drawer_login,
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 14)),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                      )
                    : Container(),
                is_logged_in.$ == true
                    ? ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Image.asset("assets/logout.png",
                            height: 16,
                            color: Color.fromRGBO(153, 153, 153, 1)),
                        title: Text(
                            AppLocalizations.of(context).main_drawer_logout,
                            style: TextStyle(
                                color: Color.fromRGBO(153, 153, 153, 1),
                                fontSize: 14)),
                        onTap: () {
                          onTapLogout(context);
                        })
                    : Container(),
                Divider(),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: CustomScrollView(
                    controller:ScrollController() ,
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                            buildCategoryList(),
                            Container(
                              height:  60 ,
                            )
                          ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  buildCategoryList() {
    var future =
        CategoryRepository().getTopCategories();
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //snapshot.hasError
            print("category list error");
            print(snapshot.error.toString());
            return Container(
              height: 10,
            );
          } else if (snapshot.hasData) {
            //snapshot.hasData
            var categoryResponse = snapshot.data;
            return SingleChildScrollView(
              child: ListView.builder(
                itemCount: categoryResponse.categories.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    child: buildCategoryItemCard(categoryResponse, index),
                  );
                },
              ),
            );
          } else {
            return SingleChildScrollView(
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    child: Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 60,
                            width: 60,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, bottom: 8.0),
                              child: Shimmer.fromColors(
                                baseColor: MyTheme.shimmer_base,
                                highlightColor: MyTheme.shimmer_highlighted,
                                child: Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * .7,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Shimmer.fromColors(
                                baseColor: MyTheme.shimmer_base,
                                highlightColor: MyTheme.shimmer_highlighted,
                                child: Container(
                                  height: 20,
                                  width: MediaQuery.of(context).size.width * .5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        });
  }
  Card buildCategoryItemCard(categoryResponse, index) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      child:
      Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            width: 80,
            height: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16), right: Radius.zero),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image:
                  categoryResponse.categories[index].banner,
                  fit: BoxFit.cover,
                ))),
        Container(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                child: Text(
                  categoryResponse.categories[index].name,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 8, 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (categoryResponse
                            .categories[index].number_of_children >
                            0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return CategoryList(
                                  parent_category_id:
                                  categoryResponse.categories[index].id,
                                  parent_category_name:
                                  categoryResponse.categories[index].name,
                                );
                              }));
                        } else {
                          ToastComponent.showDialog(
                              AppLocalizations.of(context).category_list_screen_no_subcategories, context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context).category_list_screen_view_subcategories,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: categoryResponse
                                .categories[index].number_of_children >
                                0
                                ? MyTheme.medium_grey
                                : MyTheme.light_grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Text(
                      " | ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: MyTheme.medium_grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return CategoryProducts(
                                category_id: categoryResponse.categories[index].id,
                                category_name:
                                categoryResponse.categories[index].name,
                              );
                            }));
                      },
                      child: Text(
                        AppLocalizations.of(context).category_list_screen_view_products,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: MyTheme.medium_grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }


}
