import Graphics.Gloss

main = display (InWindow "Nice Window" (400, 400) (10, 10)) white (Circle 80)

data Field = X | O | E deriving (Show, Read, Eq)

type Board = [Field]

data List x = Cons x (List x) | Nil deriving (Show, Read, Eq)

data Person = Person {
        age :: Int,
        name :: String
}

--data Person = Person Int String

--this is not fast at all.
factorial :: Integer -> Integer
factorial 1 = 1
factorial x = x * factorial (x-1)

-- faster, but less clear
factorial' :: [Integer]
factorial' = 0 : 1 : zipWith (+) factorial' (tail factorial')

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib x = fib (x-1) + fib (x-2)

only3s [] = []
only3s (x:xs) = if x mod 3 == 0 then x:(only3s xs) else only3s xs

zipWith' [] a = []
zipWith' a [] = []
zipWith' (a:as) (b:bs) = (a + b) : zipWith' as bs

fibs = 0 : 1 : zipWith' fibs (tail fibs)
