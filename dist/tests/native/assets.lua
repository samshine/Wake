local test = require('test')
local assets = assets

test.suite('Assets Library')

test.test('loadModel', function()
    local model = assets.loadModel('assets/models/teapot.obj')
    test.assert_not_equal(model, nil)

    test.expect_equal(model:getComponentCount(), 2)
    local components = model:getComponents()
    for _,component in ipairs(components) do
        local mesh = component.mesh
        test.expect_equal(type(mesh), 'userdata')
        test.expect(#mesh:getVertices() > 0)
        test.expect(#mesh:getIndices() > 0)
    end


    model = assets.loadModel('assets/models/teapot.wmdl')
    test.assert_not_equal(model, nil)

    test.expect_equal(model:getComponentCount(), 2)
    local components = model:getComponents()
    for _,component in ipairs(components) do
        local mesh = component.mesh
        test.expect_equal(type(mesh), 'userdata')
        test.expect(#mesh:getVertices() > 0)
        test.expect(#mesh:getIndices() > 0)
    end
end)

test.test('loadTexture', function()
    local texture = assets.loadTexture('assets/textures/default.png')
    test.assert_not_equal(texture, null)

    local w, h = texture:getSize()
    test.expect_equal(w, 128)
    test.expect_equal(h, 128)
    test.expect_equal(texture:getComponentsPerPixel(), 4)
end)