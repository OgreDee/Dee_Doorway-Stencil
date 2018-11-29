using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class DoorWay : MonoBehaviour {
    [SerializeField]
    Color debugColor = Color.white;

    Transform _cacheTransform;
    Transform cacheTransform
    {
        get
        {
            return _cacheTransform = _cacheTransform ?? transform;
        }
    }

    // Update is called once per frame
    void LateUpdate () {
        CalculateVertexs();

        Shader.SetGlobalMatrix("planVertexs", matrix4X4);
    }


#if UNITY_EDITOR
    private void OnDrawGizmos()
    {
        Color color = Gizmos.color;
        Gizmos.color = debugColor;



        Vector3 vertex0 = matrix4X4.GetRow(0);
        Vector3 vertex1 = matrix4X4.GetRow(1);
        Vector3 vertex2 = matrix4X4.GetRow(2);
        Vector3 vertex3 = matrix4X4.GetRow(3);

        Gizmos.DrawLine(vertex0, vertex1);
        Gizmos.DrawLine(vertex1, vertex2);
        Gizmos.DrawLine(vertex2, vertex3);
        Gizmos.DrawLine(vertex3, vertex0);

        Gizmos.color = Color.gray;
        Gizmos.DrawLine(Camera.main.transform.position, vertex0);
        Gizmos.DrawLine(Camera.main.transform.position, vertex1);
        Gizmos.DrawLine(Camera.main.transform.position, vertex2);
        Gizmos.DrawLine(Camera.main.transform.position, vertex3);

        Gizmos.color = Color.red;
        Gizmos.DrawSphere(vertex0, 0.1f);
        Gizmos.color = Color.green;
        Gizmos.DrawSphere(vertex1, 0.1f);
        Gizmos.color = Color.blue;
        Gizmos.DrawSphere(vertex2, 0.1f);
        Gizmos.color = Color.gray;
        Gizmos.DrawSphere(vertex3, 0.1f);

        Gizmos.color = color;
    }
#endif

    static Vector3 s_vertex0 = new Vector3(-0.5f, -0.5f, 0);
    static Vector3 s_vertex1 = new Vector3(-0.5f, 0.5f, 0);
    static Vector3 s_vertex2 = new Vector3(0.5f, 0.5f, 0);
    static Vector3 s_vertex3 = new Vector3(0.5f, -0.5f, 0);
    Matrix4x4 matrix4X4 = new Matrix4x4();

    void CalculateVertexs()
    {
        Vector3 vertex0 = cacheTransform.TransformPoint(s_vertex0);
        Vector3 vertex1 = cacheTransform.TransformPoint(s_vertex1);
        Vector3 vertex2 = cacheTransform.TransformPoint(s_vertex2);
        Vector3 vertex3 = cacheTransform.TransformPoint(s_vertex3);

        matrix4X4.SetRow(0, vertex0);
        matrix4X4.SetRow(1, vertex1);
        matrix4X4.SetRow(2, vertex2);
        matrix4X4.SetRow(3, vertex3);
    }
}
