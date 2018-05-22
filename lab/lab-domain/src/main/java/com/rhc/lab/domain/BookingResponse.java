package com.rhc.lab.domain;

import java.io.Serializable;
import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.rhc.lab.kie.common.KieQuery;

/**
 * 
 * This class represents the domain model for a booking response that will go
 * through our Concert Booking application for artists and venue matching. This
 * payload will be returned to the UI after rules have fired to determine
 * whether or not the venue can be booked as per the requested time(s) and
 * performance type(s)
 * 
 */
public class BookingResponse implements Serializable {
	/**
   * 
   */
	private static final long serialVersionUID = 1074544082673724792L;

	private static final Logger logger = LoggerFactory
			.getLogger(BookingResponse.class);

	@KieQuery(binding = "$bookingRequest", queryName = "getBookingRequests")
	private Collection<BookingRequest> bookingRequests;

	private Booking booking;

	@KieQuery(binding = "$status", queryName = "getStatus")
	private Collection<BookingStatus> bookingStatus;

	public Booking generateBooking() {
		if (bookingRequests != null && !bookingRequests.isEmpty()) {
			booking = new Booking(bookingRequests.iterator().next());
		} else {
			logger.error("No booking requests on response");
		}
		return booking;
	}

	public Collection<BookingRequest> getBookingRequests() {
		return bookingRequests;
	}
	public void setBookingRequests(Collection<BookingRequest> bookingRequest) {
		this.bookingRequests = bookingRequest;
	}
	public Booking getBooking() {
		return booking;
	}
	public void setBooking(Booking booking) {
		this.booking = booking;
	}

	public Collection<BookingStatus> getBookingStatus() {
		return bookingStatus;
	}
	public void setBookingStatus(Collection<BookingStatus> bookingStatus) {
		this.bookingStatus = bookingStatus;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((booking == null) ? 0 : booking.hashCode());
		result = prime * result
				+ ((bookingRequests == null) ? 0 : bookingRequests.hashCode());
		result = prime * result
				+ ((bookingStatus == null) ? 0 : bookingStatus.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookingResponse other = (BookingResponse) obj;
		if (booking == null) {
			if (other.booking != null)
				return false;
		} else if (!booking.equals(other.booking))
			return false;
		if (bookingRequests == null) {
			if (other.bookingRequests != null)
				return false;
		} else if (!bookingRequests.equals(other.bookingRequests))
			return false;
		if (bookingStatus != other.bookingStatus)
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "BookingResponse [bookingRequest=" + bookingRequests
				+ ", booking=" + booking + ", bookingStatus=" + bookingStatus
				+ "]";
	}

}
