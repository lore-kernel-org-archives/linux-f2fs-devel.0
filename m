From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LKP] [lkp] [f2fs] ec795418c4: fsmark.files_per_sec -36.3%
 regression
Date: Fri, 26 Aug 2016 17:52:57 -0700
Message-ID: <20160827005257.GD88444@jaegeuk>
References: <20160718020950.GB4986@yexl-desktop>
 <87twfmsndf.fsf@yhuang-mobile.sh.intel.com>
 <87bn18cvuu.fsf_-_@yhuang-mobile.sh.intel.com>
 <20160804172452.GA12093@jaegeuk>
 <874m70ctu3.fsf@yhuang-mobile.sh.intel.com>
 <20160804185251.GA13813@jaegeuk>
 <87r3a4b7b6.fsf@yhuang-mobile.sh.intel.com>
 <87vaz6yl8a.fsf@yhuang-mobile.sh.intel.com>
 <20160812012238.GA47037@jaegeuk>
 <CAC=cRTNtND+5f83p_yBecnx0iB5_6Q6xzbHdeY0tgrVaMRLSRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAC=cRTNtND+5f83p_yBecnx0iB5_6Q6xzbHdeY0tgrVaMRLSRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, kernel test robot <xiaolong.ye@intel.com>, LKP ML <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Aug 24, 2016 at 09:51:11AM -0700, huang ying wrote:
> Hi, Jaegeuk,
> 
> On Thu, Aug 11, 2016 at 6:22 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > On Thu, Aug 11, 2016 at 03:49:41PM -0700, Huang, Ying wrote:
> >> Hi, Kim,
> >>
> >> "Huang, Ying" <ying.huang@intel.com> writes:
> >> >>
> >> >> [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
> >> >> [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
> >> >>
> >> >> In terms of the above regression, I could check that _reproduce_ procedure
> >> >> includes mounting filesystem only. Is that correct?
> >> >
> >> > Sorry, our test system failed to generate reproduce steps for aim7.  We
> >> > will implement it.
> >> >
> >> > - [lkp] [f2fs] 3bdad3c7ee: aim7.jobs-per-min -25.3% regression
> >> >
> >> > The disk is one 48G ram disk.  The steps for aim7 is,
> >> >
> >> > cat > workfile <<EOF
> >> > FILESIZE: 1M
> >> > POOLSIZE: 10M
> >> > 10 disk_cp
> >> > EOF
> >> >
> >> > (
> >> >     echo $HOSTNAME
> >> >     echo disk_cp
> >> >
> >> >     echo 1
> >> >     echo 3000
> >> >     echo 2
> >> >     echo 3000
> >> >     echo 1
> >> > ) | ./multitask -t &
> >> >
> >> >
> >> > - [lkp] [f2fs] b93f771286: aim7.jobs-per-min -81.2% regression
> >> >
> >> > The disk is 4 12G ram disk, and setup RAID0 on them via mdadm.  The
> >> > steps for aim7 is,
> >> >
> >> > cat > workfile <<EOF
> >> > FILESIZE: 1M
> >> > POOLSIZE: 10M
> >> > 10 sync_disk_rw
> >> > EOF
> >> >
> >> > (
> >> >     echo $HOSTNAME
> >> >     echo sync_disk_rw
> >> >
> >> >     echo 1
> >> >     echo 600
> >> >     echo 2
> >> >     echo 600
> >> >     echo 1
> >> > ) | ./multitask -t &
> >>
> >> Any update on these 2 regressions?  Is the information is enough for you
> >> to reproduce?
> >
> > Sorry, I've had no time to dig this due to business travel now.
> > I'll check that when back to US.
> 
> Any update?

Sorry, how can I get multitask binary?

Thanks,

> 
> Best Regards,
> Huang, Ying
