From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Thu, 14 Sep 2017 12:14:47 -0700
Message-ID: <20170914191447.GA9428@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170913230426.GN5426@ZenIV.linux.org.uk>
 <20170913233116.GA45354@jaegeuk-macbookpro.roam.corp.google.com>
 <20170913234437.GO5426@ZenIV.linux.org.uk>
 <20170914011048.GA47448@jaegeuk-macbookpro.roam.corp.google.com>
 <20170914013017.GP5426@ZenIV.linux.org.uk>
 <20170914183723.GA17131@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914183723.GA17131@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/14, Al Viro wrote:
> On Thu, Sep 14, 2017 at 02:30:17AM +0100, Al Viro wrote:
> > On Wed, Sep 13, 2017 at 06:10:48PM -0700, Jaegeuk Kim wrote:
> > 
> > > Android triggers umount(2) by init process, which is definitely not a kernel
> > > thread. But, we've seen some kernel panics which say umount(2) was succeeded,
> > > but ext4 triggered a kernel panic due to EIO after then like below. I'm also
> > > not sure task_work_run() would be also safe enoughly. May I ask where I can
> > > find sys_umount() calls task_work_run()?
> > 
> > ret_{fast,slow}_syscall ->
> > 	slow_work_pending ->
> > 		do_work_pending() ->
> > 			tracehook_notify_resume() ->
> > 				task_work_run()
> > 
> > It's not sys_umount() (or any other sys_...()) - it's syscall dispatcher after
> > having called one of those and before returning to userland.  What is guaranteed
> > is that after successful task_work_add() the damn thing will be run in context
> > of originating process before it returns from syscall.  So any subsequent
> > syscalls from that process are guaranteed to happen after the work has run.
> > The same happens if the process exits rather than returns to userland (do_exit() ->
> > exit_task_work() -> task_work_run()), but for that you would need it to die in
> > umount(2) (e.g. get kill -9 delivered on the way out).
> > 
> > Please, check if you are seeing task_work_add() failure in there and if you do,
> > I would like to see a stack trace.  IOW, slap WARN_ON(1); right after
> >                         if (!task_work_add(task, &mnt->mnt_rcu, true))
> >                                 return;
> > and see what (if anything) gets printed.
> 
> AFAICS, for task_work_add() to fail here we need a final mntput() to be run
> in context of a thread that already had exit_signals() run *and* subsequent
> task_work_run() run to completion (with all pending callbacks executed, along
> with all callbacks added by those, etc.)
> 
> For that to have happened during umount(2) we would've needed
> 	* killing signal delivered while going through the syscall
> 	* final mntput() to have been done *NOT* from sys_umount() (otherwise
> the work would've been added before we got to exit_signals())
> 	* final mntput() to have been done *NOT* from any task_work callbacks
> (otherwise it would've been added before we'd observed a combination of empty
> list of pending work with PF_EXITING)
> 
> I really want to see the stack trace of that failing task_work_add(), if that's
> what actually happens there.  What kind of a reproducer do you have for that?

I've got this error from Android user, so there's no reproducer unfortunately.
So, I wrote a script capturing WARN_ON after reboot running at every minute, but
couldn't have got the error since yesterday so far.
