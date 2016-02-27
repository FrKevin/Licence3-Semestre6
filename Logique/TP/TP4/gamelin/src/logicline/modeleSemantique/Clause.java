package logicline.modeleSemantique;

import java.util.*;

public class Clause {
	public Clause()
	{
		litteraux = new HashMap<String, Boolean>();
	}

	public Clause(String nom, boolean value)
	{
		litteraux = new HashMap<String, Boolean>();
		litteraux.put(nom, value);
	}

	public Clause(Clause c)
	{
		litteraux = new HashMap<String, Boolean>(c.litteraux);
	}

	//retourne une chaine représentant la clause
	public String toString()
	{
		Iterator it = litteraux.entrySet().iterator();
		String s = "(";
		if (litteraux.size() > 0)
		{
			Map.Entry pairs = (Map.Entry)it.next();
			if ((Boolean)pairs.getValue())
				s += (String)pairs.getKey();
			else
				s += "¬" + (String)pairs.getKey();
			while(it.hasNext())
			{
				pairs = (Map.Entry)it.next();
				if ((Boolean)pairs.getValue())
					s += " ∨ " + (String)pairs.getKey(); 
				else
					s += " ∨ ¬" + (String)pairs.getKey(); 
			}
		}
		s += ")"; 
		return s;
	}

	//Ajoute un littéral à une clause
	public void add(String cle, boolean v) throws TrueClauseException
	{
		Boolean b;
		//si le littéral n'y est pas déjà on l'ajoute
		if ((b = litteraux.get(cle)) == null)
			litteraux.put(new String(cle), v);
		//si son inverse y est, on renvoie true
		else if (b == !v)
			throw new TrueClauseException();
	}

	//ajoute tous les éléments de la clause à une autre clause
	public void addAll(Clause c) throws TrueClauseException
	{
		litteraux.putAll(c.litteraux);
	}

	public void remove(String cle)
	{
		litteraux.remove(cle);
	}

	//renvoie la valeur associée au littéral : 
	//	true si le littéral est positif
	//	false s'il est négatif
	//	null si le littéral n'existe pas
	public Boolean get(String cle)
	{
		return litteraux.get(cle);
	}

	public List<String> litterauxPositifs()
	{
		List<String> l = new LinkedList<String>();
		Iterator it = litteraux.entrySet().iterator();
		while (it.hasNext())
		{
			Map.Entry pairs = (Map.Entry)it.next();
			if ((Boolean)pairs.getValue())
				l.add((String)pairs.getKey());
		}
		return l;
	}

	public List<String> litterauxNegatifs()
	{
		List<String> l = new LinkedList<String>();
		Iterator it = litteraux.entrySet().iterator();
		while (it.hasNext())
		{
			Map.Entry pairs = (Map.Entry)it.next();
			if (!(Boolean)pairs.getValue())
				l.add((String)pairs.getKey());
		}
		return l;
	}

	public String premierLitteral()
	{
		Iterator it = litteraux.entrySet().iterator();
		return (String)(((Map.Entry)it.next()).getKey());
	}

	//retourne le nom du littéral de la clause unitaire si la clause l'est
	//retourne null si la clause n'est pas unitaire
	public String clauseUnitaire()
	{
		if (litteraux.size() != 1)
			return null;
		return premierLitteral();
	}

	private Map<String, Boolean> litteraux;
}
