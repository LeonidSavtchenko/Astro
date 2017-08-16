function AddGeometryParams()

    global defaultGeometry
    
    AddPanel('Geometry');
    
    AddFileSelector('geometryFile', defaultGeometry, 'Neuron geometry', true, 'true', '.hoc', 'Select HOC file containing dendrite geometry');
 
end