% % Load an image.
% I = imread('cumle.jpg');
% 
% % Perform OCR.
% results = ocr(I);
% 
% % Display one of the recognized words.
% word = results.Words{3}
% % Location of the word in I
% wordBBox = results.WordBoundingBoxes(2,:)
% % Show the location of the word in the original image.
% figure;
% Iname = insertObjectAnnotation(I,'rectangle',wordBBox,word);
% imshow(Iname);
% % Find characters with low confidence.
% lowConfidenceIdx = results.CharacterConfidences < 0.5;
% 
% % Get the bounding box locations of the low confidence characters.
% lowConfBBoxes = results.CharacterBoundingBoxes(lowConfidenceIdx, :);
% 
% % Get confidence values.
% lowConfVal = results.CharacterConfidences(lowConfidenceIdx);
% 
% % Annotate image with character confidences.
% str      = sprintf('confidence = %f', lowConfVal);
% Ilowconf = insertObjectAnnotation(I,'rectangle',lowConfBBoxes,str);
% 
% figure;
% imshow(Ilowconf);
 businessCard   = imread('cumle.jpg');
     ocrResults     = ocr(businessCard,'Language','Turkish')
     
 recognizedText = ocrResults.Text;    
     figure;
     imshow(businessCard);
     
     
     
     
     
     
     
     
     
     