@cds.persistence.exists 
@cds.persistence.calcview 
Entity ![CV_SalesOrders] {
key     CREATEDAT: Timestamp  @title: 'CREATEDAT: CREATEDAT' ; 
        CREATEDBY: String(255)  @title: 'CREATEDBY: CREATEDBY' ; 
        MODIFIEDAT: Timestamp  @title: 'MODIFIEDAT: MODIFIEDAT' ; 
        MODIFIEDBY: String(255)  @title: 'MODIFIEDBY: MODIFIEDBY' ; 
        ID: String(10)  @title: 'ID: ID' ; 
        DESCRIPTION: String(50)  @title: 'DESCRIPTION: DESCRIPTION' ; 
        SALESORG: String(10)  @title: 'SALESORG: SALESORG' ; 
        CUSTOMERNO: String(10)  @title: 'CUSTOMERNO: CUSTOMERNO' ; 
}