function p = predict2(wordData, goodBag, badBag, dictionary)
	results = cell2mat(wordData(:,3));
	numberTotal = rows(results);
	numberGood = sum(results==1);
	probGood = numberGood/numberTotal;
	numberBad = numberTotal - numberGood;
	probBad = numberBad/numberTotal;
	totalDictionary = rows(dictionary);
	k=1;
	
	for i=1:numberTotal
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
	ids = cell2mat(wordData(:,1));
	data = [ids,p];
	csvwrite('guess2.csv',data);
	fprintf('Train Accuracy: %f\n', mean(double(p == results)) * 100);
end