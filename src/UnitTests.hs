import Test.HUnit
import StringSplitting
import System.Exit (exitFailure)
import Control.Monad (forM_)

testBasic = TestCase $ do
    forM_ examples assertSplit
    where
        examples = [
                ('@', "pbv@dcc.fc.up.pt", ["pbv", "dcc.fc.up.pt"]),
                ('/', "/usr/include", ["", "usr", "include"])
            ]
        assertSplit (c, xs, expected) = assertEqual message expected actual
            where
                actual = (split c xs)
                message = "split " ++ show c ++ " " ++ show xs

tests = TestList [
        TestLabel "testBasic" testBasic
    ]

main :: IO ()
main = do
    counts <- runTestTT tests
    if errors counts > 0 || failures counts > 0
        then exitFailure
        else return ()
