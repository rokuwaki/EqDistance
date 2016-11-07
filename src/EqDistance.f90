program EqDistance
  use geodesic
  use, intrinsic:: iso_fortran_env, only: ERROR_UNIT, INPUT_UNIT, OUTPUT_UNIT
  
  implicit none
  integer                   :: i, n, j, ios
  integer, parameter        :: omask=0
  real, parameter           :: df = 1.6, b = 1.0, q = 0.5
  real(kind=8), allocatable :: lon(:), lat(:), mag(:), eta(:,:), nnd(:), time(:)
  real(kind=8), parameter   :: a = 6378137d0, f = 1/298.257223563d0
  real(kind=8)              :: azi1, azi2, dr, dummy1, dummy2, dummy3, dummy4, dummy5
  real(kind=8)              :: NDt, NDr, dt, sec

  n = 0
  do
     read(INPUT_UNIT, *, iostat=ios)
     if (ios == 0) then
        n = n + 1
     else
        exit
     end if
  end do
  rewind(INPUT_UNIT)

  allocate(lon(1:n), lat(1:n), time(1:n), mag(1:n), eta(1:n,1:n), nnd(1:n))
  do i = 1, n
     read(INPUT_UNIT, *) lon(i), lat(i), sec, mag(i)
     time(i) = sec / (60*60*24*365.24255)
  end do
  close(INPUT_UNIT)

  !$omp parallel do private(i, j, dr, NDr, dt, NDt), shared(eta)
  do j = 1, n
     do i = 1, n
        call invers(a, f, lat(j), lon(j), lat(i), lon(i), dr, azi1, azi2, omask,&
             dummy1, dummy2, dummy3, dummy4 , dummy5)
        dt = time(j) - time(i)
        dr = abs(dr/1000)
        NDt = dt * 10.0 ** ((-1.0) * q * b * mag(i))
        NDr = (dr ** df) * 10.0 ** ((q-1.0) * b * mag(i))
        if (dt > 0) then
           eta(i,j) = NDt * NDr
        else
           eta(i,j) = 1e10
        end if
     end do
  end do
  
  do j = 1, n
     nnd(j) = minval(eta(1:n,j))
     if (nnd(j) < 1e10) then
        write(OUTPUT_UNIT, *) log10(nnd(j))
     end if
  end do
  
end program EqDistance
