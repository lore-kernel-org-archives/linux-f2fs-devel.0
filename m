From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Fri, 15 Sep 2017 16:29:11 -0700
Message-ID: <20170915232911.GA44998@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
 <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915001939.GA20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915020607.GW5426@ZenIV.linux.org.uk>
 <20170915034518.GB20096@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915042137.GX5426@ZenIV.linux.org.uk>
 <20170915184433.GA32008@jaegeuk-macbookpro.roam.corp.google.com>
 <20170915221238.js6elr5jmj4mgt67@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915221238.js6elr5jmj4mgt67@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/15, Theodore Ts'o wrote:
> On Fri, Sep 15, 2017 at 11:44:33AM -0700, Jaegeuk Kim wrote:
> > 
> > So, I digged it in more detail, and found, in drivers/android/binder.c [1],
> > - binder_ioctl()
> >  - create a kernel thread
> >  - zombie_cleanup_check()
> >   - binder_defer_work()
> >     - queue_work(..., &binder_deferred_work);
> > 
> > - binder_deferred_func()
> >  - binder_clear_zombies()
> >   - binder_proc_clear_zombies()
> >    - put_files_struct()
> >     - close_files()
> >      - filp_close()
> >       - fput()
> > 
> > It seems binder holds some proc files.
> 
> If binder was holding some files open, then umount should have failed
> with EBUSY, no?

Based on what I've got some traces so far,

- binder_ioctl
 - create a kernel thread
 - zombie_cleanup_check
  - binder_defer_work
   - queue_work(..., &binder_deferred_work);

- binder_deferred_func
 - binder_clear_zombies
  - binder_proc_clear_zombies
   - put_files_struct
     - close_files
      - filp_close
       - fput

- delayed_fput
 ...
 - file_free
 - dput
                                                init
                                                - umount
 - mntput
  - mntput_no_expire
                                                - do_umount
						 - mnt_get_count() > 2
                                                - mntput_no_expire
                                                 - mnt_add_count(-1);
   - mnt_add_count(-1);
                                                 - mnt_get_count() return;
                                                 - return 0;
   - delayed_mntput_work
                                                - device_shutdown
    - ext4_put_super()
     - EIO, and panic if error=panic


The mntput() in delayed_fput() is the last function call. So before that moment,
sys_umount() may see mnt_get_count() as 2, so it avoids EBUSY condition. I'm not
sure why it check over 2 tho.

> 
> Does Android use mount namespaces at all?
> 
> 					- Ted
