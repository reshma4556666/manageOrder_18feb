namespace my.salesorder;

type mystring : String(50) not null;

entity SalesOrders {
  key ID                     : String(10);
      description            : mystring not null;
      country                : String(10);
      customerNo             : String(10);
      virtual overBookingInd : Boolean;
      virtual totalQuantity  : Decimal(10, 2);
      customer               : Association to Customers //unmanaged association
                                 on customer.customerNo = customerNo;
      items                  : Composition of many SalesOrderItems //managed composition (to many)
                                 on items.salesOrder = $self;
}

entity SalesOrderItems {
  key salesOrder : Association to one SalesOrders; //managed association (to one)
  key item       : Integer;
      material   : String(18);
      quantity   : Decimal(10, 2); //Precision , scale
}

entity Customers {
  key customerNo   : String(10);
      customerName : mystring;
      addresses    : Composition of one Addresses; //managed composition (to one)
}

entity Addresses {
  key ID      : Integer;
      city    : mystring;
      country : String(10);
      contact : ContactType;
}

type ContactType {
  phonenumber : String(10);
  email       : mystring;
}
