package org.ruler.generator

import java.util.ArrayList
import java.util.List
import org.eclipse.xtext.naming.QualifiedName
import org.ruler.modeller.CallableLiteral
import org.ruler.modeller.PackageDeclaration
import org.ruler.modeller.Rule
import org.ruler.modeller.RuleSet

class Utils {
	/**
	 * Default constructor to be able to inject extension
	 */
	new() {}

	/**
	 *
	 */
	def PackageDeclaration getPackage(RuleSet ruleSet) {
		// RuleSet repositories are contained inside PackageDeclarations
		ruleSet.eContainer as PackageDeclaration
	}

	def getRuleName(CallableLiteral c) {
		(c.eContainer as Rule).name
	}

	def List<QualifiedName> getNameSpaceUsage(RuleSet ruleSet) {
		var result = new ArrayList<QualifiedName>
		//for(e: ruleSet.eAllContents.filter(Comparison).map[op].toIterable) {
		//	switch e {
		//		case "||": result.add(new QualifiedName())
		//	}
		//}
		result
	}

	/**
	 * Whether RuleSet contain action declaration
	 */
	def hasActions(RuleSet ruleSet) {
		var flag = false

		for(r: ruleSet.rules) {
			flag = r.action != null
		}

		return flag
	}
}
