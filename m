From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec
	-36.3% regression
Date: Thu, 04 Aug 2016 13:36:13 -0700
Message-ID: <87r3a4b7b6.fsf@yhuang-mobile.sh.intel.com>
References: <20160718020950.GB4986@yexl-desktop>
	<87twfmsndf.fsf@yhuang-mobile.sh.intel.com>
	<87bn18cvuu.fsf_-_@yhuang-mobile.sh.intel.com>
	<20160804172452.GA12093@jaegeuk>
	<874m70ctu3.fsf@yhuang-mobile.sh.intel.com>
	<20160804185251.GA13813@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1bVPNM-0002FQ-Kl
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Aug 2016 20:36:20 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bVPNL-0003QC-H7 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Aug 2016 20:36:20 +0000
In-Reply-To: <20160804185251.GA13813@jaegeuk> (Jaegeuk Kim's message of "Thu,
	4 Aug 2016 11:52:51 -0700")
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, lkp@01.org, kernel test robot <xiaolong.ye@intel.com>, "Huang,
	Ying" <ying.huang@intel.com>

Jaegeuk Kim <jaegeuk@kernel.org> writes:

> On Thu, Aug 04, 2016 at 10:44:20AM -0700, Huang, Ying wrote:
>> Jaegeuk Kim <jaegeuk@kernel.org> writes:
>> 
>> > Hi Huang,
>> >
>> > On Thu, Aug 04, 2016 at 10:00:41AM -0700, Huang, Ying wrote:
>> >> Hi, Jaegeuk,
>> >> 
>> >> "Huang, Ying" <ying.huang@intel.com> writes:
>> >> > Hi,
>> >> >
>> >> > I checked the comparison result below and found this is a regression for
>> >> > fsmark.files_per_sec, not fsmark.app_overhead.
>> >> >
>> >> > Best Regards,
>> >> > Huang, Ying
>> >> >
>> >> > kernel test robot <xiaolong.ye@intel.com> writes:
>> >> >
>> >> >> FYI, we noticed a -36.3% regression of fsmark.files_per_sec due to commit:
>> >> >>
>> >> >> commit ec795418c41850056feb956534edf059dc1155d4 ("f2fs: use percpu_rw_semaphore")
>> >> >> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
>> >> 
>> >> I found this has been merged by upstream.  Do you have some plan to fix
>> >> it?  Or you think the test itself has some problem?
>> >
>> > Sorry, too busy to take a look at this.
>> > The patch implements percpu_rw_semaphore which is intended to enhance FS
>> > scalability. Since I couldn't see any big regression in my test cases, could you
>> > check any debugging options which may give some overheads?
>> 
>> The kernel config related with F2FS is as follow in our test,
>> 
>> CONFIG_F2FS_FS=m
>> CONFIG_F2FS_STAT_FS=y
>> CONFIG_F2FS_FS_XATTR=y
>> CONFIG_F2FS_FS_POSIX_ACL=y
>> # CONFIG_F2FS_FS_SECURITY is not set
>> # CONFIG_F2FS_CHECK_FS is not set
>> # CONFIG_F2FS_FS_ENCRYPTION is not set
>> # CONFIG_F2FS_IO_TRACE is not set
>> # CONFIG_F2FS_FAULT_INJECTION is not set
>> 
>> What do you think we need to change?  Or do you mean some other
>> debugging options?  Anyway, you can check our kernel config attached.
>> 
>> > Let me recheck this with whole my tests.
>> 
>> Maybe you can try our kernel config?  Or if our kernel config is not
>> reasonable, can you help us to revise it?  The full kernel config we
>> used is attached with the email.
>
> I could reproduce the fsmark regression in my machine and confirm there is
> another small regression as well.
> I'll revert this patch. Thank you.
>
> [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
> [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
>
> In terms of the above regression, I could check that _reproduce_ procedure
> includes mounting filesystem only. Is that correct?

Sorry, our test system failed to generate reproduce steps for aim7.  We
will implement it.

- [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression

The disk is one 48G ram disk.  The steps for aim7 is,

cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 disk_cp
EOF

(
	echo $HOSTNAME
	echo disk_cp

	echo 1
	echo 3000
	echo 2
	echo 3000
	echo 1
) | ./multitask -t &


- [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression

The disk is 4 12G ram disk, and setup RAID0 on them via mdadm.  The
steps for aim7 is,

cat > workfile <<EOF
FILESIZE: 1M
POOLSIZE: 10M
10 sync_disk_rw
EOF

(
	echo $HOSTNAME
	echo sync_disk_rw

	echo 1
	echo 600
	echo 2
	echo 600
	echo 1
) | ./multitask -t &


Best Regards,
Huang, Ying

------------------------------------------------------------------------------
