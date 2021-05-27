# VIDEO ISSUES

## DRM/KMS driver

If you get this error when trying to play a game:

> frt: failed to get resources.

Run:

```
sudo ~/RetroPie-Setup/retropie_setup.sh
```

Go to:

- Configuration/tools
- godot-engine

Select **DRM/KMS driver**.

![DRM/KMS driver dialog](../example-images/drm-kms-driver-dialog.png)

Select the driver.

![DRM/KMS driver dialog](../example-images/select-drm-kms-driver-dialog.png)

If you want to to reverse that action, follow the same steps and select **None**.

## Video driver

If you get this error when trying to play a game:

> Your video card driver does not support any of the supported OpenGL versions. Please update your drivers or if you have a very old or integrated GPU upgrade it.

You can try to force the Godot "emulator" to use the GLES2 video driver.

Run:

```
sudo ~/RetroPie-Setup/retropie_setup.sh
```

Go to:

- Configuration/tools
- godot-engine

Select **Video driver**.

![Video driver dialog](../example-images/video-driver-dialog.png)

Select **GLES2**.

![Select video driver dialog](../example-images/select-video-driver-gles2.png)

If you want to to reverse that action, follow the same steps and select **GLES3**.