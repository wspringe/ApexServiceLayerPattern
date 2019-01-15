public with sharing class AccountTriggerHandler implements TriggerHandler{

    public void beforeInsert(List<SObject> newList) {
        AccountFunctions.setShippingPostalCode(newList);
    }
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap) {

    }
    public void beforeUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap) {
        AccountFunctions.setShippingPostalCode(newList);
    }
    public void afterUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap) {

    }
    public void beforeDelete(List<SObject> oldList, map<Id, SObject> oldMap) {

    }
    public void afterDelete(List<SObject> oldList, map<Id, SObject> oldMap) {

    }
    public void afterUndelete(List<SObject> newList, map<Id,SObject> newMap) {

    }
}
