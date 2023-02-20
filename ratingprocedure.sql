CREATE DEFINER=`root`@`localhost` PROCEDURE `ratingprocedure`()
BEGIN

select report.supp_id,report.supp_name,report.average ,
case 
when average=5 then 'Excellent Service'
when average>4 then 'Good Service'
when average>2 then 'Average Service'
else 'poor service'
end as type_of_service from
(select final.supp_id,supplier.supp_name, final.average from
(select test2.supp_id,sum(test2.RAT_RATSTARS)/count(test2.RAT_RATSTARS) as average from
(select supplier_pricing.supp_id,test.ord_id,test.RAT_RATSTARS from supplier_pricing inner join
(select `order`.pricing_id,rating.ord_id,rating.RAT_RATSTARS from
`order` inner join rating on rating.`ord_id`= `order`.ord_id) as test
on test.pricing_id=supplier_pricing.pricing_id) as test2
group by supplier_pricing.supp_id) as final
inner join supplier where final.supp_id=supplier.supp_id) as report;
END