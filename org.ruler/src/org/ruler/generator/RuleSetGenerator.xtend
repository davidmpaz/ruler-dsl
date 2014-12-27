package org.ruler.generator

import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.ruler.modeller.RuleSet

class RuleSetGenerator {

	/**
	 * naming
	 */
	@Inject extension IQualifiedNameProvider

	/**
	 * Helper extension for code generation
	 */
	@Inject extension Utils
	@Inject extension ExpressionGenerator

	/**
	 * Default constructor to be able to inject extension
	 */
	new(){}

	/**
 	 * Main entry point
	 */
	def doGenerateRuleSet (RuleSet ruleSet) '''
		<?php

		«IF ruleSet.package.fullyQualifiedName != null»
		namespace «ruleSet.package.fullyQualifiedName.toString('\\')»;
		«ENDIF»

		use Psr\Log\LogLevel;
		use Psr\Log\LoggerInterface;
		use Psr\Log\LoggerAwareInterface;

		use Ruler\Rule;
		use Ruler\Context;
		use Ruler\RuleSet;

		«IF ruleSet.package.fullyQualifiedName != null»
		use «ruleSet.package.fullyQualifiedName.append(
			RuleRepositoryInterfaceGenerator.interfaceName
		).toString("\\")»;
		«ENDIF»

		/**
		 * Class «ruleSet.name»
		 */
		class «ruleSet.name» «IF ruleSet.superType != null
			»extends «ruleSet.superType.fullyQualifiedName» «ELSE
			»extends RuleSet implements «RuleRepositoryInterfaceGenerator.interfaceName»«ENDIF»
		{
			use «ruleSet.name»Trait;

			«ruleSet.doGenerateSettersGetters()»

			«ruleSet.doGenerateRules()»
		}
	'''

	/**
	 *
	 */
	def doGenerateSettersGetters(RuleSet ruleSet) '''
		/**
		 * @var \Ruler\RuleBuilder
		 */
		private $builder = null;

		/**
		 * @var LoggerInterface
		 */
		private $logger = null;

		/**
		 * @var array
		 */
		private $context = array();

		/**
		 * Constructor
		 *
		 * @param array $rules
		 * @param \Ruler\RuleBuilder $builder
		 * @param LoggerInterface $logger
		 */
		public function __construct(array $rules = array(), $builder = null, $logger = null)
		{
			parent::__construct($rules);
			$this->logger = $logger;
			$this->builder = $builder;
			$this->buildRules();
		}

		/**
		 * @return string The name of the repository
		 */
		public function getName()
		{
			return "«ruleSet.name»";
		}

		/**
		 * @return \Ruler\RuleBuilder
		 */
		public function getBuilder()
		{
			return $this->builder;
		}

		/**
		 * @param \Ruler\RuleBuilder $builder
		 */
		public function setBuilder($builder)
		{
			$this->builder = $builder;
		}

		/**
		 * @param LoggerInterface $logger
		 */
		public function setLogger(LoggerInterface $logger)
		{
			$this->logger = $logger;
		}

		/**
		 * @return LoggerInterface
		 */
		public function getLogger()
		{
			return $this->logger;
		}

		/**
		 * @return Context
		 */
		public function getContext()
		{
			return $this->context;
		}

		/**
		 * @param Context $context
		 */
		public function setContext($context)
		{
			$this->context = $context;
		}

		/**
		 * DSL gives names to rules but, RuleSet assign hashes to avoid
		 * duplicates rules, this is a mapping of spl hashes to rule names
		 * from dsl.
		 *
		 * @var array Mapping rules to its names.
		 */
		private $ruleNamesMap = array();

		/**
		 * Return DSL rule name based on rule spl hash
		 *
		 * @return string rule name
		 */
		public function getRuleName($hash)
		{
			return $this->ruleNamesMap[$hash];
		}

		/**
		 * Get Rule by its DSL name.
		 *
		 * @return Rule rule by name defined in DSL
		 */
		public function getRuleByName($name)
		{
			$flipped = array_flip($this->ruleNamesMap);
			return $this->rules[$flipped[$name]];
		}

		/**
		 * Return collection of rules.
		 *
		 * @return array Rule
		 */
		public function getRules()
		{
			return $this->rules;
		}
	'''

	/**
	 * We are not doing anything yet with rule names
	 */
	def doGenerateRules(RuleSet ruleSet)'''
		/**
		 * Build the rules and add to collection
		 *
		 */
		 protected function buildRules()
		 {
			«FOR r: ruleSet.rules»
				$rule = $this->builder->create(
					«r.expression.doGen()»«IF r.action != null»,
					array($this, '«r.action.name»')«ENDIF»
				);
				$this->ruleNamesMap[spl_object_hash($rule)] = '«r.name»';
				$this->addRule($rule);

			«ENDFOR»
		}
	'''
}
