<?php

namespace Modeller\Test\Functional;

use Ruler\RuleBuilder;
use Ruler\Context;

use Cid\Ruler\ModusPonens\Morgan2;
use Cid\Ruler\ModusPonens\Morgan3;
use Cid\Ruler\ModusPonens\Morgan1;
use Cid\Ruler\ModusPonens\Operators;

class ModellerOperatorsTest extends \PHPUnit_Framework_TestCase
{
	/**
	 * Logger instance
	 * @var Logger
	 */
	private $logger = NULL;

	/**
	 *
	 * @var RuleBuilder
	 */
	private $builder = NUll;

	protected function setUp() {
		$this->logger = new \Psr\Log\NullLogger();
		$this->builder = new RuleBuilder();
	}

    public function testOperators()
    {
    	$context = new Context(array());
    	$operators = new Operators(array(), $this->builder, $this->logger);

    	foreach ($operators->getRules() as $r) {
    		$this->assertTrue($r->evaluate($context));
    		$r->execute($context);
    	}

    }
}
