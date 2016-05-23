local test = require('test')
local Matrix2x3 = Matrix2x3
local Vector3 = Vector3

test.suite('Matrix2x3 Library')

test.test('creation', function()
    local m = Matrix2x3.new()
    test.assert_equal(#m, 6)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 0)
    test.expect_equal(m:get(1, 3), 0)
    test.expect_equal(m:get(2, 1), 0)
    test.expect_equal(m:get(2, 2), 1)
    test.expect_equal(m:get(2, 3), 0)

    local m = Matrix2x3.new(1, 2, 3, 4, 5, 6)
    test.assert_equal(#m, 6)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(2, 1), 4)
    test.expect_equal(m:get(2, 2), 5)
    test.expect_equal(m:get(2, 3), 6)

    local m = Matrix2x3.new{1, 2, 3, 4, 5, 6}
    test.assert_equal(#m, 6)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(2, 1), 4)
    test.expect_equal(m:get(2, 2), 5)
    test.expect_equal(m:get(2, 3), 6)

    test.expect_error(Matrix2x3.new, 1, 2)
end)

test.test('size', function()
    local m = Matrix2x3.new()
    test.expect_equal(#m, 6)
    test.expect_equal(m:rows(), 2)
    test.expect_equal(m:columns(), 3)
end)

test.test('get row', function()
    local m = Matrix2x3.new(1, 2, 3, 4, 5, 6)
    test.assert_equal(m:get(1), Vector3.new(1, 2, 3))
    test.assert_equal(m:get(2), Vector3.new(4, 5, 6))
end)

test.test('equality', function()
    local a = Matrix2x3.new(3, 4, 5, 6, 7, 8)
    local b = Matrix2x3.new(5, 6, 7, 8, 9, 10)
    test.assert_not_equal(a, b)

    b = Matrix2x3.new(3, 4, 5, 6, 7, 8)
    test.assert_equal(a, b)
end)

test.test('table as parameter', function()
    test.assert_equal(Matrix2x3.get({1, 2, 3, 4, 5, 6}, 2, 3), 6)
end)

test.test('table', function()
    local m = Matrix2x3.new{1, 2, 3, 4, 5, 6}
    local t = m:table()
    test.assert_equal(#t, 6)
    test.expect_equal(t[1], 1)
    test.expect_equal(t[2], 2)
    test.expect_equal(t[3], 3)
    test.expect_equal(t[4], 4)
    test.expect_equal(t[5], 5)
    test.expect_equal(t[6], 6)
end)

test.test('set', function()
    local m = Matrix2x3.new()
    m:set(1, 1, 1)
    m:set(1, 2, 2)
    m:set(1, 3, 3)
    m:set(2, 1, 4)
    m:set(2, 2, 5)
    m:set(2, 3, 6)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(2, 1), 4)
    test.expect_equal(m:get(2, 2), 5)
    test.expect_equal(m:get(2, 3), 6)
end)

test.test('setAll', function()
    local m = Matrix2x3.new()
    m:setAll(1, 2, 3, 4, 5, 6)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(2, 1), 4)
    test.expect_equal(m:get(2, 2), 5)
    test.expect_equal(m:get(2, 3), 6)
end)

test.test('transpose', function()
    local m = Matrix2x3.new(1, 2, 3, 4, 5, 6)
    m = m:transpose()
    test.assert_equal(m:rows(), 3)
    test.assert_equal(m:columns(), 2)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 4)
    test.expect_equal(m:get(2, 1), 2)
    test.expect_equal(m:get(2, 2), 5)
    test.expect_equal(m:get(3, 1), 3)
    test.expect_equal(m:get(3, 2), 6)
end)

test.test('apply', function()
    local a = Matrix2x3.new(1, 2, 3, 4, 5, 6)
    local b = a:apply(function(v, i, r, c) return v + i + r + c end)
    test.expect_equal(b:get(1, 1), 4)
    test.expect_equal(b:get(1, 2), 7)
    test.expect_equal(b:get(1, 3), 10)
    test.expect_equal(b:get(2, 1), 11)
    test.expect_equal(b:get(2, 2), 14)
    test.expect_equal(b:get(2, 3), 17)
end)

test.test('unary minus', function()
    local a = Matrix2x3.new(1, 2, 3, 4, 5, 6)
    a = -a
    test.expect_equal(a:get(1, 1), -1)
    test.expect_equal(a:get(1, 2), -2)
    test.expect_equal(a:get(1, 3), -3)
    test.expect_equal(a:get(2, 1), -4)
    test.expect_equal(a:get(2, 2), -5)
    test.expect_equal(a:get(2, 3), -6)
end)