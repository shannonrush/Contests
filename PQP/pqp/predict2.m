function p = predict2(wordData, goodBag, badBag, dictionary)
	resultCell = wordData(:,3);
	numberTotal = rows(resultCell);
	resultMat = cell2mat(resultCell');
	numberGood = sum(resultMat=='1');
	probGood = numberGood/numberTotal;
	numberBad = numberTotal - numberGood;
	probBad = numberBad/numberTotal;
	totalDictionary = rows(dictionary);
	k=1;
	ids = [];
	results = [];
	for i=1:numberTotal
		id = str2num(cell2mat(wordData(i,1)));
		result = str2num(cell2mat(wordData(i,3)));
		ids(i,:) = id;
		results(i,:) = result;
		M = cell2mat(wordData(i,2));
		probMGood = 1;
		probMBad = 1;
		for w=1:rows(M)
			timesInGoodBag = sum(goodBag==M(w));
			goodNum = timesInGoodBag+k;
			goodDen = numberGood + k*totalDictionary;
			goodElement = goodNum/goodDen;
			probMGood = probMGood*goodElement;
			
			timesInBadBag = sum(badBag==M(w));
			badNum = timesInBadBag+k;
			badDen = numberBad + k*totalDictionary;
			badElement = badNum/badDen;
			probMBad = probMBad*badElement;
		end
		num = probMGood * probGood;
		den = probMGood * probGood + probMBad * probBad;
		probGoodM = num/den;
		if probGoodM >= 0.5
			p(i,:)=1;
		else
			p(i,:)=0;
		end
	end
	data = [ids,p];
	csvwrite('guess2_1.csv',data);
	fprintf('Train Accuracy: %f\n', mean(double(p == results)) * 100);
end