package org.php.ruler.preferences;

import org.eclipse.core.resources.IProject;

public class PropertiesProviderImpl implements PropertiesProvider {

	public String getBasePkg(IProject project) {
		return Properties.getBasePkg(project);
	}
}
