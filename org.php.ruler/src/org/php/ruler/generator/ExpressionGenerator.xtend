package org.php.ruler.generator

import java.util.List
import org.php.ruler.rule.AndOrXorExpression
import org.php.ruler.rule.ArithmeticSigned
import org.php.ruler.rule.BooleanLiteral
import org.php.ruler.rule.BooleanNegation
import org.php.ruler.rule.CallableLiteral
import org.php.ruler.rule.Comparison
import org.php.ruler.rule.Equals
import org.php.ruler.rule.Expression
import org.php.ruler.rule.Minus
import org.php.ruler.rule.MultiOrDiv
import org.php.ruler.rule.NumberLiteral
import org.php.ruler.rule.Plus
import org.php.ruler.rule.StringLiteral
import org.php.ruler.rule.VariableLiteral

/**
 * In charge of generate parts for expressions
 */
class ExpressionGenerator {

	/**
	 * Default constructor to be able to inject extension
	 */
	new() {}

	/**
	 * Numbers Literal
	 *
	 * Simplistic representation of float
	 * TODO Make Value Converter work here
	 */
	def dispatch doGen(NumberLiteral nl) '''new Variable(null, «nl.value»«IF nl.decimal != 0».«nl.decimal»«ENDIF»)'''

	/**
	 * Boolean literal
	 */
	def dispatch doGen(BooleanLiteral bl) '''new Variable(null, «bl.value»)'''

	/**
	 * String literal
	 */
	def dispatch doGen(StringLiteral sl) ''' new Variable(null, '«sl.value»')'''

	/**
	 * Variable literal
	 *
	 * If we want to have variable value materialized, just call
	 * «vl.value.toVariable» as second parameter to constructor
	 */
	def dispatch doGen(VariableLiteral vl) '''$this->builder['«vl.value»']'''

	/**
	 * Take a name-spaced name and print the expression as variable.
	 *
	 * Example: order.sku -> $order->sku
	 *
	 * @return string variable representation of FQN
	 */
	def toVariable(String name) {
		val rootObject = name.split('\\.').head as String
		if (name.split('\\.').tail.size > 0) {
			"$this->builder['" + rootObject + "']->".concat(name.split('\\.').tail.join('->'))
		} else {
			"$this->builder['" + rootObject + "']"
		}
	}

	/**
	 * Unique name for expression values names
	 */
	def variableName(String value) {
		value.hashCode
	}

	def toParamterList(List<String> parameters) {
		parameters.map [ param |
			return param.toVariable
		].join(', ')
	}

	/**
	 * Callable literal
	 */
	def dispatch doGen(CallableLiteral cl) '''«cl.name»($self, «cl.parameters.map[name].toParamterList»)'''

	////////////////////////// Prefixed ////////////////////////////
	def dispatch doGen(ArithmeticSigned a) '''
		new \Ruler\Operator\Negation(«a.expression.doGen()»)
	'''

	def dispatch doGen(BooleanNegation bn) '''
			$this->builder->logicalNot(
				«bn.expression.doGen()»
			)'''

	///////////////////// Expressions //////////////////////////////
	def dispatch doGen(AndOrXorExpression e) '''
		$this->builder«e.op.comparissonOperator»(
			«e.left.doGen()»,
			«e.right.doGen()»
		)'''

	def getComparissonOperator(String s) {
		switch s {
			case s == ">" :  '''new \Ruler\Operator\GreaterThan'''
			case s == ">=":  '''new \Ruler\Operator\GreaterThanOrEqualTo'''
			case s == "<" :  '''new \Ruler\Operator\LessThan'''
			case s == "<=":  '''new \Ruler\Operator\LessThanOrEqualTo'''
			case s == "&&":  '''->logicalAnd'''
			case s == "||":  '''->logicalOr'''
			case s == "xor": '''->logicalXor'''
		}
	}

	def isTerminal(Expression e) {
		e instanceof VariableLiteral || e instanceof NumberLiteral ||
		e instanceof BooleanLiteral || e instanceof StringLiteral
	}

	def dispatch doGen(Comparison c) '''
		$this->builder«c.op.comparissonOperator»(
			«c.left.doGen()»,
			«c.right.doGen()»
		)'''

	/**
	 *  In charge of: equal, not equal, same and not same
	 */
	def dispatch doGen(Equals e) '''
		«IF (e.op == '==')»
		new \Ruler\Operator\EqualTo(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ELSEIF (e.op == '!=')»
		new \Ruler\Operator\NotEqualTo(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ELSEIF (e.op == '===')»
		new \Ruler\Operator\SameAs(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ELSEIF (e.op == '!==')»
		new \Ruler\Operator\NotSameAs(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ENDIF»'''

	def dispatch doGen(Plus p) '''
		new \Ruler\Operator\Addition(
			«p.left.doGen()»,
			«p.right.doGen()»
		)'''

	def dispatch doGen(Minus e) '''
		new \Ruler\Operator\Subtraction(
			«e.left.doGen()»,
			«e.right.doGen()»
		)'''

	def dispatch doGen(MultiOrDiv e) '''
		«IF (e.op == '*')»
		new \Ruler\Operator\Multiplication(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ELSE»
		new \Ruler\Operator\Division(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ENDIF»'''
}
