function desc = DescToHtmlString(desc,   wrapIntoHtmlTags)
%% For the parameter description, convert cell array to HTML string with <br> line separator,
%  find and style all references to parameters exposed with GUI (they are preceded by percent),
%  wrap the resulting string into <html> and </html> tags (if the optional argument is ommitted or equals true)
    
    if nargin == 1
        wrapIntoHtmlTags = true;
    end
    
    if iscell(desc)
        desc = strjoin(desc, '<br>');
    else
        assert(ischar(desc))
    end
    
    %{
    Example of the regexprep call effect:
        %customVars   ->   <b><font color="blue">customVars</font></b>
    %}
    desc = regexprep(desc, '%\w+', '<b><font color="blue">${$0(2 : end)}</font></b>');
    
    if wrapIntoHtmlTags
        desc = sprintf('<html>%s</html>', desc);
    end
    
end
