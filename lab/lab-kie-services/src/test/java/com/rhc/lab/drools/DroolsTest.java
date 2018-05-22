package com.rhc.lab.drools;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.BootstrapWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.rhc.lab.domain.BookingRequest;
import com.rhc.lab.kie.api.StatelessDecisionService;

@RunWith(SpringJUnit4ClassRunner.class)
@BootstrapWith()
@ContextConfiguration(locations = {"classpath:kie-context.xml"})
public class DroolsTest {
	@Resource(name = "localDecisionService")
	private StatelessDecisionService decisionService;

	@Test
	public void shouldAutowireDecisionService() {
		Assert.assertNotNull(decisionService);
	}

	@Test
	public void runRules() {

		BookingRequest request = new BookingRequest();

		List<Object> facts = new ArrayList<Object>();
		facts.add(request);

		decisionService.execute(facts);

	}

}
