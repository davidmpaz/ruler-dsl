<?php

namespace Base\Test\ModusPonens;

use Ruler\RuleBuilder;
use Ruler\Context;

use PHPUnit\Framework\TestCase;
use Psr\Log\LoggerInterface;
use Base\ModusPonens\Operators;

class OperatorsTest extends TestCase
{
	/**
	 * Logger instance
	 * @var LoggerInterface
	 */
	private $logger = NULL;

	/**
	 *
	 * @var RuleBuilder
	 */
	private $builder = NUll;

	protected function setUp(): void {
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
