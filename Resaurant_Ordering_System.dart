// Begin: Abstract Class Calculation
abstract class Calculation {
  double calculateCost();
}
// End: Abstract Class Calculation

// Begin: Class Person
class Person {
  int id;
  String name, phoneNumber, address;
}
// End: Class Person

// Begin: Class Restaurant
class Restaurant {
  // Fields
  List<Order>? orders; // manages the orders
  List<Customer>? customers; // deals with customers
  List<Employer>? employers; // the staff
  Menu? menu; // instance of the menu

  // Methods
  // add & remove -> customer, order
  void addCustomer(Customer cust) {
    customers?.add(cust);
  }

  void removeCustomer(Customer cust) {
    customers?.remove(cust);
  }

  void addOrder(Order order) {
    orders?.add(order);
  }

  void removeOrder(Order order) {
    orders?.remove(order);
  }

  // display -> menu
  void displayMenu(Menu menu) => menu.displayMenu();
}
// End: Class Restaurant
class Merge{
// Begin: Class MenuItem
class MenuItem {
  // Fields
  String? itemName, category;
  Map<String, int>? itemInfo; // size & price -> itemInfo[size] = price

  // Constructor
  MenuItem(this.itemName, this.category, this.itemInfo);
}
// End: Class MenuItem

// Begin: Class Menu
class Menu {
  // Fields
  List<MenuItem> items=[];

  // Methods
  // add -> menuItem
  void addMenuItem(MenuItem menuItem) {
    items?.add(menuItem); // adds a menu item to the list
  }

  // show -> menu
  void displayMenu() {
    for (var item in items ?? []) {
      print(item.itemName);
    }
  }
}
// End: Class Menu

// Begin: Class OrderItem
class OrderItem {
  // Fields
  String? itemName;
  int quantity;
  String reqSize;

  // Constructor
  OrderItem(this.itemName, this.quantity, this.reqSize);
}
// End: Class OrderItem

// Begin: Class Order
class Order implements Calculation {
  // Fields
  String? orderId , orderTime ;
  List<OrderItem> orderItems=[];
  Customer customer;


  // Constructor
  Order(this.orderId, this.orderItems, this.customer, this.orderTime);

  // Methods
  // calculate -> total cost
  @override
  double calculateCost() {
    double total = 0;
    for (var item in orderItems ?? []) {
      total += (item.itemInfo?[item.reqSize] ?? 0) * item.quantity;
    }
    return total;
  }

  // show -> order details
  void displayOrder() {
    print("Order ID: $orderId\nYou ordered: $orderItems\nOrder time: $orderTime");
    print("Total cost: ${calculateCost()}");
  }
}
// End: Class Order

// Begin: Class Customer
class Customer extends Person {
  // Fields
  List<Order> orderHistory = []; // all orders for a customer
  String? feedback;
  int counter = 0;

  // Constructor
  Customer(this.id, this.name, this.phoneNumber, this.address);

  // Methods
  // add & remove -> customer order
  void addOrder(Order order) {
    orderHistory.add(order);
  }

  void removeOrder(Order order) {
    orderHistory.remove(order);
  }

  // show -> orderHistory
  void displayHistory() {
    print("Order History for $name:");
    for (var order in orderHistory) {
      print("order${++counter}");
      print("- Order ID: ${order.orderId}, Time: ${order.orderTime}");
      print("  Items: ${order.orderItems}");
    }
  }
}
// End: Class Customer

// Begin: Class Employer
class Employer extends Person {
  // Fields
  String? shiftTime;
  double? salary;

  // Constructor
  Employer(this.id, this.name, this.phoneNumber, this.address, this.shiftTime, this.salary);

  // Methods
  // show -> employer details
  void display() {
    print("Name: $name, Phone: $phoneNumber, Address: $address, Shift: $shiftTime, Salary: $salary");
  }
}
// End: Class Employer

// Begin: Class Supplier
class Supplier implements Calculation {
  // Fields
  String? organizationName, category, amount, date;
  double? unitCost, totalCost;

  // Constructor
  Supplier(this.organizationName, this.category, this.amount, this.unitCost, this.date);

  // Methods
  // display -> supplier info
  void displaySupplierInfo() {
    print("Supplier: $organizationName\tCategory: $category\nUnit Cost: $unitCost\tAmount: $amount\nTotal Cost: $totalCost\nDate: $date");
  }

  // calculate -> the cost of supply
  @override
  double calculateCost() {
    totalCost = (unitCost ?? 0) * (amount ?? 0);
    return totalCost ?? 0;
  }
}
// End: Class Supplier
}

void main() {
//operations are centralized with Restaurant =>  prepare Menu ,  take Orders  ,  register Customers ,  deal with employers

  //initialize rest object's fields , the components of rest are ready to use
  Restaurant restaurant = new Restaurant();
  restaurant.menu=Menu();
  restaurant.orders=[];
  restaurant.customers=[];
  restaurant.employers=[];

  //prepare Menu
  var meat = restaurant.menu.addMenuItem("Meat","Main male",{ "Kilo":500 , "Half":250 });
  var rice = restaurant.menu.addMenuItem("Rice","Main male",{ "Dish":80 , "Half":40 });
  var burger = restaurant.menu.addMenuItem("Burger","Fast Food",{ "Triple":150 , "Double":115 , "Single":100 });
  var pizza = restaurant.menu.addMenuItem("Pizza","Fast food",{ "Large":270 , "Medium":220 , "Small":150 });
  var Cola = restaurant.menu.addMenuItem("Cola","Machine",{ "Large":40 , "Small":25 });
  var Cola = restaurant.menu.addMenuItem("Cola","Can",{ "Large":35 , "Small":20 });

  //take Orders
  Order order1 = Order("001",
                       [OrderItem("Pizza", 2, "Medium"), OrderItem("Burger", 1, "Double")], customer1 , "1/31/2025 11:11 Pm");
  Order order2 = Order("002",
      [OrderItem("Rice", 2, "Dish"), OrderItem("Meat", 1, "Half")], customer2 , "1/31/2025 11:15 Pm");


  //register Customers
  Customer customer1 = Customer(1, "Rewan", "122-090-9397", "123 Mans St");
  Customer customer2 = Customer(2, "Neveen", "122-969-2510", "456 Zag St");
  restaurant.addCustomer(customer1);
  restaurant.addCustomer(customer2);

  // Display order details
  print("\nOrders:");
  for (var order in restaurant.orders) {
    order.displayOrder();
  }

}
