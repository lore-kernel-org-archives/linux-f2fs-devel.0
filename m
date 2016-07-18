From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.app_overhead
	-36.3% regression
Date: Mon, 18 Jul 2016 13:27:24 -0700
Message-ID: <87twfmsndf.fsf@yhuang-mobile.sh.intel.com>
References: <20160718020950.GB4986@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1bPF8X-00017V-GA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jul 2016 20:27:33 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bPF8T-0000rM-De for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 18 Jul 2016 20:27:33 +0000
In-Reply-To: <20160718020950.GB4986@yexl-desktop> (kernel test robot's message
	of "Mon, 18 Jul 2016 10:09:50 +0800")
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: kernel test robot <xiaolong.ye@intel.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, lkp@01.org, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi,

I checked the comparison result below and found this is a regression for
fsmark.files_per_sec, not fsmark.app_overhead.

Best Regards,
Huang, Ying

kernel test robot <xiaolong.ye@intel.com> writes:

> FYI, we noticed a -36.3% regression of fsmark.files_per_sec due to commit:
>
> commit ec795418c41850056feb956534edf059dc1155d4 ("f2fs: use percpu_rw_semaphore")
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
>
> in testcase: fsmark
> on test machine: 72 threads Haswell-EP with 128G memory
> with following parameters: cpufreq_governor=performance/disk=1SSD/filesize=8K/fs=f2fs/iterations=8/nr_directories=16d/nr_files_per_directory=256fpd/nr_threads=4/sync_method=fsyncBeforeClose/test_size=72G
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone git://git.kernel.org/pub/scm/linux/kernel/git/wfg/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =========================================================================================
> compiler/cpufreq_governor/disk/filesize/fs/iterations/kconfig/nr_directories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>   gcc-4.9/performance/1SSD/8K/f2fs/8/x86_64-rhel/16d/256fpd/4/debian-x86_64-2015-02-07.cgz/fsyncBeforeClose/lkp-hsw-ep4/72G/fsmark
>
> commit: 
>   3bdad3c7ee ("f2fs: skip to check the block address of node page")
>   ec795418c4 ("f2fs: use percpu_rw_semaphore")
>
> 3bdad3c7ee72a76e ec795418c41850056feb956534 
> ---------------- -------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>          %stddev     %change         %stddev
>              \          |                \  
>      29551 .  0%     -36.3%      18831 .  2%  fsmark.files_per_sec
>    6696820 .  1%      +4.2%    6977582 .  1%  fsmark.app_overhead
>     322.28 .  0%     +55.9%     502.37 .  2%  fsmark.time.elapsed_time
>     322.28 .  0%     +55.9%     502.37 .  2%  fsmark.time.elapsed_time.max
>  2.756e+08 .  0%      -7.6%  2.545e+08 .  0%  fsmark.time.file_system_outputs
>       8913 .  6%    +106.8%      18436 . 10%  fsmark.time.involuntary_context_switches
>     320.80 .  0%      -2.8%     311.80 .  0%  fsmark.time.percent_of_cpu_this_job_got
>     993.78 .  0%     +53.2%       1522 .  2%  fsmark.time.system_time
>      41.53 .  2%     +11.1%      46.13 .  1%  fsmark.time.user_time
>   21551618 .  0%    +123.2%   48100377 .  2%  fsmark.time.voluntary_context_switches
>      51036 .  6%     +77.9%      90812 .  0%  meminfo.Dirty
>      25742 . 49%    +100.4%      51585 . 31%  numa-meminfo.node1.Dirty
>       6517 . 49%     +97.7%      12887 . 31%  numa-vmstat.node1.nr_dirty
>     311222 .  2%     +55.6%     484246 .  7%  softirqs.RCU
>     483341 .  3%     +34.2%     648718 .  3%  softirqs.SCHED
>     849788 .  7%     +27.1%    1079705 .  5%  softirqs.TIMER
>       8.48 .  0%      -5.0%       8.06 .  0%  turbostat.%Busy
>     223.50 .  0%      -7.5%     206.80 .  0%  turbostat.Avg_MHz
>       1.02 .  3%     +45.2%       1.48 .  2%  turbostat.CPU%c3
>       7420 .  2%     -18.1%       6079 .  1%  slabinfo.ext4_extent_status.active_objs
>       7420 .  2%     -18.1%       6079 .  1%  slabinfo.ext4_extent_status.num_objs
>       7676 .  1%     -12.8%       6694 .  3%  slabinfo.kmalloc-1024.active_objs
>       8005 .  1%     -12.3%       7016 .  2%  slabinfo.kmalloc-1024.num_objs
>     270.00 .  1%     -36.3%     172.10 .  3%  vmstat.io.bi
>     424174 .  0%     -40.5%     252324 .  2%  vmstat.io.bo
>     137171 .  0%     +42.3%     195205 .  0%  vmstat.system.cs
>     129727 .  0%     -16.4%     108410 .  0%  vmstat.system.in
>     115.40 .127%     -96.1%       4.50 .189%  proc-vmstat.kswapd_high_wmark_hit_quickly
>      12748 .  6%     +78.2%      22719 .  0%  proc-vmstat.nr_dirty
>       6239 .  9%     +26.7%       7908 . 13%  proc-vmstat.numa_hint_faults
>       5275 .  8%     +22.6%       6469 . 11%  proc-vmstat.numa_hint_faults_local
>     746512 .  2%     +50.2%    1121580 .  2%  proc-vmstat.pgfault
>  2.331e+08 .  1%    +179.8%  6.522e+08 .  5%  cpuidle.C1-HSW.time
>   21473442 .  0%    +125.2%   48347668 .  2%  cpuidle.C1-HSW.usage
>   13731593 .  4%   +1207.0%  1.795e+08 . 16%  cpuidle.C1E-HSW.time
>     123887 .  3%   +1237.9%    1657510 . 18%  cpuidle.C1E-HSW.usage
>  2.173e+08 .  4%    +181.6%   6.12e+08 .  4%  cpuidle.C3-HSW.time
>     479301 .  5%    +441.1%    2593727 .  5%  cpuidle.C3-HSW.usage
>  2.042e+10 .  0%     +52.9%  3.123e+10 .  2%  cpuidle.C6-HSW.time
>   22061045 .  0%     +53.2%   33801151 .  2%  cpuidle.C6-HSW.usage
>  1.131e+08 . 10%     +44.0%  1.629e+08 .  7%  cpuidle.POLL.time
>     448858 .  0%     +25.2%     561850 .  0%  cpuidle.POLL.usage
>  6.679e+10 .  3%     +43.1%  9.559e+10 .  2%  perf-stat.L1-dcache-load-misses
>  7.043e+11 .  3%     +44.4%  1.017e+12 .  4%  perf-stat.L1-dcache-loads
>  4.012e+11 .  5%     +44.5%  5.798e+11 .  4%  perf-stat.L1-dcache-stores
>  3.657e+10 .  5%     +26.0%  4.609e+10 .  4%  perf-stat.L1-icache-load-misses
>  3.534e+10 .  3%     +39.2%  4.919e+10 .  5%  perf-stat.LLC-loads
>  5.802e+09 .  8%     +77.5%   1.03e+10 .  6%  perf-stat.LLC-stores
>  5.894e+11 .  4%     +44.1%   8.49e+11 .  4%  perf-stat.branch-instructions
>  5.843e+09 .  5%     +61.1%  9.414e+09 .  5%  perf-stat.branch-load-misses
>  5.715e+11 .  3%     +51.0%  8.631e+11 .  4%  perf-stat.branch-loads
>  5.885e+09 .  7%     +69.6%  9.981e+09 .  8%  perf-stat.branch-misses
>  1.778e+11 .  5%     +44.2%  2.564e+11 .  4%  perf-stat.bus-cycles
>  7.914e+10 .  6%     +38.9%  1.099e+11 .  5%  perf-stat.cache-references
>   44519137 .  0%    +121.2%   98455560 .  2%  perf-stat.context-switches
>  4.758e+12 .  3%     +42.2%  6.765e+12 .  4%  perf-stat.cpu-cycles
>     422734 .  2%    +113.7%     903275 .  3%  perf-stat.cpu-migrations
>  1.278e+10 .  3%     +35.1%  1.727e+10 .  4%  perf-stat.dTLB-load-misses
>  7.029e+11 .  4%     +44.3%  1.014e+12 .  5%  perf-stat.dTLB-loads
>  2.886e+08 .  4%    +139.9%  6.922e+08 .  5%  perf-stat.dTLB-store-misses
>  3.995e+11 .  8%     +45.3%  5.807e+11 .  3%  perf-stat.dTLB-stores
>  1.312e+09 .  3%     +47.0%  1.928e+09 .  7%  perf-stat.iTLB-loads
>  2.929e+12 .  2%     +38.8%  4.064e+12 .  6%  perf-stat.instructions
>     729801 .  2%     +50.8%    1100280 .  2%  perf-stat.minor-faults
>  1.071e+08 .  8%     +14.4%  1.224e+08 .  6%  perf-stat.node-store-misses
>     729789 .  2%     +50.8%    1100266 .  2%  perf-stat.page-faults
>  3.922e+12 .  3%     +47.2%  5.775e+12 .  4%  perf-stat.ref-cycles
>       6824 .  0%     +55.1%      10582 .  0%  sched_debug.cfs_rq:/.exec_clock.avg
>      28828 . 12%     +49.1%      42992 .  6%  sched_debug.cfs_rq:/.exec_clock.max
>      30.22 . 11%     +95.5%      59.08 .  7%  sched_debug.cfs_rq:/.exec_clock.min
>       7993 .  6%     +50.5%      12033 .  2%  sched_debug.cfs_rq:/.exec_clock.stddev
>      25.89 . 18%     -28.4%      18.53 . 21%  sched_debug.cfs_rq:/.load_avg.avg
>       7337 .  0%     +51.6%      11121 .  0%  sched_debug.cfs_rq:/.min_vruntime.avg
>      34800 .  9%     +43.2%      49818 .  5%  sched_debug.cfs_rq:/.min_vruntime.max
>       8745 .  6%     +46.1%      12773 .  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       5.47 . 16%     -29.1%       3.88 . 15%  sched_debug.cfs_rq:/.runnable_load_avg.avg
>     -32162 .-16%     +39.6%     -44890 .-13%  sched_debug.cfs_rq:/.spread0.min
>       8745 .  6%     +46.1%      12774 .  2%  sched_debug.cfs_rq:/.spread0.stddev
>     652.00 .  6%     -22.9%     502.53 .  6%  sched_debug.cfs_rq:/.util_avg.max
>     138.58 .  6%     -22.4%     107.57 .  3%  sched_debug.cfs_rq:/.util_avg.stddev
>     203456 .  0%     +44.0%     293000 .  0%  sched_debug.cpu.clock.avg
>     203461 .  0%     +44.0%     293005 .  0%  sched_debug.cpu.clock.max
>     203450 .  0%     +44.0%     292994 .  0%  sched_debug.cpu.clock.min
>     203456 .  0%     +44.0%     293000 .  0%  sched_debug.cpu.clock_task.avg
>     203461 .  0%     +44.0%     293005 .  0%  sched_debug.cpu.clock_task.max
>     203450 .  0%     +44.0%     292994 .  0%  sched_debug.cpu.clock_task.min
>      21.62 . 35%     -36.8%      13.66 . 28%  sched_debug.cpu.cpu_load[3].stddev
>     336.16 .  9%     +23.4%     414.96 .  8%  sched_debug.cpu.curr->pid.avg
>       5526 .  0%     +38.9%       7674 .  2%  sched_debug.cpu.curr->pid.max
>       1227 .  5%     +31.3%       1611 .  5%  sched_debug.cpu.curr->pid.stddev
>      46943 .  2%     +55.3%      72908 .  1%  sched_debug.cpu.nr_load_updates.avg
>      70757 .  3%     +51.6%     107258 .  3%  sched_debug.cpu.nr_load_updates.max
>      31077 . 12%     +56.5%      48628 . 12%  sched_debug.cpu.nr_load_updates.min
>      10900 .  4%     +53.9%      16781 .  3%  sched_debug.cpu.nr_load_updates.stddev
>     305199 .  0%    +123.9%     683210 .  0%  sched_debug.cpu.nr_switches.avg
>    1286089 . 12%    +115.6%    2772732 .  7%  sched_debug.cpu.nr_switches.max
>     602.75 .  5%     +64.8%     993.43 .  7%  sched_debug.cpu.nr_switches.min
>     362058 .  7%    +117.3%     786749 .  3%  sched_debug.cpu.nr_switches.stddev
>      57.60 . 13%    +124.4%     129.24 . 11%  sched_debug.cpu.nr_uninterruptible.max
>    -105.13 .-13%    +217.5%    -333.79 .-11%  sched_debug.cpu.nr_uninterruptible.min
>      22.80 .  5%    +220.7%      73.11 .  4%  sched_debug.cpu.nr_uninterruptible.stddev
>     304847 .  0%    +124.1%     683016 .  0%  sched_debug.cpu.sched_count.avg
>    1283492 . 12%    +115.9%    2771349 .  7%  sched_debug.cpu.sched_count.max
>     373.43 .  8%    +109.1%     780.90 .  7%  sched_debug.cpu.sched_count.min
>     361891 .  7%    +117.4%     786838 .  3%  sched_debug.cpu.sched_count.stddev
>     151704 .  0%    +124.4%     340409 .  0%  sched_debug.cpu.sched_goidle.avg
>     639131 . 12%    +115.5%    1377132 .  7%  sched_debug.cpu.sched_goidle.max
>     148.13 .  7%    +104.1%     302.30 .  7%  sched_debug.cpu.sched_goidle.min
>     180189 .  7%    +117.6%     392032 .  3%  sched_debug.cpu.sched_goidle.stddev
>     152464 .  0%    +124.2%     341851 .  0%  sched_debug.cpu.ttwu_count.avg
>     931253 . 13%     +78.3%    1660600 .  7%  sched_debug.cpu.ttwu_count.max
>     201.32 .  7%     +91.7%     385.88 .  4%  sched_debug.cpu.ttwu_count.min
>     215408 .  6%     +95.3%     420609 .  3%  sched_debug.cpu.ttwu_count.stddev
>     106.18 .  8%     +89.1%     200.76 .  4%  sched_debug.cpu.ttwu_local.min
>     203453 .  0%     +44.0%     292997 .  0%  sched_debug.cpu_clk
>     200513 .  0%     +44.5%     289817 .  0%  sched_debug.ktime
>       0.17 .  0%     -46.7%       0.09 . 49%  sched_debug.rt_rq:/.rt_nr_running.max
>       0.02 . 17%     -44.8%       0.01 . 53%  sched_debug.rt_rq:/.rt_nr_running.stddev
>     203453 .  0%     +44.0%     292997 .  0%  sched_debug.sched_clk
>       3.58 .  9%     -42.2%       2.07 . 34%  perf-profile.cycles-pp.__alloc_percpu_gfp.__percpu_counter_init.f2fs_alloc_inode.alloc_inode.new_inode_pseudo
>       3.73 .  5%     -44.5%       2.07 . 34%  perf-profile.cycles-pp.__blk_mq_complete_request.blk_mq_complete_request.__nvme_process_cq.nvme_irq.handle_irq_event_percpu
>       0.93 .  6%     -41.0%       0.55 . 35%  perf-profile.cycles-pp.__f2fs_submit_merged_bio.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range
>       0.90 .  8%     -93.3%       0.06 .300%  perf-profile.cycles-pp.__filemap_fdatawait_range.filemap_fdatawait_range.filemap_write_and_wait_range.f2fs_do_sync_file.f2fs_sync_file
>       6.88 .  7%     -30.3%       4.79 . 33%  perf-profile.cycles-pp.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.f2fs_sync_file.vfs_fsync_range
>       1.96 .  8%     -42.4%       1.13 . 34%  perf-profile.cycles-pp.__generic_file_write_iter.f2fs_file_write_iter.__vfs_write.vfs_write.sys_write
>       3.81 .  5%     -44.3%       2.12 . 34%  perf-profile.cycles-pp.__nvme_process_cq.nvme_irq.handle_irq_event_percpu.handle_irq_event.handle_edge_irq
>       3.68 .  9%     -42.2%       2.13 . 34%  perf-profile.cycles-pp.__percpu_counter_init.f2fs_alloc_inode.alloc_inode.new_inode_pseudo.new_inode
>       1.59 .  7%     -43.6%       0.90 . 34%  perf-profile.cycles-pp.__percpu_counter_sum.f2fs_balance_fs.f2fs_create.path_openat.do_filp_open
>       2.39 .  9%     -36.4%       1.52 . 34%  perf-profile.cycles-pp.__percpu_counter_sum.f2fs_balance_fs.f2fs_write_data_page.f2fs_write_cache_pages.f2fs_write_data_pages
>       2.79 .  7%     -40.8%       1.65 . 34%  perf-profile.cycles-pp.__vfs_write.vfs_write.sys_write.entry_SYSCALL_64_fastpath
>       2.91 .  6%     -45.2%       1.60 . 34%  perf-profile.cycles-pp.__wake_up.__wake_up_bit.end_page_writeback.f2fs_write_end_io.bio_endio
>       2.92 .  6%     -45.1%       1.61 . 34%  perf-profile.cycles-pp.__wake_up_bit.end_page_writeback.f2fs_write_end_io.bio_endio.blk_update_request
>       2.88 .  6%     -45.3%       1.57 . 34%  perf-profile.cycles-pp.__wake_up_common.__wake_up.__wake_up_bit.end_page_writeback.f2fs_write_end_io
>       0.98 . 11%     -62.2%       0.37 . 81%  perf-profile.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work.worker_thread
>       2.56 .  7%     -44.9%       1.41 . 34%  perf-profile.cycles-pp.activate_task.ttwu_do_activate.try_to_wake_up.default_wake_function.autoremove_wake_function
>       4.04 .  8%     -42.3%       2.33 . 34%  perf-profile.cycles-pp.alloc_inode.new_inode_pseudo.new_inode.f2fs_new_inode.f2fs_create
>       2.86 .  6%     -45.3%       1.56 . 34%  perf-profile.cycles-pp.autoremove_wake_function.wake_bit_function.__wake_up_common.__wake_up.__wake_up_bit
>       3.39 .  6%     -45.2%       1.86 . 34%  perf-profile.cycles-pp.bio_endio.blk_update_request.blk_mq_end_request.nvme_complete_rq.__blk_mq_complete_request
>       3.73 .  5%     -44.5%       2.07 . 34%  perf-profile.cycles-pp.blk_mq_complete_request.__nvme_process_cq.nvme_irq.handle_irq_event_percpu.handle_irq_event
>       3.65 .  5%     -44.7%       2.02 . 34%  perf-profile.cycles-pp.blk_mq_end_request.nvme_complete_rq.__blk_mq_complete_request.blk_mq_complete_request.__nvme_process_cq
>       3.50 .  5%     -45.2%       1.92 . 34%  perf-profile.cycles-pp.blk_update_request.blk_mq_end_request.nvme_complete_rq.__blk_mq_complete_request.blk_mq_complete_request
>       2.85 .  6%     -45.3%       1.56 . 34%  perf-profile.cycles-pp.default_wake_function.autoremove_wake_function.wake_bit_function.__wake_up_common.__wake_up
>       4.26 .  6%     -43.9%       2.39 . 34%  perf-profile.cycles-pp.do_IRQ.ret_from_intr.cpuidle_enter.call_cpuidle.cpu_startup_entry
>      20.48 .  5%     -21.1%      16.16 . 34%  perf-profile.cycles-pp.do_filp_open.do_sys_open.sys_open.entry_SYSCALL_64_fastpath
>      20.64 .  5%     -21.3%      16.25 . 34%  perf-profile.cycles-pp.do_sys_open.sys_open.entry_SYSCALL_64_fastpath
>       0.81 . 18%     -85.8%       0.11 .200%  perf-profile.cycles-pp.do_write_page.write_data_page.do_write_data_page.f2fs_write_data_page.f2fs_write_cache_pages
>       6.86 .  7%     -30.4%       4.78 . 33%  perf-profile.cycles-pp.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.f2fs_sync_file
>       3.20 .  6%     -44.7%       1.77 . 34%  perf-profile.cycles-pp.end_page_writeback.f2fs_write_end_io.bio_endio.blk_update_request.blk_mq_end_request
>       2.54 .  7%     -44.7%       1.40 . 33%  perf-profile.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.try_to_wake_up.default_wake_function
>       3.88 .  9%     -42.5%       2.23 . 34%  perf-profile.cycles-pp.f2fs_alloc_inode.alloc_inode.new_inode_pseudo.new_inode.f2fs_new_inode
>       1.99 .  5%     -49.0%       1.01 . 34%  perf-profile.cycles-pp.f2fs_balance_fs.f2fs_create.path_openat.do_filp_open.do_sys_open
>       3.12 .  9%     -43.5%       1.76 . 34%  perf-profile.cycles-pp.f2fs_balance_fs.f2fs_write_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages
>       1.18 .  6%     -47.6%       0.62 . 34%  perf-profile.cycles-pp.f2fs_dentry_hash.find_in_level.f2fs_find_entry.f2fs_lookup.path_openat
>       2.73 .  7%     -41.1%       1.61 . 34%  perf-profile.cycles-pp.f2fs_file_write_iter.__vfs_write.vfs_write.sys_write.entry_SYSCALL_64_fastpath
>       7.86 .  8%     -52.0%       3.77 . 34%  perf-profile.cycles-pp.f2fs_find_entry.f2fs_lookup.path_openat.do_filp_open.do_sys_open
>       7.95 .  8%     -51.7%       3.84 . 34%  perf-profile.cycles-pp.f2fs_lookup.path_openat.do_filp_open.do_sys_open.sys_open
>       4.60 .  7%     -42.4%       2.65 . 34%  perf-profile.cycles-pp.f2fs_new_inode.f2fs_create.path_openat.do_filp_open.do_sys_open
>       1.12 .  3%     -41.5%       0.66 . 35%  perf-profile.cycles-pp.f2fs_wait_on_page_writeback.part.31.f2fs_wait_on_page_writeback.wait_on_node_pages_writeback.f2fs_do_sync_file.f2fs_sync_file
>       1.14 .  3%     -41.6%       0.67 . 35%  perf-profile.cycles-pp.f2fs_wait_on_page_writeback.wait_on_node_pages_writeback.f2fs_do_sync_file.f2fs_sync_file.vfs_fsync_range
>       5.46 .  7%     -27.3%       3.97 . 34%  perf-profile.cycles-pp.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range
>       4.81 .  8%     -25.6%       3.57 . 34%  perf-profile.cycles-pp.f2fs_write_data_page.f2fs_write_cache_pages.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range
>       6.86 .  7%     -30.4%       4.77 . 33%  perf-profile.cycles-pp.f2fs_write_data_pages.do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file
>       3.38 .  6%     -45.1%       1.85 . 34%  perf-profile.cycles-pp.f2fs_write_end_io.bio_endio.blk_update_request.blk_mq_end_request.nvme_complete_rq
>       0.92 .  9%     -87.6%       0.11 .201%  perf-profile.cycles-pp.filemap_fdatawait_range.filemap_write_and_wait_range.f2fs_do_sync_file.f2fs_sync_file.vfs_fsync_range
>       8.18 .  7%     -35.5%       5.27 . 34%  perf-profile.cycles-pp.filemap_write_and_wait_range.f2fs_do_sync_file.f2fs_sync_file.vfs_fsync_range.do_fsync
>       1.28 .  4%     -65.3%       0.45 . 66%  perf-profile.cycles-pp.find_data_page.find_in_level.f2fs_find_entry.f2fs_lookup.path_openat
>       7.80 .  8%     -52.1%       3.74 . 34%  perf-profile.cycles-pp.find_in_level.f2fs_find_entry.f2fs_lookup.path_openat.do_filp_open
>       4.86 .  9%     -51.2%       2.37 . 35%  perf-profile.cycles-pp.find_target_dentry.find_in_level.f2fs_find_entry.f2fs_lookup.path_openat
>       1.80 .  9%     -43.4%       1.02 . 33%  perf-profile.cycles-pp.generic_perform_write.__generic_file_write_iter.f2fs_file_write_iter.__vfs_write.vfs_write
>       4.05 .  6%     -44.1%       2.26 . 34%  perf-profile.cycles-pp.handle_edge_irq.handle_irq.do_IRQ.ret_from_intr.cpuidle_enter
>       4.08 .  6%     -43.9%       2.29 . 34%  perf-profile.cycles-pp.handle_irq.do_IRQ.ret_from_intr.cpuidle_enter.call_cpuidle
>       3.92 .  5%     -44.0%       2.20 . 34%  perf-profile.cycles-pp.handle_irq_event.handle_edge_irq.handle_irq.do_IRQ.ret_from_intr
>       3.92 .  5%     -44.2%       2.19 . 34%  perf-profile.cycles-pp.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.handle_irq.do_IRQ
>       1.57 .  9%     -43.7%       0.88 . 35%  perf-profile.cycles-pp.kthread.ret_from_fork
>       1.87 .  9%     -40.5%       1.11 . 34%  perf-profile.cycles-pp.memset_erms.__alloc_percpu_gfp.__percpu_counter_init.f2fs_alloc_inode.alloc_inode
>       4.10 .  8%     -42.4%       2.36 . 34%  perf-profile.cycles-pp.new_inode.f2fs_new_inode.f2fs_create.path_openat.do_filp_open
>       4.05 .  8%     -42.4%       2.33 . 34%  perf-profile.cycles-pp.new_inode_pseudo.new_inode.f2fs_new_inode.f2fs_create.path_openat
>       3.70 .  5%     -44.6%       2.05 . 34%  perf-profile.cycles-pp.nvme_complete_rq.__blk_mq_complete_request.blk_mq_complete_request.__nvme_process_cq.nvme_irq
>       3.83 .  5%     -44.3%       2.14 . 34%  perf-profile.cycles-pp.nvme_irq.handle_irq_event_percpu.handle_irq_event.handle_edge_irq.handle_irq
>      20.41 .  6%     -21.0%      16.12 . 34%  perf-profile.cycles-pp.path_openat.do_filp_open.do_sys_open.sys_open.entry_SYSCALL_64_fastpath
>       1.51 . 10%     -43.7%       0.85 . 34%  perf-profile.cycles-pp.pcpu_alloc.__alloc_percpu_gfp.__percpu_counter_init.f2fs_alloc_inode.alloc_inode
>       1.24 . 10%     -46.7%       0.66 . 36%  perf-profile.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
>       1.57 .  9%     -43.7%       0.88 . 35%  perf-profile.cycles-pp.ret_from_fork
>       4.22 .  6%     -42.9%       2.41 . 34%  perf-profile.cycles-pp.ret_from_intr.cpuidle_enter.call_cpuidle.cpu_startup_entry.start_secondary
>      20.66 .  5%     -21.3%      16.27 . 34%  perf-profile.cycles-pp.sys_open.entry_SYSCALL_64_fastpath
>       2.93 .  7%     -40.9%       1.73 . 34%  perf-profile.cycles-pp.sys_write.entry_SYSCALL_64_fastpath
>       2.82 .  6%     -45.2%       1.55 . 34%  perf-profile.cycles-pp.try_to_wake_up.default_wake_function.autoremove_wake_function.wake_bit_function.__wake_up_common
>       2.64 .  6%     -44.9%       1.45 . 34%  perf-profile.cycles-pp.ttwu_do_activate.try_to_wake_up.default_wake_function.autoremove_wake_function.wake_bit_function
>       2.88 .  7%     -41.2%       1.69 . 34%  perf-profile.cycles-pp.vfs_write.sys_write.entry_SYSCALL_64_fastpath
>       1.43 .  3%     -43.0%       0.82 . 34%  perf-profile.cycles-pp.wait_on_node_pages_writeback.f2fs_do_sync_file.f2fs_sync_file.vfs_fsync_range.do_fsync
>       2.86 .  6%     -45.2%       1.57 . 34%  perf-profile.cycles-pp.wake_bit_function.__wake_up_common.__wake_up.__wake_up_bit.end_page_writeback
>       1.05 . 10%     -51.3%       0.51 . 51%  perf-profile.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
>       1.05 . 10%     -51.3%       0.51 . 51%  perf-profile.cycles-pp.wb_writeback.wb_workfn.process_one_work.worker_thread.kthread
>       1.25 . 10%     -46.7%       0.66 . 36%  perf-profile.cycles-pp.worker_thread.kthread.ret_from_fork
>       0.94 . 11%     -62.2%       0.36 . 81%  perf-profile.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_workfn.process_one_work
>      12602 . 10%    +605.7%      88933 .  4%  latency_stats.avg.f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range
>     117.20 . 38%  +14638.0%      17272 . 10%  latency_stats.avg.f2fs_sync_fs.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%       6536 . 74%  latency_stats.avg.rcu_sync_enter.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>     110089 .  5%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.get_node_info.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     123952 .  2%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>      10543 .  6%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.get_node_info.[f2fs].write_data_page.[f2fs].do_write_data_page.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_fdatawrite.sync_dirty_inodes.[f2fs].write_checkpoint.[f2fs]
>     417255 .  1%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.get_node_info.[f2fs].write_data_page.[f2fs].do_write_data_page.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs]
>      96289 .  4%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.is_checkpointed_node.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     116316 .  5%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.need_dentry_mark.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>      96158 .  3%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_read_failed.need_inode_block_update.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%    1238583 .  1%  latency_stats.hits.call_rwsem_down_read_failed.percpu_down_read.get_node_info.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%    2911068 .  7%  latency_stats.hits.call_rwsem_down_read_failed.percpu_down_read.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%    6208007 .  2%  latency_stats.hits.call_rwsem_down_read_failed.percpu_down_read.get_node_info.[f2fs].write_data_page.[f2fs].do_write_data_page.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>       0.00 . -1%      +Inf%    2257817 . 10%  latency_stats.hits.call_rwsem_down_read_failed.percpu_down_read.is_checkpointed_node.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%    2727789 .  1%  latency_stats.hits.call_rwsem_down_read_failed.percpu_down_read.need_dentry_mark.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%    2227301 .  2%  latency_stats.hits.call_rwsem_down_read_failed.percpu_down_read.need_inode_block_update.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>      12787 .  9%     -83.0%       2177 .  9%  latency_stats.hits.call_rwsem_down_write_failed.__f2fs_submit_merged_bio.[f2fs].f2fs_submit_merged_bio_cond.[f2fs].f2fs_wait_on_page_writeback.[f2fs].f2fs_wait_on_page_writeback.[f2fs].wait_on_node_pages_writeback.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     140416 .  3%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_write_failed.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>       0.00 . -1%      +Inf%    2617435 .  9%  latency_stats.hits.call_rwsem_down_write_failed.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%    2581381 .  1%  latency_stats.hits.call_rwsem_down_write_failed.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%    5283128 .  3%  latency_stats.hits.call_rwsem_down_write_failed.percpu_down_write.set_node_addr.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>     193673 .  4%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_write_failed.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     271526 .  3%    -100.0%       0.00 . -1%  latency_stats.hits.call_rwsem_down_write_failed.set_node_addr.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>       0.00 . -1%      +Inf%      11445 . 20%  latency_stats.hits.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>       0.00 . -1%      +Inf%      24410 . 15%  latency_stats.hits.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      26517 .  9%  latency_stats.hits.percpu_down_write.set_node_addr.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>      54803 .  8%    -100.0%       0.00 . -1%  latency_stats.max.call_rwsem_down_read_failed.f2fs_new_inode.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       7982 . 76%    -100.0%       0.00 . -1%  latency_stats.max.call_rwsem_down_read_failed.f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync
>       0.00 . -1%      +Inf%       9196 . 32%  latency_stats.max.call_rwsem_down_read_failed.percpu_down_read.f2fs_new_inode.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      15634 .151%  latency_stats.max.call_rwsem_down_read_failed.percpu_down_read.f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync
>       5996 . 54%    -100.0%       0.00 . -1%  latency_stats.max.call_rwsem_down_write_failed.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>      18794 . 50%     -99.8%      38.20 . 36%  latency_stats.max.call_rwsem_down_write_failed.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>      25320 . 17%     -99.9%      18.30 . 42%  latency_stats.max.call_rwsem_down_write_failed.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>     352.80 . 66%  +25704.3%      91037 .  7%  latency_stats.max.f2fs_sync_fs.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      20403 .131%  latency_stats.max.percpu_down_write.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      11786 . 39%  latency_stats.max.percpu_down_write.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>       0.00 . -1%      +Inf%      18121 .153%  latency_stats.max.rcu_sync_enter.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%      23677 . 90%  latency_stats.max.rcu_sync_enter.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].sync_node_pages.[f2fs].write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open
>       0.00 . -1%      +Inf%      14660 . 34%  latency_stats.max.rcu_sync_enter.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].sync_node_pages.[f2fs].write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs]
>       0.00 . -1%      +Inf%      16700 .162%  latency_stats.max.rcu_sync_enter.percpu_down_write.try_to_free_nats.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>      51205 . 11%     -80.7%       9868 . 29%  latency_stats.max.wait_on_page_bit.f2fs_wait_on_page_writeback.[f2fs].f2fs_wait_on_page_writeback.[f2fs].wait_on_node_pages_writeback.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     123642 . 26%    -100.0%       0.00 . -1%  latency_stats.sum.bt_get.blk_mq_get_tag.__blk_mq_alloc_request.blk_mq_map_request.blk_mq_make_request.generic_make_request.submit_bio.__submit_merged_bio.[f2fs].f2fs_submit_page_mbio.[f2fs].write_meta_page.[f2fs].f2fs_write_meta_page.[f2fs].sync_meta_pages.[f2fs]
>      19533 . 10%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.build_free_nids.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>     145779 . 11%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.build_free_nids.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs]
>      23239 . 49%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.f2fs_convert_inline_inode.[f2fs].f2fs_preallocate_blocks.[f2fs].f2fs_file_write_iter.[f2fs].__vfs_write.vfs_write.SyS_write.entry_SYSCALL_64_fastpath
>      15290 . 17%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>    6123697 .  6%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.f2fs_new_inode.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>      34789 . 22%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync
>     472390 .  4%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.get_node_info.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>    1526265 .  5%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>      66045 .  6%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.get_node_info.[f2fs].write_data_page.[f2fs].do_write_data_page.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_fdatawrite.sync_dirty_inodes.[f2fs].write_checkpoint.[f2fs]
>    2547237 .  2%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.get_node_info.[f2fs].write_data_page.[f2fs].do_write_data_page.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs]
>    1181887 .  2%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.is_checkpointed_node.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     879407 .  2%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.need_dentry_mark.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     658290 .  3%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_read_failed.need_inode_block_update.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      56722 .  8%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.build_free_nids.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%     201027 .  7%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.build_free_nids.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>       0.00 . -1%      +Inf%       7958 . 50%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      73190 . 11%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.f2fs_new_inode.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      47053 . 52%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync
>       0.00 . -1%      +Inf%   11815766 .  5%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.get_node_info.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%   21331651 . 17%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%   48966334 . 11%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.get_node_info.[f2fs].write_data_page.[f2fs].do_write_data_page.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>       0.00 . -1%      +Inf%   17894265 . 10%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.is_checkpointed_node.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%   18580100 .  4%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.need_dentry_mark.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%   27464359 .  6%  latency_stats.sum.call_rwsem_down_read_failed.percpu_down_read.need_inode_block_update.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>      22780 .  8%     -84.5%       3539 . 10%  latency_stats.sum.call_rwsem_down_write_failed.__f2fs_submit_merged_bio.[f2fs].f2fs_submit_merged_bio_cond.[f2fs].f2fs_wait_on_page_writeback.[f2fs].f2fs_wait_on_page_writeback.[f2fs].wait_on_node_pages_writeback.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>     965007 .  5%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_write_failed.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>       0.00 . -1%      +Inf%    7963263 . 15%  latency_stats.sum.call_rwsem_down_write_failed.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%    7766380 .  4%  latency_stats.sum.call_rwsem_down_write_failed.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%   22993263 . 10%  latency_stats.sum.call_rwsem_down_write_failed.percpu_down_write.set_node_addr.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%      24094 . 11%  latency_stats.sum.call_rwsem_down_write_failed.percpu_down_write.try_to_free_nats.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      96995 .  6%  latency_stats.sum.call_rwsem_down_write_failed.percpu_down_write.try_to_free_nats.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>    1230935 .  4%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_write_failed.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>    1133345 .  5%    -100.0%       0.00 . -1%  latency_stats.sum.call_rwsem_down_write_failed.set_node_addr.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>      59569 . 41%     -99.4%     369.80 . 18%  latency_stats.sum.call_rwsem_down_write_failed.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>     231014 . 22%    -100.0%     103.90 . 39%  latency_stats.sum.call_rwsem_down_write_failed.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>    4537935 . 27%    +306.3%   18436209 .  6%  latency_stats.sum.f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>    1473434 . 17%    +530.5%    9289385 . 11%  latency_stats.sum.f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range
>       1018 . 52%  +80360.5%     819812 . 11%  latency_stats.sum.f2fs_sync_fs.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%     517363 .  5%  latency_stats.sum.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>       0.00 . -1%      +Inf%     890753 .  3%  latency_stats.sum.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].fsync_node_pages.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%     258657 . 10%  latency_stats.sum.percpu_down_write.set_node_addr.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open
>       0.00 . -1%      +Inf%      70546 . 50%  latency_stats.sum.percpu_down_write.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       0.00 . -1%      +Inf%      65607 . 25%  latency_stats.sum.percpu_down_write.write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>       0.00 . -1%      +Inf%      50572 . 81%  latency_stats.sum.rcu_sync_enter.percpu_down_write.get_node_info.[f2fs].new_node_page.[f2fs].new_inode_page.[f2fs].init_inode_metadata.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open
>       0.00 . -1%      +Inf%     123301 . 26%  latency_stats.sum.rcu_sync_enter.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].sync_node_pages.[f2fs].write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open
>       0.00 . -1%      +Inf%     110076 . 10%  latency_stats.sum.rcu_sync_enter.percpu_down_write.set_node_addr.[f2fs].f2fs_write_node_page.[f2fs].sync_node_pages.[f2fs].write_checkpoint.[f2fs].f2fs_sync_fs.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs]
>       0.00 . -1%      +Inf%      52574 . 79%  latency_stats.sum.rcu_sync_enter.percpu_down_write.try_to_free_nats.[f2fs].f2fs_balance_fs_bg.[f2fs].f2fs_balance_fs.[f2fs].f2fs_write_data_page.[f2fs].f2fs_write_cache_pages.[f2fs].f2fs_write_data_pages.[f2fs].do_writepages.__filemap_fdatawrite_range.filemap_write_and_wait_range.f2fs_do_sync_file.[f2fs]
>     689963 . 22%     -98.9%       7538 .238%  latency_stats.sum.wait_on_page_bit.f2fs_wait_on_page_writeback.[f2fs].f2fs_wait_on_page_writeback.[f2fs].f2fs_add_regular_entry.[f2fs].__f2fs_add_link.[f2fs].f2fs_create.[f2fs].path_openat.do_filp_open.do_sys_open.SyS_open.entry_SYSCALL_64_fastpath
>       9358 . 44%     -95.3%     441.00 . 39%  latency_stats.sum.wait_on_page_bit.f2fs_wait_on_page_writeback.[f2fs].f2fs_wait_on_page_writeback.[f2fs].update_inode.[f2fs].update_inode_page.[f2fs].f2fs_write_inode.[f2fs].f2fs_do_sync_file.[f2fs].f2fs_sync_file.[f2fs].vfs_fsync_range.do_fsync.SyS_fsync.entry_SYSCALL_64_fastpath
>
>
>
>
>                               fsmark.time.system_time
>
>   1800 ++-------------------------------------------------------------------+
>        |                            O                                       |
>   1600 OOO OOOOOO OOOOOO OOOOOO OOOO O OOOOOO OOOOOO  OOOOO OOOOOO O        |
>   1400 ++                                                                   |
>        |                                                                    |
>   1200 ***.**                      * *.*** **.******.*   *                  |
>   1000 ++    ****.******.******.*** *     *           *** *.******.******.***
>        |                                                                    |
>    800 ++                                                                   |
>    600 ++                                                                   |
>        |                                                                    |
>    400 ++                                                                   |
>    200 ++                                                                   |
>        |                                                                    |
>      0 ++--------------------------------------------O----------------------+
>
>
>                              fsmark.time.elapsed_time
>
>   600 ++--------------------------------------------------------------------+
>       |                                                                     |
>   500 OOO OOOOOO OOOOO OOOOO OOOOOO OOOOO  OOOO  O O O OOOO   OO O O        |
>       |                                   O     O O        O O  O           |
>       |                                                                     |
>   400 ++                          *              *       *                  |
>       ***.******.*****.*****.***** + ****. ****.* ****.** **.*****. *** *.  *
>   300 ++                            *     *                        *   *  **|
>       |                                                                     |
>   200 ++                                                                    |
>       |                                                                     |
>       |                                                                     |
>   100 ++                                                                    |
>       |                                                                     |
>     0 ++--------------------------------------------O-----------------------+
>
>
>                            fsmark.time.elapsed_time.max
>
>   600 ++--------------------------------------------------------------------+
>       |                                                                     |
>   500 OOO OOOOOO OOOOO OOOOO OOOOOO OOOOO  OOOO  O O O OOOO   OO O O        |
>       |                                   O     O O        O O  O           |
>       |                                                                     |
>   400 ++                          *              *       *                  |
>       ***.******.*****.*****.***** + ****. ****.* ****.** **.*****. *** *.  *
>   300 ++                            *     *                        *   *  **|
>       |                                                                     |
>   200 ++                                                                    |
>       |                                                                     |
>       |                                                                     |
>   100 ++                                                                    |
>       |                                                                     |
>     0 ++--------------------------------------------O-----------------------+
>
>
>                        fsmark.time.voluntary_context_switches
>
>   6e+07 ++------------------------------------------------------------------+
>         |                                                                   |
>   5e+07 O+       OO   O   O O   OO O  OO O  OO O O    OO  O       OO        |
>         |OOO OOOO   OO OOO   OOO    OO  O  O  O O  OO   O  OOOOOO           |
>         |                                                                   |
>   4e+07 ++                                                                  |
>         |                                                                   |
>   3e+07 ++                                                                  |
>         |     *****.*******.******.**                 ***.*******.          |
>   2e+07 ****.*                       *****.*******.***            ******.****
>         |                                                                   |
>         |                                                                   |
>   1e+07 ++                                                                  |
>         |                                                                   |
>       0 ++-------------------------------------------O----------------------+
>
>
>
>
>                                 fsmark.files_per_sec
>
>   35000 ++------------------------------------------------------------------+
>         |                                                                   |
>   30000 ++    * *                    **   .**                    .******.****
>         ****.* * **.*******.******.**  ***   **** .******. ******           |
>   25000 ++                                       *        *                 |
>         |                                                                   |
>   20000 O+OO O      OO  O               O  O  O O  OO   O   OOOOO           |
>         |O    OOOOO   OO OO OOOOOO OOOOO O  OO O O    OO  OO      OO        |
>   15000 ++                                                                  |
>         |                                                                   |
>   10000 ++                                                                  |
>         |                                                                   |
>    5000 ++                                                                  |
>         |                                                                   |
>       0 ++-------------------------------------------O----------------------+
>
> 	[*] bisect-good sample
> 	[O] bisect-bad  sample
>
>
>
>
>
> Thanks,
> Xiaolong
>
>
>
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
