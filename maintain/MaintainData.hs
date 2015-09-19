




module MTData
    (
    ) where

      data OS = Windows | Linux | OSX | Final deriving (Show,Read)
      data Run = Start | Stop | Restart | Test deriving (Show)
      data MTData = MTData OS String {- the source of this -}  deriving (Show,Read)

      instance Read Run where
        readsPrec _ s =
          case s of
            "start" ->
            "stop" ->
            "restart" ->
            "test" ->
          where
            str = map toLower s
