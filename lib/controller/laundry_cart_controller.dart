
import 'package:efood_multivendor_driver/data/model/body/laundry_place_order_body.dart';
import 'package:get/get.dart';

import '../data/model/response/laundry_order_details_model.dart';

class LaundryCartController extends GetxController implements GetxService {



  int _servicesId = 0;
  double _deliveryFee = 0.0;
  List<Cart> _cartList = [];
  double _tax = 0.0;

  List<Cart> get cartList => _cartList;
  int get servicesId => _servicesId;
  double get deliveryFee => _deliveryFee;
  double get tax => _tax;

  void addToCart(int servicesId, int laundryItemId, int quantity, double price, String itemName, {int addon_id,int addon_quantity}) {
    Cart cartItem;
    List<Addons> addonList;
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].servicesId == servicesId) {
        cartItem = _cartList[i];
        break;
      }
    }
    if (cartItem != null) {
      LaundryItemList item;
      Addons addons;
      for (int i = 0; i < cartItem.items.length; i++) {
        if (cartItem.items[i].laundryItemId == laundryItemId) {
          item = cartItem.items[i];
          if(addon_id != null && addon_quantity != null){
            for (int j = 0; j < item.addons.length; j++) {
              if (item.addons[j].id == addon_id) {
                  addons = cartItem.items[i].addons[j];
                  addonList.add(cartItem.items[i].addons[j]); 
              }
            }
          }
          break;
        }
      }
      if (item != null) {
        item.quantity += quantity;
        if(addon_id != null && addon_quantity != null){
        addons.qty += addon_quantity;
        }
      } else {

        cartItem.items.add(
          LaundryItemList(
            laundryItemId: laundryItemId,
            quantity: quantity,
            price: price,
            name: itemName,
            addons: addonList != null ? addonList : <Addons>[]
          ),
        );
      }
    } else {
      _cartList.add(
        Cart(
          servicesId: servicesId,
          items: [
            LaundryItemList(
              laundryItemId: laundryItemId,
              quantity: quantity,
              price: price,
              name: itemName,
              addons: addonList != null ? addonList : <Addons>[]
            ),
          ],
        ),
      );
    }
    update();
  }

  int getQuantity(int laundryItemId, int servicesId) {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].servicesId == servicesId) {
        for (int j = 0; j < _cartList[i].items.length; j++) {
          if (_cartList[i].items[j].laundryItemId == laundryItemId) {
            return _cartList[i].items[j].quantity;
          }
        }
      }
    }
    return 0;
  }

int getQuantityAddon(int addonId, int laundryItemId, int servicesId) {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].servicesId == servicesId) {
        for (int j = 0; j < _cartList[i].items.length; j++) {
          if (_cartList[i].items[j].laundryItemId == laundryItemId) {
        for (int k = 0; k < _cartList[i].items[j].addons.length ; k++) {
          if (_cartList[i].items[j].addons[k].id == addonId) {
            return _cartList[i].items[j].addons[k].qty;
          }}}
        }
      }
    }
    return 0;
  }
  
  void setQuantity(int laundryItemId, int serviceId, bool isIncrement) {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].servicesId == serviceId) {
        for (int j = 0; j < _cartList[i].items.length; j++) {
          if (_cartList[i].items[j].laundryItemId == laundryItemId) {
            if (isIncrement) {
              _cartList[i].items[j].quantity += 1;
            } else {
              if (_cartList[i].items[j].quantity > 1) {
                _cartList[i].items[j].quantity -= 1;
              } else {
                if (_cartList[i].items[j].detailsId == null) {
                  _cartList[i].items.removeAt(j);
                }else {
                  _cartList[i].items[j].quantity = 0;
                }

              }
            }
            break;
          }
        }

        if (_cartList[i].items.isEmpty) {
          _cartList.removeAt(i);
        }
        break;
      }
    }
    update();
  }

  void setQuantityAddon(int laundryItemId, int serviceId,int addonId, bool isIncrement) {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].servicesId == serviceId) {
        for (int j = 0; j < _cartList[i].items.length; j++) {
          if (_cartList[i].items[j].laundryItemId == laundryItemId) {
        for (int k = 0; k < _cartList[i].items[j].addons.length; k++) {
            
            if (isIncrement) {
              _cartList[i].items[j].addons[k].qty += 1;
            } else {
              if (_cartList[i].items[j].addons[k].qty > 1) {
                _cartList[i].items[j].addons[k].qty -= 1;
              } else {
                if (_cartList[i].items[j].detailsId == null) {
                  _cartList[i].items[j].addons[k].removeAt(k);
                }else {
                  _cartList[i].items[j].addons[k].qty = 0;
                }
              }
            }

            break;
        }
          }
        }

        if (_cartList[i].items.isEmpty) {
          _cartList.removeAt(i);
        }
        break;
      }
    }
    update();
  }




  int get totalItems {
    int count = 0;
    for (Cart cartItem in _cartList) {
      for (LaundryItemList item in cartItem.items) {
        count += item.quantity;
      }
    }
    return count;

  }

  double get subTotalPrice {
    double total = 0.0;
    for (Cart cartItem in _cartList) {
      for (LaundryItemList item in cartItem.items) {
        total += item.price * item.quantity;
        if(item.addons.length > 0){
        for (Addons addon in item.addons) {
        total += addon.price * addon.qty;
        }
        }
      }
    }
    return total;

  }

  void setTax(double tax) {
    _tax = tax;
  }

  double get taxCalculation {
    double calculatedTax = 0.0;
    calculatedTax = (  _tax / 100) * subTotalPrice;
    return calculatedTax;
  }

  double get totalPrice {
    return subTotalPrice + _deliveryFee + taxCalculation;

  }



  void setDeliveryFee(double fee, {bool notify = true}) {
    _deliveryFee = fee;
    if (notify) {
      update();
    }
  }


  void clearCart() {
    _cartList.clear();
    update();
  }




  List<int> getServicesIdList(List<Cart> cartList) {
    List<int> _servicesIdList = [];
    for (Cart cartItem in cartList) {
      _servicesIdList.add(cartItem.servicesId);
    }
    return _servicesIdList;
  }


  List<LaundryItemList> getLaundryItemList(int servicesId) {
    List<LaundryItemList> _laundryItemList = [];
    for (Cart cartItem in _cartList) {
      if (cartItem.servicesId == servicesId) {
        for (LaundryItemList item in cartItem.items) {
          _laundryItemList.add(
            LaundryItemList(
              laundryItemId: item.laundryItemId,
              quantity: item.quantity,
              price: item.price,
              detailsId: item.detailsId,
            ),
          );
        }
      }
    }
    return _laundryItemList;
  }


  void setExistingItemsInCart(List<Cart> cartList, {bool notify = true}) {
    _cartList = [];
    _cartList.addAll(cartList);
    if (notify) {
      update();
    }
  }


  void updateQuantity(List<Cart> cartList) {
    for (Cart cartItem in cartList) {
      for (Cart _cartItem in _cartList) {
        if (cartItem.servicesId == _cartItem.servicesId) {
          for (LaundryItemList item in cartItem.items) {
            for (LaundryItemList _item in _cartItem.items) {
              if (item.laundryItemId == _item.laundryItemId) {
                _item.quantity = item.quantity;
              }
            }
          }
        }
      }
    }
    update();
  }


  void clearCartList() {
    _cartList.clear();
    update();
  }


  List<Cart> getCartList() {
    List<Cart> cartList = [];
    for (Cart cartItem in _cartList) {
      List<LaundryItemList> _laundryItemList = [];
      List<Addons> _addonList = [];
      
      for (LaundryItemList item in cartItem.items) {
        for (Addons addon in item.addons) {
        if(addon.qty != 0)
        {
          _addonList.add(new Addons(
            name: addon.name,
            price: addon.price,
            qty: addon.qty,
            id: addon.id
          ));
        }
        else{
           _addonList.add(new Addons(
            name: addon.name,
            price: addon.price,
            qty: addon.qty,
            id: addon.id
          ));
        }
        }
      
        if (item.quantity != 0) {
          _laundryItemList.add(
            LaundryItemList(
              laundryItemId: item.laundryItemId,
              quantity: item.quantity,
              price: item.price,
              name: item.name,
              detailsId: null,
              addons: _addonList
            ),
          );
        } else {
          _laundryItemList.add(
            LaundryItemList(
              laundryItemId: item.laundryItemId,
              quantity: item.quantity,
              price: item.price,
              name: item.name,
              detailsId: item.detailsId,
              addons: _addonList
            ),
          );
        }
      }
      cartList.add(
        Cart(
          servicesId: cartItem.servicesId,
          items: _laundryItemList,
        ),
      );
    }
    return cartList;
  }


}




