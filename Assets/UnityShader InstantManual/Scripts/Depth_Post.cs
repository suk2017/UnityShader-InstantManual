/*
 * 本代码演示 后处理获取深度值
 */
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace UnityShaderInstantManual
{
    [ExecuteInEditMode]
    public class Depth_Post : MonoBehaviour
    {

        /************** 公有变量 **************/
        public Material material;//用于后处理的材质

        /************** 私有变量 **************/
        private Camera m_camera;

        /************** 私有方法 **************/

        private void Awake()
        {
            m_camera = GetComponent<Camera>();
        }

        private void OnEnable()
        {
            m_camera.depthTextureMode |= DepthTextureMode.DepthNormals;
        }

        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            if (material)
            {
                Graphics.Blit(source, destination, material);
            }
            else
            {
                Graphics.Blit(source, destination);
            }
        }

        /************** 公有方法 **************/
    }

}