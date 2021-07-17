import 'package:flutter/material.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/home_screen/home_screen.dart';

class PackageDetailImage extends StatelessWidget {
  final PackageInstance package;

  const PackageDetailImage({Key key, this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.6,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: package.image == null
                  ? AssetImage("assets/images/Splash_1.PNG")
                  : NetworkImage(package.image),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  onTap: () {
                    bool isExist = false;
                    for (var i = 0; i < HomeScreen.cart.length; i++) {
                      if (HomeScreen.cart[i].id == package.id) {
                        isExist = true;
                      }
                    }
                    if (isExist == false) {
                      HomeScreen.cart.add(package);
                      MyApp.storage
                          .setItem("cart", cartItemToJson(HomeScreen.cart));
                      print("Item da duoc them vao cart : $package");
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Đã thêm dịch vụ vào wishlist"),
                        ),
                      );
                    } else {
                      print("Item da ton tai trong cart");
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Dịch vụ đã tồn tại"),
                        ),
                      );
                    }
                  },
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
