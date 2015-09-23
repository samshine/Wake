local test = require('test')
local class = require('class')
local type = type
local Matrix2x4 = Matrix2x4
local Vector4 = Vector4
local tostring = tostring

test.suite('Matrix2x4 Library')

test.test('creation', function()
    local m = Matrix2x4.new()
    test.assert_equal(#m, 8)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 0)
    test.expect_equal(m:get(1, 3), 0)
    test.expect_equal(m:get(1, 4), 0)
    test.expect_equal(m:get(2, 1), 0)
    test.expect_equal(m:get(2, 2), 1)
    test.expect_equal(m:get(2, 3), 0)
    test.expect_equal(m:get(2, 4), 0)

    local m = Matrix2x4.new(1, 2, 3, 4, 5, 6, 7, 8)
    test.assert_equal(#m, 8)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)

    local m = Matrix2x4.new{1, 2, 3, 4, 5, 6, 7, 8}
    test.assert_equal(#m, 8)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
end)

test.test('size', function()
    local m = Matrix2x4.new()
    test.expect_equal(#m, 8)
    test.expect_equal(m:rows(), 2)
    test.expect_equal(m:columns(), 4)
end)

test.test('get row', function()
    local m = Matrix2x4.new(1, 2, 3, 4, 5, 6, 7, 8)
    test.assert_equal(m:get(1), Vector4.new(1, 2, 3, 4))
    test.assert_equal(m:get(2), Vector4.new(5, 6, 7, 8))
end)

test.test('equality', function()
    local a = Matrix2x4.new(3, 4, 5, 6, 7, 8, 9, 10)
    local b = Matrix2x4.new(5, 6, 7, 8, 9, 10, 11, 12)
    test.assert_not_equal(a, b)

    b = Matrix2x4.new(3, 4, 5, 6, 7, 8, 9, 10)
    test.assert_equal(a, b)
end)

test.test('table as parameter', function()
    test.assert_equal(Matrix2x4.get({1, 2, 3, 4, 5, 6, 7, 8}, 2, 4), 8)
end)

test.test('table', function()
    local m = Matrix2x4.new{1, 2, 3, 4, 5, 6, 7, 8}
    local t = m:table()
    test.assert_equal(#t, 8)
    test.expect_equal(t[1], 1)
    test.expect_equal(t[2], 2)
    test.expect_equal(t[3], 3)
    test.expect_equal(t[4], 4)
    test.expect_equal(t[5], 5)
    test.expect_equal(t[6], 6)
    test.expect_equal(t[7], 7)
    test.expect_equal(t[8], 8)
end)

test.test('set', function()
    local m = Matrix2x4.new()
    m:set(1, 1, 1)
    m:set(1, 2, 2)
    m:set(1, 3, 3)
    m:set(1, 4, 4)
    m:set(2, 1, 5)
    m:set(2, 2, 6)
    m:set(2, 3, 7)
    m:set(2, 4, 8)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
end)

test.test('setAll', function()
    local m = Matrix2x4.new()
    m:setAll(1, 2, 3, 4, 5, 6, 7, 8)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
end)

test.test('transpose', function()
    local m = Matrix2x4.new(1, 2, 3, 4, 5, 6, 7, 8)
    m = m:transpose()
    test.assert_equal(m:rows(), 4)
    test.assert_equal(m:columns(), 2)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 5)
    test.expect_equal(m:get(2, 1), 2)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(3, 1), 3)
    test.expect_equal(m:get(3, 2), 7)
    test.expect_equal(m:get(4, 1), 4)
    test.expect_equal(m:get(4, 2), 8)
end)

test.test('apply', function()
    local a = Matrix2x4.new(1, 2, 3, 4, 5, 6, 7, 8)
    local b = a:apply(function(v, i, r, c) return v + i + r + c end)
    test.expect_equal(b:get(1, 1), 4)
    test.expect_equal(b:get(1, 2), 7)
    test.expect_equal(b:get(1, 3), 10)
    test.expect_equal(b:get(1, 4), 13)
    test.expect_equal(b:get(2, 1), 13)
    test.expect_equal(b:get(2, 2), 16)
    test.expect_equal(b:get(2, 3), 19)
    test.expect_equal(b:get(2, 4), 22)
end)

test.test('unary minus', function()
    local a = Matrix2x4.new(1, 2, 3, 4, 5, 6, 7, 8)
    a = -a
    test.expect_equal(a:get(1, 1), -1)
    test.expect_equal(a:get(1, 2), -2)
    test.expect_equal(a:get(1, 3), -3)
    test.expect_equal(a:get(1, 4), -4)
    test.expect_equal(a:get(2, 1), -5)
    test.expect_equal(a:get(2, 2), -6)
    test.expect_equal(a:get(2, 3), -7)
    test.expect_equal(a:get(2, 4), -8)
end)