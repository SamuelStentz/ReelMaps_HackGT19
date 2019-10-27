using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Video;

public class NewBehaviourScript : MonoBehaviour
{
    bool insideKlausPlaying;
    bool outsideKlausPlaying;

    VideoPlayer vpInside;
    VideoPlayer vpOutside;
    // Start is called before the first frame update
    void Start()
    {
        
        vpInside = GameObject.Find("Cube").GetComponent(typeof(VideoPlayer)) as VideoPlayer;
        vpOutside = GameObject.Find("CubeLeft").GetComponent(typeof(VideoPlayer)) as VideoPlayer;

        vpInside.Pause();
        vpOutside.Pause();

        insideKlausPlaying = false;
        outsideKlausPlaying = false;
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
                    if (selectedObject.name == "Cube")
                    {
                        hitInsideKlaus();
                    } else if (selectedObject.name == "CubeLeft")
                    {
                        hitOutsideKlaus();
                    }
                }
            }
        }
    }

    private void hitOutsideKlaus()
    {
        if (outsideKlausPlaying)
        {
            vpOutside.Pause();

        } else
        {
            if (insideKlausPlaying)
            {
                vpInside.Pause();
                insideKlausPlaying = false;
            }
            vpOutside.Play();
        }
        outsideKlausPlaying = !outsideKlausPlaying;
    }

    private void hitInsideKlaus()
    {
        if (insideKlausPlaying)
        {
            vpInside.Pause();
        } else
        {
            if (outsideKlausPlaying)
            {
                vpOutside.Pause();
                outsideKlausPlaying = false;
            }

            vpInside.Play();
        }

        insideKlausPlaying = !insideKlausPlaying;
    }
}
