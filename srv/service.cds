using my.salesorder as my from '../db/data-model.cds';

service CatalogService @(requires: 'authenticated-user',path:'/SalesOrderService') 
{
    @(restrict: [
        {
            grant: 'READ',
            to   : 'Viewer'
        },
        {
            grant: [
                'READ',
                'CREATE',
                'UPDATE',
                'DELETE'
            ],
            to   : 'Admin',
            where: 'salesorg=$user.salesorg'
        }
    ])
    @odata.draft.enabled:true
    entity SalesOrders     as projection on my.SalesOrders;

    entity SalesOrderItems as projection on my.SalesOrderItems;
    entity Customers       as projection on my.Customers;
    entity Addresses       as projection on my.Addresses;
}
