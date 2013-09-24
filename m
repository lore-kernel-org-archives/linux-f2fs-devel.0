From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: account for orphan inodes during recovery
Date: Tue, 24 Sep 2013 11:35:12 -0500
Message-ID: <CAGfvh620A-cuUzQ2rVPiua_JFE33h9Fir90KSn5g9WnxR0cp7A@mail.gmail.com>
References: <25a06e3e5ef81f00a220f0e59040806d@www.metagalaxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <25a06e3e5ef81f00a220f0e59040806d@www.metagalaxy.net>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Russ W. Knize" <russ@knizefamily.net>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Sorry about the corrupted patches: I'm a bit rusty.  I'll resend them
the old-fashioned way in a bit.

On Tue, Sep 24, 2013 at 9:36 AM, Russ W. Knize <russ@knizefamily.net> wrote:
> During recovery, orphan inodes are deleted via truncate_hole().
> These orphans are added by recover_dentry() via f2fs_delete_entry().
> However, f2fs_delete_entry() adds them via add_orphan_inode()
> without calling acquire_orphan_inode() first.  This prevents the
> counters from being incremented properly, which causes them to
> underflow when remove_orphan_inode() is called later on.
>
> Signed-off-by: Russ Knize <rknize@motorola.com>
> ---
>   fs/f2fs/recovery.c |   19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index e8cf621..908066d 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -67,24 +67,31 @@ static int recover_dentry(struct page *ipage,
> struct inode *inode)
>         name.name = raw_inode->i_name;
>   retry:
>         de = f2fs_find_entry(dir, &name, &page);
> -       if (de && inode->i_ino == le32_to_cpu(de->ino)) {
> -               kunmap(page);
> -               f2fs_put_page(page, 0);
> -               goto out;
> -       }
> +       if (de && inode->i_ino == le32_to_cpu(de->ino))
> +               goto out_unmap_put;
>         if (de) {
>                 einode = f2fs_iget(inode->i_sb, le32_to_cpu(de->ino));
>                 if (IS_ERR(einode)) {
>                         WARN_ON(1);
>                         if (PTR_ERR(einode) == -ENOENT)
>                                 err = -EEXIST;
> -                       goto out;
> +                       goto out_unmap_put;
> +               }
> +               err = acquire_orphan_inode(F2FS_SB(inode->i_sb));
> +               if (err) {
> +                       iput(einode);
> +                       goto out_unmap_put;
>                 }
>                 f2fs_delete_entry(de, page, einode);
>                 iput(einode);
>                 goto retry;
>         }
>         err = __f2fs_add_link(dir, &name, inode);
> +       goto out;
> +
> +out_unmap_put:
> +       kunmap(page);
> +       f2fs_put_page(page, 0);
>   out:
>         f2fs_msg(inode->i_sb, KERN_DEBUG, "recover_inode and its dentry: "
>                         "ino = %x, name = %s, dir = %lx, err = %d",
> --
> 1.7.9.5
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
