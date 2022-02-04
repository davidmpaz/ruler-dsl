package org.php.ruler.converter

import org.eclipse.xtext.common.services.DefaultTerminalConverters
import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.nodemodel.INode
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.conversion.ValueConverter

class RulerValueConverter extends DefaultTerminalConverters {
	IValueConverter<Float> floatValueConverter = new IValueConverter<Float>() {

		override Float toValue(String string, INode node) throws ValueConverterException {
			return Float.parseFloat(string.substring(0, string.length() - 1));
		}

		override String toString(Float value) throws ValueConverterException {
			return Float.toString(value);
		}

	};

	@ValueConverter(rule="NumberLiteral")
	def IValueConverter<Float> NumberLiteral() {
		return floatValueConverter;
	}
}
