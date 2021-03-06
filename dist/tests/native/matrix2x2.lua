local test = require('test')
local Matrix2x2 = Matrix2x2
local Vector2 = Vector2

test.suite('Matrix2x2 Library')

test.test('creation', function()
    local m = Matrix2x2.new()
    test.assert_equal(#m, 4)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 0)
    test.expect_equal(m:get(2, 1), 0)
    test.expect_equal(m:get(2, 2), 1)

    local m = Matrix2x2.new(1, 2, 3, 4)
    test.assert_equal(#m, 4)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(2, 1), 3)
    test.expect_equal(m:get(2, 2), 4)

    local m = Matrix2x2.new{1, 2, 3, 4}
    test.assert_equal(#m, 4)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(2, 1), 3)
    test.expect_equal(m:get(2, 2), 4)

    test.expect_error(Matrix2x2.new, 1, 2)
end)

test.test('size', function()
    local m = Matrix2x2.new()
    test.expect_equal(#m, 4)
    test.expect_equal(m:rows(), 2)
    test.expect_equal(m:columns(), 2)
end)

test.test('get row', function()
    local m = Matrix2x2.new(1, 2, 3, 4)
    test.assert_equal(m:get(1), Vector2.new(1, 2))
    test.assert_equal(m:get(2), Vector2.new(3, 4))
end)

test.test('equality', function()
    local a = Matrix2x2.new(3, 4, 5, 6)
    local b = Matrix2x2.new(5, 6, 7, 8)
    test.assert_not_equal(a, b)

    b = Matrix2x2.new(3, 4, 5, 6)
    test.assert_equal(a, b)
end)

test.test('table as parameter', function()
    test.assert_equal(Matrix2x2.get({1, 2, 3, 4}, 2, 2), 4)
end)

test.test('table', function()
    local m = Matrix2x2.new{1, 2, 3, 4}
    local t = m:table()
    test.assert_equal(#t, 4)
    test.expect_equal(t[1], 1)
    test.expect_equal(t[2], 2)
    test.expect_equal(t[3], 3)
    test.expect_equal(t[4], 4)
end)

test.test('set', function()
    local m = Matrix2x2.new()
    m:set(1, 1, 1)
    m:set(1, 2, 2)
    m:set(2, 1, 3)
    m:set(2, 2, 4)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(2, 1), 3)
    test.expect_equal(m:get(2, 2), 4)
end)

test.test('setAll', function()
    local m = Matrix2x2.new()
    m:setAll(1, 2, 3, 4)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(2, 1), 3)
    test.expect_equal(m:get(2, 2), 4)
end)

test.test('transpose', function()
    local m = Matrix2x2.new(1, 2, 3, 4)
    m = m:transpose()
    test.assert_equal(m:rows(), 2)
    test.assert_equal(m:columns(), 2)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 3)
    test.expect_equal(m:get(2, 1), 2)
    test.expect_equal(m:get(2, 2), 4)
end)

test.test('apply', function()
    local a = Matrix2x2.new(1, 2, 3, 4)
    local b = a:apply(function(v, i, r, c) return v + i + r + c end)
    test.expect_equal(b:get(1, 1), 4)
    test.expect_equal(b:get(1, 2), 7)
    test.expect_equal(b:get(2, 1), 9)
    test.expect_equal(b:get(2, 2), 12)
end)

test.test('unary minus', function()
    local a = Matrix2x2.new(1, 2, 3, 4)
    a = -a
    test.expect_equal(a:get(1, 1), -1)
    test.expect_equal(a:get(1, 2), -2)
    test.expect_equal(a:get(2, 1), -3)
    test.expect_equal(a:get(2, 2), -4)
end)

test.test('determinant', function()
    local m = Matrix2x2.new(1, 2, 3, 4)
    test.expect_equal(m:determinant(), -2)
end)

test.test('inverse', function()
    local m = Matrix2x2.new(1, 2, 3, 4)
    test.expect_equal(m:inverse(), Matrix2x2.new(-2, 1, 1.5, -0.5))
end)