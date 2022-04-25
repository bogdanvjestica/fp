{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE BlockArguments #-}

module Baza (unpack, conn, getNews, newPost, updatePost, getPost, removePost, auth, getDests) where

import           Database.MySQL.Base
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.String

temp :: [MySQLValue] -> [String]
temp = map \case {
                MySQLInt32 v -> show v;
                MySQLText v -> show v;
                MySQLDate v -> show v;
                MySQLTimeStamp v -> show v;
                _ -> "Error"
            }

unpack :: [[MySQLValue]] -> [[String]]
unpack = map temp

conn :: IO MySQLConn
conn =
    connect
        defaultConnectInfo {ciUser = "admin", ciPassword = "Qetuo121+", ciDatabase = "news"}

getNews :: IO [[String]]
getNews = do
    c <- conn
    (f,is) <- query_ c "SELECT * FROM post ORDER BY id DESC"
    l <- Streams.toList is
    close c
    return $ unpack l

getPost :: [Char] -> IO [[String]]
getPost id = do
    c <- conn
    (f, is) <- query_ c $ fromString $ "SELECT * FROM post WHERE id = '" ++ id ++ "'"
    l <- Streams.toList is
    close c
    return $ unpack l

newPost :: [Char] -> [Char] -> IO ()
newPost name content = do
    c <- conn
    execute_ c $ fromString $ "INSERT INTO post (name, content) VALUES ('" ++ name ++ "', '" ++ content ++ "')"
    close c

updatePost :: [Char] -> [Char] -> [Char] -> IO ()
updatePost id name content = do
    c <- conn
    execute_ c $ fromString $ "UPDATE post SET name = '" ++ name ++ "', content = '" ++ content ++ "' WHERE id = " ++ id
    close c

removePost :: [Char] -> IO ()
removePost id = do
    c <- conn
    execute_ c $ fromString $ "DELETE FROM post WHERE id = '" ++ id ++ "'"
    close c

auth :: [Char] -> [Char] -> IO [[String]]
auth email password = do
    c <- conn
    (f, is) <- query_ c $ fromString $ "SELECT * FROM users WHERE email = '" ++ email ++ "' AND password = '" ++ password ++ "'"
    l <- Streams.toList is
    close c
    return $ unpack l

getDests :: IO [[String]]
getDests = do
    c <- conn
    (f,is) <- query_ c "SELECT * FROM destinations"
    l <- Streams.toList is
    close c
    return $ unpack l
