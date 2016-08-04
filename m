From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec
	-36.3% regression
Date: Thu, 04 Aug 2016 10:00:41 -0700
Message-ID: <87bn18cvuu.fsf_-_@yhuang-mobile.sh.intel.com>
References: <20160718020950.GB4986@yexl-desktop>
	<87twfmsndf.fsf@yhuang-mobile.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1bVM0m-0004TD-AE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Aug 2016 17:00:48 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bVM0l-0004wG-Gm for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Aug 2016 17:00:48 +0000
In-Reply-To: <87twfmsndf.fsf@yhuang-mobile.sh.intel.com> (Ying Huang's message
	of "Mon, 18 Jul 2016 13:27:24 -0700")
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-f2fs-devel@lists.sourceforge.net, lkp@01.org, kernel test robot <xiaolong.ye@intel.com>, LKML <linux-kernel@vger.kernel.org>

Hi, Jaegeuk,

"Huang, Ying" <ying.huang@intel.com> writes:
> Hi,
>
> I checked the comparison result below and found this is a regression for
> fsmark.files_per_sec, not fsmark.app_overhead.
>
> Best Regards,
> Huang, Ying
>
> kernel test robot <xiaolong.ye@intel.com> writes:
>
>> FYI, we noticed a -36.3% regression of fsmark.files_per_sec due to commit:
>>
>> commit ec795418c41850056feb956534edf059dc1155d4 ("f2fs: use percpu_rw_semaphore")
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test

I found this has been merged by upstream.  Do you have some plan to fix
it?  Or you think the test itself has some problem?

We have another 2 regressions

- [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
- [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression

they are merged by upstream now too.  So same questions for them too.

Best Regards,
Huang, Ying

>> in testcase: fsmark
>> on test machine: 72 threads Haswell-EP with 128G memory
>> with following parameters:
> cpufreq_governor=performance/disk=1SSD/filesize=8K/fs=f2fs/iterations=8/nr_directories=16d/nr_files_per_directory=256fpd/nr_threads=4/sync_method=fsyncBeforeClose/test_size=72G
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>

------------------------------------------------------------------------------
