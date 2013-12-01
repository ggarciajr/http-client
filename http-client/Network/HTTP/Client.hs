-- | This is the main entry point for using http-client. Used by itself, this
-- module provides low-level access for streaming request and response bodies,
-- and only non-secure HTTP connections. Helper packages such as http-conduit
-- provided higher level streaming approaches, while other helper packages like
-- http-client-tls provide secure connections.
--
-- There are three core components to be understood here: requests, responses,
-- and managers. A @Manager@ keeps track of open connections to various hosts,
-- and when requested, will provide either an existing open connection or
-- create a new connection on demand. A @Manager@ also automatically reaps
-- connections which have been unused for a certain period of time. A @Manager@
-- allows for more efficient HTTP usage by allowing for keep-alive connections.
-- Secure HTTP connections can be allowed by modifying the settings used for
-- creating a manager. The simplest way to create a @Manager@ is with:
--
-- > 'newManager' 'defaultManagerSettings'
--
-- The next core component is a @Request@, which represents a single HTTP
-- request to be sent to a specific server. @Request@s allow for many settings
-- to control exact how they function, but usually the simplest approach for
-- creating a @Request@ is to use 'parseUrl'.
--
-- Finally, a @Response@ is the result of sending a single @Request@ to a
-- server, over a connection which was acquired from a @Manager@. Note that you
-- must close the response when you're done with it to ensure that the
-- connection is recycled to the @Manager@ to either be used by another
-- request, or to be reaped. Usage of @withResponse@ will ensure that this
-- happens automatically.
--
-- Helper packages may provide replacements for various recommendations listed
-- above. For example, if using http-client-tls, instead of using
-- 'defaultManagerSettings', you would want to use @tlsManagerSettings@. Be
-- sure to read the relevant helper library documentation for more information.
module Network.HTTP.Client
    ( -- * Performing requests
      withResponse
    , httpLbs
    , responseOpen
    , responseClose
      -- * Connection manager
    , Manager
    , newManager
    , closeManager
      -- ** Connection manager settings
    , ManagerSettings
    , defaultManagerSettings
    , managerConnCount
    , managerRawConnection
    , managerTlsConnection
    , managerResponseTimeout
    , managerRetryableException
    , managerWrapIOException
      -- * Request
    , parseUrl
    , applyBasicAuth
    , urlEncodedBody
      -- ** Request type and fields
    , Request
    , method
    , secure
    , host
    , port
    , path
    , queryString
    , requestHeaders
    , requestBody
    , proxy
    , decompress
    , redirectCount
    , checkStatus
    , responseTimeout
    , cookieJar
      -- ** Request body
    , RequestBody (..)
    , Popper
    , NeedsPopper
    , GivesPopper
      -- * Response
    , Response
    , responseStatus
    , responseVersion
    , responseHeaders
    , responseBody
    , responseCookieJar
      -- ** Response body
    , BodyReader
    , brRead
    , brConsume
      -- * Misc
    , HttpException (..)
    , Cookie (..)
    , CookieJar
    , Proxy (..)
      -- * Cookies
    , module Network.HTTP.Client.Cookies
    ) where

import Network.HTTP.Client.Body
import Network.HTTP.Client.Cookies
import Network.HTTP.Client.Core
import Network.HTTP.Client.Manager
import Network.HTTP.Client.Request
import Network.HTTP.Client.Response
import Network.HTTP.Client.Types