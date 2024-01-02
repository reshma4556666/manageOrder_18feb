const cds = require('@sap/cds');
module.exports = cds.service.impl(async function () {
    //Access Entities from Service
    const { SalesOrders, SalesOrderItems } = this.entities('CatalogService');
    this.after('READ', 'SalesOrders', async (data, req) => {
        //Scenario-1 Populate Virtual element based on SalesOrderItems
        //Compute total quantity of each sales order and check if it is greater than 200.
        //Set virtual properties (totalQuantity & overBookingInd) 
        try {
            const overBookingLimit = 200;
            let totQuantityQuery = cds.parse.cql(`SELECT salesOrder_ID, sum(quantity) as totalQuantity from ${SalesOrderItems} group by salesOrder_ID`);
            let totQuantityRes = await cds.db.run(totQuantityQuery);
            //check if single salesorder or array of salesorders are returned
            if (Array.isArray(data)) {
                data.forEach(each => {
                    let totQuantity = totQuantityRes.find(element => element.salesOrder_ID == each.ID);
                    each.overBookingInd = ((totQuantity !== undefined) && (totQuantity.totalQuantity > overBookingLimit)) ? true : false;
                    each.totalQuantity = (totQuantity !== undefined) ? totQuantity.totalQuantity : 0;
                });
            }
            /*
            else{
                let totQuantity = totQuantityRes.find(element => element.salesOrder_ID == data.ID);
                data.overBookingInd = ((totQuantity !== undefined) && (totQuantity.totalQuantity > overBookingLimit)) ? true : false;
                data.totalQuantity = (totQuantity !== undefined) ? totQuantity.totalQuantity : 0;
            }*/
            return data;
        }
        catch (error) {
            req.error(500, error.message);
        }
    });
    this.on('Get_CV_SalesOrder', async (req) => {
        try {
            let selectstmt = "select * from \"CV_SalesOrders\"";
            let result = await cds.db.run(selectstmt);
            return JSON.stringify(result);
        }
        catch (error) {
            req.error(500, error.message);
        }
    });

});