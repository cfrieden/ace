# ACE LAB Story resources

## Delete Booking
We need to be able to delete a booking. Currently we can delete using the REST API but would like an "X" button on the UI next to a booking in order to do so. We would also like there to be a double check pop up before the final deletion.

## Delete Venue
We need to be able to shut a venue down and delete it from the site. However a venue can be in various states 1.no bookings associated with it. 2. only past bookings use it and 3. there are future bookings associated with it. Can we come up with with a way to disable future bookings without loosing the old bookings? The UI portion will be similar to deleting a booking with the addition of an "X" button and double check popup.

## Update Booking

This story will need to account for running the new booking request and validating that it does not conflict with another booking. We will need to notify the user in some capacity that that booking update did not go through. There are various tasks in this story including:
* Building the UI functionality in order to capture the changes for the Booking. Preferably in a pop up Modal.
* Filling out the camel route to update the booking
* Determine the method of notification if the booking request does not pass

## Update Venue

This story is very similar to the Update Booking it update the venues instead. Updating the venue is not the difficult part (build UI form then submit via REST and then resave in the Venue collection) it's what to do with the bookings that are already associated with the venue. Think about how we should handle bookings in the past and future and if they still work with the new venue configuration. Do we allow a bookings in the future to stay or do we cancel them and notify the bands?

Tasks for this story include:
* Building the UI to capture the updated information. Preferably in a pop up Modal.
* Complete the Camel route to update the booking
* Processing the future bookings for the venue (should be part of the camel route)
* Handling the notification on an error in the request (bonus points)

## Bug 1: Identical bookings both save

One of our testers found out that if you send in a booking request for the same exact same time and date as a previous booking they are both saved. We need to make sure this does not happen. This will require new SBEs, Cucumber Tests, and new Rules.

## Do not allow a Band and an Orchestra play on the same day

This story is basically what it sounds like. It's a super important feature and we need it done THIS WEEK!

## Batch Processing

We would like the ability to submit multiple booking requests at once. Having the booking requests through the UI would be a nice to have but currently the venue owners and the band members are fine with sending us a file that we read and process.

We are looking for a solution that 1. periodically looks for a file on the file system 2. reads in each line as a booking request and processes it. 3. Renames the file so that is not processed again.

Looking up both the camel timer and camel file components will be helpful for this task.

## Add Email Notifications

Right now the only way to check if a booking goes through is to check if the list grows and the error thrown on the server side. This is has not gone over well for our customers and we need a better system.  
We have been told that camel should be able to handle this. We expect the emails to be going to both the performer and the venue owner as they both should know about a confirmed booking.   However we currently don't save anyone's email address! We will need to address that as well.  

We did create a dummy email for all of this mail to come from: rhcacelab2016@gmail.com password:acelab2016  

*Note* this is connected to one of the instructors accounts. When you want to start testing ask them enable untrusted apps.  You should be writing tests for this scenario, however it is okay to check that test in as ignored so it does not rely on gmail being able to listen.

Some possibly helpful links can be found here:  
http://camel.apache.org/mail.html  
https://myaccount.google.com/u/2/security?hl=en_GB&pli=1  
https://support.google.com/a/answer/176600?hl=en  

## Deploying on OpenShift 2
* Run the following commands on the command line to create a new EWS (Enterprise Web Server) project called "nchlab" with large gears in OpenShift:
```
	rhc app-create nchlab jbossews-2.0 -g large -s
```
These commands will output the generated credentials and locations for the OpenShift Git repository our application will use. Save this information in a text file for safekeeping.

If you don't have large gears available, the other options are small and medium, however large gears are recommended.

* Enter the newly cloned git directory
```
	cd nchlab/
```

* Connect the starter code on GitHub to the OpenShift repository:
```
	git remote add upstream -m master git://<git repo url>
	git pull -s recursive -X theirs upstream master
```
  * An editor will ask you to enter a merge message. Enter the following to (w)rite the merge record and (q)uit out of the editor:
```
		> :wq
```

* Finally, push the starter code to OpenShift:
```
	git push
```
The code will be pushed to OpenShift, where OpenShift will run a Maven build on the project, copy the built deployment into the JBoss EWS container, and start the container.

* In your browser, navigate to https://nchlab-YOURDOMAIN.rhcloud.com/
	* You now have a web application running business rules and Camel services on top of a MongoDB database!
