{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{- # LANGUAGE OverloadedStrings #-}
{- # LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{- # LANGUAGE RecordWildCards #-}
{- # LANGUAGE ScopedTypeVariables #-}


module Msg where


--import           Control.Applicative
--import           Control.Concurrent
--import           Control.Concurrent.MVar (takeMVar, putMVar, newEmptyMVar)
import           Control.DeepSeq
--import           Control.Exception
--import           Control.Monad.State
import           Data.Aeson
--import           Data.ByteString (ByteString)
--import qualified Data.ByteString.Lazy as L
--import qualified Data.ByteString.Lazy.Char8 as C8
--import qualified Data.Char as Char
--import qualified Data.JSString as JSString
--import           Data.Map (Map)
--import qualified Data.Map as Map
--import           Data.Monoid
--import qualified Data.Set as Set
--import           Data.Set (Set)
--import qualified Data.Text as Text
import           Data.Typeable
import           GHC.Generics
import           GHCJS.Types
--import           JavaScript.Web.XMLHttpRequest
import           React.Flux
--import           React.Flux.Combinators
--import           React.Flux.Addons.Intl
--import           System.Random


import           Ajax
import           Async


data Msg model
  = Poke (model -> model) (Msg model)
  | Peek (model -> Msg model)
  | Done
  | IOA (model -> IO model)
  deriving (Typeable, Generic, NFData)


updateMsg :: Msg model -> model -> IO model
updateMsg action state =
    case action of
      Poke f a ->
        updateMsg a $ f state

      Peek f ->
        updateMsg (f state) state

      Done ->
        return state

      IOA m ->
        m state


myAjax :: (FromJSON a, StoreData model, StoreAction model ~ Msg model)
       => ReactStore model -> JSString -> (Either JSString a -> Msg model) -> Msg model
myAjax store url cont =
  IOA $ \state -> async store (ajax $ mkGetRequest url) cont >> return state

