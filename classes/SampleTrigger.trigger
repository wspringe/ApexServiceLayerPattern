trigger SampleTrigger on SObjectName (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    SampleTriggerHandler handler = new SampleTriggerHandler();
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            handler.beforeInsert(Trigger.new);
        }
        else if (Trigger.isAfter) {
            handler.afterInsert(Trigger.new, Trigger.newMap);
        }
    }

    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            handler.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }
        else if (Trigger.isAfter) {
            handler.afterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }
    }

    if (Trigger.isDelete) {
        if (Trigger.isBefore) {
            handler.beforeDelete(Trigger.old, Trigger.oldMap);
        }
        else if (Trigger.isAfter) {
            handler.afterDelete(Trigger.old, Trigger.newMap);
        }
    } 

    if (Trigger.isUndelete) {
        if (Trigger.isAfter) {
            handler.afterUndelete(Trigger.new, Trigger.newMap);
        }
    }
}