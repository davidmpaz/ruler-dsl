package org.php.ruler.generator

import java.util.ArrayList
import java.util.List

import org.eclipse.xtext.naming.QualifiedName
import org.eclipse.emf.ecore.EObject

import org.eclipse.core.resources.ResourcesPlugin
import org.eclipse.core.resources.IFile

import org.php.ruler.rule.CallableLiteral
import org.php.ruler.rule.PackageDeclaration
import org.php.ruler.rule.Rule
import org.php.ruler.rule.RuleSet
import org.eclipse.emf.ecore.resource.Resource
import org.php.ruler.preferences.Properties

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
			flag = r.action !== null
		}

		return flag
	}

	def addBasePackageTransformation(Resource resource) {
		val base = getBasePackage(resource)
		resource.allContents.filter(PackageDeclaration)
			.forall[pkg |
				pkg.name = base + "." + pkg.name
				return true
			]
	}

	def getIProject(EObject object) {
		val path = object.eResource.URI.toPlatformString(true)
		val file = ResourcesPlugin?.workspace?.root?.findMember(path) as IFile
		file?.project
	}

	def getBasePackage(Resource resource) {
		return Properties.getBasePkg(getIProject(resource.allContents.head))
	}

	def basePackageAsQualifiedName(Resource resource) {
		QualifiedName.create(getBasePackage(resource).split("\\.").toList)
	}
}
