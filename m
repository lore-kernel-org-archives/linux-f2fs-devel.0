From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH] f2fs: delete and free dirty dir freeing inode entry when
 sync dirty dir inodes
Date: Tue, 22 Oct 2013 20:15:44 +0900
Message-ID: <1382440544.992.64.camel@kjgkr>
References: <5264D574.6000105@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5264D574.6000105@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

2013-10-21 (=EC=9B=94), 15:19 +0800, Gu Zheng:
> In sync_dirty_dir_inodes(), remove_dirty_dir_inode() will be called
> in the callback of filemap_flush to delete and free dirty dir inode e=
ntry.
> But for the freeing inode entry, missed this step after sbumit data b=
io,
> and this may lead to a dead loop if these is freeing inode entry in
> dir_inode_list. So add the delete and free step to fix it.

Hi Gu,

This dirty inode will be removed by f2fs_evict_inode() after submitting
any pending bio, f2fs_submit_bio().
Thanks,

>=20
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/checkpoint.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>=20
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8d16071..f61838f 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -600,7 +600,16 @@ retry:
>  		 * wribacking dentry pages in the freeing inode.
>  		 */
>  		f2fs_submit_bio(sbi, DATA, true);
> +
> +		spin_lock(&sbi->dir_inode_lock);
> +		list_del(&entry->list);
> +#ifdef CONFIG_F2FS_STAT_FS
> +		sbi->n_dirty_dirs--;
> +#endif
> +		spin_unlock(&sbi->dir_inode_lock);
> +		kmem_cache_free(inode_entry_slab, entry);
>  	}
> +
>  	goto retry;
>  }
> =20

--=20
Jaegeuk Kim
Samsung
