import StringSplitting

examples = [
        ('@',"pbv@dcc.fc.up.pt"),
        ('/',"/usr/include")
    ]

test (c,xs) = unwords ["split", show c, show xs, "=", show ys]
    where ys = split c xs

main :: IO ()
main = mapM_ (putStrLn.test) examples
