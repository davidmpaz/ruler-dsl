package org.ruler.preferences;

import org.eclipse.core.resources.IProject;

public class PropertiesProviderImpl implements PropertiesProvider {

	@Override
	public String getBasePkg(IProject project) {
		return Properties.getBasePkg(project);
	}
}
