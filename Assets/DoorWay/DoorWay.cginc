uniform float4x4 planVertexs;

#define DOORWAY_CLIP(i) \
float3 planNormal = cross(normalize(planVertexs[1].xyz - planVertexs[0].xyz), normalize(planVertexs[2].xyz - planVertexs[0].xyz));\
float3 objDir = i.worldPos.xyz - planVertexs[0].xyz;\
half dd = dot(planNormal, objDir);\
clip(dd);