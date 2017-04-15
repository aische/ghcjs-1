{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}


module Ajax where


import           Data.Aeson
import           Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Lazy.Char8 as C8
import qualified Data.JSString as JSString
import           GHCJS.Types
import           JavaScript.Web.XMLHttpRequest
import           React.Flux


ajax :: FromJSON a => Request -> IO (Either JSString a)
ajax req = do
  resp  <- fmap contents <$> xhrByteStringE req
  pure $ case resp of
    Left e -> Left (JSString.pack e)
    Right Nothing -> Left "Empty body"
    Right (Just bs) -> case eitherDecode (L.fromStrict bs) of
      Left se ->
        Left (JSString.pack se)

      Right r ->
        Right r


mkGetRequest :: JSString -> Request
mkGetRequest str =
  Request { reqMethod = GET --method :: Method
          , reqURI = str :: JSString
          , reqLogin = Nothing :: Maybe (JSString, JSString)
          , reqHeaders = []
          , reqWithCredentials = False
          , reqData = NoData :: RequestData
          }


mkPostRequest :: ToJSON a => JSString -> a -> Request
mkPostRequest str a =
  let bs = encode a in
  Request { reqMethod = POST --method :: Method
          , reqURI = str :: JSString
          , reqLogin = Nothing :: Maybe (JSString, JSString)
          , reqHeaders = [("content-type", "application/json")]
          , reqWithCredentials = False
          , reqData = StringData (JSString.pack $ C8.unpack bs)
          }


mkReq :: Method -> JSString -> Request
mkReq method str =
  Request { reqMethod = method :: Method
          , reqURI = str :: JSString
          , reqLogin = Nothing :: Maybe (JSString, JSString)
          , reqHeaders = []
          , reqWithCredentials = False
          , reqData = NoData :: RequestData
          }

