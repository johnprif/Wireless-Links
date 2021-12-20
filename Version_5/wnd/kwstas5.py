from maya import cmds

def setImport():
    setImportPath = 'oldcar.fbx'
    cmds.file(setImportPath, i=True, mergeNamespacesOnClash=True, namespace=':');

setImport()
