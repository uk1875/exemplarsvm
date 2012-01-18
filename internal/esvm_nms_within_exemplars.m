function top = esvm_nms_within_exemplars(boxes,os_thresh)
% Perform NMS within each exemplar, where the 6th field of each
% detection indicates the exemplar source id
% [boxes]: the input bounding boxes
% [os_thresh]: the overlap_threshold given to esvm_nms

if length(boxes) == 0
  top = boxes;
  return;
end
uex = unique(boxes(:,6));
top = cell(length(uex),1);
for i = 1:length(uex)
  top{i} = esvm_nms(boxes(boxes(:,6)==uex(i),:),os_thresh);
end
top = cat(1,top{:});

%Sort the detections within the new scores
[aa,bb] = sort(top(:,end),'descend');
top = top(bb,:);
