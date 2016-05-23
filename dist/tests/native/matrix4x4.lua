local test = require('test')
local Matrix4x4 = Matrix4x4
local Vector4 = Vector4

test.suite('Matrix4x4 Library')

test.test('creation', function()
    local m = Matrix4x4.new()
    test.assert_equal(#m, 16)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 0)
    test.expect_equal(m:get(1, 3), 0)
    test.expect_equal(m:get(1, 4), 0)
    test.expect_equal(m:get(2, 1), 0)
    test.expect_equal(m:get(2, 2), 1)
    test.expect_equal(m:get(2, 3), 0)
    test.expect_equal(m:get(2, 4), 0)
    test.expect_equal(m:get(3, 1), 0)
    test.expect_equal(m:get(3, 2), 0)
    test.expect_equal(m:get(3, 3), 1)
    test.expect_equal(m:get(3, 4), 0)
    test.expect_equal(m:get(4, 1), 0)
    test.expect_equal(m:get(4, 2), 0)
    test.expect_equal(m:get(4, 3), 0)
    test.expect_equal(m:get(4, 4), 1)

    local m = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    test.assert_equal(#m, 16)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
    test.expect_equal(m:get(3, 1), 9)
    test.expect_equal(m:get(3, 2), 10)
    test.expect_equal(m:get(3, 3), 11)
    test.expect_equal(m:get(3, 4), 12)
    test.expect_equal(m:get(4, 1), 13)
    test.expect_equal(m:get(4, 2), 14)
    test.expect_equal(m:get(4, 3), 15)
    test.expect_equal(m:get(4, 4), 16)

    local m = Matrix4x4.new{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}
    test.assert_equal(#m, 16)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
    test.expect_equal(m:get(3, 1), 9)
    test.expect_equal(m:get(3, 2), 10)
    test.expect_equal(m:get(3, 3), 11)
    test.expect_equal(m:get(3, 4), 12)
    test.expect_equal(m:get(4, 1), 13)
    test.expect_equal(m:get(4, 2), 14)
    test.expect_equal(m:get(4, 3), 15)
    test.expect_equal(m:get(4, 4), 16)

    test.expect_error(Matrix4x4.new, 1, 2)
end)

test.test('size', function()
    local m = Matrix4x4.new()
    test.expect_equal(#m, 16)
    test.expect_equal(m:rows(), 4)
    test.expect_equal(m:columns(), 4)
end)

test.test('get row', function()
    local m = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    test.assert_equal(m:get(1), Vector4.new(1, 2, 3, 4))
    test.assert_equal(m:get(2), Vector4.new(5, 6, 7, 8))
    test.assert_equal(m:get(3), Vector4.new(9, 10, 11, 12))
    test.assert_equal(m:get(4), Vector4.new(13, 14, 15, 16))
end)

test.test('equality', function()
    local a = Matrix4x4.new(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    local b = Matrix4x4.new(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    test.assert_not_equal(a, b)

    b = Matrix4x4.new(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18)
    test.assert_equal(a, b)
end)

test.test('table as parameter', function()
    test.assert_equal(Matrix4x4.get({1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}, 4, 4), 16)
end)

test.test('table', function()
    local m = Matrix4x4.new{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16}
    local t = m:table()
    test.assert_equal(#t, 16)
    test.expect_equal(t[1], 1)
    test.expect_equal(t[2], 2)
    test.expect_equal(t[3], 3)
    test.expect_equal(t[4], 4)
    test.expect_equal(t[5], 5)
    test.expect_equal(t[6], 6)
    test.expect_equal(t[7], 7)
    test.expect_equal(t[8], 8)
    test.expect_equal(t[9], 9)
    test.expect_equal(t[10], 10)
    test.expect_equal(t[11], 11)
    test.expect_equal(t[12], 12)
    test.expect_equal(t[13], 13)
    test.expect_equal(t[14], 14)
    test.expect_equal(t[15], 15)
    test.expect_equal(t[16], 16)
end)

test.test('set', function()
    local m = Matrix4x4.new()
    m:set(1, 1, 1)
    m:set(1, 2, 2)
    m:set(1, 3, 3)
    m:set(1, 4, 4)
    m:set(2, 1, 5)
    m:set(2, 2, 6)
    m:set(2, 3, 7)
    m:set(2, 4, 8)
    m:set(3, 1, 9)
    m:set(3, 2, 10)
    m:set(3, 3, 11)
    m:set(3, 4, 12)
    m:set(4, 1, 13)
    m:set(4, 2, 14)
    m:set(4, 3, 15)
    m:set(4, 4, 16)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
    test.expect_equal(m:get(3, 1), 9)
    test.expect_equal(m:get(3, 2), 10)
    test.expect_equal(m:get(3, 3), 11)
    test.expect_equal(m:get(3, 4), 12)
    test.expect_equal(m:get(4, 1), 13)
    test.expect_equal(m:get(4, 2), 14)
    test.expect_equal(m:get(4, 3), 15)
    test.expect_equal(m:get(4, 4), 16)
end)

test.test('setAll', function()
    local m = Matrix4x4.new()
    m:setAll(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 2)
    test.expect_equal(m:get(1, 3), 3)
    test.expect_equal(m:get(1, 4), 4)
    test.expect_equal(m:get(2, 1), 5)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 7)
    test.expect_equal(m:get(2, 4), 8)
    test.expect_equal(m:get(3, 1), 9)
    test.expect_equal(m:get(3, 2), 10)
    test.expect_equal(m:get(3, 3), 11)
    test.expect_equal(m:get(3, 4), 12)
    test.expect_equal(m:get(4, 1), 13)
    test.expect_equal(m:get(4, 2), 14)
    test.expect_equal(m:get(4, 3), 15)
    test.expect_equal(m:get(4, 4), 16)
end)

test.test('transpose', function()
    local m = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    m = m:transpose()
    test.assert_equal(m:rows(), 4)
    test.assert_equal(m:columns(), 4)
    test.expect_equal(m:get(1, 1), 1)
    test.expect_equal(m:get(1, 2), 5)
    test.expect_equal(m:get(1, 3), 9)
    test.expect_equal(m:get(1, 4), 13)
    test.expect_equal(m:get(2, 1), 2)
    test.expect_equal(m:get(2, 2), 6)
    test.expect_equal(m:get(2, 3), 10)
    test.expect_equal(m:get(2, 4), 14)
    test.expect_equal(m:get(3, 1), 3)
    test.expect_equal(m:get(3, 2), 7)
    test.expect_equal(m:get(3, 3), 11)
    test.expect_equal(m:get(3, 4), 15)
    test.expect_equal(m:get(4, 1), 4)
    test.expect_equal(m:get(4, 2), 8)
    test.expect_equal(m:get(4, 3), 12)
    test.expect_equal(m:get(4, 4), 16)
end)

test.test('apply', function()
    local a = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    local b = a:apply(function(v, i, r, c) return v + i + r + c end)
    test.expect_equal(b:get(1, 1), 4)
    test.expect_equal(b:get(1, 2), 7)
    test.expect_equal(b:get(1, 3), 10)
    test.expect_equal(b:get(1, 4), 13)
    test.expect_equal(b:get(2, 1), 13)
    test.expect_equal(b:get(2, 2), 16)
    test.expect_equal(b:get(2, 3), 19)
    test.expect_equal(b:get(2, 4), 22)
    test.expect_equal(b:get(3, 1), 22)
    test.expect_equal(b:get(3, 2), 25)
    test.expect_equal(b:get(3, 3), 28)
    test.expect_equal(b:get(3, 4), 31)
    test.expect_equal(b:get(4, 1), 31)
    test.expect_equal(b:get(4, 2), 34)
    test.expect_equal(b:get(4, 3), 37)
    test.expect_equal(b:get(4, 4), 40)
end)

test.test('unary minus', function()
    local a = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    a = -a
    test.expect_equal(a:get(1, 1), -1)
    test.expect_equal(a:get(1, 2), -2)
    test.expect_equal(a:get(1, 3), -3)
    test.expect_equal(a:get(1, 4), -4)
    test.expect_equal(a:get(2, 1), -5)
    test.expect_equal(a:get(2, 2), -6)
    test.expect_equal(a:get(2, 3), -7)
    test.expect_equal(a:get(2, 4), -8)
    test.expect_equal(a:get(3, 1), -9)
    test.expect_equal(a:get(3, 2), -10)
    test.expect_equal(a:get(3, 3), -11)
    test.expect_equal(a:get(3, 4), -12)
    test.expect_equal(a:get(4, 1), -13)
    test.expect_equal(a:get(4, 2), -14)
    test.expect_equal(a:get(4, 3), -15)
    test.expect_equal(a:get(4, 4), -16)
end)

test.test('determinant', function()
    local m = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    test.expect_equal(m:determinant(), 0)
end)

test.test('inverse', function()
    local m = Matrix4x4.new(4, 0, 0, 0, 0, 0, 2, 0, 0, 1, 2, 0, 1, 0, 0, 1)
    test.expect_equal(m:inverse(), Matrix4x4.new(0.25, 0, 0, 0, 0, -1, 1, 0, 0, 0.5, 0, 0, -0.25, 0, 0, 1))
end)

test.test('quat', function()
    local m = Matrix4x4.new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    local q = m:quat()
    test.expect_num_equal(q:get(1), -0.344124, 0.000001)
    test.expect_num_equal(q:get(2), 0.688247, 0.000001)
    test.expect_num_equal(q:get(3), -0.344124, 0.000001)
    test.expect_num_equal(q:get(4), 2.17945, 0.000001)
end)