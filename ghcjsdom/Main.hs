import Control.Monad.IO.Class (MonadIO(..))
import Control.Concurrent.MVar (takeMVar, putMVar, newEmptyMVar)
import GHCJS.DOM --(run, syncPoint, currentDocument)
import GHCJS.DOM.Types
       --(HTMLParagraphElement(..), HTMLSpanElement(..))
import GHCJS.DOM.Document
import GHCJS.DOM.Element --(setInnerHTML)
import GHCJS.DOM.Node --(appendChild)
import GHCJS.DOM.EventM --(on, mouseClientXY)
import GHCJS.DOM.Document as D (click)
import GHCJS.DOM.HTMLElement -- as E (click)

import Control.Concurrent

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

main = do
    Just doc <- currentDocument
    Just body <- getBody doc
    setInnerHTML body (Just "<style> span {margin: 10px}</style>")
    myloop 100000 doc body $ take (11::Int) fibs

myloop d doc body (x:xs) = do
    appendText doc body x
    threadDelay d
    forkIO $ myloop (d + 10000) doc body xs
    myloop d doc body xs
myloop _ _ _ _ =
    return ()


appendText doc body i = do
    Just newParagraph <- createElement doc (Just "span")
    let xxx = toJSString (show i)
    text <- createTextNode doc xxx
    appendChild newParagraph text
    appendChild body (Just newParagraph)
    return ()

