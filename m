From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec
	-36.3% regression
Date: Wed, 24 Aug 2016 09:51:11 -0700
Message-ID: <CAC=cRTNtND+5f83p_yBecnx0iB5_6Q6xzbHdeY0tgrVaMRLSRQ@mail.gmail.com>
References: <20160718020950.GB4986@yexl-desktop>
	<87twfmsndf.fsf@yhuang-mobile.sh.intel.com>
	<87bn18cvuu.fsf_-_@yhuang-mobile.sh.intel.com>
	<20160804172452.GA12093@jaegeuk>
	<874m70ctu3.fsf@yhuang-mobile.sh.intel.com>
	<20160804185251.GA13813@jaegeuk>
	<87r3a4b7b6.fsf@yhuang-mobile.sh.intel.com>
	<87vaz6yl8a.fsf@yhuang-mobile.sh.intel.com>
	<20160812012238.GA47037@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huang.ying.caritas@gmail.com>) id 1bcbOY-0003UB-HU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Aug 2016 16:51:18 +0000
Received: from mail-qk0-f194.google.com ([209.85.220.194])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bcbOX-0000QS-Q7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 24 Aug 2016 16:51:18 +0000
Received: by mail-qk0-f194.google.com with SMTP id n66so1580606qkf.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 24 Aug 2016 09:51:17 -0700 (PDT)
In-Reply-To: <20160812012238.GA47037@jaegeuk>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, LKP ML <lkp@01.org>, kernel test robot <xiaolong.ye@intel.com>, "Huang, Ying" <ying.huang@intel.com>

Hi, Jaegeuk,

On Thu, Aug 11, 2016 at 6:22 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> On Thu, Aug 11, 2016 at 03:49:41PM -0700, Huang, Ying wrote:
>> Hi, Kim,
>>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>> >>
>> >> [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
>> >> [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
>> >>
>> >> In terms of the above regression, I could check that _reproduce_ procedure
>> >> includes mounting filesystem only. Is that correct?
>> >
>> > Sorry, our test system failed to generate reproduce steps for aim7.  We
>> > will implement it.
>> >
>> > - [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
>> >
>> > The disk is one 48G ram disk.  The steps for aim7 is,
>> >
>> > cat > workfile <<EOF
>> > FILESIZE: 1M
>> > POOLSIZE: 10M
>> > 10 disk_cp
>> > EOF
>> >
>> > (
>> >     echo $HOSTNAME
>> >     echo disk_cp
>> >
>> >     echo 1
>> >     echo 3000
>> >     echo 2
>> >     echo 3000
>> >     echo 1
>> > ) | ./multitask -t &
>> >
>> >
>> > - [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
>> >
>> > The disk is 4 12G ram disk, and setup RAID0 on them via mdadm.  The
>> > steps for aim7 is,
>> >
>> > cat > workfile <<EOF
>> > FILESIZE: 1M
>> > POOLSIZE: 10M
>> > 10 sync_disk_rw
>> > EOF
>> >
>> > (
>> >     echo $HOSTNAME
>> >     echo sync_disk_rw
>> >
>> >     echo 1
>> >     echo 600
>> >     echo 2
>> >     echo 600
>> >     echo 1
>> > ) | ./multitask -t &
>>
>> Any update on these 2 regressions?  Is the information is enough for you
>> to reproduce?
>
> Sorry, I've had no time to dig this due to business travel now.
> I'll check that when back to US.

Any update?

Best Regards,
Huang, Ying

------------------------------------------------------------------------------
