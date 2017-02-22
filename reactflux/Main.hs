{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Control.DeepSeq
import Control.Concurrent
import Control.Concurrent.MVar (takeMVar, putMVar, newEmptyMVar)
import Data.Typeable
import GHC.Generics
import GHCJS.Types
import React.Flux
import React.Flux.Combinators
import React.Flux.Addons.Intl
import qualified Data.JSString as JSString


data Counter
    = Counter { unCounter :: Integer, fibResult :: Integer, inputTextValue :: String }
    deriving (Show, Typeable)

data CounterAction
   = CounterIncrement
   | CounterDecrement
   | CounterFib
   | CounterSetText String
   deriving (Show, Typeable, Generic, NFData)

instance StoreData Counter where
    type StoreAction Counter = CounterAction
    transform action (Counter idx fr str) =
        pure $
        case action of
          CounterIncrement -> let idx' = idx + 1 in Counter idx' (head $ drop (max 0 (fromIntegral idx')) fibs) (show idx')
          CounterDecrement -> let idx' = idx - 1 in Counter idx' (head $ drop (max 0 (fromIntegral idx')) fibs) (show idx')
          CounterFib       -> Counter idx (head $ drop (max 0 (fromIntegral idx)) fibs) str
          CounterSetText s -> Counter (tryReadInteger idx s) fr s

counterStore :: ReactStore Counter
counterStore = mkStore (Counter 10 0 "")

dispatchCounter :: CounterAction -> [SomeStoreAction]
dispatchCounter a = [SomeStoreAction counterStore a]

counterApp :: ReactView ()
counterApp =
    defineControllerView "Counter APP" counterStore $ \counterState () ->
    div_ $
    do --button_ [ onClick $ \_ _ -> dispatchCounter CounterIncrement ] "Up" []
       button_ [ onClick $ \_ _ -> dispatchCounter CounterIncrement ] $ $(message "up-button" "Up") []
       button_ [ onClick $ \_ _ -> dispatchCounter CounterDecrement ] $ $(message "down-button" "Down") []
       span_ [property "key" ("xxx1" :: String)] $ elemString $ show $ unCounter counterState
       br_ mempty
       input_ [property "value" (inputTextValue counterState ), onInput (\e -> dispatchCounter (CounterSetText (target e "value")))]
       span_ [property "key" ("xxx3" :: String)] $ elemString $ inputTextValue counterState
       br_ mempty
       button_ [ onClick $ \_ _ -> dispatchCounter CounterFib ] $ $(message "fib-button" "Fib") []
       --span_ [property "key" ("xxx2" :: String)] $ int_ $ fibResult counterState
       span_ [property "key" ("xxx2" :: String), classNames [("breaking", True)]] $ elemString $ show $ fibResult counterState
       br_ mempty

realApp =
    div_ $
    do
        --mv <- newEmptyMVar
        view counterApp () mempty

app :: ReactView ()
app =
    defineView "core app" $ \() ->
    intlProvider_ ( js_initialLocale) (Just $ js_myMessages js_initialLocale) Nothing $
    realApp

main :: IO ()
main =
    reactRender "app" app ()

fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

tryReadInteger :: Integer -> String -> Integer
tryReadInteger def str =
    case reads str of
        (i, "") : _ -> i
        _           -> def


foreign import javascript unsafe
    "$r = window['config']['locale']"
    js_initialLocale :: JSString

foreign import javascript unsafe
    "window['i18n'] ? window['i18n'][$1] : null"
    js_myMessages :: JSString -> JSVal


$(writeIntlMessages (intlFormatJson $ "i18n/core.json"))

