SUBROUTINE pt_upmesh(point,DAT,ndat,clost,dif)

IMPLICIT NONE
	integer ::ndat,i
	real :: point(3),clost(3),clostmp(3),dist(3),dif,dif_old,DAT(ndat,12), vbtmp(12)
 !real*8, target :: DAT(ndat,12)
 !real*8, pointer :: vbtmp(:)

 !allocate(vbtmp(12))
 clostmp(:) = (/9999,9999,9999/)
 dif_old=1e10
 
 do i = 1,ndat
   
    vbtmp(:) = DAT(i,1:12)
    
    call pt_tri(point,vbtmp,clostmp)
    dist(:) = (clostmp(:)-point(:))
    dif = dot_product(dist(:),dist(:))
   
    if (dif <= dif_old) then
      dif_old = dif
      clost = clostmp
      
   end if
      

 
 end do

END SUBROUTINE pt_upmesh
