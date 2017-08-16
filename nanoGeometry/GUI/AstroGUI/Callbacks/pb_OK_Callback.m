function pb_OK_Callback(~, ~)

    global invalidParams hf
    
    if ~isempty(invalidParams)
        msg = ['The following parameters are not valid:', invalidParams];
        warndlg(msg, 'Invalid parameters');
        return
    end
    
    % Close the figure as late as possible so that maximum number of errors could occur before it is closed
%     close(hf);
    
end
