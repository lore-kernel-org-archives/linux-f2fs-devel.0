From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Wed, 13 Sep 2017 16:31:16 -0700
Message-ID: <20170913233116.GA45354@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170913230426.GN5426@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170913230426.GN5426@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Al,

On 09/14, Al Viro wrote:
> On Wed, Sep 13, 2017 at 01:09:41PM -0700, Jaegeuk Kim wrote:
> > +	if (!retval && (flags & UMOUNT_WAIT)) {
> > +		if (likely(!(current->flags & PF_KTHREAD)))
> > +			task_work_run();
> 
> This is complete crap.  The same damn thing will be done by
> caller of sys_umount() pretty much immediately afterwards.
> I'm not sure what it is that you are trying to paper over,
> but this is just plain wrong.

Okay.

> What _is_ the semantics of UMOUNT_WAIT?  What does it guarantee,
> and what would be supplying it to umount(2)?

When android tries to reboot the system, it calls umount(2) without any flag.
Then, mntput_no_expire() will add delayed_mntput_work() which finally does
cleanup_mnt() later. In the mean time, android proceeded to shutdown all
the UFS devices, but filesystem would be still alive and tries to trigger
some I/Os. At this moment, I'd like to avoid EIO, since ext4 can issue kernel
panic because of error=panic.

So, what I'm trying to do is 1) adding a flag to wait for umount() completion,
2) issuing umount(2) with UMOUNT_WAIT in android. Then, it can guarantee there'd
be no I/Os after sucessful umount().

Could you please correct me?

Thanks,
