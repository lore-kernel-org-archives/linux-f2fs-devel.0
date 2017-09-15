From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Fri, 15 Sep 2017 11:44:33 -0700
Message-ID: <20170915184433.GA32008@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913233116.GA45354@jaegeuk-macbookpro.roam.corp.google.com>
 <20170913234437.GO5426@ZenIV.linux.org.uk>
 <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915020607.GW5426@ZenIV.linux.org.uk>
 <20170915034518.GB20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915042137.GX5426@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915042137.GX5426@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/15, Al Viro wrote:
> On Thu, Sep 14, 2017 at 08:45:18PM -0700, Jaegeuk Kim wrote:
> 
> > > Which filesystem it is?  With root I would've expected remount ro done
> > > by sys_umount(); with anything else...  How has it managed to avoid
> > > -EBUSY?  If it was umount -l (IOW, MNT_DETACH), I can see that happening,
> > > but...  How would flushing prevent the scenario when the same opened
> > > file had remained open until after the umount(2) return?
> > 
> > It's ext4, and we use umount(0) and retry it several times if -EBUSY happens.
> 
> ????
> 
> umount(0) will result in EFAULT; what are you talking about?

Sorry, I meant: umount2("/data", 0);

> 
> > But, I don't see -EBUSY error in the log.
> 
> Sorry, I'd been unclear - where is it mounted?  Is that the root filesystem?

No, it's /userdata in Android.

> > > In other words, where has that fput() come from and how had it managed
> > > to get past the umount(2)?
> > 
> > Huge number of fput() were called by system drivers when init kills all the
> > processes before umount(2). So, most of fput() were added in delayed_fput_list.
> 
> Umm...  What do you mean by system drivers?  If it was held by userland processes,
> then we are back to the same question - why has task_work_add() failed in fput()?
> If it had been kernel threads, which files had they been holding open?

So, I digged it in more detail, and found, in drivers/android/binder.c [1],
- binder_ioctl()
 - create a kernel thread
 - zombie_cleanup_check()
  - binder_defer_work()
    - queue_work(..., &binder_deferred_work);

- binder_deferred_func()
 - binder_clear_zombies()
  - binder_proc_clear_zombies()
   - put_files_struct()
    - close_files()
     - filp_close()
      - fput()

It seems binder holds some proc files. If you think it's android-specific issue,
I may need to write a patch for android kernel instead. Let me know.

[1] https://android.googlesource.com/kernel/msm/+/android-8.0.0_r0.4/drivers/staging/android/binder.c

> 
> > Then, it seems there is a race between delayed_fput() and umount(). Anyway,
> > even after umount returns zero, it seems ext4's superblock is still alive
> > and waiting for delayed_fput() which will finally call put_super.
> 
> That might be more than one mount of the same fs (in different namespaces, for
> example) with umount taking out one of those, with the other having been
> hit with umount -l before that, with some opened files being the only thing
> that used to keep it alive.
> 
> I'd like to see /proc/1/mountinfo and fuser output, TBH...  I'm not familiar enough
> with Android userland setup, so my apologies for dumb questions ;-/
