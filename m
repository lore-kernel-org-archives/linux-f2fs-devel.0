From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: add a wait queue to avoid
 unnecessary, build_free_nid
Date: Mon, 10 Mar 2014 13:09:48 +0900
Message-ID: <1394424588.5043.1.camel@lcm>
References: <5319A2DB.8040705@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5319A2DB.8040705@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Kim <jaegeuk.kim@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On =EA=B8=88, 2014-03-07 at 18:43 +0800, Gu Zheng wrote:
> Previously, when we try to alloc free nid while the build free nid
> is going, the allocer will be run into the flow that waiting for
> "nm_i->build_lock", see following:
> 	/* We should not use stale free nids created by build_free_nids */
> ---->	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
> 		f2fs_bug_on(list_empty(&nm_i->free_nid_list));
> 		list_for_each(this, &nm_i->free_nid_list) {
> 			i =3D list_entry(this, struct free_nid, list);
> 			if (i->state =3D=3D NID_NEW)
> 				break;
> 		}
>=20
> 		f2fs_bug_on(i->state !=3D NID_NEW);
> 		*nid =3D i->nid;
> 		i->state =3D NID_ALLOC;
> 		nm_i->fcnt--;
> 		spin_unlock(&nm_i->free_nid_list_lock);
> 		return true;
> 	}
> 	spin_unlock(&nm_i->free_nid_list_lock);
>=20
> 	/* Let's scan nat pages and its caches to get free nids */
> ---->	mutex_lock(&nm_i->build_lock);
> 	build_free_nids(sbi);
> 	mutex_unlock(&nm_i->build_lock);
> and this will cause another unnecessary building free nid if the curr=
ent
> building free nid job is done.
> So here we introduce a wait_queue to avoid this issue.
>=20
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/f2fs.h |    1 +
>  fs/f2fs/node.c |   10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f845e92..7ae193e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -256,6 +256,7 @@ struct f2fs_nm_info {
>  	spinlock_t free_nid_list_lock;	/* protect free nid list */
>  	unsigned int fcnt;		/* the number of free node id */
>  	struct mutex build_lock;	/* lock for build free nids */
> +	wait_queue_head_t build_wq;	/* wait queue for build free nids */
> =20
>  	/* for checkpoint */
>  	char *nat_bitmap;		/* NAT bitmap pointer */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4b7861d..ab44711 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1422,7 +1422,13 @@ retry:
>  	spin_lock(&nm_i->free_nid_list_lock);
> =20
>  	/* We should not use stale free nids created by build_free_nids */
> -	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
> +	if (on_build_free_nids(nm_i)) {
> +		spin_unlock(&nm_i->free_nid_list_lock);
> +		wait_event(nm_i->build_wq, !on_build_free_nids(nm_i));
> +		goto retry;
> +	}
> +

It would be better moving spin_lock(free_nid_list_lock) here after
removing above spin_unlock().

> +	if (nm_i->fcnt) {
>  		f2fs_bug_on(list_empty(&nm_i->free_nid_list));
>  		list_for_each(this, &nm_i->free_nid_list) {
>  			i =3D list_entry(this, struct free_nid, list);
> @@ -1443,6 +1449,7 @@ retry:
>  	mutex_lock(&nm_i->build_lock);
>  	build_free_nids(sbi);
>  	mutex_unlock(&nm_i->build_lock);
> +	wake_up_all(&nm_i->build_wq);
>  	goto retry;
>  }
> =20
> @@ -1813,6 +1820,7 @@ static int init_node_manager(struct f2fs_sb_inf=
o *sbi)
>  	INIT_LIST_HEAD(&nm_i->dirty_nat_entries);
> =20
>  	mutex_init(&nm_i->build_lock);
> +	init_waitqueue_head(&nm_i->build_wq);
>  	spin_lock_init(&nm_i->free_nid_list_lock);
>  	rwlock_init(&nm_i->nat_tree_lock);
> =20
