{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import           Control.Applicative
import           Control.Concurrent
import           Control.Concurrent
import           Control.Concurrent.MVar (takeMVar, putMVar, newEmptyMVar)
import           Control.DeepSeq
import           Control.Exception
import           Control.Monad.State
import           Data.Aeson
import           Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as L
import qualified Data.Char as Char
import qualified Data.JSString as JSString
import           Data.Map (Map)
import qualified Data.Map as Map
import           Data.Monoid
import qualified Data.Set as Set
import           Data.Set (Set)
import qualified Data.Text as Text
import           Data.Typeable
import           GHC.Generics
import           GHCJS.Types
import           JavaScript.Web.XMLHttpRequest
import           React.Flux
--import           React.Flux.Ajax
import           React.Flux.Combinators
import           React.Flux.Addons.Intl
import           System.Random
--import           Utils

import           Ajax
import           Async
import           Msg
import           ActionMonad


-------------------------------------------------------------------------------
data MyState = MyState
  { counter :: Int
  , running :: Bool
  , content :: Maybe Value
  , loadstatus :: JSString
  }
  deriving (Show, Typeable)


initialMyState :: MyState
initialMyState = MyState
  { counter = 0
  , running = False
  , content = Nothing
  , loadstatus = "Idle"
  }


instance StoreData MyState where
  type StoreAction MyState = Msg MyState
  transform action state =
    updateMsg action state


myStore :: ReactStore MyState
myStore = mkStore initialMyState


dispatchMsg :: Msg MyState -> [SomeStoreAction]
dispatchMsg a = [SomeStoreAction myStore a]


dispatchAction :: Action MyState () -> [SomeStoreAction]
dispatchAction a = dispatchMsg $ runAction myStore a
-------------------------------------------------------------------------------

loadUrl :: JSString -> Action MyState ()
loadUrl url = do
  updateModel (\model -> model { content = Nothing, loadstatus = "Loading: " `JSString.append` url })
  r <- ajaxAction url
  case r of
    Left err ->
      updateModel (\model -> model { loadstatus = ("Error: " `JSString.append` err) })
    Right v ->
      updateModel (\model -> model { content = Just v, loadstatus = "Idle" })


increment :: Action MyState ()
increment = updateModel $ \model -> model { counter = counter model + 1 }


decrement :: Action MyState ()
decrement = updateModel $ \model -> model { counter = counter model - 1 }


counterloop :: Action MyState ()
counterloop = do
  r <- running <$> getModel
  if r then do
    increment
    delayAction (1000 * 1000)
    counterloop
  else do
    return ()


togglecounterloop :: Action MyState ()
togglecounterloop = do
  r <- running <$> getModel
  if r then do
    updateModel $ \model -> model { running = False }
  else do
    updateModel $ \model -> model { running = True }
    counterloop


--testblabla :: Action MyState ()
--testblabla = do
--  let url = "..."
--  updateModel (\model -> model { content = Nothing, loadstatus = "Loading: " `JSString.append` url })
--  r <- ajaxAction url
--  case r of
--    Left err ->
--      updateModel (\model -> model { loadstatus = ("Error: " `JSString.append` err) })
--    Right v -> do
--      updateModel (\model -> model { content = Just v, loadstatus = "Idle" })
--      updateModel (\model -> model { loadstatus = "Sending" })
--      x <- ajaxPostAction "..." v
--      case x of
--        Left err ->
--          updateModel (\model -> model { loadstatus = ("Error: " `JSString.append` err) })
--        Right v -> do
--          updateModel (\model -> model { content = Just v, loadstatus = "Idle" })


myApp :: ReactView ()
myApp = do
  defineControllerView "My APP" myStore $ \state () ->
    div_ $
    do
      span_ [] (elemString (show (counter state)))

      button_ [ onClick $ \_ _ -> dispatchMsg (Poke (\s -> s { counter = counter s - 1 }) Done ) ] "-"
      button_ [ onClick $ \_ _ -> dispatchMsg (Poke (\s -> s { counter = counter s + 1 }) Done ) ] "+"

      button_
        [ onClick $ \_ _ -> dispatchAction $ do
            x <- liftIO $ randomRIO (0,100)
            updateModel (\model -> model { counter = x })
        ] "random counter"

      button_
        [ onClick $ \_ _ -> dispatchAction $ do
            delayAction (2 * 1000 * 1000)
            x <- liftIO $ randomRIO (0,100)
            updateModel (\model -> model { counter = x })
        ] "delayed random counter"

      button_
        [ onClick $ \_ _ -> dispatchAction togglecounterloop
        ] (if running state then "stop counter" else "start counter")

      button_
        [ onClick $ \_ _ -> dispatchAction $ loadUrl "http://api.smartnoob.de/ferien/v1/ferien/?bundesland=bw&jahr=2017"
        ] "load json"

      span_ [] (elemJSString $ loadstatus state)

      case content state of
        Nothing ->
          return ()

        Just v ->
          div_ [] (elemString (show v))

      return ()


realApp =
  div_ $
  do
    view myApp () mempty


app :: ReactView ()
app =
  defineView "core app" $ \() ->
  realApp


main :: IO ()
main = do
  reactRender "app" app ()


