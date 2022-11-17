using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SkinnedMeshRenderer))]
public class ThresholdPositionSetter : MonoBehaviour
{
    public Transform ThresholdObject;
    private Material _material;

    // Start is called before the first frame update
    void Start()
    {
        _material = GetComponent<SkinnedMeshRenderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        _material.SetFloat("_ThresholdPositionY", ThresholdObject.transform.position.y);
    }
}
