package com.rhc.lab.drools;

import org.junit.BeforeClass;
import org.junit.Test;

public class RuleFlowTest extends BaseBPMNTest {

	private static final String P_BOOKING = "bookingProcess";

	@BeforeClass
	public static void setTestResources() {
		setProcesses("rules/bookingProcess.bpmn2");
	}

	@Test
	public void shouldTriggerValidateBookingRuleFlowGroup() {

		processInstance = ksession.startProcess(P_BOOKING, processVars);
		assertProcessInstanceActive(processInstance.getId(), ksession);

		assertNodeTriggered(processInstance.getId(), "Validate Booking");
		assertNodeActive(processInstance.getId(), ksession, "Validate Booking");
	}

}
