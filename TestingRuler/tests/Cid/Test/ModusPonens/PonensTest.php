<?php

namespace Cid\Test\ModusPonens;

use Psr\Log\LoggerInterface;
use Ruler\Context;
use Ruler\RuleBuilder;

use Cid\ModusPonens\Morgan2;
use Cid\ModusPonens\Morgan3;
use Cid\ModusPonens\Morgan1;

use PHPUnit\Framework\TestCase;

class PonensTest extends TestCase
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

    /**
     * @dataProvider truthTableTwo
     */
    public function testDeMorgan($p, $q)
    {
    	$context = new Context(compact('p', 'q'));
        $morgan2 = new Morgan2(array(), $this->builder, $this->logger);
        $morgan2->setContext($context);

        foreach ($morgan2->getRules() as $r) {
			$this->assertTrue($r->evaluate($context));
        	$r->execute($context);
        }
    }

    /**
     * @dataProvider truthTableThree
     */
    public function testAssociation($p, $q, $r)
    {
        $context = new Context(compact('p', 'q', 'r'));
        $morgan3 = new Morgan3(array(), $this->builder, $this->logger);
        $morgan3->setContext($context);

		foreach ($morgan3->getRules() as $r) {
        	$this->assertTrue($r->evaluate($context));
            $r->execute($context);
        }

    }

    /**
     * @dataProvider truthTableOne
     */
    public function testDoubleNegation($p)
    {
        $context = new Context(compact('p'));
        $morgan1 = new Morgan1(array(), $this->builder, $this->logger);
        $morgan1->setContext($context);

		foreach ($morgan1->getRules() as $r) {
        	$this->assertTrue($r->evaluate($context));
            $r->execute($context);
        }

    }

    public function truthTableOne()
    {
        return array(
            array(true),
            array(false),
        );
    }

    public function truthTableTwo()
    {
        return array(
            array(true,  true),
            array(true,  false),
            array(false, true),
            array(false, false),
        );
    }

    public function truthTableThree()
    {
        return array(
            array(true,  true,  true),
            array(true,  true,  false),
            array(true,  false, true),
            array(true,  false, false),
            array(false, true,  true),
            array(false, true,  false),
            array(false, false, true),
            array(false, false, false),
        );
    }
}
