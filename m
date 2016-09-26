From: "Huang\, Ying" <ying.huang@linux.intel.com>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec
	-36.3% regression
Date: Mon, 26 Sep 2016 14:26:06 +0800
Message-ID: <87fuoni3cx.fsf@yhuang-dev.intel.com>
References: <87bn18cvuu.fsf_-_@yhuang-mobile.sh.intel.com>
	<20160804172452.GA12093@jaegeuk>
	<874m70ctu3.fsf@yhuang-mobile.sh.intel.com>
	<20160804185251.GA13813@jaegeuk>
	<87r3a4b7b6.fsf@yhuang-mobile.sh.intel.com>
	<87vaz6yl8a.fsf@yhuang-mobile.sh.intel.com>
	<20160812012238.GA47037@jaegeuk>
	<CAC=cRTNtND+5f83p_yBecnx0iB5_6Q6xzbHdeY0tgrVaMRLSRQ@mail.gmail.com>
	<20160827005257.GD88444@jaegeuk>
	<20160827021334.eb3xpz57xvo37g5l@wfg-t540p.sh.intel.com>
	<20160830023048.GA2088@jaegeuk>
	<87pooqnr4t.fsf@yhuang-mobile.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@linux.intel.com>) id 1boPMm-0004O5-0G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 06:26:16 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1boPMk-0008R9-P9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 06:26:15 +0000
In-Reply-To: <87pooqnr4t.fsf@yhuang-mobile.sh.intel.com> (Ying Huang's message
	of "Tue, 30 Aug 2016 09:44:18 -0700")
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Huang, Ying" <ying.huang@intel.com>
Cc: LKP ML <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, huang ying <huang.ying.caritas@gmail.com>

Hi, Jaegeuk,

"Huang, Ying" <ying.huang@intel.com> writes:

> Jaegeuk Kim <jaegeuk@kernel.org> writes:
>
>> Hello,
>>
>> On Sat, Aug 27, 2016 at 10:13:34AM +0800, Fengguang Wu wrote:
>>> Hi Jaegeuk,
>>> 
>>> > > >> > - [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
>>> > > >> >
>>> > > >> > The disk is 4 12G ram disk, and setup RAID0 on them via mdadm.  The
>>> > > >> > steps for aim7 is,
>>> > > >> >
>>> > > >> > cat > workfile <<EOF
>>> > > >> > FILESIZE: 1M
>>> > > >> > POOLSIZE: 10M
>>> > > >> > 10 sync_disk_rw
>>> > > >> > EOF
>>> > > >> >
>>> > > >> > (
>>> > > >> >     echo $HOSTNAME
>>> > > >> >     echo sync_disk_rw
>>> > > >> >
>>> > > >> >     echo 1
>>> > > >> >     echo 600
>>> > > >> >     echo 2
>>> > > >> >     echo 600
>>> > > >> >     echo 1
>>> > > >> > ) | ./multitask -t &
>>> > > >>
>>> > > >> Any update on these 2 regressions?  Is the information is enough for you
>>> > > >> to reproduce?
>>> > > >
>>> > > > Sorry, I've had no time to dig this due to business travel now.
>>> > > > I'll check that when back to US.
>>> > > 
>>> > > Any update?
>>> > 
>>> > Sorry, how can I get multitask binary?
>>> 
>>> It's part of aim7, which can be downloaded here:
>>> 
>>> http://nchc.dl.sourceforge.net/project/aimbench/aim-suite7/Initial%20release/s7110.tar.Z
>>
>> Thank you for the codes.
>>
>> I've run this workload on the latest f2fs and compared performance having
>> without the reported patch. (1TB nvme SSD, 16 cores, 16GB DRAM)
>> Interestingly, I could find slight performance improvement rather than
>> regression. :(
>> Not sure how to reproduce this.
>
> I think the difference lies on disk used.  The ramdisk is used in the
> original test, but it appears that your memory is too small to setup the
> RAM disk for test.  So it may be impossible for you to reproduce the
> test unless you can find more memory :)
>
> But we can help you to root cause the issue.  What additional data do
> you want?  perf-profile data before and after the patch?

Any update to this regression?

Best Regards,
Huang, Ying

------------------------------------------------------------------------------
