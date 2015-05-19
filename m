From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs crypto: add rwsem to avoid data races
Date: Tue, 19 May 2015 10:42:04 -0700
Message-ID: <20150519174204.GA42970@jaegeuk-mac02.mot.com>
References: <1432013801-39069-1-git-send-email-jaegeuk@kernel.org>
 <20150519142943.GE20421@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150519142943.GE20421@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 19, 2015 at 10:29:43AM -0400, Theodore Ts'o wrote:
> On Mon, May 18, 2015 at 10:36:41PM -0700, Jaegeuk Kim wrote:
> > Previoulsy, fi->i_crypt_info was not covered by any lock, resulting in
> > memory leak.
> > 
> > This patch adds a rwsem to avoid leaking objects on i_crypt_info.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> I'm not sure we need an rwsem to fix this issue.  In terms of
> serializing the creation and deletion of the structure, it should be
> possible to use an cmpxchg() on the pointer itself.  (e.g., if we lose
> the race on the creation side, we just release our structure and use
> the one that the winner allocated).

What I'm looking is when multiple threads enter into get_encryption_info.
If ei->i_crypt_info doesn't exist, all of them can go into the allocation phase.
Since, new ei->i_crypt_info will be assigned after finishing all the stuffs,
it can do allocation redundantly without freeing the existing one.

I've seen some crypt_info object leaks reported by kmemleak after finishing
some tests in xfstests below. And I confirmed that this patch fixes that.

=============================================================================
BUG f2fs_crypt_info (Tainted: G           O   ): Objects remaining in
				f2fs_crypt_info on kmem_cache_close()
-----------------------------------------------------------------------------

Disabling lock debugging due to kernel taint
CPU: 3 PID: 26284 Comm: rmmod Tainted: G    B      O    4.1.0-rc2+ #20
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
 ffff8800376d98c0 ffff88001dd13d38 ffffffff817ffd6a 0000000000000001
 ffffea00007d6a80 ffff88001dd13e08 ffffffff81218ac0 ffff880000000020
 ffff88001dd13e18 ffff88001dd13dc8 656a624f001a0000 616d657220737463
Call Trace:
 [<ffffffff817ffd6a>] dump_stack+0x4f/0x7b
 [<ffffffff81218ac0>] slab_err+0xa0/0xb0
 [<ffffffff8121c89c>] ? __kmalloc+0x37c/0x3d0
 [<ffffffff8121dcd6>] ? __kmem_cache_shutdown+0x126/0x340
 [<ffffffff8121dcd6>] ? __kmem_cache_shutdown+0x126/0x340
 [<ffffffff8121dcf6>] __kmem_cache_shutdown+0x146/0x340
 [<ffffffff811e3079>] ? kmem_cache_destroy+0x39/0x130
 [<ffffffff811e30e8>] kmem_cache_destroy+0xa8/0x130
 [<ffffffffa03a0801>] f2fs_exit_crypto+0x41/0x50 [f2fs]
 [<ffffffffa03a1e2a>] exit_f2fs_fs+0x28/0x1fe [f2fs]
 [<ffffffff8113125c>] SyS_delete_module+0x18c/0x210
 [<ffffffff8180b532>] system_call_fastpath+0x16/0x7a
 INFO: Object 0xffff88001f5ab3e0 @offset=5088
 INFO: Allocated in _f2fs_get_encryption_info+0x97/0x260 [f2fs]
 	__slab_alloc+0x4bd/0x562
 	kmem_cache_alloc+0x2a4/0x390
 	_f2fs_get_encryption_info+0x97/0x260 [f2fs]
 	f2fs_file_open+0x57/0x70 [f2fs]
 	do_dentry_open+0x257/0x350
 	vfs_open+0x49/0x50
 	do_last+0x208/0x13e0
 	path_openat+0x84/0x660
 	do_filp_open+0x3a/0x90
 	do_sys_open+0x128/0x220
 	SyS_creat+0x1e/0x20
 	system_call_fastpath+0x16/0x7a
 INFO: Freed in f2fs_free_encryption_info+0x52/0x70 [f2fs]
 	__slab_free+0x39/0x214
 	kmem_cache_free+0x394/0x3a0
 	f2fs_free_encryption_info+0x52/0x70 [f2fs]
 	f2fs_evict_inode+0x15a/0x460 [f2fs]
 	evict+0xb8/0x190
 	iput+0x30e/0x3f0
 	d_delete+0x178/0x1b0
 	vfs_rmdir+0x122/0x140
 	do_rmdir+0x1fb/0x220
 	SyS_rmdir+0x16/0x20
 	system_call_fastpath+0x16/0x7a

> 
> If we do end up needing to serialize access to the tfm in the
> i_crypt_info object for datapath reads/writes, then we might need a
> mutex, but I think that should be it, no?

Seems like we don't need to care about serialization on tfm.

Thanks,
