From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH V2] f2fs: introduce f2fs_kmem_cache_alloc to hide the
 unfailed, kmem cache allocation
Date: Tue, 22 Oct 2013 21:30:05 +0900
Message-ID: <1382445005.992.70.camel@kjgkr>
References: <526620AA.60007@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <526620AA.60007@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Gao feng <gaofeng@cn.fujitsu.com>, Haicheng Li <haicheng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

Looks good to me.

Thanks,

2013-10-22 (=ED=99=94), 14:52 +0800, Gu Zheng:
> Introduce the unfailed version of kmem_cache_alloc named f2fs_kmem_ca=
che_alloc
> to hide the retry routine and make the code a bit cleaner.
>=20
> v2:
>    Fix the wrong use of 'retry' tag pointed out by Gao feng.
>    Use more neat code to remove redundant tag suggested by Haicheng L=
i.
>=20
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/checkpoint.c |   26 +++++++-------------------
>  fs/f2fs/f2fs.h       |   15 +++++++++++++++
>  fs/f2fs/gc.c         |    8 ++------
>  fs/f2fs/node.c       |   27 +++++++++++----------------
>  4 files changed, 35 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 8d16071..6fb484c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -226,12 +226,8 @@ void add_orphan_inode(struct f2fs_sb_info *sbi, =
nid_t ino)
>  			break;
>  		orphan =3D NULL;
>  	}
> -retry:
> -	new =3D kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
> -	if (!new) {
> -		cond_resched();
> -		goto retry;
> -	}
> +
> +	new =3D f2fs_kmem_cache_alloc(orphan_entry_slab, GFP_ATOMIC);
>  	new->ino =3D ino;
> =20
>  	/* add new_oentry into list which is sorted by inode number */
> @@ -484,12 +480,8 @@ void set_dirty_dir_page(struct inode *inode, str=
uct page *page)
> =20
>  	if (!S_ISDIR(inode->i_mode))
>  		return;
> -retry:
> -	new =3D kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
> -	if (!new) {
> -		cond_resched();
> -		goto retry;
> -	}
> +
> +	new =3D f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
>  	new->inode =3D inode;
>  	INIT_LIST_HEAD(&new->list);
> =20
> @@ -506,13 +498,9 @@ retry:
>  void add_dirty_dir_inode(struct inode *inode)
>  {
>  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> -	struct dir_inode_entry *new;
> -retry:
> -	new =3D kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
> -	if (!new) {
> -		cond_resched();
> -		goto retry;
> -	}
> +	struct dir_inode_entry *new =3D
> +			f2fs_kmem_cache_alloc(inode_entry_slab, GFP_NOFS);
> +
>  	new->inode =3D inode;
>  	INIT_LIST_HEAD(&new->list);
> =20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 171c52f..2949275 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -18,6 +18,7 @@
>  #include <linux/crc32.h>
>  #include <linux/magic.h>
>  #include <linux/kobject.h>
> +#include <linux/sched.h>
> =20
>  /*
>   * For mount options
> @@ -787,6 +788,20 @@ static inline struct kmem_cache *f2fs_kmem_cache=
_create(const char *name,
>  	return kmem_cache_create(name, size, 0, SLAB_RECLAIM_ACCOUNT, ctor)=
;
>  }
> =20
> +static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
> +						gfp_t flags)
> +{
> +	void *entry;
> +retry:
> +	entry =3D kmem_cache_alloc(cachep, flags);
> +	if (!entry) {
> +		cond_resched();
> +		goto retry;
> +	}
> +
> +	return entry;
> +}
> +
>  #define RAW_IS_INODE(p)	((p)->footer.nid =3D=3D (p)->footer.ino)
> =20
>  static inline bool IS_INODE(struct page *page)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index fbad968..7914b92 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -361,12 +361,8 @@ static void add_gc_inode(struct inode *inode, st=
ruct list_head *ilist)
>  		iput(inode);
>  		return;
>  	}
> -repeat:
> -	new_ie =3D kmem_cache_alloc(winode_slab, GFP_NOFS);
> -	if (!new_ie) {
> -		cond_resched();
> -		goto repeat;
> -	}
> +
> +	new_ie =3D f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
>  	new_ie->inode =3D inode;
>  	list_add_tail(&new_ie->list, ilist);
>  }
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index ef80f79..4fa3fd5 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1296,23 +1296,18 @@ static int add_free_nid(struct f2fs_nm_info *=
nm_i, nid_t nid, bool build)
>  	if (nid =3D=3D 0)
>  		return 0;
> =20
> -	if (!build)
> -		goto retry;
> -
> -	/* do not add allocated nids */
> -	read_lock(&nm_i->nat_tree_lock);
> -	ne =3D __lookup_nat_cache(nm_i, nid);
> -	if (ne && nat_get_blkaddr(ne) !=3D NULL_ADDR)
> -		allocated =3D true;
> -	read_unlock(&nm_i->nat_tree_lock);
> -	if (allocated)
> -		return 0;
> -retry:
> -	i =3D kmem_cache_alloc(free_nid_slab, GFP_NOFS);
> -	if (!i) {
> -		cond_resched();
> -		goto retry;
> +	if (build) {
> +		/* do not add allocated nids */
> +		read_lock(&nm_i->nat_tree_lock);
> +		ne =3D __lookup_nat_cache(nm_i, nid);
> +		if (ne && nat_get_blkaddr(ne) !=3D NULL_ADDR)
> +			allocated =3D true;
> +		read_unlock(&nm_i->nat_tree_lock);
> +		if (allocated)
> +			return 0;
>  	}
> +
> +	i =3D f2fs_kmem_cache_alloc(free_nid_slab, GFP_NOFS);
>  	i->nid =3D nid;
>  	i->state =3D NID_NEW;
> =20

--=20
Jaegeuk Kim
Samsung
