function [CMQmat,CMQ]=V2_MAT(bcell,smcell,interval,cellnum,cellnumjy,smcellnum,widght,tp1,tp2,MC,t,D,h,OSS)
for i=1:tp2-1
    gttao=[(i-1)*tp1+1:i*tp1]';
    C_SE=Z_K(gttao,bcell,cellnum);
    [~,ginterval]=G(C_SE,interval,widght);
    cdnt=smG(ginterval,smcell,widght,smcellnum);
    cdnt=repelem(cdnt,MC,1);
    image_t=V2_mappingtest(cdnt,t,D,h,OSS);
    fttao=F(image_t,bcell,interval,widght,cellnumjy);
    temp1=tp1*smcellnum*MC;
    mid1=repelem(gttao,smcellnum*MC);
    unq=zeros(temp1,2);
    unq(:,1)=mid1;
    unq(:,2)=fttao;
    eval(['[xishu_',num2str(i),',~,midt_',num2str(i),']=unique(unq,''rows'');']);
    eval(['[lg(i),~]=size(xishu_',num2str(i),');']);
    eval(['midt',num2str(i),'=histc(midt_',num2str(i),',[1:lg(',num2str(i),')]'')/(smcellnum*MC);']);
end
gttao=[(tp2-1)*tp1+1:cellnum]';
C_SE=Z_K(gttao,bcell,cellnum);
[~,ginterval]=G(C_SE,interval,widght);
cdnt=smG(ginterval,smcell,widght,smcellnum);
cdnt=repelem(cdnt,MC,1);
image_t=V2_mappingtest(cdnt,t,D,h,OSS);
fttao=F(image_t,bcell,interval,widght,cellnumjy);
mid1=repelem(gttao,smcellnum*MC);
temp1=length(gttao)*smcellnum*MC;
unq=zeros(temp1,2);
unq(:,1)=mid1;
unq(:,2)=fttao;
eval(['[xishu_',num2str(tp2),',~,midt_',num2str(tp2),']=unique(unq,''rows'');']);
eval(['[lg(tp2),~]=size(xishu_',num2str(tp2),');']);
eval(['midt',num2str(tp2),'=histc(midt_',num2str(tp2),',[1:lg(',num2str(tp2),')]'')/(smcellnum*MC);']);

l_g=sum(lg);
xishu1=zeros(l_g+1,3);
xishu2=zeros(l_g+1,3);
lg1=0;
for i=1:tp2
    eval(['xishu1(lg1+1:lg1+lg(i),1:2)=xishu_',num2str(i),';']);
    eval(['xishu1(lg1+1:lg1+lg(i),3)=midt',num2str(i),';']);
    lg1=lg1+lg(i);
end
xishu1(end,:)=[cellnumjy,cellnumjy,1];
xishu2(:,1:2)=xishu1(:,1:2);
xishu2(:,3)=1;
CMQmat=sparse(xishu1(:,1),xishu1(:,2),xishu1(:,3));
CMQ=sparse(xishu2(:,1),xishu2(:,2),xishu2(:,3));
