From: "Huang\, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec -36.3% regression
Date: Tue, 27 Sep 2016 08:50:02 +0800
Message-ID: <8760pii2th.fsf@yhuang-dev.intel.com>
References: <20160804185251.GA13813@jaegeuk>
        <87r3a4b7b6.fsf@yhuang-mobile.sh.intel.com>
        <87vaz6yl8a.fsf@yhuang-mobile.sh.intel.com>
        <20160812012238.GA47037@jaegeuk>
        <CAC=cRTNtND+5f83p_yBecnx0iB5_6Q6xzbHdeY0tgrVaMRLSRQ@mail.gmail.com>
        <20160827005257.GD88444@jaegeuk>
        <20160827021334.eb3xpz57xvo37g5l@wfg-t540p.sh.intel.com>
        <20160830023048.GA2088@jaegeuk>
        <87pooqnr4t.fsf@yhuang-mobile.sh.intel.com>
        <87fuoni3cx.fsf@yhuang-dev.intel.com> <20160926182353.GA33149@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160926182353.GA33149@jaegeuk> (Jaegeuk Kim's message of "Mon,
        26 Sep 2016 11:23:53 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, LKP ML <lkp@01.org>, huang ying <huang.ying.caritas@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Jaegeuk Kim <jaegeuk@kernel.org> writes:

> On Mon, Sep 26, 2016 at 02:26:06PM +0800, Huang, Ying wrote:
>> Hi, Jaegeuk,
>> 
>> "Huang, Ying" <ying.huang@intel.com> writes:
>> 
>> > Jaegeuk Kim <jaegeuk@kernel.org> writes:
>> >
>> >> Hello,
>> >>
>> >> On Sat, Aug 27, 2016 at 10:13:34AM +0800, Fengguang Wu wrote:
>> >>> Hi Jaegeuk,
>> >>> 
>> >>> > > >> > - [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
>> >>> > > >> >
>> >>> > > >> > The disk is 4 12G ram disk, and setup RAID0 on them via mdadm.  The
>> >>> > > >> > steps for aim7 is,
>> >>> > > >> >
>> >>> > > >> > cat > workfile <<EOF
>> >>> > > >> > FILESIZE: 1M
>> >>> > > >> > POOLSIZE: 10M
>> >>> > > >> > 10 sync_disk_rw
>> >>> > > >> > EOF
>> >>> > > >> >
>> >>> > > >> > (
>> >>> > > >> >     echo $HOSTNAME
>> >>> > > >> >     echo sync_disk_rw
>> >>> > > >> >
>> >>> > > >> >     echo 1
>> >>> > > >> >     echo 600
>> >>> > > >> >     echo 2
>> >>> > > >> >     echo 600
>> >>> > > >> >     echo 1
>> >>> > > >> > ) | ./multitask -t &
>> >>> > > >>
>> >>> > > >> Any update on these 2 regressions?  Is the information is enough for you
>> >>> > > >> to reproduce?
>> >>> > > >
>> >>> > > > Sorry, I've had no time to dig this due to business travel now.
>> >>> > > > I'll check that when back to US.
>> >>> > > 
>> >>> > > Any update?
>> >>> > 
>> >>> > Sorry, how can I get multitask binary?
>> >>> 
>> >>> It's part of aim7, which can be downloaded here:
>> >>> 
>> >>> http://nchc.dl.sourceforge.net/project/aimbench/aim-suite7/Initial%20release/s7110.tar.Z
>> >>
>> >> Thank you for the codes.
>> >>
>> >> I've run this workload on the latest f2fs and compared performance having
>> >> without the reported patch. (1TB nvme SSD, 16 cores, 16GB DRAM)
>> >> Interestingly, I could find slight performance improvement rather than
>> >> regression. :(
>> >> Not sure how to reproduce this.
>> >
>> > I think the difference lies on disk used.  The ramdisk is used in the
>> > original test, but it appears that your memory is too small to setup the
>> > RAM disk for test.  So it may be impossible for you to reproduce the
>> > test unless you can find more memory :)
>> >
>> > But we can help you to root cause the issue.  What additional data do
>> > you want?  perf-profile data before and after the patch?
>> 
>> Any update to this regression?
>
> Sorry, no. But meanwhile, I've purchased more DRAMs. :)
> Now I'm with 128GB DRAM. I can configure 64GB as pmem.
> Is it worth to try the test again?

I think you are the decision maker for this.  You can judge whether the
test is reasonable.  And we can adjust our test accordingly.

BTW: For this test, we use brd ram disk and raid to test.

Best Regards,
Huang, Ying
