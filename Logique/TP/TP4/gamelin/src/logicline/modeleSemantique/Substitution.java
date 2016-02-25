package logicline.modeleSemantique;

import java.util.*;

public class Substitution {
	public Substitution()
	{
		substitutions = new TreeMap<String, Formule>();
	}

	public Substitution(Substitution s)
	{
		substitutions = new TreeMap<String, Formule>(s.substitutions);
	}

	public String toString()
	{
		if (substitutions.isEmpty())
			return "[]";
		Iterator it = substitutions.entrySet().iterator();
		Map.Entry pairs = (Map.Entry)it.next();
		String s = "[" + (String)pairs.getKey() + " ← " + ((Formule)pairs.getValue()).toString();
	    while(it.hasNext())
	    {
	    	pairs = (Map.Entry)it.next();
	    	s += ", " + (String)pairs.getKey() + " ← " + ((Formule)pairs.getValue()).toString();
	    }
		return s + "]";
	}

	public String ligneTable()
	{
		Iterator it = substitutions.entrySet().iterator();
		String s = "";
	    while(it.hasNext())
	    {
			Map.Entry pairs = (Map.Entry)it.next();
			s += ((Formule)pairs.getValue()).toString() + "\t|";
		}
		return s;
	}

	public void set(String v, Formule f)
	{
		substitutions.put(new String(v), f);
	}

	public Formule get(String v)
	{
		return substitutions.get(v);
	}

	public boolean isEmpty()
	{
		return substitutions.isEmpty();
	}

	private Map<String, Formule> substitutions;
}
