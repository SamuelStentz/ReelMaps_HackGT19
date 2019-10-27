using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;

public class Pause : MonoBehaviour
{
    bool isPlaying;
    VideoPlayer vp;
    // Start is called before the first frame update
    void Start()
    {
        vp = GameObject.Find("CubeLeft1").GetComponent(typeof(VideoPlayer)) as VideoPlayer;
        vp.Pause();
        isPlaying = false;

    }

    // Update is called once per frame
    void Update()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {

                Ray ray = Camera.main.ScreenPointToRay(touch.position);
                RaycastHit hit;
                if (Physics.Raycast(ray, out hit, 100))
                {
                    var selectedObject = hit.transform;
                    if (selectedObject.name == "CubeLeft1")
                    {
                        if (isPlaying)
                        {
                            vp.Pause();
                        } else
                        {
                            vp.Play();
                        }
                        isPlaying = !isPlaying;
                    }
                }
            }
        }

    }
}
