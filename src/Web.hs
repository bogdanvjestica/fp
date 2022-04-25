{-# language OverloadedStrings #-}
{-# language ScopedTypeVariables #-}

module Web (server) where

import qualified Data.Text as T
import qualified Web.Scotty as S
import qualified Lucid as H
import           Network.Wai.Middleware.Static
import           Control.Monad.IO.Class (liftIO)
import           Control.Monad
import qualified Baza as D
import           Data.String

type Html = H.Html()

format :: [a] -> [a]
format s = reverse (drop 1 (reverse (drop 1 s)))

server :: IO ()
server = do
    S.scotty 8080 $ do
        S.middleware $ staticPolicy (addBase "static")
        S.get "/" $ do
            html $ do
                H.head_ $ do
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/font/css/font-awesome.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/bootstrap/bootstrap.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/style.css" ]
                    H.toHtmlRaw $ T.pack "<script src='js/jquery-3.3.1.min.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/session.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/bootstrap.min.js'></script>"
                    H.title_ "Home page"

                    menu
                H.body_ $ do
                    H.div_ [ H.class_ "container" ] ""
                                
        S.get "/news" $ do
            l <- liftIO D.getNews
            html $ do
                H.head_ $ do
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/font/css/font-awesome.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/bootstrap/bootstrap.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/news.css" ]
                    H.toHtmlRaw $ T.pack "<script src='js/jquery-3.3.1.min.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/session.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/news.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/bootstrap.min.js'></script>"
                    H.title_ "News"

                    menu
                H.body_ $ do
                    H.div_ [ H.class_ "container pt-3 pb-5" ] $ do
                        H.div_ [ H.class_ "row" ] $ do
                            H.div_ [ H.class_ "col-md-10 offset-1", H.id_ "msg" ] $ do
                                H.div_ [ H.class_ "alert alert-success alert-dismissable", H.role_ "alert", H.id_ "allow", H.style_ "display: none;"] ""
                            H.div_ [ H.class_ "col-md-12" ] $ do
                                H.a_ [H.href_ "/add", H.class_ "btn btn-primary float-right add", H.style_ "display: none;" ] "Add Post"
                            forM_ l $ \l -> do
                                H.div_ [ H.class_ "col-md-12" ] $ do
                                    H.div_ [ H.class_ "card mt-3 bg-light bg-gradient opacity-50" ] $ do
                                        H.div_ [ H.class_ "card-body" ] $ do
                                            H.h5_ [ H.class_ "card-title" ] $ do
                                                H.toHtml $ l !! 3
                                            H.h2_ [ H.class_ "card-title" ] $ do
                                                H.b_ $ do
                                                    H.toHtml $ format $ l !! 1
                                            H.p_ [ H.class_ "card-text txt" ] $ do
                                                H.toHtmlRaw $ format $ l !! 2
                                            H.input_ [ H.type_ "button", H.id_ $ fromString $ head l , H.class_ "btn btn-primary more", H.value_ "Read more"]

                                H.div_ [ H.class_ "col-md-10 offset-1", H.id_ $ fromString $ "more-" ++ head l, H.style_ "display: none;" ] $ do
                                    H.div_ [ H.class_ "card bg-light bg-gradient" ] $ do
                                        H.div_ [ H.class_ "card-body" ] $ do
                                            H.h5_ [ H.class_ "card-title" ] $ do
                                                H.toHtml $ l !! 3
                                            H.h2_ [ H.class_ "card-title" ] $ do
                                                H.b_ $ do
                                                    H.toHtml $ format $ l !! 1
                                            H.p_ [ H.class_ "card-text" ] $ do
                                                H.toHtmlRaw $ format $ l !! 2
                                            H.input_ [ H.type_ "button", H.id_ $ fromString $ "closebtn-" ++ head l, H.class_ "btn btn-danger", H.value_ "Close"]

                                H.div_ [ H.class_ "col-md-10 offset-1", H.id_ $ fromString $ "more-admin-" ++ head l, H.style_ "display: none;" ] $ do
                                    H.div_ [ H.class_ "card bg-light bg-gradient" ] $ do
                                        H.div_ [ H.class_ "card-body" ] $ do
                                            H.form_ [ H.method_ "post", H.id_ $ fromString $ "update-" ++ head l ] $ do
                                                H.input_ [ H.type_ "hidden", H.value_ $ fromString $ head l, H.id_ $ fromString $ "postID-" ++ head l ]
                                                H.h5_ [ H.class_ "card-title" ] $ do
                                                    H.toHtml $ l !! 3
                                                H.div_ [ H.class_ "form-group" ] $ do
                                                    H.label_ [ H.for_ "name" ] "Name"
                                                    H.input_ [ H.type_ "text", H.class_ "form-control", H.value_ $ fromString $ format $ l !! 1, H.id_ $ fromString $ "name-" ++ head l, H.required_ ""]
                                                H.div_ [ H.class_ "form-group" ] $ do
                                                    H.label_ [ H.for_ "content" ] "Content"
                                                    H.textarea_ [ H.class_ "form-control", H.id_ $ fromString $ "content-" ++ head l, H.rows_ "9", H.required_ "" ] $ fromString $ format $ l !! 2
                                                H.div_ [ H.class_ "form-group" ] $ do
                                                    H.label_ [ H.for_ "preview" ] "Preview"
                                                    H.div_ [ H.class_ "card bg-light bg-gradient" ] $ do
                                                        H.div_ [ H.class_ "card-body" ] $ do
                                                            H.p_ [ H.class_ "card-text", H.name_ "preview" ] $ do
                                                                H.toHtmlRaw $ format $ l !! 2
                                                H.div_ [ H.class_ "card-footer" ] $ do
                                                    H.input_ [ H.type_ "button", H.id_ $ fromString $ "closebtn-admin-" ++ head l, H.class_ "btn btn-danger", H.value_ "Close"]
                                                    H.input_ [ H.type_ "button", H.id_ $ fromString $ head l, H.class_ "btn btn-warning float-right rempost", H.value_ "Delete post"]
                                                    H.button_ [ H.class_ "btn btn-success float-right mr-1", H.type_ "submit" ] "Save"
                
        S.get "/add" $ do
            html $ do
                H.head_ $ do
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/font/css/font-awesome.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/bootstrap/bootstrap.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/news.css" ]
                    H.toHtmlRaw $ T.pack "<script src='js/jquery-3.3.1.min.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/session.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/add.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/bootstrap.min.js'></script>"
                    H.title_ "New Post"

                    menu
                H.body_ $ do
                    H.div_ [ H.class_ "container pt-3" ] $ do
                        H.div_ [ H.class_ "col-md-8 offset-2", H.id_ "msg" ] $ do
                            H.div_ [ H.class_ "alert alert-success alert-dismissable", H.role_ "alert", H.id_ "allow", H.style_ "display: none;"] ""
                        H.div_ [ H.class_ "col-md-8 offset-2" ] $ do
                            H.div_ [ H.class_ "card" ] $ do
                                H.div_ [ H.class_ "card-header" ] "New Post"
                                H.div_ [ H.class_ "card-body" ] $ do
                                    H.form_ [ H.method_ "post", H.id_ "insert" ] $ do
                                        H.div_ [ H.class_ "form-group" ] $ do
                                            H.label_ [ H.for_ "name" ] "Name"
                                            H.input_ [ H.type_ "text", H.class_ "form-control", H.id_ "name", H.required_ ""]
                                        H.div_ [ H.class_ "form-group" ] $ do
                                            H.label_ [ H.for_ "content" ] "Content"
                                            H.textarea_ [ H.class_ "form-control", H.id_ "content", H.rows_ "10", H.required_ "" ] ""
                                        H.button_ [ H.class_ "btn btn-primary", H.type_ "submit" ] "Add Post"

        S.get "/login" $ do
            html $ do
                H.head_ $ do
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/font/css/font-awesome.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/bootstrap/bootstrap.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/news.css" ]
                    H.toHtmlRaw $ T.pack "<script src='js/jquery-3.3.1.min.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/session.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/login.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/bootstrap.min.js'></script>"
                    H.title_ "Login"

                    menu
                H.body_ $ do
                    H.div_ [ H.class_ "container pt-3 pb-5" ] $ do
                        H.div_ [ H.class_ "row" ] $ do
                            H.div_ [ H.class_ "col-md-6 offset-3 mt-3", H.id_ "msg" ] $ do
                                H.div_ [ H.class_ "alert alert-success alert-dismissable", H.role_ "alert", H.id_ "allow", H.style_ "display: none;"] ""
                                H.div_ [ H.class_ "alert alert-danger alert-dismissable", H.role_ "alert", H.id_ "deny", H.style_ "display: none;"] ""
                            H.div_ [ H.class_ "col-md-6 offset-3" ] $ do
                                H.div_ [ H.class_ "card bg-light bg-gradient" ] $ do
                                    H.div_ [ H.class_ "card-body" ] $ do
                                        H.h2_ [ H.class_ "card-title" ] $ do
                                            H.b_ $ do
                                                "Login"
                                        H.form_ [ H.method_ "post", H.id_ "login" ] $ do
                                            H.div_ [ H.class_ "form-group" ] $ do
                                                H.label_ [ H.for_ "name" ] "E-mail address"
                                                H.input_ [ H.type_ "email", H.class_ "form-control", H.id_ "email", H.required_ ""]
                                            H.div_ [ H.class_ "form-group" ] $ do
                                                H.label_ [ H.for_ "content" ] "Password"
                                                H.input_ [ H.type_ "password", H.class_ "form-control", H.id_ "password", H.required_ "" ]
                                            H.button_ [ H.class_ "btn btn-primary", H.type_ "submit" ] "Login"
        S.get "/destinations" $ do
            l <- liftIO D.getDests
            html $ do
                H.head_ $ do
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/font/css/font-awesome.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/bootstrap/bootstrap.min.css" ]
                    H.link_ [ H.rel_ "stylesheet", H.type_ "text/css", H.href_ "css/news.css" ]
                    H.toHtmlRaw $ T.pack "<script src='js/jquery-3.3.1.min.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/session.js'></script>"
                    H.toHtmlRaw $ T.pack "<script src='js/bootstrap.min.js'></script>"
                    H.title_ "Destinations"

                    menu
                H.body_ $ do
                    H.div_ [ H.class_ "container" ] $ do
                        H.div_ [ H.class_ "col-md-12 row" ] $ do
                            forM_ l $ \l -> do
                                H.div_ [ H.class_ "col-md-4 pt-4" ] $ do
                                    H.div_ [ H.class_ "card", H.style_ "width: 18rem;" ] $ do
                                        H.img_ [ H.class_ "card-img-top", H.style_ "width:286px; height: 190px;", H.src_ $ fromString $ format $ l !! 2, H.alt_ $ fromString $ format $ head l ]
                                        H.div_ [ H.class_ "card-body" ] $ do
                                            H.h2_ [ H.class_ "card-title" ] $ do
                                                H.b_ $ do
                                                    H.toHtml $ format $ head l
                                            H.p_ [ H.class_ "card-text"] $ do
                                                H.toHtml $ format $ l !! 1
                                            H.a_ [ H.href_ $ fromString $ format $ l !! 3, H.class_ "btn btn-primary text-center" ] "Book now"        


        S.post "/newPost" $ do
            name <- S.param "name"
            content <- S.param "content"
            liftIO $ D.newPost name content
            S.text "{\"success\":\"true\"}"

        S.post "/updatePost" $ do
            id <- S.param "id"
            name <- S.param "name"
            content <- S.param "content"
            liftIO $ D.updatePost id name content
            S.text "{\"success\":\"true\"}"

        S.post "/auth" $ do
            email <- S.param "email"
            password <- S.param "password"
            users <- liftIO $ D.auth email password
            if length users == 1 then do
                let temp = head users
                S.text $ fromString $ "{\"id\":" ++ head temp ++ ",\"name\":" ++ temp !! 1 ++ ",\"surname\":" ++ temp !! 2 ++ ",\"email\":" ++ temp !! 3 ++ "}"
            else
                S.text "{}"
        S.post "/deletePost" $ do
            id <- S.param "id"
            liftIO $ D.removePost id

html :: Html -> S.ActionM ()
html = S.html . H.renderText . H.doctypehtml_

menu :: Html
menu =
    H.nav_ [ H.class_ "navbar navbar-expand-lg bg-primary navbar-dark fixed-top" ] $ do
        H.div_ [ H.class_ "container", H.id_ "temp" ] $ do
            H.a_ [ H.class_ "navbar-brand", H.href_ "#"] $ do
                H.span_ "BNX.aero"
            H.div_ [ H.class_ "collapse navbar-collapse", H.id_ "collapsibleNavbar"] $ do
                H.ul_ [ H.class_ "navbar-nav" ] $ do
                    H.li_ [ H.class_ "nav-item"] $ do
                        H.a_ [ H.class_ "nav-link", H.href_ "/"] $ do
                            H.i_ [ H.class_ "fa fa-home" ] ""
                            H.span_ "Home Page"
                    H.li_ [ H.class_ "nav-item"] $ do
                        H.a_ [ H.class_ "nav-link", H.href_ "/news"] $ do
                            H.i_ [ H.class_ "fa fa-newspaper-o" ] ""
                            H.span_ "News"
                    H.li_ [ H.class_ "nav-item"] $ do
                        H.a_ [ H.class_ "nav-link", H.href_ "/destinations"] $ do
                            H.i_ [ H.class_ "fa fa-plane" ] ""
                            H.span_ "Destinations"
                H.ul_ [ H.class_ "navbar-nav ml-auto" ] $ do
                    H.li_ [ H.class_ "nav-item"] $ do
                        H.a_ [ H.class_ "nav-link", H.id_ "mnLogin", H.href_ "/login"] ""
                    H.li_ [ H.class_ "nav-item"] $ do
                        H.a_ [ H.class_ "nav-link", H.href_ "tel:051535210"] $ do
                            H.i_ [ H.class_ "fa fa-phone" ] ""
                            H.span_ "051 535 210"