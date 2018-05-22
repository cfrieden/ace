package com.rhc.lab.domain;

import java.io.Serializable;

/**
 * 
 * This enumerated type represents the domain model for booking status to be
 * used in Booking Request/Responses
 * 
 */
public enum BookingStatus implements Serializable {

	CONFIRMED("Confirmed"), REVOKED("Revoked"), FAILED("Failure"), NEW("New");

	private String bookingStatus;

	BookingStatus(String bookingStatus) {
		this.bookingStatus = bookingStatus;
	}

	public String toString() {
		return bookingStatus;
	}
}
