module StringSplitting where

import Data.List (intersperse, intercalate)

split :: Char -> String -> [String]
--split _ [] = []
split c xs = xs' : if null xs'' then [] else split c (tail xs'')
    where xs' = takeWhile (/=c) xs
          xs''= dropWhile (/=c) xs

myjoin :: Char -> [String] -> String
myjoin c = concat . intersperse [c]
--or
--myjoin c = intercalate [c]
