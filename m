From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev][PATCH 2/2] f2fs: enable recover_xattr_data to avoid
 cp when fsync after operating xattr
Date: Sat, 10 Jan 2015 21:32:12 -0800
Message-ID: <20150111053212.GB91790@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <009401d0297a$41523580$c3f6a080$@samsung.com>
 <20150106194419.GB54001@jaegeuk-mac02>
 <000101d02cce$4bed1c60$e3c75520$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000101d02cce$4bed1c60$e3c75520$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Jan 10, 2015 at 08:08:33PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, January 07, 2015 3:44 AM
> > To: Chao Yu
> > Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> > Subject: Re: [f2fs-dev][PATCH 2/2] f2fs: enable recover_xattr_data to avoid cp when fsync after
> > operating xattr
> > 
> > Hi Chao,
> > 
> > On Tue, Jan 06, 2015 at 02:29:40PM +0800, Chao Yu wrote:
> > > Now if we call fsync() after we update the xattr date belongs to the file, f2fs
> > > will do checkpoint to keep data.
> > > This can cause low performance because checkpoint block most operation and write
> > > lots of blocks. So we'd better to avoid doing checkpoint by writing modified
> > > xattr node page to warm node segment, and then it can be recovered when we mount
> > > this device later on.
> > 
> > You're trying to change the writing policy as xattr blocks are written into
> > WARM_NODE area instead of COLD_NODE area.
> > I don't think xattrs are frequently changed between each fsync calls.
> > 
> > How do you think?
> 
> I'm not sure whether there is a scenario that setxattr and fsync are invoked
> alternately, but if there is, our performance will decrease obviously.
> 
> If you don't want to change writing policy, how about writing xattr node with
> fsync flag into cold node segment when fsync() is called, then try to recover
> it from cold node chain when recovery after abnormally pow-cut, this way can
> avoid cp frequently in above scenario.

Firt of all, I don't think this scenario is frequent enough that we have to
break the exisiting writing and recovery procedures.
Moreover, if xattr entries are covered by inline_xattr, it doesn't trigger
checkpoint.

Let me know, if I'm missing something.

If you try to change the recovery procedure, it needs to think about the
disk full condition. (i.e., space_for_roll_forward())
And, I don't want to search cold node chain.

Thanks,

> 
> Thanks,
> Yu
