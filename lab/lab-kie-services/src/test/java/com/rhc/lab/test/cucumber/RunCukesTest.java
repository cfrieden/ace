package com.rhc.lab.test.cucumber;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(features = "classpath:features/", plugin = {"pretty",
		"html:target/cucumber"}, tags = {"~@Ignore", "~@not_implemented"}, glue = {"com.rhc"})
public class RunCukesTest {
}