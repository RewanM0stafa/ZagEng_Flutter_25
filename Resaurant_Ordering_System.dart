// Begin: Abstract Class Calculation
abstract class Calculation {
  double calculateCost();
}
// End: Abstract Class Calculation

// Begin: Class Person
class Person {
  int id = 0;
  String? name, phoneNumber, address;
  Person(this.id, this.name, this.phoneNumber, this.address);
}
// End: Class Person

// Begin: Class Restaurant
class Restaurant {
  // Fields
  List<Order> orders =[]; // manages the orders
  List<Customer> customers=[]; // deals with customers
  List<Employer> employers=[]; // the staff
  List<Supplier> suppliers=[]; // our providers
  Menu menu=Menu(); // instance of the menu

  // Methods
  // add & remove -> customer, order
  void addCustomer(Customer cust) {
    customers.add(cust);
  }

  void removeCustomer(Customer cust) {
    customers.remove(cust);
  }

  void addOrder(Order order) {
    orders.add(order);
  }

  void removeOrder(Order order) {
    orders.remove(order);
  }

  // display -> menu
  void displayMenu(Menu menu) => menu.displayMenu();
}
// End: Class Restaurant

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
  MenuItem addMenuItem(MenuItem menuItem) {
    items.add(menuItem); // adds a menu item to the list
    return menuItem;
  }

  // show -> menu
  void displayMenu() {
    for (var item in items) {
      print("\n ${item.itemName}");
      print("Category : ${item.category}");
      print("Available Sizes : ");
      //forEach method
      item.itemInfo?.forEach((size, price) {
      print("  - $size: \$${price}"); });
      }
      print("\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n");
    
 /*
    // Iterating through the itemInfo map with a for loop
    for (var size in item.itemInfo!.keys) {
      var price = item.itemInfo?[size];
      print("  - $size: \$${price}");
    }
 */
      
    
  }
}
// End: Class Menu

// Begin: Class OrderItem
class OrderItem {
  // Fields
  MenuItem menuItem;
  int quantity;
  String reqSize;

  // Constructor
  OrderItem(this.menuItem, this.quantity, this.reqSize);
}
// End: Class OrderItem

// Begin: Class Order
class Order implements Calculation {
  // Fields
  String orderId , orderTime ;
  List<OrderItem> orderItems=[];
  Customer customer= Customer();
 // String Ordername=customer.name;


  // Constructor
  Order(this.orderId, this.orderItems, this.customer, this.orderTime);

  // Methods
  // calculate -> total cost
  @override
  double calculateCost() {
    double total = 0;
    for (var item in orderItems) {
      total += (item.menuItem.itemInfo?[item.reqSize] ?? 0) * item.quantity;
    }
    return total;
  }

  // show -> order details
  void displayOrder() {
    print("Order ID: $orderId \nOrder time: $orderTime");
    print("Customer: ${customer.name}");
    print("Items you ordered:");
    for(var item in orderItems){
      print("  - ${item.quantity}x ${item.menuItem.itemName} (${item.reqSize}) ");
    }
    print("Total cost: ${calculateCost()}");
    print("_______________________________\n");
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
  Customer():super(0,null,null,null);
  Customer.withDetails(int id, String? name, String? phoneNumber, String? address)
 :super(id, name, phoneNumber, address);

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
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
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
  Employer(int id, String? name, String? phoneNumber, String? address,    this.shiftTime, this.salary):super(id, name, phoneNumber, address);

  // Methods
  // show -> employer details
  void displayEmployerInfo() {
    print("Name: $name, Phone: $phoneNumber, Address: $address Shift: $shiftTime, Salary: $salary");
      print("###################################\n");
  }
}
// End: Class Employer

// Begin: Class Supplier
class Supplier implements Calculation {
  // Fields
  String? organizationName, category, date;
  double? unitCost, totalCost,amount;

  // Constructor
  Supplier(this.organizationName, this.category, this.amount, this.unitCost, this.date);

  // Methods
  // display -> supplier info
  void displaySupplierInfo() {
    print("Supplier: $organizationName\tCategory: $category\nUnit Cost: $unitCost\tAmount: $amount\nTotal Cost: $totalCost\nDate: $date");
      print("******************************\n");
  }

  // calculate -> the cost of supply
  @override
  double calculateCost() {
    totalCost = (unitCost ?? 0) * (amount??0);
    return totalCost ?? 0;
  }
}
// End: Class Supplier


void main() {
//operations are centralized with Restaurant =>  prepare Menu ,  take Orders  ,  register Customers ,  deal with employers

  //initialize rest object's fields , the components of rest are ready to use
  Restaurant restaurant = Restaurant();
  restaurant.menu=Menu();
  restaurant.orders=[];
  restaurant.customers=[];
  restaurant.employers=[];
  //restaurant.suppliers=[];

  //prepare Menu
  var meat = MenuItem("Meat","Main Male",{ "Kilo":500 , "Half":250 });
  restaurant.menu.addMenuItem(meat);
  var rice = MenuItem("Rice","Main Male",{ "Dish":80 , "Half":40 });
  restaurant.menu.addMenuItem(rice);
  var burger =  MenuItem("Burger","Fast Food",{ "Triple":150 , "Double":115 , "Single":100 });
  restaurant.menu.addMenuItem(burger);
  var pizza =  MenuItem("Pizza","Fast food",{ "Large":270 , "Medium":220 , "Small":150 });
  restaurant.menu.addMenuItem(pizza);
  var cola1 =  MenuItem("ColaMachine","Machine",{ "Large":40 , "Small":25 });
  restaurant.menu.addMenuItem(cola1);
  var cola2 =  MenuItem("ColaCan","Can",{ "Large":35 , "Small":20 });
  restaurant.menu.addMenuItem(cola2);

  
  
  //register Customers
  
  Customer customer1 = Customer.withDetails(1, "Rewan", "122-090-9397", "123 Mans St");
  Customer customer2 = Customer.withDetails(2, "Neveen", "122-969-2510", "456 Zag St");
  restaurant.addCustomer(customer1);
  restaurant.addCustomer(customer2);
  
  
  //take Orders
  
  Order order1 = Order("001", [OrderItem(pizza, 2, "Medium"), OrderItem(burger, 1, "Double")], customer1 , "1/31/2025 11:11 Pm");
  
  Order order2 = Order("002", [OrderItem(rice, 2, "Dish"), OrderItem(meat, 1,     "Half")], customer2 , "1/31/2025 11:15 Pm");

  // Add orders to customers' history <=
  customer1.addOrder(order1);
  customer2.addOrder(order2);
  
  restaurant.addOrder(order1);
  restaurant.addOrder(order2);
  
   //Add Employers
  Employer employer1 = Employer(01, "Hana", "0122=090-9397", "Morning shift", "Talkha",4500);
  Employer employer2 = Employer(02, "Saeed", "0102=623-8859", "Evening shift", "Mansoura",5000);
  restaurant.employers.add(employer1);
  restaurant.employers.add(employer2);
  
   // Add Suppliers
  Supplier supplier1 = Supplier("FoodSupplier", "Meat", 100, 50, "2/01/2025");
  Supplier supplier2 = Supplier("DrinkSupplier", "Beverage", 200, 25, "2/01/2025");
  restaurant.suppliers.add(supplier1);
  restaurant.suppliers.add(supplier2);
 

  //Display Menu
   print("* MENU *");
   restaurant.menu.displayMenu();
 
  
  // Display order details
  print("\n* Orders *: \n");
  for (var order in restaurant.orders) {
       order.displayOrder();
  }
  
   //Display Customers and their orders
   print("Customer History:");
   for(var cust in restaurant.customers){
      cust.displayHistory();
   }
  
  
  //Display Employers Info
  print("Employers Info:");
  for(var emp in restaurant.employers){
     emp.displayEmployerInfo();
  }
  
  //Show our Suppliers
  print("Our Suppliers:");
  for(var sup in restaurant.suppliers){
     sup.displaySupplierInfo();
  }
  
  
}
