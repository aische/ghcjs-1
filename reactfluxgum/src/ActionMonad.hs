{-# LANGUAGE TypeFamilies #-}


module ActionMonad where


import           Control.Concurrent
import           Control.Monad.State
import           Data.Aeson
import           GHCJS.Types
import           React.Flux


import           Ajax
import           Async
import           Msg


data Action model a = M { unM :: ReactStore model -> (a -> Msg model) -> Msg model }


runAction :: ReactStore model -> Action model () -> Msg model
runAction store (M m) = m store (const Done)


instance Functor (Action model) where
  fmap f (M g) = M $ \store cont -> g store (cont . f)


instance Applicative (Action model) where
  pure a = M $ \store cont -> cont a
  M mf <*> M ma = M $ \store cont -> mf store (\f -> ma store (\a -> cont (f a)))


instance Monad (Action model) where
  return = pure
  M ma >>= f = M $ \store cont -> ma store (\a -> unM (f a) store cont)


updateModel :: (model -> model) -> Action model ()
updateModel f = M $ \store cont -> Poke f (cont ())


getModel :: Action model model
getModel = M $ \store cont -> Peek $ \model -> cont model


ajaxAction :: (StoreAction model ~ Msg model, FromJSON a, StoreData model) => JSString -> Action model (Either JSString a)
ajaxAction url = asyncAction (ajax $ mkGetRequest url)


ajaxPostAction :: (StoreAction model ~ Msg model, ToJSON a, FromJSON b, StoreData model) => JSString -> a -> Action model (Either JSString b)
ajaxPostAction url a = asyncAction (ajax $ mkPostRequest url a)


asyncAction :: (StoreAction model ~ Msg model, StoreData model) => IO a -> Action model a
asyncAction ioa = M $ \store cont -> IOA $ \model -> do
  forkIO $ do
    result <- ioa
    alterStore store $ cont result
  return model


delayAction :: (StoreAction model ~ Msg model, StoreData model) => Int -> Action model ()
delayAction delay = M $ \store cont -> IOA $ \model -> do
  forkIO $ do
    threadDelay delay
    alterStore store $ cont ()
  return model


instance (StoreAction model ~ Msg model, StoreData model) => MonadIO (Action model) where
  liftIO = asyncAction

