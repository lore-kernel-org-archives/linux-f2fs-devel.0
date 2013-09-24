From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [f2fs-dev] [RFC] f2fs: dont take an fs_lock in f2fs_setxattr()
Date: Tue, 24 Sep 2013 09:59:24 -0500
Message-ID: <CAGfvh61tGsZW_vtB0ihTTJihZ+812RCEuLiCd9gX639hP-bLpQ@mail.gmail.com>
References: <e28992f12d725c3f0c0137aa046c8786@www.metagalaxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <e28992f12d725c3f0c0137aa046c8786@www.metagalaxy.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Russ W. Knize" <rknize@gmail.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

I sent this as RFC do that we can continue the discussion about the
design here.  Even with the above patch, we uncovered another deadlock
condition:

- f2fs_write_begin()
 - f2fs_balance_fs() <-- takes gc_mutex
  - f2fs_gc()
   - write_checkpoint()
    - block_operations()
     - mutex_lock_all() <-- blocks trying to grab all fs_locks

- f2fs_mkdir() <-- takes an fs_lock
 - __f2fs_add_link()
  - f2fs_init_security()
   - security_inode_init_security()
    - f2fs_initxattrs()
     - f2fs_setxattr()
      - f2fs_balance_fs() <-- blocks trying to take gc_mutex

The fundamental problem is the same: we are trying to call
f2fs_settxattr from within the F2FS driver itself.  It seems like
f2fs_init_security() should be using an internal API here.  The
alternative is to remove the f2fs_balance_fs() from f2fs_setxattr() as
well as the fs_lock.

Russ

On Tue, Sep 24, 2013 at 9:39 AM, Russ W. Knize <rknize@gmail.com> wrote:
> The VFS layer already protects xattr_handler.set from concurrent
> access via an inode mutex, so there is no reason to take an fs_lock
> as well.  This avoids a potential dealock:
>
> - vfs_create()
>   - f2fs_create() - takes an fs_lock
>    - f2fs_add_link()
>     - __f2fs_add_link()
>      - init_inode_metadata()
>       - f2fs_init_security()
>        - security_inode_init_security()
>         - f2fs_initxattrs()
>          - f2fs_setxattr() - also takes an fs_lock
>
> If the caller happens to grab the same fs_lock from the pool in both
> places, they will deadlock.
>
> Signed-off-by: Russ Knize <rknize@motorola.com>
> ---
>   fs/f2fs/xattr.c |    4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 1ac8a5f..18b4080 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -478,7 +478,6 @@ int f2fs_setxattr(struct inode *inode, int
> name_index, const char *name,
>         void *base_addr;
>         int found, newsize;
>         size_t name_len;
> -       int ilock;
>         __u32 new_hsize;
>         int error = -ENOMEM;
>
> @@ -495,8 +494,6 @@ int f2fs_setxattr(struct inode *inode, int
> name_index, const char *name,
>
>         f2fs_balance_fs(sbi);
>
> -       ilock = mutex_lock_op(sbi);
> -
>         base_addr = read_all_xattrs(inode, ipage);
>         if (!base_addr)
>                 goto exit;
> @@ -578,7 +575,6 @@ int f2fs_setxattr(struct inode *inode, int
> name_index, const char *name,
>         else
>                 update_inode_page(inode);
>   exit:
> -       mutex_unlock_op(sbi, ilock);
>         kzfree(base_addr);
>         return error;
>   }
> --
> 1.7.10.4
>
>
> ------------------------------------------------------------------------------
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
