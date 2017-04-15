{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeFamilies #-}


module Msg where


import           Control.DeepSeq
import           Data.Aeson
import           Data.Typeable
import           GHC.Generics
import           GHCJS.Types
import           React.Flux


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

