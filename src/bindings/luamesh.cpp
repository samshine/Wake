#include "bindings/luamesh.h"
#include "bindings/luamatrix.h"
#include "moduleregistry.h"

#include <sstream>
#include <cstring>
#include <glm/gtx/string_cast.hpp>

namespace wake
{
    namespace binding
    {
        struct MeshContainer
        {
            MeshPtr mesh;
        };

        static int mesh_new(lua_State* L)
        {
            int argCount = lua_gettop(L);
            switch (argCount)
            {
                default:
                    luaL_error(L, "wrong number of arguments for Mesh.new");
                    return 0;

                case 0:
                    pushValue(L, MeshPtr(new Mesh()));
                    return 1;

                case 1:
                {
                    int type = lua_type(L, 1);
                    switch (type)
                    {
                        default:
                            luaL_error(L, "expected table or Mesh for argumnent #1 to Mesh.new");
                            break;

                        case LUA_TTABLE:
                        {
                            std::vector<Vertex> vertices;
                            lua_pushnil(L);
                            while (lua_next(L, 1) != 0)
                            {
                                luaL_checktype(L, -2, LUA_TNUMBER);
                                vertices.push_back(*luaW_checkvertex(L, -1));
                                lua_pop(L, 1);
                            }

                            pushValue(L, MeshPtr(new Mesh(vertices)));
                            return 1;
                        }

                        case LUA_TUSERDATA:
                        {
                            MeshPtr mesh = luaW_checkmesh(L, 1);
                            pushValue(L, MeshPtr(new Mesh(*mesh.get())));
                            return 1;
                        }
                    }

                    return 0;
                }

                case 2:
                {
                    luaL_checktype(L, 1, LUA_TTABLE);
                    luaL_checktype(L, 2, LUA_TTABLE);

                    std::vector<Vertex> vertices;
                    lua_pushnil(L);
                    while (lua_next(L, 1) != 0)
                    {
                        luaL_checktype(L, -2, LUA_TNUMBER);
                        vertices.push_back(*luaW_checkvertex(L, -1));
                        lua_pop(L, 1);
                    }

                    std::vector<GLuint> indices;
                    lua_pushnil(L);
                    while (lua_next(L, 2) != 0)
                    {
                        luaL_checktype(L, -2, LUA_TNUMBER);
                        indices.push_back((GLuint) luaL_checkinteger(L, -1));
                        lua_pop(L, 1);
                    }

                    pushValue(L, MeshPtr(new Mesh(vertices, indices)));
                    return 1;
                }
            }
        }

        static int mesh_get_vertices(lua_State* L)
        {
            MeshPtr mesh = luaW_checkmesh(L, 1);
            auto& vertices = mesh->getVertices();

            lua_newtable(L);
            for (size_t i = 0; i < vertices.size(); ++i)
            {
                lua_pushnumber(L, i + 1);
                pushValue(L, vertices[i]);
                lua_settable(L, -3);
            }

            return 1;
        }

        static int mesh_set_vertices(lua_State* L)
        {
            MeshPtr mesh = luaW_checkmesh(L, 1);
            luaL_checktype(L, 2, LUA_TTABLE);
            bool updateIndices = (lua_gettop(L) >= 3) ? (lua_toboolean(L, 3) == 1) : false;

            std::vector<Vertex> vertices;
            lua_pushnil(L);
            while (lua_next(L, 2) != 0)
            {
                luaL_checktype(L, -2, LUA_TNUMBER);
                vertices.push_back(*luaW_checkvertex(L, -1));
                lua_pop(L, 1);
            }

            mesh->setVertices(vertices, updateIndices);
            return 0;
        }

        static int mesh_get_indices(lua_State* L)
        {
            MeshPtr mesh = luaW_checkmesh(L, 1);
            auto& indices = mesh->getIndices();

            lua_newtable(L);
            for (size_t i = 0; i < indices.size(); ++i)
            {
                lua_pushnumber(L, i + 1);
                lua_pushnumber(L, (lua_Number) indices[i]);
                lua_settable(L, -3);
            }

            return 1;
        }

        static int mesh_set_indices(lua_State* L)
        {
            MeshPtr mesh = luaW_checkmesh(L, 1);
            luaL_checktype(L, 2, LUA_TTABLE);

            std::vector<GLuint> indices;
            lua_pushnil(L);
            while (lua_next(L, 2) != 0)
            {
                luaL_checktype(L, -2, LUA_TNUMBER);
                indices.push_back((GLuint) luaL_checkinteger(L, -1));
                lua_pop(L, 1);
            }

            mesh->setIndices(indices);
            return 0;
        }

        static int mesh_draw(lua_State* L)
        {
            MeshPtr mesh = luaW_checkmesh(L, 1);
            mesh->draw();
            return 0;
        }

        static int mesh_m_gc(lua_State* L)
        {
            void* dataPtr = luaL_checkudata(L, 1, W_MT_MESH);
            luaL_argcheck(L, dataPtr != nullptr, 1, "'Mesh' expected");
            MeshContainer* container = (MeshContainer*) dataPtr;
            container->mesh.reset();
            return 0;
        }

        static int mesh_m_tostring(lua_State* L)
        {
            MeshPtr mesh = luaW_checkmesh(L, 1);

            std::stringstream ss;
            ss << "Mesh[" << mesh->getVertices().size() << "," << mesh->getIndices().size() << "]";
            auto str = ss.str();
            lua_pushstring(L, str.data());
            return 1;
        }

        static const struct luaL_reg meshlib_f[] = {
                {"new",         mesh_new},
                {"getVertices", mesh_get_vertices},
                {"setVertices", mesh_set_vertices},
                {"getIndices",  mesh_get_indices},
                {"setIndices",  mesh_set_indices},
                {"draw",        mesh_draw},
                {NULL, NULL}
        };

        static const struct luaL_reg meshlib_m[] = {
                {"new",         mesh_new},
                {"getVertices", mesh_get_vertices},
                {"setVertices", mesh_set_vertices},
                {"getIndices",  mesh_get_indices},
                {"setIndices",  mesh_set_indices},
                {"draw",        mesh_draw},
                {"__gc",        mesh_m_gc},
                {"__tostring",  mesh_m_tostring},
                {NULL, NULL}
        };

        int luaopen_mesh(lua_State* L)
        {
            luaL_newmetatable(L, W_MT_MESH);

            lua_pushstring(L, "__index");
            lua_pushvalue(L, -2);
            lua_settable(L, -3);

            luaL_register(L, NULL, meshlib_m);

            luaL_register(L, "Mesh", meshlib_f);
            return 1;
        }

        W_REGISTER_MODULE(luaopen_mesh);

        struct VertexContainer
        {
            Vertex* vertex;
        };

        static int vertex_new(lua_State* L)
        {
            int argCount = lua_gettop(L);
            switch (argCount)
            {
                default:
                    luaL_error(L, "wrong number of arguments for Vertex.new");
                    return 0;

                case 0:
                    pushValue(L, Vertex());
                    return 1;

                case 1:
                    pushValue(L, Vertex(*luaW_checkvector3(L, 1)));
                    return 1;

                case 2:
                    pushValue(L, Vertex(*luaW_checkvector3(L, 1), *luaW_checkvector3(L, 2)));
                    return 1;

                case 3:
                    pushValue(L, Vertex(*luaW_checkvector3(L, 1), *luaW_checkvector3(L, 2), *luaW_checkvector2(L, 3)));
                    return 1;
            }
        }

        static int vertex_get_position(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            pushValue(L, vertex->position);
            return 1;
        }

        static int vertex_set_position(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            vertex->position = *luaW_checkvector3(L, 2);
            return 0;
        }

        static int vertex_get_normal(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            pushValue(L, vertex->normal);
            return 1;
        }

        static int vertex_set_normal(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            vertex->normal = *luaW_checkvector3(L, 2);
            return 0;
        }

        static int vertex_get_tex_coords(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            pushValue(L, vertex->texCoords);
            return 1;
        }

        static int vertex_set_tex_coords(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            vertex->texCoords = *luaW_checkvector2(L, 2);
            return 0;
        }

        static int vertex_m_gc(lua_State* L)
        {
            delete luaW_checkvertex(L, 1);
            return 0;
        }

        static int vertex_m_tostring(lua_State* L)
        {
            Vertex* vertex = luaW_checkvertex(L, 1);
            std::stringstream ss;
            ss  << "Vertex("
                << "{" << vertex->position[0] << "," << vertex->position[1] << "," << vertex->position[2] << "}"
                << "," << "{" << vertex->normal[0] << "," << vertex->normal[1] << "," << vertex->normal[2] << "}"
                << "," << "{" << vertex->texCoords[0] << "," << vertex->texCoords[1] << "})";
            auto str = ss.str();
            lua_pushstring(L, str.data());
            return 1;
        }

        static int vertex_m_eq(lua_State* L)
        {
            Vertex* a = luaW_checkvertex(L, 1);
            Vertex* b = luaW_checkvertex(L, 2);

            return a->position == b->position && a->normal == b->normal && a->texCoords == b->texCoords;
        }

        static const struct luaL_reg vertexlib_f[] = {
                {"new",          vertex_new},
                {"getPosition",  vertex_get_position},
                {"setPosition",  vertex_set_position},
                {"getNormal",    vertex_get_normal},
                {"setNormal",    vertex_set_normal},
                {"getTexCoords", vertex_get_tex_coords},
                {"setTexCoords", vertex_set_tex_coords},
                {NULL, NULL}
        };

        static const struct luaL_reg vertexlib_m[] = {
                {"new",          vertex_new},
                {"getPosition",  vertex_get_position},
                {"setPosition",  vertex_set_position},
                {"getNormal",    vertex_get_normal},
                {"setNormal",    vertex_set_normal},
                {"getTexCoords", vertex_get_tex_coords},
                {"setTexCoords", vertex_set_tex_coords},
                {"__gc",         vertex_m_gc},
                {"__tostring",   vertex_m_tostring},
                {"__eq",         vertex_m_eq},
                {NULL, NULL}
        };

        int luaopen_vertex(lua_State* L)
        {
            luaL_newmetatable(L, W_MT_VERTEX);

            lua_pushstring(L, "__index");
            lua_pushvalue(L, -2);
            lua_settable(L, -3);

            luaL_register(L, NULL, vertexlib_m);

            luaL_register(L, "Vertex", vertexlib_f);
            return 1;
        }

        W_REGISTER_MODULE(luaopen_vertex);
    }

    void pushValue(lua_State* L, MeshPtr value)
    {
        if (value.get() == nullptr)
        {
            lua_pushnil(L);
            return;
        }

        auto* container = (binding::MeshContainer*) lua_newuserdata(L, sizeof(binding::MeshContainer));
        memset(container, 0, sizeof(binding::MeshContainer));
        container->mesh = value;
        luaL_getmetatable(L, W_MT_MESH);
        lua_setmetatable(L, -2);
    }

    void pushValue(lua_State* L, const Vertex& value)
    {
        auto* container = (binding::VertexContainer*) lua_newuserdata(L, sizeof(binding::VertexContainer));
        container->vertex = new Vertex(value);
        luaL_getmetatable(L, W_MT_VERTEX);
        lua_setmetatable(L, -2);
    }

    MeshPtr luaW_checkmesh(lua_State* L, int narg)
    {
        void* dataPtr = luaL_checkudata(L, narg, W_MT_MESH);
        luaL_argcheck(L, dataPtr != nullptr, narg, "'Mesh' expected");
        binding::MeshContainer* container = (binding::MeshContainer*) dataPtr;
        return container->mesh;
    }

    Vertex* luaW_checkvertex(lua_State* L, int narg)
    {
        void* dataPtr = luaL_checkudata(L, narg, W_MT_VERTEX);
        luaL_argcheck(L, dataPtr != nullptr, narg, "'Vertex' expected");
        binding::VertexContainer* container = (binding::VertexContainer*) dataPtr;
        return container->vertex;
    }
}