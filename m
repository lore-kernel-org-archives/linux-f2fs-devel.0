From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec -36.3%
 regression
Date: Thu, 4 Aug 2016 11:52:51 -0700
Message-ID: <20160804185251.GA13813@jaegeuk>
References: <20160718020950.GB4986@yexl-desktop>
 <87twfmsndf.fsf@yhuang-mobile.sh.intel.com>
 <87bn18cvuu.fsf_-_@yhuang-mobile.sh.intel.com>
 <20160804172452.GA12093@jaegeuk>
 <874m70ctu3.fsf@yhuang-mobile.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874m70ctu3.fsf@yhuang-mobile.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: kernel test robot <xiaolong.ye@intel.com>, lkp@01.org, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Aug 04, 2016 at 10:44:20AM -0700, Huang, Ying wrote:
> Jaegeuk Kim <jaegeuk@kernel.org> writes:
> 
> > Hi Huang,
> >
> > On Thu, Aug 04, 2016 at 10:00:41AM -0700, Huang, Ying wrote:
> >> Hi, Jaegeuk,
> >> 
> >> "Huang, Ying" <ying.huang@intel.com> writes:
> >> > Hi,
> >> >
> >> > I checked the comparison result below and found this is a regression for
> >> > fsmark.files_per_sec, not fsmark.app_overhead.
> >> >
> >> > Best Regards,
> >> > Huang, Ying
> >> >
> >> > kernel test robot <xiaolong.ye@intel.com> writes:
> >> >
> >> >> FYI, we noticed a -36.3% regression of fsmark.files_per_sec due to commit:
> >> >>
> >> >> commit ec795418c41850056feb956534edf059dc1155d4 ("f2fs: use percpu_rw_semaphore")
> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> >> 
> >> I found this has been merged by upstream.  Do you have some plan to fix
> >> it?  Or you think the test itself has some problem?
> >
> > Sorry, too busy to take a look at this.
> > The patch implements percpu_rw_semaphore which is intended to enhance FS
> > scalability. Since I couldn't see any big regression in my test cases, could you
> > check any debugging options which may give some overheads?
> 
> The kernel config related with F2FS is as follow in our test,
> 
> CONFIG_F2FS_FS=m
> CONFIG_F2FS_STAT_FS=y
> CONFIG_F2FS_FS_XATTR=y
> CONFIG_F2FS_FS_POSIX_ACL=y
> # CONFIG_F2FS_FS_SECURITY is not set
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FS_ENCRYPTION is not set
> # CONFIG_F2FS_IO_TRACE is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> 
> What do you think we need to change?  Or do you mean some other
> debugging options?  Anyway, you can check our kernel config attached.
> 
> > Let me recheck this with whole my tests.
> 
> Maybe you can try our kernel config?  Or if our kernel config is not
> reasonable, can you help us to revise it?  The full kernel config we
> used is attached with the email.

I could reproduce the fsmark regression in my machine and confirm there is
another small regression as well.
I'll revert this patch. Thank you.

[lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
[lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression

In terms of the above regression, I could check that _reproduce_ procedure
includes mounting filesystem only. Is that correct?

Thanks,

> 
> Best Regards,
> Huang, Ying
> 
> > Thanks,
> >
> >> 
> >> We have another 2 regressions
> >> 
> >> - [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
> >> - [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
> >> 
> >> they are merged by upstream now too.  So same questions for them too.
> >> 
> >> Best Regards,
> >> Huang, Ying
> >> 
> >> >> in testcase: fsmark
> >> >> on test machine: 72 threads Haswell-EP with 128G memory
> >> >> with following parameters:
> >> > cpufreq_governor=performance/disk=1SSD/filesize=8K/fs=f2fs/iterations=8/nr_directories=16d/nr_files_per_directory=256fpd/nr_threads=4/sync_method=fsyncBeforeClose/test_size=72G
> >> >>
> >> >>
> >> >>
> >> >> Disclaimer:
> >> >> Results have been estimated based on internal Intel analysis and are provided
> >> >> for informational purposes only. Any difference in system hardware or software
> >> >> design or configuration may affect actual performance.
> >> >>
> 
