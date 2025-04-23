Implementor’s Guide
Disclaimer
Thank you for your interest in our unmanaged package. Please be advised of the following important information:
1. No Offi cial Support from Salesforce or this publisher: This package is provided as-is and is not offi cially supported by Salesforce. Any issues or questions related to this package should be directed to the community.
2. Open Source Nature: This package is off ered as an open-source solution. You are free to use, modify, and distribute it in accordance with the terms of the applicable open-source license.
3. Use at Your Own Risk: While we have made every eff ort to ensure the quality and functionality of this package, it is provided without any warranties or guarantees. Users assume all risks associated with its use.
4. No Liability: The creators of this package, as well as Salesforce, shall not be held liable for any damages or losses arising from the use of this package.
5. Community Support: We encourage users to engage with the community for support, enhancements, and collaboration. Your feedback and contributions are valuable to the ongoing improvement of this package.
6. Testing and Security: It is the responsibility of the user to thoroughly test this package in a sandbox or development environment before deploying it to a production environment. Ensure that the package complies with your organization's security policies and standards.
7. Ethical Use: Users are expected to use this package ethically and in compliance with all applicable laws and regulations. Misuse of this package, including but not limited to unauthorized distribution or malicious use, is strictly prohibited.
By using this package, you acknowledge and agree to the terms outlined in this disclaimer. Thank you for your understanding and cooperation.

Implementor’s Guide
Appointment Booking Custom Agent for Field Service
Implementor’s Guide
Developed:
Feb 13, 2025

Implementor’s Guide
Overview
Unlock Efficient Appointment Booking with the Salesforce Field Service Custom Agent
This comprehensive guide empowers you to seamlessly implement the AI-powered Salesforce Field Service Appointment Booking Custom Agent. Developed by a cross-functional team of experts, this tool gives you the power of Autonomous Agent to your field service customers. Leverage the insights and best practices within this guide to effortlessly deploy and customise the agent, maximising the efficiency of your appointment booking process. The Salesforce Field Service Appointment Booking Custom Agent revolutionises field service operations by automating the appointment booking process.
By autonomously handling appointment bookings, the Custom Agent frees up valuable time for field service teams, allowing them to focus on delivering exceptional service.
The agent installation package includes a custom object that is used to collect metrics. This data can then be leveraged to measure the value of the Agentforce implementation.
Key Features
● Dynamic retrieval of appointment slots based on customer preferences.
● Configurable scheduling parameters for flexibility.
● Seamless integration with Salesforce Field Service for Work Order and Service Appointment creation.
Disclaimer
This Autonomous Service Agent (ASA) for Appointment Booking (AB) is developed solely as a baseline for implementers. It should be customized according to project-specific requirements and use cases.
Implementers are advised to conduct additional security and toxicity tests on the customer's deployed system in accordance with Salesforce guidelines before deployment.

Implementor’s Guide
AB Custom Agent Video
Watch this video to get a hand of what AB Custom Agent is capable of:
AB Custom Agent Video
Assumptions
● User Authentication: The user is authenticated and associated with an account from the experience site/Customer’s website
● Account/Contact Information: The customer’s account and contact details are accessible.
● Address Validation: The address associated with the account is used by default.
● SA Service Territory: Derived automatically from polygon or other automated process

Exclusions
● User Authentication: Implementers must configure this step based on project requirements.
● Appointment Cancellation: Not supported.
● Appointment Rescheduling: Not supported.
● Special Customer Requests: Exceptional cases (e.g., minor at home, specific technician requests) are transferred to human agents.
How to Quick Start with AB Custom Agent:
Below are the quick start steps to install and use AB custom Agent, the detailed steps are provided in the “Implementation Steps” section of this document.
1. Set up your Org and enable Agentforce.
2. Install Unmanaged Package for Appointment Booking (AB) Custom Agent (Installation Link)
3. Create custom permission sets required
4. Configure Agent Topic and Instructions Manually 

Implementation Steps
1. Agentforce Setup
Follow the Agentforce Deployment Guide to enable Agentforce in the Salesforce Org.
Here are MUST-DO Pre-Deployment Manual Steps:
Step 1: Setting up Einstein
Enable Einstein: Go to Setup → Search Einstein Setup
Click the Turn on Einstein, and make sure Einstein is On
Step 2: Enable Agents
Refresh the browser after completing the above steps. Search “Agents” in the Quick Find box.
Enable the toggle for Agentforce.

2. Package Installation
Install the Unmanaged Package for ASA Appointment Booking Agent through the provided link:
Versioning Tracker
Date Version Updates
17 Feb 2025 4.2 (Current version)
  1. Removed hard-coded value for Asset ID in ASA Optimization AB Create Service Appointment flow
  2. Removed hard-coded value for Scheduling Policy ID in ASA Optimization AB Schedule Service Appointment flow
  3. Added newer versions of the Actions viz. ASA_Optimization_AB_Schedule_Service_Appointment_2 and ASA_Optimization_AB_Create_Service_Appointment_2
  4. Added default Duedate if ‘FSL__Due_Date_Offset__c’=null
  5. Documentation
<upcoming> 4.3
  1.Modified the flow ASA Optimization AB Retrieve Time Slots to take Service Territory. Timezone as input while fetching slots (instead of Running User timezone)
  2. Added fix to convert the slot selected from Service Territory Time Zone into UTC before updating the Service Appointment
    - Added Apex for Time Zone conversion - "TimeConversion"
    - Updated the Flow "ASA Optimization AB Update Service Appointment" - to run the Apex before Update of the SA

Note:
What if existing component names conflict with the ones in this package? Rename conflicting components in the package. 

3.Post Package Installation Steps
Step 1: Create the following custom permission sets
  1.1 ASA Optimization AB - Field Service Dispatcher
  Steps to create this Permission Set (also covered in Permission Set Requirements section):
  1.Clone the Field Service Dispatcher Permission Set.2.Modify the cloned permission set:
  ● Remove all Visualforce Page access.Agentforce cannot access Visualforce Pages.
  ● Remove Appointment Bundle Policy object access.
  ● March 27, 2025 note: Remove Appointment Bundle Configs object access.
  Referenced document for creating this PS - Demo Custom Agentforce Scheduling Actions
  1.2 ASA Optimization AB - Additional Objects
  Steps to create this Permission Set (also covered in Permission Set Requirements section):
  We have provided Read, Create, Edit access to following objects and Read All and Edit All on the field level for - update this as per the specific use-case requirement / security considerations.
    ● Operating Hours
    ● Scheduling Policy
    ● Contact
    ● Account
    ● Work Type
    ● Work Order
    ● Service Appointment
    ● Service Resource
    ● Assigned Resource
    ● AB Agent Metrics
Step 2: Setup Agent User Setup user with profile Einstein Agent User. Assign following permission sets to the user:
Step 3: Setup Agentforce Service Agent. Setup the ASA as per your use-case. Ensure that the associated user has above permissions.
  March 27 Note: Don't have Data Cloud User perm set. Will this fail? No - Data Cloud is not a requirement for this package
Step 4: Configure the Agent Topic and Instructions:
Note: The “Appointment Management” topic should be manually configured (The one that comes with the installation package is throwing some error, so it should be manually configured) and the details should be updated under this topic as below:
Open the Agent created in step 3 → Create a new Topic → Add details as below
  Topic label:
  Appointment Management
  Classification Description:
  Your job is to schedule a service appointment.
  To clarify: You must enter this topic if, and only if, the client explicitly ask to schedule an appointment.
  Scope:
  Your job is to schedule a service appointment.
  To clarify: You must enter this topic if, and only if, the client explicitly ask to schedule an appointment.
  You must also enter the topic if the client requests to book an appointment/meeting/discussion, requests to meet someone, asks to modify an appointment/meeting/discussion, or cancel an existing appointment/meeting/discussion.
    Instruction 1:
    If the user wants to schedule an appointment
    Get Contact ID: You need the user's email to find this.
    Instruction 2:
    When responding with the Available Time Slots, show up to 3 slot having with the highest grade where at least one is within the requested time frame by the customer.
    Display the time slots in this format: MMM,DD,YYYY HH - HH, for example: Jan 02, 2024 9am - 10am
    Instruction 3:
    Get Work Types: This ensures we offer the appointment type the user is looking for - it doesn't have to be an exact match but similar. always show all options to the user
    Instruction 4:
    Create Service Appointment only after you have a worktype and account to execute the action.
    Instruction 5:
    Only after you created the work order by using the action. Once the user selects their preferred time, update the service appointment then schedule the service appointment - the appointment is not scheduled until this action runs. After the service appointment has been updated, schedule the service for the user.
    Instruction 6:
    Always begin with Showing Address For Confirmation: Only once confirmed then you can proceed. If the address is not correct, escalate the conversation to a service representative.
    Instruction 7:
    notes or comments to the appointment can only be submitted by a human agent. if someone tell you something that should be noted escalate to a human representative
    Instruction 8:
    if someone tells you someone will wait when the technician arrives at the location, mention that a person has to be at least 18 years old.
    if not suggest to escalate to human agent
    Instruction 9:
    if the customer asks for a slot recommendation you should not recommend specific slots.
    Customers are not aware of the grades and you should not mention it
    Instruction 10:
    we have variety of skilled technicians if someone asks for specific one you can suggest to escalate it a human agent
Step 5: Add actions to the Topic from Asset Library
That’s it, you are all set to start playing around with the AB custom Agent!

Technical Details:
Below are the technical details related to various components of the AB Custom agent that implementors can use to customize/modify further. 14
Implementor’s Guide
AB Agent Flow Chart and Error Handling
Below is the Flow diagram for AB Custom Agent: 
  Flow Steps
  1. Customer
  ● The customer requests to book an appointment.
  ● Agent verifies the address and date of the appointment.
  2. Address Verification
  Action Flow 1:
  ● Validate the address from the customer account.
  3. Slot Generation
  Action Flow 2:
  ● Use the customer’s desired date (with a +5 day buffer).
  ● Apply the predefined Work Type, Scheduling Policy, and Operating Hours. 16
  Implementor’s Guide
  ● Create the Work Order (WO) and Service Appointment (SA) with the provided details.
  ● Invoke GetSlots() Apex:
  ○ Request Parameters:
  ■ ServiceAppointmentId
  ■ OperatingHours
  ■ SchedulingPolicyId
  ■ TimeZone
  ○ Response:
  ■ Returns 15 slots graded and ordered by Early Start.
  ● Present the top 3 slots to the customer for selection.
  4. Customer Slot Selection
  ● Customer selects one of the suggested slots or declines the options and requests new ones.
  ● If declined, provide an additional set of 3 slots (out of the remaining 12).
  5. Schedule Confirmation
  Action Flow 3:
  ● Once the slot is confirmed, finalize the Service Appointment.
  ● Scheduled Service Appointment (SA).
  Default Behavior
  ● Retrieve 15 appointment slots ordered by Early Start.
  ● Display top 3 graded slots.
  Error Handling:
  ● Slot Unavailability: Notify the customer to expand the horizon.
  ● Service Appointment Creation Failure: Log error and alert the agent.

**Installation Package details**  
The AB custom Installation Package includes below components:
  2.1 Agent Topics (Generative AI Plugin Definition)
    1. Appointment_Management (Needs to be manually configured after installing the package)
  2.2 Agent Actions (Generative AI Function Definition)
    1. Get_Contact_ID
    2. AB_Optimization_AB_Show_Address_For_Confirmation
    3. ASA_Optimization_AB_Get_Work_Types
    4. ASA_Optimization_AB_Create_Service_Appointment
    5. ASA_Optimization_AB_Retrieve_Available_Time_Slots
    6. ASA_Optimization_AB_Update_Service_Appointment
    7. ASA_Optimization_AB_Schedule_Service_Appointment
  2.3 Flows - corresponding to each action above (Flow Version)
    1. Get Contact ID
    2. ASA Optimization AB Show Address For Confirmation
    3. ASA Optimization AB Get Work Types
    4. ASA Optimization AB Create Service Appointment
    5. ASA Optimization AB Retrieve Available Time Slots
    6. ASA Optimization AB Update Service Appointment
    7. ASA Optimization AB Schedule Service Appointment
  2.4 Code (Apex class)
    1. FieldServiceScheduleAppointment
    2. ASA_Optimization_AB_GetSlots
  2.5 Object (Custom object)
    1. AB Agent Metric
  2.6 Fields - of custom object above (Custom field)
    1. SA Grade AB Agent Metric
    2. Returned Slots AB Agent Metric
    3. Schedule Success AB Agent Metric
    4. SA Number AB Agent Metric
    5. SA Id AB Agent Metric
    6. Account Name AB Agent Metric
  2.7 Page layout
    1. AB Agent Metric Layout

**Flows Details and Configurable Variables**
High-Level Inputs:
  ● Email: Provided by the customer.
  ● Contact: Retrieved from the associated account.
  ● Address: Validated from the account.
  ● Work Type: Retrieved based on customer input.
  ● Date: Desired appointment timeframe provided by the customer.
  ● Service Appointment ID: Generated after Work Order creation.
Configurable Variables:
● Work Type: Type of work order.
● Scheduling Policy: Logic for appointment scheduling.
● Operating Hours: Defines available slots.
● Time Zone: Defaults to the account’s time zone.
● Horizon: Scheduling limit (default is 5 days from the requested date).
● Apex Variables:
○ Number of Slots
○ Ordering Criteria (by date or grade)

**AB Optimization AB Show Address For Confirmation**
● Functional Description: To confirm the customer's address based on Account. If the customer's response is negative (no), the Agent escalates the case to the human Agent.
● Inputs: ContactID
● Outputs: Address_To_Confirm
● Configurable(s): None

**ASA Optimization AB Get Work Types**
● Functional Description: To identify the relevant work type based on the customer's request to the AB Agent
● Inputs: Text from Customer given to the Agent
● Outputs: Eligible_Work_Types_List (List of relevant Work Types)
● Configurable(s): Different Work Types can be added based on implementation requirement (set in the flow). Need to be added in ‘Eligible_Work_Types_List’

**ASA Optimization AB Create Service Appointment**
● Functional Description: To use worktype ID from above and create WO and Service Appointment
● Inputs:
○ ContactID
○ assetID
○ CustomerDueDate
○ EarliestStart
○ Messaging_Session_Id
○ workTypeId
● Outputs: Service_Appointment_ID (WO and SA ID Fetch Account ID related to the Contact ID provided and fetch all the details from the Account Object and WorkType details will be used to create WO and SA)
● Configurable(s):
○ Timezone is taken from the service territory
○ Early Start (default is Now )
○ Due Date - derived from work type with the following formula: (Vx) IF(ISNULL({!Get_Work_Type.FSL__Due_Date_Offset__c}),({!EarliestStart}+1),
IF( ({!EarliestStart}+{!Get_Work_Type.FSL__Due_Date_Offset__c})>({!EarliestStart}+5),
{!EarliestStart}+5,
{!EarliestStart} + {!Get_Work_Type.FSL__Due_Date_Offset__c}+{!Get_Work_Type.EstimatedDuration}))

**ASA Optimization AB Retrieve Available Time Slots**
● Functional Description: To return slots for the customer in the Service Territory timezone. Get Slot Apex is OOTB but it is modified to use operating hrs. 
● Inputs:
○ operatingHoursName
○ schedulingPolicyName
○ Service_Appointment_ID (from 2nd Flow)
● Outputs: Available Time slots
● Configurable(s):
○ No. of Slots returned (default 10)
○ Sort By (Default is sort by Date)
○ Scheduling Policy ID

**ASA Optimization AB Update Service Appointment**
● Functional Description: Converts the selected timeslots to UTC & updates the Arrival window based on the selected slot by the customer on the SA
● Inputs:
○ SelectedArrivalWindowStart
○ SelectedArrivalWindowEnd
○ Service_Appointment_ID (Start and End time Slot selected from the Customer via Agent)
○ numberOfReturnedSlots
● Outputs:
○ Updated_Time
○ Update_Arrival_Start_and_End (Arrival Window Start)
○ Arrival Window End (Derived from the slot user selected from the get slot flow above)
● Configurable(s): None

**ASA Optimization AB Schedule Service Appointment**
● Functional Description: To schedule SA (Calling Schedule Service Appointment Apex)
● Inputs:
○ Scheduling Policy ID
○ Service Appointment ID (Retrieved from earlier flows above)
● Outputs: Service Appointment is scheduled
● Configurable(s):
○ Scheduling Policy ID (by name)

**Get Contact ID**
● Functional Description: This is added solely for this implementation to identify end users. Implementors should update the authentication method as per the project requirements from their customers
● Inputs: Customer's email
● Outputs: Contact ID
● Configurable(s): To be configured by implementers to verify users

**Agent Topics & Instructions**
The Topic “Appointment MAnagement” that has been created contains below Topic and Instructions:
Agent Topic
Topic label:
Appointment Management
Classification Description:
Your job is to schedule a service appointment.
To clarify: You must enter this topic if, and only if, the client explicitly ask to schedule an appointment.
Scope:
Your job is to schedule a service appointment.
To clarify: You must enter this topic if, and only if, the client explicitly ask to schedule an appointment.
You must also enter the topic if the client requests to book an appointment/meeting/discussion, requests to meet someone, asks to modify an appointment/meeting/discussion, or cancel an existing appointment/meeting/discussion.
Agent Instructions
Instruction 1:
If the user wants to schedule an appointment
Get Contact ID: You need the user's email to find this.
Instruction 2:
When responding with the
Available Time Slots, show up to 3 slot having with the highest grade where at least one is within the requested time frame by the customer.
Display the time slots in this format: MMM,DD,YYYY HH - HH, for example: Jan 02, 2024 9am - 10am
Instruction 3:
Get Work Types: This ensures we offer the appointment type the user is looking for - it doesn't have to be an exact match but similar. always show all options to the user
Instruction 4:
Create Service Appointment only after you have a worktype and account to execute the action. 22
Implementor’s Guide
Instruction 5:
Only after you created the work order by using the action. Once the user selects their preferred time, update the service appointment then schedule the service appointment - the appointment is not scheduled until this action runs. After the service appointment has been updated, schedule the service for the user.
Instruction 6:
Always begin with Showing Address For Confirmation: Only once confirmed then you can proceed. If the address is not correct, escalate the conversation to a service representative.
Instruction 7:
notes or comments to the appointment can only be submitted by a human agent. if someone tell you something that should be noted escalate to a human representative
Instruction 8:
if someone tells you someone will wait when the technician arrives at the location, mention that a person has to be at least 18 years old.
if not suggest to escalate to human agent
Instruction 9:
if the customer asks for a slot recommendation you should not recommend specific slots.
Customers are not aware of the grades and you should not mention it
Instruction 10:
we have variety of skilled technicians if someone asks for specific one you can suggest to escalate it a human agent

**Metrics Collection**
A custom object AB_Agent_Metric__c is part of the installation package to collect agent metrics:
● Fields:
○ Account Name
○ *Returned Slots (number)
○ SA Grade
○ SA Id
○ SA Number
○ Schedule Success
○ Messaging_Session_Id
* In the Roadmap: not functional as of now

**Permission Set Requirements**
AB Agent Metric Object Access
● Read, create, and edit permissions for agent users.
ASA Optimization AB - Field Service Dispatcher
1. Assign the Agentforce user the Field Service Dispatcher permission set license. (If you’re not sure how to create it - follow the Create Field Service Permission Sets help doc)
2. Clone the Field Service Dispatcher Permission Set.
3. Modify the cloned permission set:
● Remove all Visualforce Page access.
● Remove Appointment Bundle Policy object access.
1. Assign the cloned permission set to the Agentforce user.
Additional Permissions:
Access permissions to Agentforce Agent for the following objects:
● Operating Hours
● Scheduling Policy
● Contact
● Account
● Work Type
● Work Order
● Service Appointment
● Service Resource
● Assigned Resource
● AB Agent Metrics

**Apex Implementation Details**
GetSlots() Apex Method
Request Parameters:
● ServiceAppointmentId: From Work Order
● OperatingHours: Configured variable
● SchedulingPolicyId: Configured variable
● TimeZone: Retrieved from account/contact
Response:
● Returns 15 slots ordered by Early Start.
● Each slot includes start time, end time, and grade.
Testing Considerations
1. General Flow Testing:
● Conversational flow between agent and customer.
2. Exception Handling:
● Special requests routed to human agents.
● No available slots scenarios.
3. Ethical and Responsible AI Testing:
● Tests for bias, toxicity, and unsafe interactions.
ProServ Testing:
● Ensure efficient implementation aligned with business requirements and customer satisfaction.
This guide provides the essential information for implementors to deploy and customize the Salesforce Field Service Appointment Booking Custom Agent effectively.


**Appendix**
Apex: FieldServiceGetTerritory
public with sharing class FieldServiceGetTerritory {
@InvocableMethod(label='Get Service Territory by Coordinates')
public static List<String> getTerritoryByCoordinates(List<Request> inputCoordinates) {
List<String> territoryIds = new List<String>();
for (Request input : inputCoordinates) {
try {
// Call the PolygonUtils method to retrieve the territory ID
Id territoryId = FSL.PolygonUtils.getTerritoryIdByPolygons(input.longitude, input.latitude);
if (territoryId != null) {
territoryIds.add(String.valueOf(territoryId));
} else {
territoryIds.add(null);
}
} catch (Exception e) {
System.debug('Error during execution: Latitude ' + input.latitude + ', Longitude ' + input.longitude + ' - ' + e.getMessage());
territoryIds.add(null);
}
}
return territoryIds;
}
// Define the input structure for the Flow
public class Request {
@InvocableVariable(required=true description='Latitude of the location')
public Double latitude;
@InvocableVariable(required=true description='Longitude of the location')
public Double longitude;
} 
}
Apex: FieldServiceGetAppointmentSlots
public with sharing class FieldServiceGetAppointmentSlots {
@InvocableMethod(label='Get Appointment Slots' description='Gets available appointment slots with customizable block duration')
public static List<List<String>> getAppointmentSlots(List<InputParameters> inputParams) {
List<List<String>> results = new List<List<String>>();
// Assuming one set of input parameters is passed
if (inputParams != null && !inputParams.isEmpty()) {
InputParameters params = inputParams[0];
// Fetch the ServiceAppointment details using the input ID
ServiceAppointment sa = [SELECT Id, EarliestStartTime, DueDate FROM ServiceAppointment
WHERE Id = :params.serviceAppointmentId LIMIT 1];
// Fetch the Scheduling Policy using the input ID
Id schedulingPolicyId = [SELECT Id FROM FSL__Scheduling_Policy__c
WHERE Id = :params.schedulingPolicyId LIMIT 1].Id;
// Fetch the Operating Hours using the input ID
Id operatingHoursId = [SELECT Id FROM OperatingHours
WHERE Id = :params.operatingHoursId LIMIT 1].Id;
// Get the timezone object based on the input parameter
TimeZone tz = TimeZone.getTimeZone(params.timezone);
if (tz == null) {
throw new IllegalArgumentException('Invalid timezone: ' + params.timezone);
}
// Fetch appointment slots using the FSL service
List<FSL.AppointmentBookingSlot> slots = FSL.AppointmentBookingService.GetSlots(
sa.Id, schedulingPolicyId, operatingHoursId, tz, false
);
List<String> result = new List<String>();
for (FSL.AppointmentBookingSlot slot : slots) {
DateTime start = slot.Interval.Start;
DateTime endTime = slot.Interval.Finish;

// Break down the slot into user-defined minute blocks
while (start < endTime) {
DateTime nextBlock = start.addMinutes(params.blockDuration);
// Ensure the nextBlock does not exceed the finish time of the slot
if (nextBlock > endTime) {
nextBlock = endTime;
}
// Adjust start and end time to the specified timezone
Integer offsetStart = tz.getOffset(start);
Integer offsetNextBlock = tz.getOffset(nextBlock);
DateTime adjustedStart = start.addSeconds(offsetStart / 1000 * -1); // Convert ms to seconds and adjust
DateTime adjustedEnd = nextBlock.addSeconds(offsetNextBlock / 1000 * -1);
// Handle DST drift if necessary
Integer offsetAtAdjustedStart = tz.getOffset(adjustedStart);
Integer offsetAtAdjustedEnd = tz.getOffset(adjustedEnd);
if (offsetAtAdjustedStart != offsetStart) {
adjustedStart = adjustedStart.addSeconds((offsetStart - offsetAtAdjustedStart) / 1000);
}
if (offsetAtAdjustedEnd != offsetNextBlock) {
adjustedEnd = adjustedEnd.addSeconds((offsetNextBlock - offsetAtAdjustedEnd) / 1000);
}
// Format the adjusted DateTime values
String formattedStart = adjustedStart.format('yyyy-MM-dd HH:mm', params.timezone);
String formattedEnd = adjustedEnd.format('yyyy-MM-dd HH:mm', params.timezone);
String slotDetails = 'Start: ' + formattedStart +
', End: ' + formattedEnd +
', Grade: ' + slot.Grade;
result.add(slotDetails);
// Move to the next block
start = nextBlock; 
// If we've collected enough blocks (up to 10), stop
if (result.size() >= 10) {
break;
}
}
// Break out of the outer loop if enough slots have been collected
if (result.size() >= 10) {
break;
}
}
// If no slots found, add a message
if (result.isEmpty()) {
result.add('No available slots found');
}
results.add(result);
// Debugging slot details
System.debug('Number of slots retrieved: ' + result.size());
}
return results;
}
// Input parameter class for flow
public class InputParameters {
@InvocableVariable(label='Service Appointment ID' description='ID of the Service Appointment' required=true)
public Id serviceAppointmentId;
@InvocableVariable(label='Scheduling Policy ID' description='ID of the Scheduling Policy' required=true)
public Id schedulingPolicyId;
@InvocableVariable(label='Operating Hours ID' description='ID of the Operating Hours' required=true)
public Id operatingHoursId;
@InvocableVariable(label='Timezone' description='Timezone for formatting the slots' required=true)
public String timezone; 
@InvocableVariable(label='Block Duration' description='Duration of each block in minutes' required=true)
public Integer blockDuration;
}
}
Apex: TimeConversion
public class TimeConversion {
// Define a wrapper class for inputs
public class TimeInput {
@InvocableVariable
public Datetime arrivalWindowStart; // Arrival start date in Datetime format
@InvocableVariable
public Datetime arrivalWindowEnd; // Arrival end date in Datetime format
@InvocableVariable
public String sourceTimeZone; // Source time zone (e.g., 'America/New_York')
}
// Define a wrapper class for outputs
public class TimeOutput {
@InvocableVariable
public Datetime arrivalWindowStartUTC; // Converted Arrival Window Start in UTC

@InvocableVariable
public Datetime arrivalWindowEndUTC; // Converted Arrival Window End in UTC
}
@InvocableMethod(label='Convert Arrival Window Times to UTC')
public static List<TimeOutput> convertToUTC(List<TimeInput> inputs) {
List<TimeOutput> results = new List<TimeOutput>();
for (TimeInput input : inputs) {
// Convert both times from the source time zone to UTC
TimeZone tz = TimeZone.getTimeZone(input.sourceTimeZone);
Datetime startInUTC = input.arrivalWindowStart.addSeconds(-tz.getOffset(input.arrivalWindowStart) / 1000);
Datetime endInUTC = input.arrivalWindowEnd.addSeconds(-tz.getOffset(input.arrivalWindowEnd) / 1000);
// Create output for each input and add it to the result list
TimeOutput output = new TimeOutput();
output.arrivalWindowStartUTC = startInUTC;
output.arrivalWindowEndUTC = endInUTC;
results.add(output);
}
return results; 
}
}
(Alternate apex for time zone conversion - not used in current implementation)
Apex: FieldServiceConvertDatetimeTimezone
public with sharing class FieldServiceConvertDatetimeTimezone {
@InvocableMethod(label='Convert DateTime from UTC to TimeZone' description='Converts a UTC DateTime value to the specified timezone')
public static List<OutputWrapper> convertDateTime(List<InputWrapper> inputParams) {
List<OutputWrapper> results = new List<OutputWrapper>();
for (InputWrapper input : inputParams) {
if (input.originalDateTime == null || String.isBlank(input.timeZoneName)) {
throw new IllegalArgumentException('Both originalDateTime and timeZoneName must be provided.');
}
try {
// Parse the target timezone using the name
TimeZone targetTimeZone = TimeZone.getTimeZone(input.timeZoneName);
if (targetTimeZone == null) {
throw new IllegalArgumentException('Invalid TimeZone name: ' + input.timeZoneName);
}
// Calculate the offset from UTC in milliseconds
Integer offsetFromUTC = targetTimeZone.getOffset(input.originalDateTime);
// Adjust the original UTC DateTime to the target timezone
Datetime convertedDateTime = input.originalDateTime.addSeconds(-offsetFromUTC / 1000);
// Handle potential DST drift
Integer offsetAtConverted = targetTimeZone.getOffset(convertedDateTime);
if (offsetAtConverted != offsetFromUTC) {
Datetime dstAdjustedDateTime = convertedDateTime.addSeconds((offsetFromUTC - offsetAtConverted) / 1000);
Integer finalOffset = targetTimeZone.getOffset(dstAdjustedDateTime);
if (finalOffset == offsetAtConverted || dstAdjustedDateTime > convertedDateTime) { 
convertedDateTime = dstAdjustedDateTime;
}
}
// Add the result to the output
results.add(new OutputWrapper(convertedDateTime));
} catch (Exception e) {
throw new IllegalArgumentException('Error converting DateTime: ' + e.getMessage());
}
}
return results;
}
public class InputWrapper {
@InvocableVariable(label='Original UTC DateTime' description='The original DateTime in UTC to be converted' required=true)
public Datetime originalDateTime;
@InvocableVariable(label='TimeZone Name' description='The name of the timezone to convert to (e.g., "America/Los_Angeles")' required=true)
public String timeZoneName;
}
public class OutputWrapper {
@InvocableVariable(label='Converted DateTime' description='The DateTime value converted to the specified timezone')
public Datetime convertedDateTime;
public OutputWrapper(Datetime convertedDateTime) {
this.convertedDateTime = convertedDateTime;
}
}
}
Apex: FieldServiceScheduleAppointment
public with sharing class FieldServiceScheduleAppointment {
// Define the invocable method that can be called from a Flow
@InvocableMethod(label='Schedule Service Appointment' description='Schedules a Service Appointment using FSL Scheduling Service')
public static List<String> scheduleServiceAppointment(List<Request> requestList) {
List<String> result = new List<String>(); 
// Loop through each request from Flow
for (Request req : requestList) {
try {
// Call the FSL ScheduleService class and schedule the appointment
FSL.ScheduleResult myResult = FSL.ScheduleService.schedule(req.schedulingPolicyId, req.serviceAppointmentId);
// Convert the result into a string (or use any relevant field)
result.add(myResult.toString()); // You can choose which part of myResult you need
// Debugging output (optional, useful for troubleshooting)
System.debug('Schedule Result: ' + myResult);
} catch (Exception e) {
// Add error message to result if any exception occurs
result.add('Error scheduling appointment: ' + e.getMessage());
System.debug('Exception: ' + e.getMessage());
}
}
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
