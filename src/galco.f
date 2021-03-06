c      $Id$
      SUBROUTINE GALCO (ARA,ADC,Q,PHI,GALANG)

C  CONVERTS POSITION ANGLE PHI FROM CELESTIAL COORDS TO GALACTIC COORDS.

      IMPLICIT REAL*8 (A-H,O-Z)

      HPI=3.1415926/2.
      RG=(12.+49./60.)*HPI/6.
      DG=HPI*(1.-(27.+24./60.)/90.)
      SQ=DSIN(DG)*DSIN(RG-ARA)
      CQ=DCOS(DG)*DSIN(HPI-ADC)-DSIN(DG)*DCOS(HPI-ADC)*DCOS(RG-ARA)
      IF (DABS(CQ).GT.1.E-06) GO TO 10
      Q=HPI
      IF (SQ.LT.0) Q=3.*HPI
      GO TO 20
10    Q=DATAN2(SQ,CQ)
20    Q=Q*90./HPI
      TPI=360.
      GALANG=DMOD(PHI-Q,TPI)
      IF (GALANG.LT.0.) GALANG=GALANG+TPI
      RETURN
      END
