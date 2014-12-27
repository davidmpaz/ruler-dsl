package org.ruler.preferences;

import java.util.prefs.BackingStoreException;

import org.eclipse.core.resources.IProject;
import org.eclipse.core.resources.ProjectScope;
import org.eclipse.core.runtime.preferences.IEclipsePreferences;
import org.ruler.ModellerRuntimeModule;

public class Properties {

	public static final String PROPERTY_BASE_PKG = ModellerRuntimeModule.PLUGIN_ID + ".base.pkg";
	public static final String PROPERTY_DEFAULT_BASE_PKG = "Base";

	public static String getBasePkg(IProject project) {
		IEclipsePreferences node = new ProjectScope(project).getNode(ModellerRuntimeModule.PLUGIN_ID);
		return node.get(PROPERTY_BASE_PKG, PROPERTY_DEFAULT_BASE_PKG);
	}

	public static void storeBasePkg(IProject project, String pkg) throws BackingStoreException, org.osgi.service.prefs.BackingStoreException {
		IEclipsePreferences node = new ProjectScope(project).getNode(ModellerRuntimeModule.PLUGIN_ID);

		node.put(PROPERTY_BASE_PKG, pkg);
		node.flush();
	}
}
