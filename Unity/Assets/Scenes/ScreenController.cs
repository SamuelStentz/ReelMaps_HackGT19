using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class ScreenController : MonoBehaviour
{
    public static ScreenController instance;
    public int sceneNumber = 0;
    // Start is called before the first frame update
    void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        } else
        {
            Destroy(gameObject);
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.touchCount == 3)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                if (sceneNumber == 0)
                {
                    SceneManager.LoadScene("VRWorld1");
                }
                else if (sceneNumber == 1)
                {
                    SceneManager.LoadScene("VRWorld2");
                } else if (sceneNumber == 2)
                {
                    SceneManager.LoadScene("VRWorld3");
                } else if (sceneNumber == 3)
                {
                    SceneManager.LoadScene("SampleScene");
                }

                sceneNumber = (sceneNumber + 1) % 4;
            }
        }
    }
}
