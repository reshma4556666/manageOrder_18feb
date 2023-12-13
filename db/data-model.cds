using {cuid,managed} from '@sap/cds/common';
namespace my.salesorder;

type mystring : String(50) not null;

entity SalesOrders : managed {
  key ID                     : String(10) @title : 'ID';
      description            : mystring not null @title : 'Description';
      salesorg               : String(10) @title : 'Sales Organization';
      customerNo             : String(10) @title : 'Customer No';
      virtual overBookingInd : Boolean @title : 'Over Booking Indicator';
      virtual totalQuantity  : Decimal(10, 2) @title : 'Total Quantity';
      customer               : Association to Customers //unmanaged association
                                 on customer.customerNo = customerNo;
      items                  : Composition of many SalesOrderItems //managed composition (to many)
                                 on items.salesOrder = $self;
}

entity SalesOrderItems :cuid{       // introduce key property ID of type uuid for odata draft enablement
      salesOrder : Association to one SalesOrders; //managed association (to one)
      item       : Integer @title : 'ITEM';
      material   : String(18) @title : 'Material';
      quantity   : Decimal(10, 2) @title : 'Order Quantity'; //Precision , scale
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
