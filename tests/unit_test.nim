
import unittest

import adventOfCode2019_11
import adventOfCode2019_11/consts


suite "unit-test suite":
    test "getMessage":
        assert(cHelloWorld == getMessage())
