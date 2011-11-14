function nansMeaned = nanToMean(X)
	nansMeaned = X;
	for c=1:columns(nansMeaned)
		tmpcol = nansMeaned(:,c);
		nas = find(isnan(tmpcol));
		tmpcol(find(isnan(tmpcol))) = 0;
		mn = sum(tmpcol)/(rows(tmpcol)-rows(nas));
		for r = 1:rows(nas)
			nansMeaned(nas(r),c) = mn;
		end						
	end
end
