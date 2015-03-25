From: NeilBrown <neilb@suse.de>
Subject: Re: performance changes on d4b4c2cd:  37.6% fsmark.files_per_sec,
 -15.9% fsmark.files_per_sec, and few more
Date: Wed, 25 Mar 2015 14:05:31 +1100
Message-ID: <20150325140531.489d5033@notabene.brown>
References: <20150318050319.GD30894@yliu-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/RdVwbF3DHd8sIl1MIDavNuQ"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150318050319.GD30894@yliu-dev.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuanahn Liu <yuanhan.liu@linux.intel.com>
Cc: "shli@kernel.org" <shli@kernel.org>, lkp@01.org, lkp@linux.intel.com, linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

--Sig_/RdVwbF3DHd8sIl1MIDavNuQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2015 13:03:19 +0800 Yuanahn Liu <yuanhan.liu@linux.intel.com>
wrote:

> Hi,
>=20
> FYI, we noticed performance changes on `fsmark.files_per_sec' by d4b4c2cd=
ffab86f5c7594c44635286a6d277d5c6:
>=20
>     > commit d4b4c2cdffab86f5c7594c44635286a6d277d5c6
>     > Author:     shli@kernel.org <shli@kernel.org>
>     > AuthorDate: Mon Dec 15 12:57:03 2014 +1100
>     > Commit:     NeilBrown <neilb@suse.de>
>     > CommitDate: Wed Mar 4 13:40:17 2015 +1100
>     >=20
>     >     RAID5: batch adjacent full stripe write

Thanks a lot for this one too!
Generally positive, with the only regressions on NoSync tests.  Maybe the
same cause?

Again,=20
>          7 =C2=B1  5%     +37.6%         10 =C2=B1  6%  fsmark.time.perce=
nt_of_cpu_this_job_got
and
>          9 =C2=B1  0%     -14.8%          7 =C2=B1  6%  fsmark.time.perce=
nt_of_cpu_this_job_got

are a bit confusing - really less than 10% of a CPU ??

Thanks,
NeilBrown


>=20
> c1dfe87e41d9c2926fe92f803f02c733ddbccf0b     d4b4c2cdffab86f5c7594c446352=
86a6d277d5c6
> ----------------------------------------     ----------------------------=
------------
> run time(m)     metric_value     =C2=B1stddev     run time(m)     metric_=
value     =C2=B1stddev     change   testbox/benchmark/sub-testcase
> --- ------  ----------------------------     --- ------  ----------------=
------------     -------- ------------------------------
> 4   15.3              33.525     =C2=B13.0%       6   11.1              4=
6.133     =C2=B15.0%          37.6% ivb44/fsmark/1x-1t-3HDD-RAID5-xfs-4M-12=
0G-NoSync
> 3   0.5              262.800     =C2=B11.5%       3   0.4              30=
7.367     =C2=B11.2%          17.0% ivb44/fsmark/1x-1t-4BRD_12G-RAID5-f2fs-=
4M-30G-NoSync
> 3   0.5              289.900     =C2=B10.3%       3   0.4              32=
3.367     =C2=B12.4%          11.5% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-f2fs=
-4M-30G-NoSync
> 3   0.5              325.667     =C2=B12.2%       3   0.5              35=
8.800     =C2=B11.8%          10.2% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-ext4=
-4M-30G-NoSync
> 3   0.6              216.100     =C2=B10.4%       3   0.6              23=
0.100     =C2=B10.4%           6.5% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-f2fs=
-4M-30G-fsyncBeforeClose
> 3   0.5              309.900     =C2=B10.3%       3   0.5              32=
8.500     =C2=B11.1%           6.0% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-xfs-=
4M-30G-NoSync
>=20
> 3   13.8              37.000     =C2=B10.2%       3   16.5              3=
1.100     =C2=B10.3%         -15.9% ivb44/fsmark/1x-1t-3HDD-RAID5-f2fs-4M-1=
20G-NoSync
>=20
> NOTE: here are some more info about those test parameters for you to
>       understand the testcase better:
>=20
>       1x : where 'x' means iterations or loop, corresponding to the 'L' o=
ption of fsmark
>       64t: where 't' means thread
>       4M : means the single file size, corresponding to the '-s' option o=
f fsmark
>       120G, 30G: means the total test size
>=20
>       4BRD_12G: BRD is the ramdisk, where '4' means 4 ramdisk, and where =
'12G' means
>                 the size of one ramdisk. So, it would be 48G in total. An=
d we made a
>                 raid on those ramdisk.
>=20
>=20
> And FYI, here I listed more detailed changes for the maximal postive and =
negtive changes.
>=20
>=20
> more detailed changes about ivb44/fsmark/1x-1t-3HDD-RAID5-xfs-4M-120G-NoS=
ync
> ---------
>=20
> c1dfe87e41d9c292  d4b4c2cdffab86f5c7594c4463 =20
> ----------------  -------------------------- =20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      33.53 =C2=B1  3%     +37.6%      46.13 =C2=B1  4%  fsmark.files_per_=
sec
>        916 =C2=B1  3%     -27.2%        667 =C2=B1  5%  fsmark.time.elaps=
ed_time.max
>        916 =C2=B1  3%     -27.2%        667 =C2=B1  5%  fsmark.time.elaps=
ed_time
>          7 =C2=B1  5%     +37.6%         10 =C2=B1  6%  fsmark.time.perce=
nt_of_cpu_this_job_got
>      92097 =C2=B1  2%     -23.1%      70865 =C2=B1  4%  fsmark.time.volun=
tary_context_switches
>       0.04 =C2=B1 42%    +681.0%       0.27 =C2=B1 22%  turbostat.Pkg%pc3
>     716062 =C2=B1  3%     -82.7%     124210 =C2=B1 21%  cpuidle.C1-IVT.us=
age
>  6.883e+08 =C2=B1  2%     -86.8%   91146705 =C2=B1 34%  cpuidle.C1-IVT.ti=
me
>       0.04 =C2=B1 30%    +145.8%       0.10 =C2=B1 25%  turbostat.CPU%c3
>        404 =C2=B1 16%     -58.4%        168 =C2=B1 14%  cpuidle.POLL.usage
>        159 =C2=B1 47%    +179.5%        444 =C2=B1 23%  proc-vmstat.kswap=
d_low_wmark_hit_quickly
>      11133 =C2=B1 23%    +100.3%      22298 =C2=B1 30%  cpuidle.C3-IVT.us=
age
>   10286681 =C2=B1 27%     +95.6%   20116924 =C2=B1 27%  cpuidle.C3-IVT.ti=
me
>       7.92 =C2=B1 16%     +77.4%      14.05 =C2=B1  6%  turbostat.Pkg%pc6
>       4.93 =C2=B1  3%     -38.6%       3.03 =C2=B1  2%  turbostat.CPU%c1
>        916 =C2=B1  3%     -27.2%        667 =C2=B1  5%  time.elapsed_time=
.max
>        916 =C2=B1  3%     -27.2%        667 =C2=B1  5%  time.elapsed_time
>    2137390 =C2=B1  3%     -26.7%    1566752 =C2=B1  5%  proc-vmstat.pgfau=
lt
>          7 =C2=B1  5%     +37.6%         10 =C2=B1  6%  time.percent_of_c=
pu_this_job_got
>  4.309e+10 =C2=B1  3%     -26.3%  3.176e+10 =C2=B1  5%  cpuidle.C6-IVT.ti=
me
>      49038 =C2=B1  2%     -23.9%      37334 =C2=B1  4%  uptime.idle
>       1047 =C2=B1  2%     -23.8%        797 =C2=B1  4%  uptime.boot
>      92097 =C2=B1  2%     -23.1%      70865 =C2=B1  4%  time.voluntary_co=
ntext_switches
>    4005888 =C2=B1  0%     +13.3%    4537685 =C2=B1 11%  meminfo.DirectMap=
2M
>       3917 =C2=B1  2%     -16.3%       3278 =C2=B1  5%  proc-vmstat.pageo=
utrun
>     213737 =C2=B1  1%     -13.9%     183969 =C2=B1  3%  softirqs.SCHED
>      46.86 =C2=B1  1%     +16.5%      54.59 =C2=B1  1%  turbostat.Pkg%pc2
>      32603 =C2=B1  3%     -11.7%      28781 =C2=B1  5%  numa-vmstat.node1=
.nr_unevictable
>     130415 =C2=B1  3%     -11.7%     115127 =C2=B1  5%  numa-meminfo.node=
1.Unevictable
>     256781 =C2=B1  2%      -8.8%     234146 =C2=B1  3%  softirqs.TASKLET
>     253606 =C2=B1  2%      -8.9%     231108 =C2=B1  3%  softirqs.BLOCK
>     119.10 =C2=B1  2%     -70.0%      35.78 =C2=B1 13%  iostat.sdc.rrqm/s
>     119.86 =C2=B1  1%     -70.3%      35.64 =C2=B1 12%  iostat.sdb.rrqm/s
>     117.13 =C2=B1  2%     -70.2%      34.96 =C2=B1 11%  iostat.sda.rrqm/s
>        504 =C2=B1  2%     -67.6%        163 =C2=B1 12%  iostat.sdc.rkB/s
>        507 =C2=B1  1%     -67.9%        163 =C2=B1 12%  iostat.sdb.rkB/s
>        496 =C2=B1  2%     -67.7%        160 =C2=B1 11%  iostat.sda.rkB/s
>      15392 =C2=B1  3%     +37.8%      21203 =C2=B1  5%  iostat.sdb.wrqm/s
>      15393 =C2=B1  3%     +37.7%      21203 =C2=B1  5%  iostat.sdc.wrqm/s
>      15392 =C2=B1  3%     +37.7%      21203 =C2=B1  5%  iostat.sda.wrqm/s
>     125236 =C2=B1  3%     +37.7%     172422 =C2=B1  4%  vmstat.io.bo
>     125181 =C2=B1  3%     +37.6%     172303 =C2=B1  4%  iostat.md0.wkB/s
>        552 =C2=B1  3%     +37.6%        760 =C2=B1  4%  iostat.md0.w/s
>      62611 =C2=B1  3%     +37.6%      86167 =C2=B1  4%  iostat.sdb.wkB/s
>      62613 =C2=B1  3%     +37.6%      86167 =C2=B1  4%  iostat.sdc.wkB/s
>      62613 =C2=B1  3%     +37.6%      86168 =C2=B1  4%  iostat.sda.wkB/s
>      40.24 =C2=B1  1%     -18.5%      32.81 =C2=B1  2%  turbostat.CorWatt
>        200 =C2=B1  0%     +22.2%        245 =C2=B1  2%  iostat.sdc.w/s
>       1020 =C2=B1  2%     +21.7%       1242 =C2=B1  2%  vmstat.system.in
>        200 =C2=B1  0%     +22.1%        245 =C2=B1  2%  iostat.sda.w/s
>        200 =C2=B1  0%     +22.2%        245 =C2=B1  2%  iostat.sdb.w/s
>      69.99 =C2=B1  0%     -12.4%      61.34 =C2=B1  2%  turbostat.PkgWatt
>       3943 =C2=B1  2%      -8.9%       3593 =C2=B1  1%  vmstat.system.cs
>       1.51 =C2=B1  1%      +6.1%       1.60 =C2=B1  2%  iostat.sdb.avgqu-=
sz
>       3.21 =C2=B1  0%      +5.4%       3.39 =C2=B1  1%  turbostat.RAMWatt
>     256182 =C2=B1  1%      -4.2%     245424 =C2=B1  1%  iostat.md0.avgqu-=
sz
>=20
>=20
>=20
> more detailed changes about ivb44/fsmark/1x-1t-3HDD-RAID5-f2fs-4M-120G-No=
Sync
> ---------
>=20
> c1dfe87e41d9c292  d4b4c2cdffab86f5c7594c4463 =20
> ----------------  -------------------------- =20
>          %stddev     %change         %stddev
>              \          |                \ =20
>      37.00 =C2=B1  0%     -15.9%      31.10 =C2=B1  0%  fsmark.files_per_=
sec
>      63414 =C2=B1  4%     +57.6%      99945 =C2=B1  1%  fsmark.time.volun=
tary_context_switches
>        830 =C2=B1  0%     +18.8%        987 =C2=B1  0%  fsmark.time.elaps=
ed_time
>        830 =C2=B1  0%     +18.8%        987 =C2=B1  0%  fsmark.time.elaps=
ed_time.max
>          9 =C2=B1  0%     -14.8%          7 =C2=B1  6%  fsmark.time.perce=
nt_of_cpu_this_job_got
>       1.48 =C2=B1 20%    +357.3%       6.75 =C2=B1  5%  turbostat.Pkg%pc6
>      63414 =C2=B1  4%     +57.6%      99945 =C2=B1  1%  time.voluntary_co=
ntext_switches
>        109 =C2=B1 15%     -37.8%         68 =C2=B1 20%  time.involuntary_=
context_switches
>        338 =C2=B1 17%     +57.6%        533 =C2=B1  0%  cpuidle.POLL.usage
>       2691 =C2=B1  1%     -20.3%       2144 =C2=B1 12%  proc-vmstat.kswap=
d_high_wmark_hit_quickly
>    1060792 =C2=B1  0%     +20.2%    1275544 =C2=B1  0%  cpuidle.C6-IVT.us=
age
>  3.876e+10 =C2=B1  0%     +19.3%  4.625e+10 =C2=B1  0%  cpuidle.C6-IVT.ti=
me
>        830 =C2=B1  0%     +18.8%        987 =C2=B1  0%  time.elapsed_time=
.max
>        830 =C2=B1  0%     +18.8%        987 =C2=B1  0%  time.elapsed_time
>      39984 =C2=B1  0%     +18.6%      47434 =C2=B1  0%  uptime.idle
>        856 =C2=B1  0%     +18.4%       1014 =C2=B1  0%  uptime.boot
>      15874 =C2=B1 12%     +20.9%      19188 =C2=B1  6%  slabinfo.anon_vma=
.active_objs
>    1942445 =C2=B1  0%     +18.1%    2293524 =C2=B1  0%  proc-vmstat.pgfau=
lt
>      15977 =C2=B1 12%     +20.1%      19188 =C2=B1  6%  slabinfo.anon_vma=
.num_objs
>     110388 =C2=B1  9%     +13.0%     124724 =C2=B1  4%  meminfo.DirectMap=
4k
>       3107 =C2=B1  8%     -20.9%       2459 =C2=B1 15%  numa-meminfo.node=
0.AnonHugePages
>      18408 =C2=B1 11%     +15.0%      21165 =C2=B1  3%  slabinfo.free_nid=
.active_objs
>      18880 =C2=B1 11%     +13.7%      21465 =C2=B1  4%  slabinfo.free_nid=
.num_objs
>    1125535 =C2=B1  0%     -11.5%     996605 =C2=B1  1%  cpuidle.C1-IVT.us=
age
>          9 =C2=B1  0%     -14.8%          7 =C2=B1  6%  time.percent_of_c=
pu_this_job_got
>     198260 =C2=B1  1%     +11.7%     221366 =C2=B1  0%  softirqs.SCHED
>       6.09 =C2=B1  2%     -12.2%       5.34 =C2=B1  0%  turbostat.CPU%c1
>      14203 =C2=B1  2%     -13.1%      12346 =C2=B1  8%  slabinfo.kmalloc-=
256.num_objs
>      13763 =C2=B1  3%     -13.3%      11937 =C2=B1  9%  slabinfo.kmalloc-=
256.active_objs
>       1255 =C2=B1  6%     +10.1%       1383 =C2=B1  1%  slabinfo.RAW.num_=
objs
>       1255 =C2=B1  6%     +10.1%       1383 =C2=B1  1%  slabinfo.RAW.acti=
ve_objs
>      30.37 =C2=B1  3%     +30.5%      39.62 =C2=B1  0%  iostat.sdc.rrqm/s
>      31.23 =C2=B1  5%     +28.0%      39.98 =C2=B1  1%  iostat.sdb.rrqm/s
>      33.37 =C2=B1  3%     +19.0%      39.72 =C2=B1  2%  iostat.sda.rrqm/s
>        562 =C2=B1  0%     -15.9%        472 =C2=B1  0%  iostat.md0.w/s
>      17106 =C2=B1  0%     -15.9%      14382 =C2=B1  0%  iostat.sda.wrqm/s
>      17106 =C2=B1  0%     -15.9%      14382 =C2=B1  0%  iostat.sdc.wrqm/s
>      17106 =C2=B1  0%     -15.9%      14382 =C2=B1  0%  iostat.sdb.wrqm/s
>      69317 =C2=B1  0%     -15.9%      58284 =C2=B1  0%  iostat.sdc.wkB/s
>      69316 =C2=B1  0%     -15.9%      58284 =C2=B1  0%  iostat.sda.wkB/s
>      69317 =C2=B1  0%     -15.9%      58284 =C2=B1  0%  iostat.sdb.wkB/s
>     138603 =C2=B1  0%     -15.9%     116543 =C2=B1  0%  iostat.md0.wkB/s
>     138705 =C2=B1  0%     -15.9%     116633 =C2=B1  0%  vmstat.io.bo
>        213 =C2=B1  0%     -14.5%        182 =C2=B1  0%  iostat.sdb.w/s
>        213 =C2=B1  0%     -14.5%        182 =C2=B1  0%  iostat.sda.w/s
>        213 =C2=B1  0%     -14.6%        182 =C2=B1  0%  iostat.sdc.w/s
>       4731 =C2=B1  0%     -12.7%       4131 =C2=B1  0%  vmstat.system.cs
>       1133 =C2=B1  2%     -12.3%        993 =C2=B1  0%  vmstat.system.in
>       3.02 =C2=B1  3%      -8.6%       2.76 =C2=B1  3%  iostat.sdc.avgqu-=
sz
>       3.29 =C2=B1  2%      -9.4%       2.98 =C2=B1  3%  iostat.sdb.avgqu-=
sz
>         25 =C2=B1 19%     -21.3%         19 =C2=B1  2%  turbostat.Avg_MHz
>       3.10 =C2=B1  1%      -9.4%       2.81 =C2=B1  1%  iostat.sda.avgqu-=
sz
>      44.45 =C2=B1  1%      -5.6%      41.94 =C2=B1  2%  turbostat.CorWatt
>       0.75 =C2=B1 19%     -20.1%       0.60 =C2=B1  4%  turbostat.%Busy
>      74.92 =C2=B1  1%      -4.9%      71.23 =C2=B1  2%  turbostat.PkgWatt


--Sig_/RdVwbF3DHd8sIl1MIDavNuQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVRIl+znsnt1WYoG5AQLdUhAApIN39ms3zqwF2d+EBWm4aD9PGgpvj/pI
farLTzTs4WtTVQ1woDE2AMXN4RXZOXyQa+LJQRdoVi4Gv4je7k6Tn1g8w3i0oaXc
9Bk/G0wQCMtikCHgmQiwZ9I7oQ9z4xd0zte11cUpu5qgxAqvsrsaEluiYgCw5o5y
xB+TXnVPZEsgwj6d+PBCr+K+i4WmZWimNswR3n2jDUe5fZ203f42Gn7pWdzJeRT2
kOSg9lzQODdcbe4InFI+wOzvffLZsSH+7Ej1YaY/5k8UPQ5CqTlEN0q9dzG5LauT
2J9WXl99KQ5AsWKyknzm5V/HGHGfZ1O3cjS6IgC8OgHEMx4yuMs96z0MknH58JIk
xmfGDSOcG1wRjo9nW4dbigdiPJM2BD/HYNX7fKuHITzJVI/6YpyfkVX9gv8Nc3Ql
3afzek7ojU5GvpJ7Syu+RW3I+y7wLY/Swqaz5754PsrpMq0d8zcRQ5bNhQFMWglB
9et+P6f1ywd2o9nXpj/eUUlc5CgB6bkNktE6W1TJ/WksAsZbu39Wywa3UyXwB+bp
/wFs5ZdZWyp4yMCTOU7KimZw/H68/721wB4OdvXlexuYKke1j0ClG749d8YoQPjx
t6bo3YZENgRX6WWJYK7CpOmEboCJzaHDmF/tZ3e2mo0IJCIb3xeoCH2UPyuYSMlk
CcwmkJ0T4+c=
=KGX5
-----END PGP SIGNATURE-----

--Sig_/RdVwbF3DHd8sIl1MIDavNuQ--
