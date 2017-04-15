module Async where


import           Control.Concurrent
import           React.Flux


async :: StoreData state => ReactStore state -> IO r -> (r -> StoreAction state) -> IO ()
async store ioaction callback = do
  forkIO $ do
    result <- ioaction
    alterStore store $ callback result
  return ()

