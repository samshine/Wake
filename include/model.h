#pragma once

#include <glm/glm.hpp>
#include <vector>

#include "mesh.h"
#include "material.h"
#include "engineptr.h"

namespace wake
{
    struct ModelComponent
    {
        static ModelComponent Invalid;

        ModelComponent()
        {
            mesh = nullptr;
            material = nullptr;
        }

        MeshPtr mesh;
        MaterialPtr material;
    };

    class Model
    {
    public:
        Model();

        Model(const std::vector<ModelComponent> components);

        Model(const Model& other);

        ~Model();

        Model& operator=(const Model& other);

        void setComponents(const std::vector<ModelComponent> components);

        const std::vector<ModelComponent>& getComponents() const;

        size_t getComponentCount() const;

        const ModelComponent& getComponent(size_t index) const;

        void setComponent(size_t index, const ModelComponent& component);

        void setMesh(size_t index, MeshPtr mesh);

        void setMaterial(size_t index, MaterialPtr material);

        void removeComponent(size_t index);

        void addComponent(const ModelComponent& component);

        void draw();

    private:
        std::vector<ModelComponent> components;
    };

    typedef SharedPtr<Model> ModelPtr;
}