package org.ruler.generator

import org.eclipse.xtext.naming.IQualifiedNameProvider
import com.google.inject.Inject
import org.ruler.modeller.RuleSet
import org.ruler.modeller.CallableLiteral

class RuleSetTrait {
	@Inject extension Utils
	@Inject extension IQualifiedNameProvider

	/**
	 * Default constructor to be able to inject extension
	 */
	 new(){}

	def doGenerateRuleSetTrait(RuleSet ruleSet) '''
	<?php

	«IF ruleSet.package.fullyQualifiedName != null»
	namespace «ruleSet.package.fullyQualifiedName.toString("\\")»;
	«ENDIF»

	trait «ruleSet.name»Trait
	{
		«FOR action: ruleSet.eAllContents.filter(CallableLiteral).toIterable»
		/**
		 * These parameters should be accessible from $this->context array
		 *
		 «FOR p: action.parameters»
		 * $this->context['«IF p.alias != null»«p.alias»«ELSE»«p.name»«ENDIF»']
		 «ENDFOR»
		 */
		public function «action.name»() {
			// TODO implement this
			//throw new \Exception('Implement this action for rule: «action.ruleName».');
		}
		«ENDFOR»
	}
	'''
}
