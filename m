From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] vfs: introduce UMOUNT_WAIT which waits for umount
 completion
Date: Wed, 20 Sep 2017 19:38:25 +0100
Message-ID: <20170920183825.GD32076@ZenIV.linux.org.uk>
References: <20170913200941.39420-1-jaegeuk@kernel.org>
 <20170920173831.GA7151@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170920173831.GA7151@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Sep 20, 2017 at 10:38:31AM -0700, Jaegeuk Kim wrote:
> This patch introduces UMOUNT_WAIT flag for umount(2) which let user wait for
> umount(2) to complete filesystem shutdown. This should fix a kernel panic
> triggered when a living filesystem tries to access dead block device after
> device_shutdown done by kernel_restart as below.

NAK.  This is just papering over the race you've got; it does not fix it.
You count upon the kernel threads in question having already gotten past
scheduling delayed fput, but what's there to guarantee that?  You are
essentially adding a "flush all pending fput that had already been
scheduled" syscall.  It
	a) doesn't belong in umount(2) and
	b) doesn't fix the race.
It might change the timing enough to have your specific reproducer survive,
but that kind of approach is simply wrong.

Incidentally, the name is a misnomer - it does *NOT* wait for completion of
fs shutdown.  Proof: have a filesystem mounted in two namespaces and issue
that thing in one of them.  Then observe how it's still alive, well and
accessible in another.

The only case that gets affected by it is when another mount is heading for
shutdown and is in a very specific part of that.  That is waited for.
If it's just before *OR* just past that stage, you are fucked.

And yes, "just past" is also affected.  Look:
CPU1: delayed_fput()
        struct llist_node *node = llist_del_all(&delayed_fput_list);
delayed_fput_list() is empty now
        llist_for_each_entry_safe(f, t, node, f_u.fu_llist)
                __fput(f);
CPU2: your umount UMOUNT_WAIT
	flush_delayed_fput()
		does nothing, the list is empty
	....
	flush_scheduled_work()
		waits for delayed_fput() to finish
CPU1:
	finish __fput()
	call mntput() from it
	schedule_delayed_work(&delayed_mntput_work, 1);
CPU2:
	OK, everything scheduled prior to call of flush_scheduled_work() is completed,
we are done.
	return from umount(2)
	(in bogus userland code) tell it to shut devices down
...
oops, that delayed_mntput_work we'd scheduled there got to run.  Too bad...
