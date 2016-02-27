
//----------------------------------------------------
// The following code was generated by CUP v0.11a beta 20060608
// Thu Feb 25 09:08:32 CET 2016
//----------------------------------------------------

package logicline.analyseurs;

import java_cup.runtime.*;
import java.util.*;
import logicline.modeleSemantique.*;

/** CUP v0.11a beta 20060608 generated parser.
  * @version Thu Feb 25 09:08:32 CET 2016
  */
public class ParserLogic extends java_cup.runtime.lr_parser {

  /** Default constructor. */
  public ParserLogic() {super();}

  /** Constructor which sets the default scanner. */
  public ParserLogic(java_cup.runtime.Scanner s) {super(s);}

  /** Constructor which sets the default scanner. */
  public ParserLogic(java_cup.runtime.Scanner s, java_cup.runtime.SymbolFactory sf) {super(s,sf);}

  /** Production table. */
  protected static final short _production_table[][] = 
    unpackFromStrings(new String[] {
    "\000\030\000\002\002\004\000\002\003\004\000\002\003" +
    "\002\000\002\002\005\000\002\002\005\000\002\002\005" +
    "\000\002\002\005\000\002\002\004\000\002\004\003\000" +
    "\002\004\004\000\002\005\005\000\002\005\005\000\002" +
    "\005\003\000\002\006\005\000\002\006\005\000\002\006" +
    "\003\000\002\007\004\000\002\007\005\000\002\007\003" +
    "\000\002\007\003\000\002\007\003\000\002\010\010\000" +
    "\002\011\007\000\002\011\002" });

  /** Access to production table. */
  public short[][] production_table() {return _production_table;}

  /** Parse-action table. */
  protected static final short[][] _action_table = 
    unpackFromStrings(new String[] {
    "\000\062\000\026\002\uffff\004\011\005\007\006\012\007" +
    "\004\014\013\015\005\016\015\017\021\020\014\001\002" +
    "\000\014\004\011\005\007\006\012\007\004\020\014\001" +
    "\002\000\014\004\011\005\007\006\012\007\004\020\014" +
    "\001\002\000\004\002\061\001\002\000\024\010\uffee\011" +
    "\uffee\012\uffee\013\uffee\021\uffee\022\uffee\023\uffee\025\uffee" +
    "\026\uffee\001\002\000\004\026\060\001\002\000\024\010" +
    "\uffef\011\uffef\012\uffef\013\uffef\021\uffef\022\uffef\023\uffef" +
    "\025\uffef\026\uffef\001\002\000\024\010\uffed\011\uffed\012" +
    "\uffed\013\uffed\021\uffed\022\uffed\023\uffed\025\uffed\026\uffed" +
    "\001\002\000\014\004\011\005\007\006\012\007\004\020" +
    "\014\001\002\000\014\004\011\005\007\006\012\007\004" +
    "\020\014\001\002\000\014\004\011\005\007\006\012\007" +
    "\004\020\014\001\002\000\026\002\uffff\004\011\005\007" +
    "\006\012\007\004\014\013\015\005\016\015\017\021\020" +
    "\014\001\002\000\024\010\046\011\045\012\ufff2\013\ufff2" +
    "\021\ufff2\022\ufff2\023\ufff2\025\ufff2\026\ufff2\001\002\000" +
    "\020\012\042\013\041\021\ufff5\022\ufff5\023\ufff5\025\ufff5" +
    "\026\ufff5\001\002\000\014\004\011\005\007\006\012\007" +
    "\004\020\014\001\002\000\006\022\024\026\ufff9\001\002" +
    "\000\004\026\ufff8\001\002\000\004\004\025\001\002\000" +
    "\004\024\026\001\002\000\014\004\011\005\007\006\012" +
    "\007\004\020\014\001\002\000\006\023\uffea\025\031\001" +
    "\002\000\004\023\036\001\002\000\004\004\032\001\002" +
    "\000\004\024\033\001\002\000\014\004\011\005\007\006" +
    "\012\007\004\020\014\001\002\000\006\023\uffea\025\031" +
    "\001\002\000\004\023\uffeb\001\002\000\004\026\uffec\001" +
    "\002\000\004\026\040\001\002\000\026\002\ufffb\004\ufffb" +
    "\005\ufffb\006\ufffb\007\ufffb\014\ufffb\015\ufffb\016\ufffb\017" +
    "\ufffb\020\ufffb\001\002\000\014\004\011\005\007\006\012" +
    "\007\004\020\014\001\002\000\014\004\011\005\007\006" +
    "\012\007\004\020\014\001\002\000\014\021\ufff7\022\ufff7" +
    "\023\ufff7\025\ufff7\026\ufff7\001\002\000\014\021\ufff6\022" +
    "\ufff6\023\ufff6\025\ufff6\026\ufff6\001\002\000\014\004\011" +
    "\005\007\006\012\007\004\020\014\001\002\000\014\004" +
    "\011\005\007\006\012\007\004\020\014\001\002\000\020" +
    "\012\ufff3\013\ufff3\021\ufff3\022\ufff3\023\ufff3\025\ufff3\026" +
    "\ufff3\001\002\000\020\012\ufff4\013\ufff4\021\ufff4\022\ufff4" +
    "\023\ufff4\025\ufff4\026\ufff4\001\002\000\004\002\000\001" +
    "\002\000\004\026\053\001\002\000\026\002\ufffc\004\ufffc" +
    "\005\ufffc\006\ufffc\007\ufffc\014\ufffc\015\ufffc\016\ufffc\017" +
    "\ufffc\020\ufffc\001\002\000\004\021\055\001\002\000\024" +
    "\010\ufff0\011\ufff0\012\ufff0\013\ufff0\021\ufff0\022\ufff0\023" +
    "\ufff0\025\ufff0\026\ufff0\001\002\000\004\026\057\001\002" +
    "\000\026\002\ufffe\004\ufffe\005\ufffe\006\ufffe\007\ufffe\014" +
    "\ufffe\015\ufffe\016\ufffe\017\ufffe\020\ufffe\001\002\000\026" +
    "\002\ufffa\004\ufffa\005\ufffa\006\ufffa\007\ufffa\014\ufffa\015" +
    "\ufffa\016\ufffa\017\ufffa\020\ufffa\001\002\000\004\002\001" +
    "\001\002\000\004\026\063\001\002\000\026\002\ufffd\004" +
    "\ufffd\005\ufffd\006\ufffd\007\ufffd\014\ufffd\015\ufffd\016\ufffd" +
    "\017\ufffd\020\ufffd\001\002\000\024\010\ufff1\011\ufff1\012" +
    "\ufff1\013\ufff1\021\ufff1\022\ufff1\023\ufff1\025\ufff1\026\ufff1" +
    "\001\002" });

  /** Access to parse-action table. */
  public short[][] action_table() {return _action_table;}

  /** <code>reduce_goto</code> table. */
  protected static final short[][] _reduce_table = 
    unpackFromStrings(new String[] {
    "\000\062\000\016\002\015\003\005\004\007\005\021\006" +
    "\017\007\016\001\001\000\004\007\063\001\001\000\012" +
    "\004\061\005\021\006\017\007\016\001\001\000\002\001" +
    "\001\000\002\001\001\000\002\001\001\000\002\001\001" +
    "\000\002\001\001\000\012\004\055\005\021\006\017\007" +
    "\016\001\001\000\010\005\053\006\017\007\016\001\001" +
    "\000\012\004\051\005\021\006\017\007\016\001\001\000" +
    "\016\002\015\003\050\004\007\005\021\006\017\007\016" +
    "\001\001\000\002\001\001\000\002\001\001\000\012\004" +
    "\036\005\021\006\017\007\016\001\001\000\004\010\022" +
    "\001\001\000\002\001\001\000\002\001\001\000\002\001" +
    "\001\000\010\005\026\006\017\007\016\001\001\000\004" +
    "\011\027\001\001\000\002\001\001\000\002\001\001\000" +
    "\002\001\001\000\010\005\033\006\017\007\016\001\001" +
    "\000\004\011\034\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001\000\002\001\001\000\010\005\043" +
    "\006\017\007\016\001\001\000\010\005\042\006\017\007" +
    "\016\001\001\000\002\001\001\000\002\001\001\000\006" +
    "\006\047\007\016\001\001\000\006\006\046\007\016\001" +
    "\001\000\002\001\001\000\002\001\001\000\002\001\001" +
    "\000\002\001\001\000\002\001\001\000\002\001\001\000" +
    "\002\001\001\000\002\001\001\000\002\001\001\000\002" +
    "\001\001\000\002\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001" });

  /** Access to <code>reduce_goto</code> table. */
  public short[][] reduce_table() {return _reduce_table;}

  /** Instance of action encapsulation class. */
  protected CUP$ParserLogic$actions action_obj;

  /** Action encapsulation object initializer. */
  protected void init_actions()
    {
      action_obj = new CUP$ParserLogic$actions(this);
    }

  /** Invoke a user supplied parse action. */
  public java_cup.runtime.Symbol do_action(
    int                        act_num,
    java_cup.runtime.lr_parser parser,
    java.util.Stack            stack,
    int                        top)
    throws java.lang.Exception
  {
    /* call code in generated class */
    return action_obj.CUP$ParserLogic$do_action(act_num, parser, stack, top);
  }

  /** Indicates start state. */
  public int start_state() {return 0;}
  /** Indicates start production. */
  public int start_production() {return 0;}

  /** <code>EOF</code> Symbol index. */
  public int EOF_sym() {return 0;}

  /** <code>error</code> Symbol index. */
  public int error_sym() {return 1;}


 

private boolean erreurSyntaxique;
private String messageErreur;

/** Redéfinition de la méthode parse() pour levée de 
  * ParserException() en cas d'erreur syntaxique.
  * @throws ParserException en cas d'erreur syntaxique.
  */ 
public Symbol parse() throws Exception, ParserException {
   Symbol s = null;
   try {    
     s = super.parse();
   } catch (Exception e) {
   	   if (this.erreurSyntaxique)
     	      throw new ParserException(this.messageErreur); 
           else throw e;
   }
   return s;
} 

/** Redéfinition de syntax_error() pour qu'elle affiche
  * le symbole courant.
  */
public void syntax_error(Symbol symboleCourant) {
    this.erreurSyntaxique = true;
    this.messageErreur = "erreur syntaxique sur le symbole " 
    + ((Symbole)symboleCourant).getRepresentationTextuelle() 
    + " ligne " + (symboleCourant.left + 1) 
    + " colonne " + (symboleCourant.right + 1);
}


}

/** Cup generated class to encapsulate user supplied action code.*/
class CUP$ParserLogic$actions {
  private final ParserLogic parser;

  /** Constructor */
  CUP$ParserLogic$actions(ParserLogic parser) {
    this.parser = parser;
  }

  /** Method with the actual generated action code. */
  public final java_cup.runtime.Symbol CUP$ParserLogic$do_action(
    int                        CUP$ParserLogic$act_num,
    java_cup.runtime.lr_parser CUP$ParserLogic$parser,
    java.util.Stack            CUP$ParserLogic$stack,
    int                        CUP$ParserLogic$top)
    throws java.lang.Exception
    {
      /* Symbol object for return from actions */
      java_cup.runtime.Symbol CUP$ParserLogic$result;

      /* select the action based on the action number */
      switch (CUP$ParserLogic$act_num)
        {
          /*. . . . . . . . . . . . . . . . . . . .*/
          case 23: // listesub ::= 
            {
              Substitution RESULT =null;
		 RESULT = new Substitution(); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("listesub",7, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 22: // listesub ::= VIR VARIABLE AFF form1 listesub 
            {
              Substitution RESULT =null;
		int vleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-3)).left;
		int vright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-3)).right;
		String v = (String)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-3)).value;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		int lleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int lright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Substitution l = (Substitution)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 l.set(v, f); RESULT = l; 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("listesub",7, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-4)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 21: // substitution ::= CO VARIABLE AFF form1 listesub CF 
            {
              Substitution RESULT =null;
		int vleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-4)).left;
		int vright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-4)).right;
		String v = (String)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-4)).value;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).value;
		int lleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int lright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Substitution l = (Substitution)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		 l.set(v, f); RESULT = l; 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("substitution",6, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-5)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 20: // form3 ::= FALSE 
            {
              Formule RESULT =null;
		 RESULT = new Constante(false); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form3",5, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 19: // form3 ::= TRUE 
            {
              Formule RESULT =null;
		 RESULT = new Constante(true); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form3",5, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 18: // form3 ::= VARIABLE 
            {
              Formule RESULT =null;
		int vleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int vright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		String v = (String)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = new Variable(v); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form3",5, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 17: // form3 ::= PO form1 PF 
            {
              Formule RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		 RESULT = f; 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form3",5, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 16: // form3 ::= NON form3 
            {
              Formule RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = new Non(f); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form3",5, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 15: // form2 ::= form3 
            {
              Formule RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = f; 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form2",4, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 14: // form2 ::= form3 ET form2 
            {
              Formule RESULT =null;
		int fgleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).left;
		int fgright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).right;
		Formule fg = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).value;
		int fdleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fdright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule fd = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = new Et(fg, fd); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form2",4, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 13: // form2 ::= form3 OU form2 
            {
              Formule RESULT =null;
		int fgleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).left;
		int fgright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).right;
		Formule fg = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).value;
		int fdleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fdright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule fd = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = new Ou(fg, fd); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form2",4, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 12: // form1 ::= form2 
            {
              Formule RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = f; 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form1",3, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 11: // form1 ::= form2 EQUIV form1 
            {
              Formule RESULT =null;
		int fgleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).left;
		int fgright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).right;
		Formule fg = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).value;
		int fdleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fdright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule fd = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = new Equivalence(fg, fd); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form1",3, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 10: // form1 ::= form2 IMPL form1 
            {
              Formule RESULT =null;
		int fgleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).left;
		int fgright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).right;
		Formule fg = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)).value;
		int fdleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fdright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule fd = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = new Implique(fg, fd); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("form1",3, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 9: // formule ::= form1 substitution 
            {
              Formule RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		int sleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int sright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Substitution s = (Substitution)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = f.substitue(s); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("formule",2, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 8: // formule ::= form1 
            {
              Formule RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.peek()).value;
		 RESULT = f; 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("formule",2, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 7: // commande ::= formule POINT 
            {
              Object RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		 System.out.println(f); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("commande",0, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 6: // commande ::= DPLL formule POINT 
            {
              Object RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		
      Formule f2 = f.fnc();
      System.out.println("Formule en FNC : \n" + f2.toString());
      System.out.println("Liste de clauses : ");
      ListeClauses l = null;
      try
      {
        l = f2.clauses();
        System.out.println(l);
      }
      catch(TrueClauseException e)
      {
        System.out.println("Tautologie"); 
      }
      catch(FalseClauseException e)
      {
        System.out.println("Non satisfiable"); 
      }
      try
      {
        Substitution s = l.dpll();
        System.out.println(s);
      }
      catch(NotSatisfiableException e)
      {
        System.out.println("Non satisfiable"); 
      }
    
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("commande",0, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 5: // commande ::= VL formule POINT 
            {
              Object RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		 Set<String> set = f.variablesLibres() ; for (String s : set) System.out.print(s + " "); System.out.println();
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("commande",0, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 4: // commande ::= FNC formule POINT 
            {
              Object RESULT =null;
		int fleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int fright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule f = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		 
      Formule f2 = f.fnc();
      System.out.println("Formule en FNC : \n" + f2.toString());
      System.out.println("Liste de clauses : ");
      try
      {
        ListeClauses l = f2.clauses();
        System.out.println(l);
      }
      catch(TrueClauseException e)
      {
        System.out.println("⊤"); 
      }
      catch(FalseClauseException e)
      {
        System.out.println("⊥"); 
      }
    
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("commande",0, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 3: // commande ::= TABLE formule POINT 
            {
              Object RESULT =null;
		int eleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int eright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Formule e = (Formule)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		 e.tableVerite(); 
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("commande",0, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-2)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 2: // listecommandes ::= 
            {
              Object RESULT =null;

              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("listecommandes",1, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 1: // listecommandes ::= commande listecommandes 
            {
              Object RESULT =null;

              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("listecommandes",1, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          return CUP$ParserLogic$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 0: // $START ::= listecommandes EOF 
            {
              Object RESULT =null;
		int start_valleft = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).left;
		int start_valright = ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).right;
		Object start_val = (Object)((java_cup.runtime.Symbol) CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)).value;
		RESULT = start_val;
              CUP$ParserLogic$result = parser.getSymbolFactory().newSymbol("$START",0, ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.elementAt(CUP$ParserLogic$top-1)), ((java_cup.runtime.Symbol)CUP$ParserLogic$stack.peek()), RESULT);
            }
          /* ACCEPT */
          CUP$ParserLogic$parser.done_parsing();
          return CUP$ParserLogic$result;

          /* . . . . . .*/
          default:
            throw new Exception(
               "Invalid action number found in internal parse table");

        }
    }
}

