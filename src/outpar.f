c      $Id$
      subroutine outpar(nits,irh,irm,rsec,ers,decsgn,idd,idm,dsec,eds)

      implicit real*8 (A-H,O-Z)
      character decsgn*1, fit1*3

      parameter (TWOPI=6.28318530717958648d0)

      include 'dim.h'     
      include 'acom.h'
      include 'bcom.h'
      include 'trnsfr.h'
      include 'clocks.h'
      include 'dp.h'
      include 'glitch.h'
      include 'eph.h'
      include 'tz.h'

      c1=360.d0/TWOPI
      c=360.*3600./TWOPI
      cc=1.d-9*c*365.25*8.64d7
      fit1='  1'

      write(71,'(''PSR              '',a)')psrname

      if(eclcoord)then
         if(nfit(6).gt.0)then
            write(71,1011)c1*pra,fit1,ferr(6)
         else
            write(71,1011)c1*pra
         endif
 1011    format('LAMBDA',f20.13,a,f20.8)
         
         if(nfit(5).gt.0)then
            write(71,1012)c1*pdec,fit1,ferr(5)
         else
            write(71,1012)c1*pdec
         endif
 1012    format('BETA',f22.13,a,f20.8)
         
         if(pmra.ne.0.)then
            if(nfit(8).gt.0)then
               write(71,1013)pmra,fit1,ferr(8)*cc
            else
               write(71,1013)pmra
            endif
         endif
 1013    format('PMLAMBDA',f18.4,a,f20.4)
         
        if(pmdec.ne.0.)then
           if(nfit(7).gt.0)then
              write(71,1014)pmdec,fit1,ferr(7)*cc
           else
              write(71,1014)pmdec
           endif
        endif
 1014   format('PMBETA',f20.4,a,f20.4)
        
      else
        irs=rsec
        rs=rsec-irs
        ids=dsec
        ds=dsec-ids
        if(nfit(6).gt.0)then
           write(71,1021)irh,irm,irs,rs,fit1,ers
        else
           write(71,1021)irh,irm,irs,rs
        endif
 1021   format('RA',i9.2,':',i2.2,':',i2.2,f9.8,a,f20.8)
        
        if(nfit(5).gt.0)then
           write(71,1022)decsgn,idd,idm,ids,ds,fit1,eds
        else
           write(71,1022)decsgn,idd,idm,ids,ds
        endif
 1022   format('DEC',6x,a,i2.2,':',i2.2,':',i2.2,f8.7,a,f20.7)
        
        if(pmra.ne.0.)then
           if(nfit(8).gt.0)then
              write(71,1023)pmra,fit1,ferr(8)*cc
           else
              write(71,1023)pmra
           endif
        endif
 1023   format('PMRA',f22.4,a,f20.4)
        
        if(pmdec.ne.0.)then
           if(nfit(7).gt.0)then
              write(71,1024)pmdec,fit1,ferr(7)*cc
           else
              write(71,1024)pmdec
           endif
        endif
 1024   format('PMDEC',f21.4,a,f20.4)
        
      endif

      if(pmrv.ne.0.)then
         if(nfit(36).gt.0)then
            write(71,1025)pmrv,fit1,10.*c*ferr(36)
         else
            write(71,1025)pmrv
         endif
      endif
 1025 format('PMRV',f22.4,a,f20.4)

      if(px.ne.0.)then
         if(nfit(17).gt.0)then
            write(71,1026)px,fit1,ferr(17)
         else
            write(71,1026)px
         endif
      endif
 1026 format('PX',f24.4,a,f20.4)

      if(posepoch.gt.0.)write(71,1027)posepoch
 1027 format('POSEPOCH',f18.4)

        
      if(nfit(2).gt.0)then
         write(71,1031)f0,fit1,ferr(2)*1.d-9
      else
         write(71,1031)f0
      endif
 1031 format('F0',f24.16,a,f20.16)

      if(nfit(3).gt.0)then
         write(71,1032)f1,fit1,ferr(3)*1.d-18
      else
         write(71,1032)f1
      endif
 1032 format('F1',1p,d24.12,a,d20.12)

      if(f2.ne.0.)then
         if(nfit(4).gt.0)then
            write(71,1033)f2,fit1,ferr(4)*1.d-27
         else
            write(71,1033)f2
         endif
      endif
 1033 format('F2',1p,d24.12,a,d20.12)

      if(f3.ne.0.)then
         if(nfit(51).gt.0)then
            write(71,1034)f3,fit1,ferr(51)*1.d-36
         else
            write(71,1034)f3
         endif
      endif
 1034 format('F3',1p,d24.12,a,d20.12)

      do i = 1, 9
         if (f4(i).ne.0)then
            if(nfit(51+i).gt.0)then
               write(71,1035)i+3,f4(i),fit1,ferr(51+i)*(1.d-9)**(i+4)
            else
               write(71,1035)i+3,f4(i)
            endif
         endif
      enddo
 1035 format('F',z1,1p,d24.12,a,d20.12)

      write(71,'(''PEPOCH'',f20.6)')pepoch
      if (usestart) then
        write(71,'(''START'',f21.3,a)')start,fit1
      else
        write(71,'(''START'',f21.3)')start
      endif
      if (usefinish) then
        write(71,'(''FINISH'',f20.3,a)')finish,fit1
      else
        write(71,'(''FINISH'',f20.3)')finish
      endif

      if(nfit(16).gt.0)then
         write(71,1050)dm,fit1,ferr(16)
      else
         write(71,1050)dm
      endif
 1050 format('DM',f24.6,a,f20.6)

      do i=1,9
         if(dmcof(i).ne.0)then
            if(nfit(40+i).gt.0)then
               write(71,1051)i,dmcof(i),fit1,ferr(40+i)
            else
               write(71,1051)i,dmcof(i)
            endif
         endif
      enddo
 1051 format('DM',z1,1p,d23.12,a,d20.12)

      if(ngl.gt.0)then
         do i=1,ngl
            ii=60+(i-1)*NGLP
            write(71,'(''GLEP_'',i1,f18.6)')i,glepoch(i)
            if(nfit(ii+1).gt.0)then
               write(71,1061)i,glph(i),fit1,ferr(ii+1)
            else
               write(71,1061)i,glph(i)
            endif
 1061       format('GLPH_',i1,f20.6,a,f20.6)
            if(nfit(ii+2).gt.0)then
               write(71,1062)i,glf0(i),fit1,ferr(ii+2)*1.d-9
            else
               write(71,1062)i,glf0(i)
            endif
 1062       format('GLF0_',i1,1p,d20.8,a,d20.8)
            if(nfit(ii+3).gt.0)then
               write(71,1063)i,glf1(i),fit1,ferr(ii+3)*1.d-18
            else
               write(71,1063)i,glf1(i)
            endif
 1063       format('GLF1_',i1,1p,d20.8,a,d20.8)
            if(nfit(ii+4).gt.0)then
               write(71,1064)i,glf0d(i),fit1,ferr(ii+4)*1.d-9
            else
               write(71,1064)i,glf0d(i)
            endif
 1064       format('GLF0D_',i1,1p,d19.8,a,d20.8)
            if(nfit(ii+5).gt.0)then
               write(71,1065)i,gltd(i),fit1,ferr(ii+5)/86400.d0
            else
               write(71,1065)i,gltd(i)
            endif
 1065       format('GLTD_',i1,f20.4,a,f20.4)
         enddo
      endif

      write(71,'(''EPHEM'',13x,a)')ephfile(nephem)(1:5)
      write(71,'(''CLK'',15x,a)')clklbl(nclk)
      write(71,'(''TZRMJD '',f21.13)')tzrmjd
      write(71,'(''TZRFRQ '',f19.3)')tzrfrq
      write(71,'(''TZRSITE '',17x,a)')tzrsite
      if(nprnt.gt.0)write(71,'(''NPRNT'',i21)')nprnt
      if(nits.gt.0)write(71,'(''NITS'',i22)')nits
      if(iboot.gt.0)write(71,'(''IBOOT'',i21)')iboot
      if(nddm.gt.0)write(71,'(''NDDM'',i22)')nddm

      return
      end

c=======================================================================

      subroutine outbinpar

      implicit real*8 (A-H,O-Z)

      parameter (TWOPI=6.28318530717958648d0)

      include 'dim.h'     
      include 'acom.h'
      include 'bcom.h'
      include 'trnsfr.h'
      include 'dp.h'
      include 'orbit.h'

      character fit1*3

      fit1='  1'

      write(71,'(''BINARY'',12x,a)')bmodel(nbin)

      if(nfit(9).gt.0)then
         write(71,1009)a1(1),fit1,ferr(9)
      else
         write(71,1009)a1(1)
      endif
 1009 format('A1',f24.9,a,f20.9)

      if(nbin.ne.9)then
         if(nfit(10).gt.0)then
            write(71,1010)e(1),fit1,ferr(10)
         else
            write(71,1010)e(1)
         endif
      endif
 1010 format('E',f25.10,a,f20.10)

      if(nbin.ne.9)then
         if(nfit(11).gt.0)then
            write(71,1011)t0(1),fit1,ferr(11)
         else
            write(71,1011)t0(1)
         endif
      endif
 1011 format('T0',f24.9,a,f20.9)

      if(nfit(12).gt.0)then
         write(71,1012)pb(1),fit1,ferr(12)
      else
         write(71,1012)pb(1)
      endif
 1012 format('PB',f24.12,a,f20.12)

      if(nbin.ne.9)then
         if(nfit(13).gt.0)then
            write(71,1013)omz(1),fit1,ferr(13)*57.295
         else
            write(71,1013)omz(1)
         endif
      endif
 1013 format('OM',f24.12,a,f20.12)

      if(nbin.eq.9)then
         if(nfit(11).gt.0)then
            write(71,2011)t0asc,fit1,ferr(11)
         else
            write(71,2011)t0asc
         endif
 2011    format('TASC',f21.9,a,f20.9)

         if(nfit(10).gt.0)then
            write(71,2010)eps1,fit1,ferr(10)
         else
            write(71,2010)eps1
         endif
 2010    format('EPS1',f22.10,a,f20.10)

         if(nfit(13).gt.0)then
            write(71,2013)eps2,fit1,ferr(13)
         else
            write(71,2013)eps2
         endif
 2013    format('EPS2',f22.10,a,f20.10)
      endif

      if(omdot.ne.0.)then
         if(nfit(14).gt.0)then
            write(71,1014)omdot,fit1,ferr(14)
         else
            write(71,1014)omdot
         endif
      endif
 1014 format('OMDOT',f21.7,a,f20.7)

      if(xomdot.ne.0.)then
         if(nfit(37).gt.0)then
            write(71,1037)xomdot,fit1,ferr(37)
         else
            write(71,1037)xomdot
         endif
      endif
 1037 format('XOMDOT',f20.7,a,f20.7)

      if(gamma.ne.0.)then
         if(nfit(15).gt.0)then
            write(71,1015)gamma,fit1,ferr(15)
         else
            write(71,1015)gamma
         endif
      endif
 1015 format('GAMMA',f21.7,a,f20.7)

      if(pbdot.ne.0.)then
         if(nfit(18).gt.0)then
            write(71,1018)pbdot*1.d12,fit1,ferr(18)*1.d6
         else
            write(71,1018)pbdot*1.d12
         endif
      endif
 1018 format('PBDOT',f21.7,a,f20.7)

      if(xpbdot.ne.0.)then
         if(nfit(38).gt.0)then
            write(71,1038)xpbdot*1.d12,fit1,ferr(38)*1.d6
         else
            write(71,1038)xpbdot*1.d12
         endif
      endif
 1038 format('XPBDOT',f20.7,a,f20.7)

      if(si.ne.0.)then
         if(nfit(20).gt.0)then
            write(71,1020)si,fit1,ferr(20)
         else
            write(71,1020)si
         endif
      endif
 1020 format('SINI',f22.6,a,f20.6)

      if(am.ne.0.)then
         if(nfit(21).gt.0)then
            write(71,1021)am,fit1,ferr(21)
         else
            write(71,1021)am
         endif
      endif
 1021 format('MTOT',f22.6,a,f20.6)

      if(am2.ne.0.)then
         if(nfit(22).gt.0)then
            write(71,1022)am2,fit1,ferr(22)
         else
            write(71,1022)am2
         endif
      endif
 1022 format('M2',f24.6,a,f20.6)

      if(dth.ne.0.)then
         if(nfit(23).gt.0)then
            write(71,1023)dth*1.d6,fit1,ferr(23)
         else
            write(71,1023)dth*1.d6
         endif
      endif
 1023 format('DTHETA',f20.6,a,f20.6)
      if(xdot.ne.0.)then
         if(nfit(24).gt.0)then
            write(71,1024)xdot*1.d12,fit1,ferr(24)*1.d12
         else
            write(71,1024)xdot*1.d12
         endif
      endif
 1024 format('XDOT',f22.6,a,f20.6)
      
      if(edot.ne.0.)then
         if(nfit(25).gt.0)then
            write(71,1025)edot*1.d12,fit1,ferr(25)*1.d12
         else
            write(71,1025)edot*1.d12
         endif
      endif
 1025 format('EDOT',f22.6,a,f20.6)

      if(nbin.eq.8)then
         if(om2dot.ne.0.)then
            if(nfit(39).gt.0)then
               write(71,1039)om2dot,fit1,ferr(39)
            else
               write(71,1039)om2dot
            endif
         endif
 1039    format('OM2DOT',10x,e10.4,a,10x,e10.4)
         
         if(x2dot.ne.0.)then
            if(nfit(40).gt.0)then
               write(71,1040)x2dot,fit1,ferr(40)
            else
               write(71,1040)x2dot
            endif
         endif   
 1040    format('X2DOT',11x,e10.4,a,10x,e10.4)
      endif

      if(nbin.eq.9)then
         if(eps1dot.ne.0.)then
            if(nfit(39).gt.0)then
               write(71,2039)eps1dot*1.d12,fit1,ferr(39)*1.d12
            else
               write(71,2039)eps1dot*1.d12
            endif
         endif   
 2039    format('EPS1DOT',f19.6,a,f20.6)

         if(eps2dot.ne.0.)then
            if(nfit(40).gt.0)then
               write(71,2040)eps2dot*1.d12,fit1,ferr(40)*1.d12
            else
               write(71,2040)eps2dot*1.d12
            endif
         endif   
 2040    format('EPS2DOT',f19.6,a,f20.6)
      endif

      if(afac.ne.0.)write (71,2200) 'AFAC  ',afac
      if(dr.ne.0.)  write (71,2200) 'DR    ',dr*1.d6
      if(a0.ne.0.)  write (71,2200) 'A0    ',a0*1.d6
      if(b0.ne.0.)  write (71,2200) 'B0    ',b0*1.d6
      if(bp.ne.0.)  write (71,2200) 'BP    ',bp
      if(bpp.ne.0.) write (71,2200) 'BPP   ',bpp
 2200 format(a6,f20.7)

      if(nplanets.gt.0)then
         do j=2,nplanets+1
            jj=16+j*5
            if(nfit(jj).gt.0)then
               write(71,3026)j,a1(j),fit1,ferr(jj)
            else
               write(71,3026)j,a1(j)
            endif
 3026       format('A1_',i1,f22.9,a,f20.9)
            if(nfit(jj+1).gt.0)then
               write(71,3027)j,e(j),fit1,ferr(jj+1)
            else
               write(71,3027)j,e(j)
            endif
 3027       format('E_',i1,f23.9,a,f20.9)
            if(nfit(jj+2).gt.0)then
               write(71,3028)j,t0(j),fit1,ferr(jj+2)
            else
               write(71,3028)j,t0(j)
            endif
 3028       format('T0_',i1,f22.9,a,f20.9)
            if(nfit(jj+3).gt.0)then
               write(71,3029)j,pb(j),fit1,ferr(jj+3)
            else
               write(71,3029)j,pb(j)
            endif
 3029       format('PB_',i1,f22.12,a,f20.12)
            if(nfit(jj+4).gt.0)then
               write(71,3030)j,omz(j),fit1,ferr(jj+4)*57.295
            else
               write(71,3030)j,omz(j)
            endif
 3030       format('OM_',i1,f22.12,a,f20.12)
         enddo
      endif

      return
      end

c=======================================================================

      subroutine outjumppar

      implicit real*8 (A-H,O-Z)

      parameter (TWOPI=6.28318530717958648d0)

      include 'dim.h'     
      include 'acom.h'
      include 'bcom.h'
      include 'trnsfr.h'
      include 'dp.h'
      include 'orbit.h'

      character fit1*3

      fit1='  1'

      do i = 1, nxoff
        write (71,1090) i,dct(i),fit1,ferr(60+NGLT*NGLP+i)/f0
 1090   format('JUMP_',i1,f20.8,a,f20.8)
      enddo

      return
      end