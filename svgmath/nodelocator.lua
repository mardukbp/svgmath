-- Node locator for MathML parser.
local sys = require('sys')

NodeLocator = PYLUA.class() {
  -- Node locator for MathML parser.
  --     
  --     Stores data from a SAX locator object; 
  --     provides a method to format error messages from the parser.

  __init__ = function(self, locator)
    if locator then
      self.line = locator.getLineNumber()
      self.column = locator.getColumnNumber()
      self.filename = locator.getSystemId()
    else
      self.line = nil
      self.column = nil
      self.filename = nil
    end
  end
  ;

  message = function(self, msg, label)
    coordinate = ''
    separator = ''
    if PYLUA.op_is_not(self.filename, nil) then
      coordinate = coordinate+PYLUA.mod('file %s', self.filename)
      separator = ', '
    end
    if PYLUA.op_is_not(self.line, nil) then
      coordinate = coordinate+separator+PYLUA.mod('line %d', self.line)
      separator = ', '
    end
    if PYLUA.op_is_not(self.column, nil) then
      coordinate = coordinate+separator+PYLUA.mod('column %d', self.column)
    end
    if label then
      sys.stderr.write(PYLUA.mod('[%s] ', label))
    end
    if coordinate then
      sys.stderr.write(coordinate+': ')
    end
    if msg then
      sys.stderr.write(msg)
    end
    sys.stderr.write('\n')
  end
  ;
}

