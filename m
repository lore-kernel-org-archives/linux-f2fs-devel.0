From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [lkp-robot] [f2fs] 22588f8773:
	xfstests.generic.026.fail
Date: Fri, 31 Mar 2017 19:05:00 +0800
Message-ID: <bfc513a3-461f-0cf8-ed09-4e9495df1b00@huawei.com>
References: <20170330023933.GD15042@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ctuMv-0002SA-Ow
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Mar 2017 11:05:25 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ctuMs-0004JU-K2
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 31 Mar 2017 11:05:25 +0000
In-Reply-To: <20170330023933.GD15042@yexl-desktop>
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

Hi Xiaolong,

Thanks for the report, since this patch has changed xattr node block layout, it
expanded total xattr space, so this will make generic/026 being failed.

Till now, we are still testing this patch, anyway after next merge window, if
there is no issue found or reported, I will send a patch to fstest for fixing.

Thanks,

On 2017/3/30 10:39, kernel test robot wrote:
> 
> FYI, we noticed the following commit:
> 
> commit: 22588f8773f687449ce6e97dce9f102553440d30 ("f2fs: don't reserve additional space in xattr block")
> https://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git dev-test
> 
> in testcase: xfstests
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: f2fs
> 	test: generic-quick1
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-2500K CPU @ 3.30GHz with 6G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> 2017-03-30 02:02:12 export TEST_DIR=/fs/sda5
> 2017-03-30 02:02:12 export TEST_DEV=/dev/sda5
> 2017-03-30 02:02:12 export FSTYP=f2fs
> 2017-03-30 02:02:12 export SCRATCH_MNT=/fs/scratch
> 2017-03-30 02:02:12 mkdir /fs/scratch -p
> 2017-03-30 02:02:12 export SCRATCH_DEV=/dev/sda8
> 2017-03-30 02:02:12 ./check generic/001 generic/002 generic/003 generic/004 generic/005 generic/006 generic/007 generic/008 generic/009 generic/011 generic/012 generic/014 generic/015 generic/015 generic/016 generic/018 generic/020 generic/021 generic/022 generic/023 generic/024 generic/025 generic/026 generic/028 generic/029 generic/030 generic/031 generic/032 generic/033 generic/034 generic/035 generic/036 generic/037 generic/039 generic/040 generic/041 generic/042 generic/043 generic/044 generic/045 generic/046 generic/047 generic/048 generic/049 generic/050 generic/051 generic/052 generic/052 generic/053 generic/054 generic/054 generic/055 generic/055 generic/056 generic/057 generic/058 generic/059 generic/060 generic/061 generic/062 generic/064 generic/065 generic/066 generic/067 ge
 neric/069 generic/071 generic/072 generic/073 generic/077 generic/078 generic/079 generic/080 generic/082 generic/084 generic/085 generic/086 generic/087
> FSTYP         -- f2fs
> PLATFORM      -- Linux/x86_64 snb-drag 4.11.0-rc3-00077-g22588f8
> MKFS_OPTIONS  -- /dev/sda8
> MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda8 /fs/scratch
> 
> generic/001	 2s
> generic/002	 0s
> generic/003	 14s
> generic/004	 0s
> generic/005	 1s
> generic/006	 0s
> generic/007	 0s
> generic/008	 1s
> generic/009	 1s
> generic/011	 0s
> generic/012	 2s
> generic/014	 0s
> generic/015	 0s
> generic/016	 2s
> generic/018	 [not run] defragmentation not supported for fstype "f2fs"
> generic/020	 0s
> generic/021	 2s
> generic/022	 2s
> generic/023	 1s
> generic/024	 0s
> generic/025	 0s
> generic/026	 - output mismatch (see /lkp/benchmarks/xfstests/results//generic/026.out.bad)
>     --- tests/generic/026.out	2016-11-10 09:18:29.000000000 +0800
>     +++ /lkp/benchmarks/xfstests/results//generic/026.out.bad	2017-03-30 02:03:20.925483449 +0800
>     @@ -4,6 +4,6 @@
>      1 below acl max
>      acl max
>      1 above acl max
>     -chacl: cannot set access acl on "largeaclfile": Argument list too long
>     +Wrong ACL count - 532 != 531
>      use 16 aces
>      use 17 aces
>     ...
>     (Run 'diff -u tests/generic/026.out /lkp/benchmarks/xfstests/results//generic/026.out.bad'  to see the entire diff)
> generic/028	 5s
> generic/029	 3s
> generic/030	 3s
> generic/031	 2s
> generic/032	 35s
> generic/033	 2s
> generic/034	 2s
> generic/035	 1s
> generic/036	 11s
> generic/037	 4s
> generic/039	 3s
> generic/040	 5s
> generic/041	 6s
> generic/042	 [failed, exit status 1] - output mismatch (see /lkp/benchmarks/xfstests/results//generic/042.out.bad)
>     --- tests/generic/042.out	2016-11-10 09:18:29.000000000 +0800
>     +++ /lkp/benchmarks/xfstests/results//generic/042.out.bad	2017-03-30 02:05:16.444481154 +0800
>     @@ -1,10 +1 @@
>      QA output created by 042
>     -falloc -k
>     -wrote 65536/65536 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -fpunch
>     -wrote 65536/65536 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     ...
>     (Run 'diff -u tests/generic/042.out /lkp/benchmarks/xfstests/results//generic/042.out.bad'  to see the entire diff)
> generic/043	 16s
> generic/044	 17s
> generic/045	 17s
> generic/046	 16s
> generic/047	 46s
> generic/048	 104s
> generic/049	 10s
> generic/050	 5s
> generic/051	 97s
> generic/052	 5s
> generic/053	 5s
> generic/054	 111s
> generic/055	 60s
> generic/056	 3s
> generic/057	 2s
> generic/058	 3s
> generic/059	 3s
> generic/060	 2s
> generic/061	 2s
> generic/062	 3s
> generic/064	 5s
> generic/065	 3s
> generic/066	 - output mismatch (see /lkp/benchmarks/xfstests/results//generic/066.out.bad)
>     --- tests/generic/066.out	2016-11-10 09:18:29.000000000 +0800
>     +++ /lkp/benchmarks/xfstests/results//generic/066.out.bad	2017-03-30 02:14:51.353469734 +0800
>     @@ -6,5 +6,6 @@
>      
>      xattr names and values after second fsync log replay:
>      # file: SCRATCH_MNT/foobar
>     +user.attr1="val1"
>      user.attr3="val3"
>      
>     ...
>     (Run 'diff -u tests/generic/066.out /lkp/benchmarks/xfstests/results//generic/066.out.bad'  to see the entire diff)
> generic/067	 2s
> generic/069	 4s
> generic/071	 3s
> generic/072	 4s
> generic/073	 3s
> generic/077	 32s
> generic/078	 0s
> generic/079	 2s
> generic/080	 2s
> generic/082	 [not run] disk quotas not supported by this filesystem type: f2fs
> generic/084	 7s
> generic/085	 4s
> generic/086	 0s
> generic/087	 0s
> Ran: generic/001 generic/002 generic/003 generic/004 generic/005 generic/006 generic/007 generic/008 generic/009 generic/011 generic/012 generic/014 generic/015 generic/016 generic/020 generic/021 generic/022 generic/023 generic/024 generic/025 generic/026 generic/028 generic/029 generic/030 generic/031 generic/032 generic/033 generic/034 generic/035 generic/036 generic/037 generic/039 generic/040 generic/041 generic/042 generic/043 generic/044 generic/045 generic/046 generic/047 generic/048 generic/049 generic/050 generic/051 generic/052 generic/053 generic/054 generic/055 generic/056 generic/057 generic/058 generic/059 generic/060 generic/061 generic/062 generic/064 generic/065 generic/066 generic/067 generic/069 generic/071 generic/072 generic/073 generic/077 generic/078 generic/079 g
 eneric/080 generic/084 generic/085 generic/086 generic/087
> Not run: generic/018 generic/082
> Failures: generic/026 generic/042 generic/066
> Failed 3 of 71 tests
> 
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/01org/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Xiaolong
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
