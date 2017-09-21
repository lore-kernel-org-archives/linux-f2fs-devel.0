From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Thu, 21 Sep 2017 03:42:52 +0100
Message-ID: <20170921024251.GE32076@ZenIV.linux.org.uk>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170920173831.GA7151@jaegeuk-macbookpro.roam.corp.google.com>
 <20170920183825.GD32076@ZenIV.linux.org.uk>
 <20170921003409.GA11365@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170921003409.GA11365@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 20, 2017 at 05:34:09PM -0700, Jaegeuk Kim wrote:
> > 	flush_delayed_fput()
> > 		does nothing, the list is empty
> 
> 		how about waiting for workqueue completion here?
> 
> > 	....
> 
> 	If all the __fput()s are not finished, do_umount() will return -EBUSY.

Hell, no.  That's only when they are all on the same vfsmount.  And in that
case you don't need any waiting - if any of those mntput() is not past the
unlock_mount_hash() in mntput_no_expire(), you will get -EBUSY.  And if they
all are, the caller of umount(2) will end up dropping the last reference.  
In which case the shutdown will be scheduled via task_work_add() and processed
before umount(2) returns to userland.

The whole problem is that you have several vfsmounts over the same filesystem
(== same struct super_block), some of them held by kernel threads of yours.
umount(2) doesn't affect those and isn't affected by those.  What you do is,
AFAICS,
	ask the kernel threads to start shutting down
	umount()
	shut device down, hoping that all vfsmounts that used
to be held by those threads are gone by that point.

Your patch tries to stick "flush the pending work" in the umount().
With no warranty that it will catch that stuff in the stage where
flushing will affect anything.

> +void flush_delayed_fput_wait(void)
> +{
> +	delayed_fput(NULL);
> +	flush_delayed_work(&delayed_fput_work);
> +}

> +void flush_delayed_mntput_wait(void)
> +{
> +	delayed_mntput(NULL);
> +	flush_delayed_work(&delayed_mntput_work);
> +}

It's still a broken approach.  What I don't understand is why bother
with that sort of brittle logics in the first place.  Why not simply
open the damn thing with O_EXCL before proceeding to device shutdown?
And if you get "busy" from that, wait and retry...
