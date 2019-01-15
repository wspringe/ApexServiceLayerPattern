public with sharing class AccountFunctions {

    public static void setShippingPostalCode(List<SObject> newList) {
        List<Account> newRecords = new List<Account>();
        for(SObject s : newList) {
            newRecords.add((Account) s);
        }

        for (Account acct : newRecords) {
            if (acct.Match_Billing_Address__c) {
                acct.ShippingPostalCode = acct.BillingPostalCode;
            }
        }
    }
}
