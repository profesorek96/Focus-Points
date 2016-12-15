local LrSystemInfo = import 'LrSystemInfo'
local LrFunctionContext = import 'LrFunctionContext'
local LrApplication = import 'LrApplication'
local LrDialogs = import 'LrDialogs'
local LrView = import 'LrView'
local LrColor = import 'LrColor'
local LrTasks = import 'LrTasks'
local LrFileUtils = import 'LrFileUtils'
local LrPathUtils = import 'LrPathUtils'

require "UiDialog"
require "Utils"
require "PointsRendererFactory"

local function showDialog()
  LrFunctionContext.callWithContext("showDialog", function(context)
      
      local catalog = LrApplication.activeCatalog()
      local targetPhoto = catalog:getTargetPhoto()
      
      LrTasks.startAsyncTask(function(context)
          local developSettings = targetPhoto:getDevelopSettings()
          local metaData = readMetaData(targetPhoto)
          
          local rendererTable = PointsRendererFactory.createRenderer("Nikon")
          local overlay = rendererTable.createView(targetPhoto, metaData, developSettings)
          UiDialog.createDialog(targetPhoto, overlay)
          
          -- display the contents
          LrDialogs.presentModalDialog {
            title = "My Picture Viewer Dialog",
            cancelVerb = "< exclude >",
            actionVerb = "OK",
            contents = UiDialog.display
          }
      end
      )
    end
  )
  
end

showDialog()


