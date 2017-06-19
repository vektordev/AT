
main = do  
        putStrLn "Hello, what's your name?"  
        getLine  
        putStrLn ("Hey " ++ "name" ++ ", you rock!")

askName :: IO String
askName = do
--        [...]
        getLine