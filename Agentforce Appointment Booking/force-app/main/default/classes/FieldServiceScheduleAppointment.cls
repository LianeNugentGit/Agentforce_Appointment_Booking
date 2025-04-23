Global without sharing class FieldServiceScheduleAppointment {
    
    // Define the invocable method that can be called from a Flow
    @InvocableMethod(label='Schedule Service Appointment' description='Schedules a Service Appointment using FSL Scheduling Service')
    public static List<String> scheduleServiceAppointment(List<Request> requestList) {
        List<String> result = new List<String>();
        
        System.debug(JSON.serialize(requestList));
        
        // Loop through each request from Flow
        for (Request req : requestList) {
            try {
                // Call the FSL ScheduleService class and schedule the appointment
                FSL.ScheduleResult myResult = FSL.ScheduleService.schedule(req.schedulingPolicyId, req.serviceAppointmentId);
                
                if(myResult!=null){
                    // Debugging output (optional, useful for troubleshooting)
                    System.debug('Schedule Result: ' + myResult);
                    
                    // Convert the result into a string (or use any relevant field)
                    result.add(myResult.toString()); // You can choose which part of myResult you need
                }else{
                    System.debug('Schedule Result NULL RESULT: ' + myResult);
                }
                
            } catch (Exception e) {
                // Add error message to result if any exception occurs
                result.add('Error scheduling appointment: ' + e.getMessage());
                System.debug('Exception: ' + e.getMessage());
            }
        }        
		
        System.debug('Final RESULTS::' + result);
        
        // Return the result list to the Flow
        return result;
    }

    // Define the class for accepting inputs from Flow
    public class Request {
        @InvocableVariable(required=true description='ID of the Service Appointment to be scheduled')
        public String serviceAppointmentId;
        
        @InvocableVariable(required=true description='ID of the Scheduling Policy to use for scheduling')
        public String schedulingPolicyId;
    }
}