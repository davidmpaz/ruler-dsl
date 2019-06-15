package org.php.ruler.generator

import org.eclipse.xtext.naming.QualifiedName

class RuleRepositoryInterfaceGenerator {

	/**
	 * Default constructor to be able to inject extension
	 */
	 new(){}

	def static getInterfaceName() {
		'RuleRepositoryInterface'
	}

	def doGenerate(QualifiedName fqn) '''
	<?php

	namespace «fqn.toString("\\")»;

	use Psr\Log\LoggerInterface;
	use Psr\Log\LoggerAwareInterface;
	use Ruler\Context;

	/**
	 * Class RuleRepositoryInterface
	 *
	 */
	interface RuleRepositoryInterface extends LoggerAwareInterface
	{
	    /**
	     * The logger to use when reporting messages
	     *
	     * @param LoggerInterface $logger
	     * @return void
	     */
	    public function setLogger(LoggerInterface $logger);

	    /**
	     * @return LoggerInterface
	     */
	    public function getLogger();

	    /**
	     * All rule repositories must be named
	     * @return string Name of repository
	     */
	    public function getName();

	    /**
	     * Setting up external context to improve error messages

	     * @param Context $context
	     * @return void
	     */
	    public function setContext($context);

	    /**
	     * Get the full context used by rules
	     * @return Context
	     */
	    public function getContext();

	    /**
	     * Uses a RuleBuilder and create the rules.
	     *
	     * @return array Rule
	     */
	    public function getRules();
	}
	'''
}
