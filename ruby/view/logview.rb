# Created by Satoshi Nakagawa.
# You can redistribute it and/or modify it under the Ruby's license or the GPL2.

class LogView < OSX::WebView
  include OSX
  attr_accessor :key_delegate, :resize_delegate
  
  def keyDown(e)
    @key_delegate.logView_keyDown(e) if @key_delegate
  end
  
  objc_alias_method 'superSetFrame:', 'setFrame:'    
  objc_method :setFrame, 'v@:{_NSRect={_NSPoint=ff}{_NSSize=ff}}'
  def setFrame(rect)
    @resize_delegate.logView_willResize(rect) if @resize_delegate
    superSetFrame(rect)
    @resize_delegate.logView_didResize(rect) if @resize_delegate
  end
end
