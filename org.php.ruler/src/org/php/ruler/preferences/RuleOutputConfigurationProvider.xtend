package org.php.ruler.preferences

import java.util.Set
import org.eclipse.xtext.generator.OutputConfiguration
import org.eclipse.xtext.generator.OutputConfigurationProvider

/**
 *
 */
class RuleOutputConfigurationProvider extends OutputConfigurationProvider {

	/**
	 *
	 * Provides OutputConfiguration in two outlet, for generated files and
	 * for files to edit manually, aka generated once files.
	 *
   	 * @return a set of {@link OutputConfiguration} available for the generator
   	 */

	public final static String GEN_ONCE_OUTPUT = 'gen-once'

	override Set<OutputConfiguration> getOutputConfigurations() {

		val Set<OutputConfiguration> options = super.outputConfigurations

		val OutputConfiguration readonlyOutput = new OutputConfiguration(GEN_ONCE_OUTPUT)

		readonlyOutput.setDescription("Manual Editing Output Folder")
		readonlyOutput.setOutputDirectory("./src")
		readonlyOutput.setOverrideExistingResources(false)
		readonlyOutput.setCreateOutputDirectory(true)
		readonlyOutput.setCleanUpDerivedResources(false)
		readonlyOutput.setSetDerivedProperty(false)

		options.add(readonlyOutput)
		return options
	}
}
