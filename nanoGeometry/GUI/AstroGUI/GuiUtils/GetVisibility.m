function vis = GetVisibility(h)
    vis = get(h, 'Visible');
    vis = strcmp(vis, 'on');
end
