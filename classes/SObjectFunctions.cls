public with sharing class SObjectFunctions {

    public static void functionName(List<SObject> newList) {
        // you will need to cast the SObject type of the records as your desired SObject Type
        List<DesiredSObject> newRecords = new List<DesiredSObject>();
        for(SObject s : newList) {
            newRecords.add((DesiredSObjectType) s);
        }

        // additional functions/logic here
    }
}
