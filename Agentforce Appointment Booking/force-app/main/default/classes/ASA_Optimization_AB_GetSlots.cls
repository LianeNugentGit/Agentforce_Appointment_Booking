global with sharing class ASA_Optimization_AB_GetSlots {
    public ASA_Optimization_AB_GetSlots() {
    }

    @InvocableMethod(label='Get Slots' description='Returns the list of slots based on the inputs.')
    global static List<OutputResponse> getAppointmentSlots(List<InputRequest> requestList) {
        List<OutputResponse> overallResults = new List<OutputResponse>();
        for (InputRequest request : requestList) {
            List<FSL.AppointmentBookingSlot> slots = getSlots(request.serviceAppoinmentID, request.schedulingPolicyName, request.operatingHoursName);

            if (request.sortBy == 'SORT_BY_GRADE') {
                for (Integer i = 0; i < slots.size(); i++) {
                    for (Integer j = i + 1; j < slots.size(); j++) {
                        if (slots[j].Grade > slots[i].Grade) {
                            FSL.AppointmentBookingSlot temp = slots[i];
                            slots[i] = slots[j];
                            slots[j] = temp;
                        }
                    }
                }
            } else if (request.sortBy == 'SORT_BY_DATE') {
                for (Integer i = 0; i < slots.size(); i++) {
                    for (Integer j = i + 1; j < slots.size(); j++) {
                        if (slots[j].Interval.Start < slots[i].Interval.Start) {
                            FSL.AppointmentBookingSlot temp = slots[i];
                            slots[i] = slots[j];
                            slots[j] = temp;
                        }
                    }
                }
            }

            OutputResponse response = new OutputResponse();
            for (Integer i = 1; i <= Math.min(request.numberOfReturnedSlots, slots.size()); i++) {
                response.slotsText += '\nSlot:' + i + ' Start: ' + slots[i].Interval.Start + ' Finish: ' + slots[i].Interval.Finish + ' Grade: ' + slots[i].Grade;
            }
            overallResults.add(response);
        }
        return overallResults;
    }

    global class InputRequest {
        @InvocableVariable(required=true)
        global ID serviceAppoinmentID;
        @InvocableVariable(required=true)
        global String schedulingPolicyName;
        @InvocableVariable(required=true)
        global String operatingHoursName;
        @InvocableVariable(required=true)
        global String sortBy; // Acceptable values: SORT_BY_GRADE, SORT_BY_DATE, SORT_BY_NO_SORT
        @InvocableVariable(required=true)
        global Integer numberOfReturnedSlots; // Limit the number of slots returned
    }

    global class OutputResponse {
        @InvocableVariable(required=true)
        global String slotsText;
    }

    global static List<FSL.AppointmentBookingSlot> getSlots(ID serviceAppoinmentIDParam, String schedulingPolicyNameParam, String operatingHoursNameParam) {
        ServiceAppointment sa = [SELECT Id, EarliestStartTime, DueDate FROM ServiceAppointment WHERE Id=: serviceAppoinmentIDParam];
        Id schedulingPolicyId = [SELECT Id FROM FSL__Scheduling_Policy__c WHERE Name=:schedulingPolicyNameParam LIMIT 1].Id;
        Id operatingHoursId = [SELECT Id FROM OperatingHours WHERE Name=:operatingHoursNameParam LIMIT 1].Id;
        Timezone tz = UserInfo.getTimeZone();
        List<FSL.AppointmentBookingSlot> slots = FSL.AppointmentBookingService.GetSlots(sa.Id, schedulingPolicyId, operatingHoursId, tz, false);
        return slots;
    }
}