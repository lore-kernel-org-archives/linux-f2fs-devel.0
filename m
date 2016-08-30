From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec -36.3%
 regression
Date: Mon, 29 Aug 2016 19:30:48 -0700
Message-ID: <20160830023048.GA2088@jaegeuk>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160827021334.eb3xpz57xvo37g5l@wfg-t540p.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: huang ying <huang.ying.caritas@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, LKP ML <lkp@01.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

On Sat, Aug 27, 2016 at 10:13:34AM +0800, Fengguang Wu wrote:
> Hi Jaegeuk,
> 
> > > >> > - [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
> > > >> >
> > > >> > The disk is 4 12G ram disk, and setup RAID0 on them via mdadm.  The
> > > >> > steps for aim7 is,
> > > >> >
> > > >> > cat > workfile <<EOF
> > > >> > FILESIZE: 1M
> > > >> > POOLSIZE: 10M
> > > >> > 10 sync_disk_rw
> > > >> > EOF
> > > >> >
> > > >> > (
> > > >> >     echo $HOSTNAME
> > > >> >     echo sync_disk_rw
> > > >> >
> > > >> >     echo 1
> > > >> >     echo 600
> > > >> >     echo 2
> > > >> >     echo 600
> > > >> >     echo 1
> > > >> > ) | ./multitask -t &
> > > >>
> > > >> Any update on these 2 regressions?  Is the information is enough for you
> > > >> to reproduce?
> > > >
> > > > Sorry, I've had no time to dig this due to business travel now.
> > > > I'll check that when back to US.
> > > 
> > > Any update?
> > 
> > Sorry, how can I get multitask binary?
> 
> It's part of aim7, which can be downloaded here:
> 
> http://nchc.dl.sourceforge.net/project/aimbench/aim-suite7/Initial%20release/s7110.tar.Z

Thank you for the codes.

I've run this workload on the latest f2fs and compared performance having
without the reported patch. (1TB nvme SSD, 16 cores, 16GB DRAM)
Interestingly, I could find slight performance improvement rather than
regression. :(
Not sure how to reproduce this.

Thanks,
