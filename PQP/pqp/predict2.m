function p = predict2(wordData, goodBag, badBag, dictionary)
	results = cell2mat(wordData(:,3));
	numberTotal = rows(results);
	numberGood = sum(results==1);
	probGood = numberGood/numberTotal;
	numberBad = numberTotal - numberGood;
	probBad = numberBad/numberTotal;
	totalDictionary = rows(dictionary);
	k=1;
	
	for i=1:rows(wordData)
		disp(i);
		M = cell2mat(wordData(i,2));
		probMGood = 1;
		probMBad = 1;
		for word=1:rows(M)
			timesInGoodBag = sum(goodBag==word);
			goodNum = timesInGoodBag+k;
			goodDen = numberGood + k*totalDictionary;
			goodElement = goodNum/goodDen;
			probMGood = probMGood*goodElement;
			
			timesInBadBag = sum(badBag==word);
			badNum = timesInBadBag+k;
			badDen = numberBad + k*totalDictionary;
			badElement = badNum/badDen;
			probMBad = probMBad*badElement;
		end
		num = probMGood * probGood;
		den = probMGood * probGood + probMBad * probBad;
		probGoodM = num/den;
		if probGoodM >= 0.5
			p(i)=1;
		else
			p(i)=0;
		end
	end
end