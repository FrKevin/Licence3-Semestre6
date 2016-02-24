


data Operateur = Mult | Div | Moins | Plus
                    deriving (Show)

data Expression = Valeur Float
                   | Operation Operateur Expression Expression
                   deriving (Show)

op2String :: Operateur -> String
op2String Mult = "*"
op2String Div = "/"
op2String Moins = "-"
op2String Plus = "+"

op2Function :: Operateur -> Float -> Float -> Float
op2Function Mult = (*)
op2Function Div = (/)
op2Function Moins = (-)
op2Function Plus = (+)

tree2String :: Expression -> String
tree2String (Valeur v) = show v
tree2String (Operation o g d) = "(" ++ (tree2String g)
                                ++ " " ++ (op2String o)
                                ++ " "  ++ (tree2String d) ++ ")"


eval :: Expression -> Float
eval (Valeur v) = v
eval (Operation o g d) = (op2Function o) (eval g) (eval d)

foldExpr :: (Operateur -> Float -> Float -> Float) -> Expression -> Float
foldExpr _ (Valeur x) = x
foldExpr f (Operation op e1 e2) = (f op) (foldExpr f e1) (foldExpr f e2)

eval' :: Expression -> Float
eval' = foldrExpr op2Function

exemple :: Expression
exemple = (Operation Mult (Valeur 3) (Operation Plus (Valeur 6) (Valeur 4)))

