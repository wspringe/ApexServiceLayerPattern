public interface TriggerHandler {
    void beforeInsert(List<SObject> newList);
    void afterInsert(List<SObject> newList, Map<Id, SObject> newMap);
    void beforeUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap);
    void afterUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap);
    void beforeDelete(List<SObject> oldList, map<Id, SObject> oldMap);
    void afterDelete(List<SObject> oldList, map<Id, SObject> oldMap);
    void afterUndelete(List<SObject> newList, map<Id,SObject> newMap);
}
