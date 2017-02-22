{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RecursiveDo #-}

module Main where

--import Data.Aeson (object, (.=))
import Data.Default
import Data.Typeable
import GHC.Generics
import GHCJS.Types
import           Reflex
import           Reflex.Dom
import qualified Data.Map as Map
import Data.List (permutations)

main :: IO ()
main = do
    mainWidget $ do
        el "h1" $ text "Hello Reflex 1!"
        ti <- textInput def
        ti2 <- textInput def

        elAttr "div" (Map.fromList [("style", "color: red; word-wrap: break-word;")]) $ do
            sss <- mapDyn permutations (_textInput_value ti)
            simpleList sss (\s -> el "p" $ dynText s)
            return ()

        elAttr "div" (Map.fromList [("style", "color: blue; word-wrap: break-word;")]) $ do
            sss <- mapDyn primfactors (_textInput_value ti2)
            simpleList sss (\s -> el "p" $ dynText s)
            return ()


primfactors :: String -> [String]
primfactors s = fmap show $ prime_factors $ tryParseInteger s


prime_factors :: Integer -> [Integer]
prime_factors n =
  case factors of
    [] -> [n]
    _  -> factors ++ prime_factors (n `div` (head factors))
  where factors = take 1 $ filter (\x -> (n `mod` x) == 0) [2 .. n-1]


tryParseInteger :: String -> Integer
tryParseInteger s =
    case reads s of
        (i,_):_ -> i
        _       -> 0

