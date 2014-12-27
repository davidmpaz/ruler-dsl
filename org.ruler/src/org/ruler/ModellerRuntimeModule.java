/*
 * generated by Xtext
 */
package org.ruler;

import org.eclipse.xtext.generator.IOutputConfigurationProvider;
import org.ruler.preferences.RuleOutputConfigurationProvider;

import com.google.inject.Binder;
import com.google.inject.Singleton;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class ModellerRuntimeModule extends org.ruler.AbstractModellerRuntimeModule {

	public static final String PLUGIN_ID = "org.ruler";

	@Override
	public void configure(Binder binder) {
	    super.configure(binder);
	    binder.bind(IOutputConfigurationProvider.class)
	    	.to(RuleOutputConfigurationProvider.class)
	    	.in(Singleton.class);
	}
}
