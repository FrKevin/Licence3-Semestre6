package logicline.modeleSemantique;

import java.util.*;

public class ListeClauses {
    public ListeClauses()
    {
        clauses = new LinkedList<Clause>();
    }

    public String toString()
    {
        if (clauses.size() == 0)
          return "⊤"; 

        String s = "";
        ListIterator<Clause> it = clauses.listIterator();
        s += it.next().toString();
        while(it.hasNext())
            s += " ∧ " + it.next().toString(); 
        return s; 
    }

    public void add(Clause c)
    {
        clauses.add(c);
    }

    public void addAll(ListeClauses l)
    {
        clauses.addAll(l.clauses);
    }

    public Clause get(int i)
    {
        return clauses.get(i);
    }

    public ListeClauses simplifieClause(String litteral, boolean valeur) throws NotSatisfiableException
    {
        //À compléter
        return new ListeClauses();
    }

    public Substitution dpll() throws NotSatisfiableException
    {
        //À compléter
        return null
    }

    private List<Clause> clauses;
}
