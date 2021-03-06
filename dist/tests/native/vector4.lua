local test = require('test')
local Vector4 = Vector4

test.suite('Vector4 Library')

test.test('creation', function()
    local v = Vector4.new()
    test.assert_equal(#v, 4)
    test.expect_equal(v:get(1), 0)
    test.expect_equal(v:get(2), 0)
    test.expect_equal(v:get(3), 0)
    test.expect_equal(v:get(4), 0)

    v = Vector4.new(1, 2, 3, 4)
    test.assert_equal(#v, 4)
    test.expect_equal(v:get(1), 1)
    test.expect_equal(v:get(2), 2)
    test.expect_equal(v:get(3), 3)
    test.expect_equal(v:get(4), 4)

    v = Vector4.new{1, 2, 3, 4}
    test.assert_equal(#v, 4)
    test.expect_equal(v:get(1), 1)
    test.expect_equal(v:get(2), 2)
    test.expect_equal(v:get(3), 3)
    test.expect_equal(v:get(4), 4)

    test.expect_error(Vector4.new, 1, 2, 3, 4, 5, 6)
end)

test.test('equality', function()
    local a = Vector4.new(3, 4, 5, 6)
    local b = Vector4.new(5, 6, 7, 8)
    test.assert_not_equal(a, b)

    b = Vector4.new(3, 4, 5, 6)
    test.assert_equal(a, b)
end)

test.test('table as parameter', function()
    test.assert_equal(Vector4.get({1, 2, 3, 4}, 4), 4)
end)

test.test('table', function()
    local v = Vector4.new{1, 2, 3, 4}
    local t = v:table()
    test.assert_equal(#t, 4)
    test.expect_equal(t[1], 1)
    test.expect_equal(t[2], 2)
    test.expect_equal(t[3], 3)
    test.expect_equal(t[4], 4)
end)

test.test('set', function()
    local v = Vector4.new()
    v:set(1, 1)
    v:set(2, 2)
    v:set(3, 3)
    v:set(4, 4)
    test.expect_equal(v:get(1), 1)
    test.expect_equal(v:get(2), 2)
    test.expect_equal(v:get(3), 3)
    test.expect_equal(v:get(4), 4)
end)

test.test('setAll', function()
    local v = Vector4.new()
    v:setAll(1, 2, 3, 4)
    test.expect_equal(v:get(1), 1)
    test.expect_equal(v:get(2), 2)
    test.expect_equal(v:get(3), 3)
    test.expect_equal(v:get(4), 4)
end)

test.test('dot', function()
    local a = Vector4.new(1, 1, 1, 1)
    local b = Vector4.new(2, 2, 2, 2)
    test.assert_equal(a:dot(b), 8)
end)

test.test('distance', function()
    local a = Vector4.new(1, 1, 1, 1)
    local b = Vector4.new(3, 1, 1, 1)
    test.assert_equal(a:distance(b), 2)
end)

test.test('length', function()
    local v = Vector4.new(3, 0, 0, 0)
    test.assert_equal(v:length(), 3)
end)

test.test('apply', function()
    local a = Vector4.new(1, 2, 3, 4)
    local b = a:apply(function(v, i) return v + i end)
    test.expect_equal(b:get(1), 2)
    test.expect_equal(b:get(2), 4)
    test.expect_equal(b:get(3), 6)
    test.expect_equal(b:get(4), 8)
end)

test.test('normalize', function()
    local a = Vector4.new(1, 2, 3, 4)
    local b = a:normalize()
    test.expect_num_equal(b:get(1), 1 / math.sqrt(30), 0.0000001)
    test.expect_num_equal(b:get(2), math.sqrt(2 / 15), 0.0000001)
    test.expect_num_equal(b:get(3), math.sqrt(3 / 10), 0.0000001)
    test.expect_num_equal(b:get(4), 2 * math.sqrt(2 / 15), 0.0000001)
end)

test.test('reflect', function()
    local a = Vector4.new(2, 3, 4, 5):normalize()
    local b = Vector4.new(1, 2, 3, 4):normalize()
    local result = a:reflect(b)
    test.expect_num_equal(result:get(1), -0.090721845626831, 0.0000001)
    test.expect_num_equal(result:get(2), -0.31752645969391, 0.0000001)
    test.expect_num_equal(result:get(3), -0.54433107376099, 0.0000001)
    test.expect_num_equal(result:get(4), -0.77113568782806, 0.0000001)
end)

test.test('refract', function()
    local a = Vector4.new(2, 3, 4, 5):normalize()
    local b = Vector4.new(1, 2, 3, 4):normalize()
    local result = a:refract(b, 0.75)
    test.expect_num_equal(result:get(1), -0.11389777064323, 0.0000001)
    test.expect_num_equal(result:get(2), -0.32985761761665, 0.0000001)
    test.expect_num_equal(result:get(3), -0.5458174943924, 0.0000001)
    test.expect_num_equal(result:get(4), -0.76177728176117, 0.0000001)
end)

test.test('table length', function()
    local a = Vector4.new(1, 2, 3, 4)
    test.expect_equal(#a, 4)
end)

test.test('unary minus', function()
    local a = Vector4.new(1, 2, 3, 4)
    a = -a
    test.expect_equal(a:get(1), -1)
    test.expect_equal(a:get(2), -2)
    test.expect_equal(a:get(3), -3)
    test.expect_equal(a:get(4), -4)
end)