Feature: Book Artists at Venues
  Requests should have a valid opening time and closing time
  Venues should not allow two bookings in the same time slot
  Venues should not allow a booking with a performance it cannot accomodate

  # XXX-Instructions
  Scenario: Deny a BAND to play with no opening time or closing time specified
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | COMIC |
      | BAND  |
    And a request for a "COMIC" performance by "Aziz Ansari"
    When validating the booking
    Then the booking should be "REVOKED"

  Scenario: Deny a BAND to play an overlapping timeslot
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND      |
      | ORCHESTRA |
    And an existing "BAND" performance by "The Clash" from "07-01-2017 01:00:00" to "07-01-2017 02:00:00"
    And a dated request for a "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "07-01-2017 01:30:00" to "07-01-2017 02:30:00"
    When validating the booking
    Then the booking should be "REVOKED"
    
   Scenario: Deny a BAND to play an encompased timeslot
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND      |
      | ORCHESTRA |
    And an existing "BAND" performance by "The Clash" from "01-02-2016 01:00:00" to "01-04-2016 02:00:00"
    And a dated request for a "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-01-2016 01:30:00" to "01-05-2016 02:30:00"
    When validating the booking
    Then the booking should be "REVOKED"
    
   Scenario: Deny a BAND to start at the same time as another
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND	  |
    And an existing "BAND" performance by "The Clash" from "06-21-2017 01:00:00" to "06-22-2017 02:00:00"
    And a dated request for a "BAND" performance by "Van Halen" from "06-21-2017 01:00:00" to "06-22-2017 02:00:00"
    When validating the booking
    Then the booking should be "REVOKED"
    
   Scenario: Deny a BAND to end at the same time as another
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND	  |
    And an existing "BAND" performance by "The Clash" from "06-21-2017 01:00:00" to "06-22-2017 02:00:00"
    And a dated request for a "BAND" performance by "Van Halen" from "06-21-2017 00:00:00" to "06-22-2017 02:00:00"
    When validating the booking
    Then the booking should be "REVOKED"

  Scenario: Allow a BAND to play an open timeslot
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND      |
      | ORCHESTRA |
    And an existing "BAND" performance by "The Clash" from "01-01-2016 01:00:00" to "01-01-2016 02:00:00"
    And a dated request for a "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-02-2016 02:00:00" to "01-02-2016 04:00:00"
    When validating the booking
    Then the booking should be "CONFIRMED"

  Scenario: Allow a BAND to play a small venue
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND  |
      | COMIC |
    And a dated request for a "BAND" performance by "The Clash" from "01-01-2016 02:00:00" to "01-01-2016 03:00:00"
    When validating the booking
    Then the booking should be "CONFIRMED"

  Scenario: Deny an ORCHESTRA to play a small venue
    Given a venue "The Cellar" with an occupancy of "200"
    And the venue accomodates performances by a
      | BAND |
      | COMIC |
    And a dated request for a "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-01-2016 02:00:00" to "01-01-2016 03:00:00"
    When validating the booking
    Then the booking should be "REVOKED"
    
  Scenario: Deny an ORCHESTRA to play within a day of a previously scheduled BAND
  	Given a venue "The Cellar" with an occupancy of "400"
  	And the venue accomodates performances by a 
  	  | BAND |
  	  | ORCHESTRA |
  	And an existing "BAND" performance by "The Clash" from "01-01-2016 01:00:00" to "01-01-2016 04:00:00"
  	And a dated request for a "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-01-2016 10:00:00" to "01-01-2016 12:00:00"
  	When validating the booking
  	Then the booking should be "REVOKED"  	

  Scenario: Deny a BAND to play within a day of a previously scheduled ORCHESTRA
    Given a venue "The Cellar" with an occupancy of "400"
    And the venue accomodates performences by a
      | BAND |
      | ORCHESTRA |
    And an existing "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-01-2016 01:00:00" to "01-01-2016 04:00:00"
    And a dated request for a "BAND" performance by "The Clash" from "01-01-2016 10:00:00" to "01-01-2016 12:00:00"
    When validating the booking
    Then the booking should be "REVOKED"
    
  Scenario: Allow an ORCHESTRA to play outside of a day of a previously scheduled BAND
    Given a venue "The Cellar" with an occupancy of "400"
    And the venue accomodates performances by a
      | BAND |
      | ORCHESTRA |
    And an existing "BAND" performance by "The Clash" from "01-01-2016 01:00:00" to "01-01-2016 04:00:00"
    And a dated request for a "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-02-2016 04:00:00" to "01-02-2016 06:00:00"
    When validating the booking
    Then the booking should be "CONFIRMED"
    
  Scenario: Allow a BAND to play outside of a day of a previously scheduled ORCHESTRA
    Given a venue "The Cellar" with an occupancy of "400"
    And the venue accomodates performances by a
      | BAND |
      | ORCHESTRA |
    And an existing "ORCHESTRA" performance by "The Brooklyn Symphony ORCHESTRA" from "01-01-2016 01:00:00" to "01-01-2016 04:00:00"
    And a dated request for a "BAND" performance by "The Clash" from "01-02-2016 04:00:00" to "01-02-2016 06:00:00"
    When validating the booking
    Then the booking should be "CONFIRMED"