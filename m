From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Thu, 14 Sep 2017 20:45:18 -0700
Message-ID: <20170915034518.GB20096@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170913230426.GN5426@ZenIV.linux.org.uk>
 <20170913233116.GA45354@jaegeuk-macbookpro.roam.corp.google.com>
 <20170913234437.GO5426@ZenIV.linux.org.uk>
 <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915020607.GW5426@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915020607.GW5426@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/15, Al Viro wrote:
> On Thu, Sep 14, 2017 at 05:19:39PM -0700, Jaegeuk Kim wrote:
> > Instead, I put more traces in the reboot procedure, and got a clue to suspect
> > the below flow.
> > 
> > delayed_fput()                 init
> >                                - umount
> >  - mntput()
> >  - mntput_no_expire()            - mntput_no_expire()
> >                                  - mnt_add_count(-1);
> >                                  - mnt_get_count() return;
> >                                  - return 0;
> >  - mnt_add_count(-1);
> >  - delayed_mntput_work
> >                                - device_shutdown
> >  - ext4_put_super()
> >  - EIO
> > 
> > Does this make any sense?
> 
> Which filesystem it is?  With root I would've expected remount ro done
> by sys_umount(); with anything else...  How has it managed to avoid
> -EBUSY?  If it was umount -l (IOW, MNT_DETACH), I can see that happening,
> but...  How would flushing prevent the scenario when the same opened
> file had remained open until after the umount(2) return?

It's ext4, and we use umount(0) and retry it several times if -EBUSY happens.
But, I don't see -EBUSY error in the log.

> In other words, where has that fput() come from and how had it managed
> to get past the umount(2)?

Huge number of fput() were called by system drivers when init kills all the
processes before umount(2). So, most of fput() were added in delayed_fput_list.
Then, it seems there is a race between delayed_fput() and umount(). Anyway,
even after umount returns zero, it seems ext4's superblock is still alive
and waiting for delayed_fput() which will finally call put_super.
