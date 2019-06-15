package org.php.ruler.preferences;

import org.eclipse.core.resources.IProject;

import com.google.inject.ImplementedBy;

@ImplementedBy(PropertiesProviderImpl.class)
public interface PropertiesProvider {
  public String getBasePkg(IProject project);
}
