public with sharing class SampleTriggerHandler implements TriggerHandlerInterface{

    public void beforeInsert(List<SObject> newList) {
        SObjectFunctions.functionName(newList);
    }
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap) {

    }
    public void beforeUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap) {

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
