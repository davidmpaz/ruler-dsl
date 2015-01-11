package org.ruler.generator

import java.util.List
import org.ruler.modeller.ArithmeticSigned
import org.ruler.modeller.BooleanLiteral
import org.ruler.modeller.BooleanNegation
import org.ruler.modeller.CallableLiteral
import org.ruler.modeller.Comparison
import org.ruler.modeller.Equals
import org.ruler.modeller.Expression
import org.ruler.modeller.FloatLiteral
import org.ruler.modeller.Minus
import org.ruler.modeller.MultiOrDiv
import org.ruler.modeller.NumberLiteral
import org.ruler.modeller.Plus
import org.ruler.modeller.StringLiteral
import org.ruler.modeller.VariableLiteral
import org.ruler.modeller.AndOrXorExpression

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
	 */
	def dispatch doGen(NumberLiteral nl) '''new Variable(null, «nl.value»)'''

	/**
	 * Float literal
	 */
	def dispatch doGen(FloatLiteral fl) '''new Variable(null, «fl.value».«fl.decimal»)'''

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
			case s == ">" :  '''->greaterThan'''
			case s == ">=":  '''->greaterThanOrEqualTo'''
			case s == "<" :  '''->lessThan'''
			case s == "<=":  '''->lessThanOrEqualTo'''
			case s == "!=":  '''->notEqualTo'''
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
		new «c.op.comparissonOperator»(
			«c.left.doGen()»,
			«c.right.doGen()»
		)'''

	def dispatch doGen(Equals e) '''
		new \Ruler\Operator\EqualTo(
			«e.left.doGen()»,
			«e.right.doGen()»
		)'''

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
			«e.right.doGen()»)«ELSE»
		new \Ruler\Operator\Division(
			«e.left.doGen()»,
			«e.right.doGen()»
		)«ENDIF»
		'''
}
