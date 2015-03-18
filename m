From: Yuanahn Liu <yuanhan.liu@linux.intel.com>
Subject: performance changes on d4b4c2cd:  37.6% fsmark.files_per_sec, -15.9%
 fsmark.files_per_sec, and few more
Date: Wed, 18 Mar 2015 13:03:19 +0800
Message-ID: <20150318050319.GD30894@yliu-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "shli@kernel.org" <shli@kernel.org>
Cc: NeilBrown <neilb@suse.de>, lkp@01.org, lkp@linux.intel.com, linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

=46YI, we noticed performance changes on `fsmark.files_per_sec' by d4b4=
c2cdffab86f5c7594c44635286a6d277d5c6:

    > commit d4b4c2cdffab86f5c7594c44635286a6d277d5c6
    > Author:     shli@kernel.org <shli@kernel.org>
    > AuthorDate: Mon Dec 15 12:57:03 2014 +1100
    > Commit:     NeilBrown <neilb@suse.de>
    > CommitDate: Wed Mar 4 13:40:17 2015 +1100
    >=20
    >     RAID5: batch adjacent full stripe write

c1dfe87e41d9c2926fe92f803f02c733ddbccf0b     d4b4c2cdffab86f5c7594c4463=
5286a6d277d5c6
----------------------------------------     --------------------------=
--------------
run time(m)     metric_value     =B1stddev     run time(m)     metric_v=
alue     =B1stddev     change   testbox/benchmark/sub-testcase
--- ------  ----------------------------     --- ------  --------------=
--------------     -------- ------------------------------
4   15.3              33.525     =B13.0%       6   11.1              46=
=2E133     =B15.0%          37.6% ivb44/fsmark/1x-1t-3HDD-RAID5-xfs-4M-=
120G-NoSync
3   0.5              262.800     =B11.5%       3   0.4              307=
=2E367     =B11.2%          17.0% ivb44/fsmark/1x-1t-4BRD_12G-RAID5-f2f=
s-4M-30G-NoSync
3   0.5              289.900     =B10.3%       3   0.4              323=
=2E367     =B12.4%          11.5% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-f2=
fs-4M-30G-NoSync
3   0.5              325.667     =B12.2%       3   0.5              358=
=2E800     =B11.8%          10.2% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-ex=
t4-4M-30G-NoSync
3   0.6              216.100     =B10.4%       3   0.6              230=
=2E100     =B10.4%           6.5% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-f2=
fs-4M-30G-fsyncBeforeClose
3   0.5              309.900     =B10.3%       3   0.5              328=
=2E500     =B11.1%           6.0% ivb44/fsmark/1x-64t-4BRD_12G-RAID5-xf=
s-4M-30G-NoSync

3   13.8              37.000     =B10.2%       3   16.5              31=
=2E100     =B10.3%         -15.9% ivb44/fsmark/1x-1t-3HDD-RAID5-f2fs-4M=
-120G-NoSync

NOTE: here are some more info about those test parameters for you to
      understand the testcase better:

      1x : where 'x' means iterations or loop, corresponding to the 'L'=
 option of fsmark
      64t: where 't' means thread
      4M : means the single file size, corresponding to the '-s' option=
 of fsmark
      120G, 30G: means the total test size

      4BRD_12G: BRD is the ramdisk, where '4' means 4 ramdisk, and wher=
e '12G' means
                the size of one ramdisk. So, it would be 48G in total. =
And we made a
                raid on those ramdisk.


And FYI, here I listed more detailed changes for the maximal postive an=
d negtive changes.


more detailed changes about ivb44/fsmark/1x-1t-3HDD-RAID5-xfs-4M-120G-N=
oSync
---------

c1dfe87e41d9c292  d4b4c2cdffab86f5c7594c4463 =20
----------------  -------------------------- =20
         %stddev     %change         %stddev
             \          |                \ =20
     33.53 =B1  3%     +37.6%      46.13 =B1  4%  fsmark.files_per_sec
       916 =B1  3%     -27.2%        667 =B1  5%  fsmark.time.elapsed_t=
ime.max
       916 =B1  3%     -27.2%        667 =B1  5%  fsmark.time.elapsed_t=
ime
         7 =B1  5%     +37.6%         10 =B1  6%  fsmark.time.percent_o=
f_cpu_this_job_got
     92097 =B1  2%     -23.1%      70865 =B1  4%  fsmark.time.voluntary=
_context_switches
      0.04 =B1 42%    +681.0%       0.27 =B1 22%  turbostat.Pkg%pc3
    716062 =B1  3%     -82.7%     124210 =B1 21%  cpuidle.C1-IVT.usage
 6.883e+08 =B1  2%     -86.8%   91146705 =B1 34%  cpuidle.C1-IVT.time
      0.04 =B1 30%    +145.8%       0.10 =B1 25%  turbostat.CPU%c3
       404 =B1 16%     -58.4%        168 =B1 14%  cpuidle.POLL.usage
       159 =B1 47%    +179.5%        444 =B1 23%  proc-vmstat.kswapd_lo=
w_wmark_hit_quickly
     11133 =B1 23%    +100.3%      22298 =B1 30%  cpuidle.C3-IVT.usage
  10286681 =B1 27%     +95.6%   20116924 =B1 27%  cpuidle.C3-IVT.time
      7.92 =B1 16%     +77.4%      14.05 =B1  6%  turbostat.Pkg%pc6
      4.93 =B1  3%     -38.6%       3.03 =B1  2%  turbostat.CPU%c1
       916 =B1  3%     -27.2%        667 =B1  5%  time.elapsed_time.max
       916 =B1  3%     -27.2%        667 =B1  5%  time.elapsed_time
   2137390 =B1  3%     -26.7%    1566752 =B1  5%  proc-vmstat.pgfault
         7 =B1  5%     +37.6%         10 =B1  6%  time.percent_of_cpu_t=
his_job_got
 4.309e+10 =B1  3%     -26.3%  3.176e+10 =B1  5%  cpuidle.C6-IVT.time
     49038 =B1  2%     -23.9%      37334 =B1  4%  uptime.idle
      1047 =B1  2%     -23.8%        797 =B1  4%  uptime.boot
     92097 =B1  2%     -23.1%      70865 =B1  4%  time.voluntary_contex=
t_switches
   4005888 =B1  0%     +13.3%    4537685 =B1 11%  meminfo.DirectMap2M
      3917 =B1  2%     -16.3%       3278 =B1  5%  proc-vmstat.pageoutru=
n
    213737 =B1  1%     -13.9%     183969 =B1  3%  softirqs.SCHED
     46.86 =B1  1%     +16.5%      54.59 =B1  1%  turbostat.Pkg%pc2
     32603 =B1  3%     -11.7%      28781 =B1  5%  numa-vmstat.node1.nr_=
unevictable
    130415 =B1  3%     -11.7%     115127 =B1  5%  numa-meminfo.node1.Un=
evictable
    256781 =B1  2%      -8.8%     234146 =B1  3%  softirqs.TASKLET
    253606 =B1  2%      -8.9%     231108 =B1  3%  softirqs.BLOCK
    119.10 =B1  2%     -70.0%      35.78 =B1 13%  iostat.sdc.rrqm/s
    119.86 =B1  1%     -70.3%      35.64 =B1 12%  iostat.sdb.rrqm/s
    117.13 =B1  2%     -70.2%      34.96 =B1 11%  iostat.sda.rrqm/s
       504 =B1  2%     -67.6%        163 =B1 12%  iostat.sdc.rkB/s
       507 =B1  1%     -67.9%        163 =B1 12%  iostat.sdb.rkB/s
       496 =B1  2%     -67.7%        160 =B1 11%  iostat.sda.rkB/s
     15392 =B1  3%     +37.8%      21203 =B1  5%  iostat.sdb.wrqm/s
     15393 =B1  3%     +37.7%      21203 =B1  5%  iostat.sdc.wrqm/s
     15392 =B1  3%     +37.7%      21203 =B1  5%  iostat.sda.wrqm/s
    125236 =B1  3%     +37.7%     172422 =B1  4%  vmstat.io.bo
    125181 =B1  3%     +37.6%     172303 =B1  4%  iostat.md0.wkB/s
       552 =B1  3%     +37.6%        760 =B1  4%  iostat.md0.w/s
     62611 =B1  3%     +37.6%      86167 =B1  4%  iostat.sdb.wkB/s
     62613 =B1  3%     +37.6%      86167 =B1  4%  iostat.sdc.wkB/s
     62613 =B1  3%     +37.6%      86168 =B1  4%  iostat.sda.wkB/s
     40.24 =B1  1%     -18.5%      32.81 =B1  2%  turbostat.CorWatt
       200 =B1  0%     +22.2%        245 =B1  2%  iostat.sdc.w/s
      1020 =B1  2%     +21.7%       1242 =B1  2%  vmstat.system.in
       200 =B1  0%     +22.1%        245 =B1  2%  iostat.sda.w/s
       200 =B1  0%     +22.2%        245 =B1  2%  iostat.sdb.w/s
     69.99 =B1  0%     -12.4%      61.34 =B1  2%  turbostat.PkgWatt
      3943 =B1  2%      -8.9%       3593 =B1  1%  vmstat.system.cs
      1.51 =B1  1%      +6.1%       1.60 =B1  2%  iostat.sdb.avgqu-sz
      3.21 =B1  0%      +5.4%       3.39 =B1  1%  turbostat.RAMWatt
    256182 =B1  1%      -4.2%     245424 =B1  1%  iostat.md0.avgqu-sz



more detailed changes about ivb44/fsmark/1x-1t-3HDD-RAID5-f2fs-4M-120G-=
NoSync
---------

c1dfe87e41d9c292  d4b4c2cdffab86f5c7594c4463 =20
----------------  -------------------------- =20
         %stddev     %change         %stddev
             \          |                \ =20
     37.00 =B1  0%     -15.9%      31.10 =B1  0%  fsmark.files_per_sec
     63414 =B1  4%     +57.6%      99945 =B1  1%  fsmark.time.voluntary=
_context_switches
       830 =B1  0%     +18.8%        987 =B1  0%  fsmark.time.elapsed_t=
ime
       830 =B1  0%     +18.8%        987 =B1  0%  fsmark.time.elapsed_t=
ime.max
         9 =B1  0%     -14.8%          7 =B1  6%  fsmark.time.percent_o=
f_cpu_this_job_got
      1.48 =B1 20%    +357.3%       6.75 =B1  5%  turbostat.Pkg%pc6
     63414 =B1  4%     +57.6%      99945 =B1  1%  time.voluntary_contex=
t_switches
       109 =B1 15%     -37.8%         68 =B1 20%  time.involuntary_cont=
ext_switches
       338 =B1 17%     +57.6%        533 =B1  0%  cpuidle.POLL.usage
      2691 =B1  1%     -20.3%       2144 =B1 12%  proc-vmstat.kswapd_hi=
gh_wmark_hit_quickly
   1060792 =B1  0%     +20.2%    1275544 =B1  0%  cpuidle.C6-IVT.usage
 3.876e+10 =B1  0%     +19.3%  4.625e+10 =B1  0%  cpuidle.C6-IVT.time
       830 =B1  0%     +18.8%        987 =B1  0%  time.elapsed_time.max
       830 =B1  0%     +18.8%        987 =B1  0%  time.elapsed_time
     39984 =B1  0%     +18.6%      47434 =B1  0%  uptime.idle
       856 =B1  0%     +18.4%       1014 =B1  0%  uptime.boot
     15874 =B1 12%     +20.9%      19188 =B1  6%  slabinfo.anon_vma.act=
ive_objs
   1942445 =B1  0%     +18.1%    2293524 =B1  0%  proc-vmstat.pgfault
     15977 =B1 12%     +20.1%      19188 =B1  6%  slabinfo.anon_vma.num=
_objs
    110388 =B1  9%     +13.0%     124724 =B1  4%  meminfo.DirectMap4k
      3107 =B1  8%     -20.9%       2459 =B1 15%  numa-meminfo.node0.An=
onHugePages
     18408 =B1 11%     +15.0%      21165 =B1  3%  slabinfo.free_nid.act=
ive_objs
     18880 =B1 11%     +13.7%      21465 =B1  4%  slabinfo.free_nid.num=
_objs
   1125535 =B1  0%     -11.5%     996605 =B1  1%  cpuidle.C1-IVT.usage
         9 =B1  0%     -14.8%          7 =B1  6%  time.percent_of_cpu_t=
his_job_got
    198260 =B1  1%     +11.7%     221366 =B1  0%  softirqs.SCHED
      6.09 =B1  2%     -12.2%       5.34 =B1  0%  turbostat.CPU%c1
     14203 =B1  2%     -13.1%      12346 =B1  8%  slabinfo.kmalloc-256.=
num_objs
     13763 =B1  3%     -13.3%      11937 =B1  9%  slabinfo.kmalloc-256.=
active_objs
      1255 =B1  6%     +10.1%       1383 =B1  1%  slabinfo.RAW.num_objs
      1255 =B1  6%     +10.1%       1383 =B1  1%  slabinfo.RAW.active_o=
bjs
     30.37 =B1  3%     +30.5%      39.62 =B1  0%  iostat.sdc.rrqm/s
     31.23 =B1  5%     +28.0%      39.98 =B1  1%  iostat.sdb.rrqm/s
     33.37 =B1  3%     +19.0%      39.72 =B1  2%  iostat.sda.rrqm/s
       562 =B1  0%     -15.9%        472 =B1  0%  iostat.md0.w/s
     17106 =B1  0%     -15.9%      14382 =B1  0%  iostat.sda.wrqm/s
     17106 =B1  0%     -15.9%      14382 =B1  0%  iostat.sdc.wrqm/s
     17106 =B1  0%     -15.9%      14382 =B1  0%  iostat.sdb.wrqm/s
     69317 =B1  0%     -15.9%      58284 =B1  0%  iostat.sdc.wkB/s
     69316 =B1  0%     -15.9%      58284 =B1  0%  iostat.sda.wkB/s
     69317 =B1  0%     -15.9%      58284 =B1  0%  iostat.sdb.wkB/s
    138603 =B1  0%     -15.9%     116543 =B1  0%  iostat.md0.wkB/s
    138705 =B1  0%     -15.9%     116633 =B1  0%  vmstat.io.bo
       213 =B1  0%     -14.5%        182 =B1  0%  iostat.sdb.w/s
       213 =B1  0%     -14.5%        182 =B1  0%  iostat.sda.w/s
       213 =B1  0%     -14.6%        182 =B1  0%  iostat.sdc.w/s
      4731 =B1  0%     -12.7%       4131 =B1  0%  vmstat.system.cs
      1133 =B1  2%     -12.3%        993 =B1  0%  vmstat.system.in
      3.02 =B1  3%      -8.6%       2.76 =B1  3%  iostat.sdc.avgqu-sz
      3.29 =B1  2%      -9.4%       2.98 =B1  3%  iostat.sdb.avgqu-sz
        25 =B1 19%     -21.3%         19 =B1  2%  turbostat.Avg_MHz
      3.10 =B1  1%      -9.4%       2.81 =B1  1%  iostat.sda.avgqu-sz
     44.45 =B1  1%      -5.6%      41.94 =B1  2%  turbostat.CorWatt
      0.75 =B1 19%     -20.1%       0.60 =B1  4%  turbostat.%Busy
     74.92 =B1  1%      -4.9%      71.23 =B1  2%  turbostat.PkgWatt
