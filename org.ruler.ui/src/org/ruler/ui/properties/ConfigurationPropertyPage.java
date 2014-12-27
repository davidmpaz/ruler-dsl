package org.ruler.ui.properties;

import org.eclipse.core.resources.IProject;
import org.eclipse.jface.preference.PreferencePage;
import org.eclipse.swt.SWT;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.Text;
import org.eclipse.ui.dialogs.PropertyPage;
import org.ruler.preferences.Properties;

public class ConfigurationPropertyPage extends PropertyPage {

	private static final String BASE_PKG_TITLE = "Base Package:";

	private static final int TEXT_FIELD_WIDTH = 50;

	private Text basePkgText;

	/**
	 * Constructor for SamplePropertyPage.
	 */
	public ConfigurationPropertyPage() {
		super();
	}

	private void addBasePkgSection(Composite parent) {
		Composite composite = createDefaultComposite(parent);

		// Label for owner field
		Label ownerLabel = new Label(composite, SWT.NONE);
		ownerLabel.setText(BASE_PKG_TITLE);

		// Owner text field
		basePkgText = new Text(composite, SWT.SINGLE | SWT.BORDER);
		GridData gd = new GridData();
		gd.widthHint = convertWidthInCharsToPixels(TEXT_FIELD_WIDTH);
		basePkgText.setLayoutData(gd);

		// Populate owner text field
		try {
			basePkgText.setText(Properties.getBasePkg(getProject()));
		} catch (Exception e) {
			basePkgText.setText(Properties.PROPERTY_DEFAULT_BASE_PKG);
		}
	}

	private IProject getProject() {
		return (IProject) getElement().getAdapter(IProject.class);
	}

	/**
	 * @see PreferencePage#createContents(Composite)
	 */
	@Override
	protected Control createContents(Composite parent) {
		Composite composite = new Composite(parent, SWT.NONE);
		GridLayout layout = new GridLayout();
		composite.setLayout(layout);
		GridData data = new GridData(GridData.FILL);
		data.grabExcessHorizontalSpace = true;
		composite.setLayoutData(data);

		addBasePkgSection(composite);
		return composite;
	}

	private Composite createDefaultComposite(Composite parent) {
		Composite composite = new Composite(parent, SWT.NULL);
		GridLayout layout = new GridLayout();
		layout.numColumns = 2;
		composite.setLayout(layout);

		GridData data = new GridData();
		data.verticalAlignment = GridData.FILL;
		data.horizontalAlignment = GridData.FILL;
		composite.setLayoutData(data);

		return composite;
	}

	@Override
	protected void performDefaults() {
		super.performDefaults();
		// Populate the owner text field with the default value
		basePkgText.setText(Properties.PROPERTY_DEFAULT_BASE_PKG);
	}

	@Override
	public boolean performOk() {
		// store the value in the owner text field
		try {
			Properties.storeBasePkg(getProject(), basePkgText.getText());
			return true;
		} catch (Exception e) {
			return false;
		}
	}

}
