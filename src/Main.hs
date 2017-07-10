{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.HTTP.Server
import Network.HTTP.Server.Response
import Network.URL
import Network.Socket.Internal

import Web.Spock

import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.Monoid
import Data.IORef
import qualified Data.Text as T

import Graphics.Gloss
import Graphics.Gloss.Data.ViewPort

import System.Random

import qualified Data.Vector as V

data MySession = EmptySession
data MyAppState = DummyAppState (IORef Int)

--col-state: Vector Vector Bool

it :: ViewPort -> Float -> V.Vector (V.Vector Bool) -> V.Vector (V.Vector Bool)
it _ _ array = tick array

tick :: V.Vector (V.Vector Bool) -> V.Vector (V.Vector Bool)
tick array = V.generate x (\a -> V.generate y (\b -> getNextStateAt a b))
  where
    (x,y) = (length array, length (array V.! 0))
    getNextStateAt a b =
      if getCurrentStateAt a b
        --a b is live.
        then live8Neighbors a b `elem` [2,3]
        --a b is dead
        else live8Neighbors a b `elem` [3]
    getCurrentStateAt a b = array V.! (a `mod` x) V.! (b `mod` y)
    live8Neighbors a b = length $ filter id [getCurrentStateAt (a+c) (b+d) | c <- [-1, 0, 1], d <- [-1, 0, 1], c /= 0 || d /= 0]

emptyField :: V.Vector(V.Vector Bool)
emptyField = V.replicate 80 (V.replicate 80 False)

draw :: V.Vector (V.Vector Bool) -> Picture
draw array = Scale 4 4 $ Pictures [fig a b | a <- [0..(x-1)], b <- [0..(y-1)]]
  where
    (x,y) = (length array, length (array V.! 0))
    fig :: Int -> Int -> Picture
    fig a b = Translate (fromIntegral a) (fromIntegral b) $ Color (color a b) $ Circle 0.5
    color a b = if (array V.! a) V.! b then black else red

randomField :: Int ->  IO (V.Vector(V.Vector Bool))
randomField field_size = mapM ( \ iV -> mapM ( \ someBool -> randomIO) iV) emptyField
{-randomField field_size = do
  rng <- newStdGen
  let rngBools = randoms rng
  undefined
  where splits x = (take field_size x : splits (drop field_size x))-}

main :: IO ()
main = do
  field <- randomField 0
  --display (InWindow "Nice Window" (600, 600) (10, 10)) white (draw field)
  simulate (InWindow "Nice Window" (600, 600) (10, 10)) white 10 field draw it

--    do ref <- newIORef 0
--       spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
--       runSpock 8080 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app =
    do get root $
           html "<html><head><title>Hello World</title></head><body>Hallo Welt</body></html>"
       get ("index.html") $
           html "<!doctype html><html><head><title>Hello World</title></head><body>Hallo Welt</body></html>"
       get ("hello" <//> var) $ \name ->
           do (DummyAppState ref) <- getState
              visitorNumber <- liftIO $ atomicModifyIORef' ref $ \i -> (i+1, i+1)
              Web.Spock.text ("Hello " <> name <> ", you are visitor number " <> T.pack (show visitorNumber))

--import Graphics.Gloss

--main = display (InWindow "Nice Window" (400, 400) (10, 10)) white (Circle 80)


--main = putStrLn "Hello World"



--main :: IO ()
--main = server handler

handler :: SockAddr -> URL -> Request a -> IO (Response String)
handler _ _ req = do
        putStrLn ("handling request" Prelude.++ show req)
        return $ Response (2, 0, 0) "" [Header HdrContentLength (show lngt)] msg
        --return $ respond OK
                where
                        lngt = Prelude.length msg
                        msg = "<html><head><title>Hello World</title></head><body>Hallo Welt</body></html>"

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
factorial' = 0 : 1 : Prelude.zipWith (+) factorial' (Prelude.tail factorial')

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib x = fib (x-1) + fib (x-2)

only3s [] = []
only3s (x:xs) = if x mod 3 == 0 then x:(only3s xs) else only3s xs

zipWith' [] a = []
zipWith' a [] = []
zipWith' (a:as) (b:bs) = (a + b) : zipWith' as bs

fibs = 0 : 1 : zipWith' fibs (Prelude.tail fibs)
