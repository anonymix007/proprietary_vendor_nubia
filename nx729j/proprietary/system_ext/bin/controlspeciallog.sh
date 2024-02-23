#!/system/bin/sh
if [ "x$(getprop persist.sys.ztelog.enable)" != "x1" ]; then
    exit 0
fi
local open=`getprop init.svc.openspeciallog`
if [ "$open" = "running" ] ; then
    dumpsys window -d enable all
    dumpsys activity -d enable all
    dumpsys activity log x on
    dumpsys cfreezer -d enable DEBUG_LEVEL_3
    dumpsys ZteScreenRefreshRate -log -e
    dumpsys scenedecision -log -e
    dumpsys Autolaunch -log -e
    dumpsys activity spkl debug! 4
    dumpsys mindsyncservice -log -e
fi
local close=`getprop init.svc.closespeciallog`
if [ "$close" = "running" ] ; then
    dumpsys window -d disable all
    dumpsys activity -d disable all
    dumpsys activity log x off
    dumpsys cfreezer -d disable DEBUG_LEVEL_3
    dumpsys ZteScreenRefreshRate -log -d
    dumpsys scenedecision -log -d
    dumpsys Autolaunch -log -d
    dumpsys activity spkl debug! 0
    dumpsys mindsyncservice -log -d
fi
