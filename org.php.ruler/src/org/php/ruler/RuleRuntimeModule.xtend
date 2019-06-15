/*
 * generated by Xtext 2.16.0
 */
package org.php.ruler

import org.eclipse.xtext.generator.IOutputConfigurationProvider

import com.google.inject.Binder
import com.google.inject.Singleton

import org.php.ruler.preferences.RuleOutputConfigurationProvider

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class RuleRuntimeModule extends AbstractRuleRuntimeModule {
    public static final String PLUGIN_ID = "org.php.ruler"
    
    override configure(Binder binder) {
        super.configure(binder);
        configureOutputConfigurationProvider(binder)
    }

    def configureOutputConfigurationProvider(Binder binder) {
        binder.bind(IOutputConfigurationProvider)
            .to(RuleOutputConfigurationProvider)
            .in(Singleton);
    }
}
