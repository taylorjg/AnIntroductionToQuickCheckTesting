import Test.QuickCheck
import Test.QuickCheck.Test
import StringSplitting
import System.Exit (exitFailure)

-- random c and random xs
prop_join_split :: Char -> String -> Bool
prop_join_split c xs = myjoin c (split c xs) == xs

-- random c and random xs, with collect
prop_join_split_collect :: Char -> String -> Property
prop_join_split_collect c xs =
    let ys = split c xs in
    collect (length ys) $
    myjoin c ys == xs

-- choose a c from xs using elements
prop_join_split' :: String -> Property
prop_join_split' xs = forAll (elements xs) $ \c -> prop_join_split c xs

-- choose a c from xs using elements, with collect
prop_join_split_collect' :: String -> Property
prop_join_split_collect' xs = collect (length xs) $ prop_join_split' xs

-- add a condition that xs is not empty, choose a c from xs using elements
prop_join_split'' :: String -> Property
prop_join_split'' xs = (not $ null xs) ==> prop_join_split' xs

-- add a condition that xs is not empty, choose a c from xs using elements, with collect
prop_join_split_collect'' :: String -> Property
prop_join_split_collect'' xs = collect (length xs) $ prop_join_split'' xs

main :: IO ()
main = do
    let args = stdArgs {maxSuccess = 100}

    r1 <- quickCheckWithResult args prop_join_split
    r2 <- quickCheckWithResult args prop_join_split_collect

    r3 <- quickCheckWithResult args prop_join_split'
    -- Use verboseCheckWithResult instead of quickCheckWithResult to see
    -- exceptions caused by "elements" being used against an empty string.
    -- Exception thrown by generator: 'QuickCheck.elements used with empty list'
    --r3 <- verboseCheckWithResult args prop_join_split'
    r4 <- quickCheckWithResult args prop_join_split_collect'

    let genNonEmptyString = suchThat (arbitrary :: Gen String) (\xs -> not $ null xs)
    r5 <- quickCheckWithResult args $ forAll genNonEmptyString prop_join_split'
    r6 <- quickCheckWithResult args $ forAll genNonEmptyString prop_join_split_collect'

    r7 <- quickCheckWithResult args prop_join_split''
    r8 <- quickCheckWithResult args prop_join_split_collect''

    if all isSuccess [r1, r2, r3, r4, r5, r6, r7, r8]
        then return ()
        else exitFailure
