From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid congestion_wait when do_checkpoint
 for better performance
Date: Tue, 08 Oct 2013 17:37:18 +0800
Message-ID: <5253D24E.3010309@cn.fujitsu.com>
References: <25944790.263941381221039729.JavaMail.weblogic@epml12>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <25944790.263941381221039729.JavaMail.weblogic@epml12>
Sender: linux-kernel-owner@vger.kernel.org
To: yuan.mark.zhong@samsung.com
Cc: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, shu.tan@samsung.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yuan,
On 10/08/2013 04:30 PM, Yuan Zhong wrote:

> Previously, do_checkpoint() will call congestion_wait() for waiting t=
he pages (previous submitted node/meta/data pages) to be written back.
> Because congestion_wait() will set a regular period (e.g. HZ / 50 ) f=
or waiting.
> For this reason, there is a situation that after the pages have been =
written back, but the checkpoint thread still wait for congestion_wait =
to exit.

How do you confirm this issue? I suspect that the block-core does not h=
ave a wake-up mechanism
when the back device is uncongested.

> This is a problem here, especially, when sync a large number of small=
 files or dirs.
> In order to avoid this, a wait_list is introduced, the checkpoint thr=
ead will be dropped into the wait_list if the pages have not been writt=
en back, and will be waked up by contrast.

Please pay some attention to the mail form, this mail is out of format =
in my mail client.

Regards,
Gu

>=20
> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
> --- =20
>  fs/f2fs/checkpoint.c |    3 +--
>  fs/f2fs/f2fs.h       |   19 +++++++++++++++++++
>  fs/f2fs/segment.c    |    1 +
>  fs/f2fs/super.c      |    1 +
>  4 files changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index ca39442..5d69ae0 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -758,8 +758,7 @@ static void do_checkpoint(struct f2fs_sb_info *sb=
i, bool is_umount)
>  	f2fs_put_page(cp_page, 1);
> =20
>  	/* wait for previous submitted node/meta pages writeback */
> -	while (get_pages(sbi, F2FS_WRITEBACK))
> -		congestion_wait(BLK_RW_ASYNC, HZ / 50);
> +	f2fs_writeback_wait(sbi);
> =20
>  	filemap_fdatawait_range(sbi->node_inode->i_mapping, 0, LONG_MAX);
>  	filemap_fdatawait_range(sbi->meta_inode->i_mapping, 0, LONG_MAX);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7fd99d8..4b0d70e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -18,6 +18,8 @@
>  #include <linux/crc32.h>
>  #include <linux/magic.h>
>  #include <linux/kobject.h>
> +#include <linux/wait.h>
> +#include <linux/sched.h>
> =20
>  /*
>   * For mount options
> @@ -368,6 +370,7 @@ struct f2fs_sb_info {
>  	struct mutex fs_lock[NR_GLOBAL_LOCKS];	/* blocking FS operations */
>  	struct mutex node_write;		/* locking node writes */
>  	struct mutex writepages;		/* mutex for writepages() */
> +	wait_queue_head_t writeback_wqh;	/* wait_queue for writeback */
>  	unsigned char next_lock_num;		/* round-robin global locks */
>  	int por_doing;				/* recovery is doing or not */
>  	int on_build_free_nids;			/* build_free_nids is doing */
> @@ -961,6 +964,22 @@ static inline int f2fs_readonly(struct super_blo=
ck *sb)
>  	return sb->s_flags & MS_RDONLY;
>  }
> =20
> +static inline void f2fs_writeback_wait(struct f2fs_sb_info *sbi)
> +{
> +	DEFINE_WAIT(wait);
> +
> +	prepare_to_wait(&sbi->writeback_wqh, &wait, TASK_UNINTERRUPTIBLE);
> +	if (get_pages(sbi, F2FS_WRITEBACK))
> +		io_schedule();
> +	finish_wait(&sbi->writeback_wqh, &wait);
> +}
> +
> +static inline void f2fs_writeback_wake(struct f2fs_sb_info *sbi)
> +{
> +	if (!get_pages(sbi, F2FS_WRITEBACK))
> +		wake_up_all(&sbi->writeback_wqh);
> +}
> +
>  /*
>   * file.c
>   */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bd79bbe..0708aa9 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -597,6 +597,7 @@ static void f2fs_end_io_write(struct bio *bio, in=
t err)
> =20
>  	if (p->is_sync)
>  		complete(p->wait);
> +	f2fs_writeback_wake(p->sbi);
>  	kfree(p);
>  	bio_put(bio);
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 094ccc6..3ac6d85 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -835,6 +835,7 @@ static int f2fs_fill_super(struct super_block *sb=
, void *data, int silent)
>  	mutex_init(&sbi->gc_mutex);
>  	mutex_init(&sbi->writepages);
>  	mutex_init(&sbi->cp_mutex);
> +	init_waitqueue_head(&sbi->writeback_wqh);
>  	for (i =3D 0; i < NR_GLOBAL_LOCKS; i++)
>  		mutex_init(&sbi->fs_lock[i]);
>  	mutex_init(&sbi->node_write);N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2=
X=AC=B6=C7=A7v=D8^=96)=DE=BA{.n=C7+=89=B7=A5=8A{=B1=91=EA=E7zX=A7=B6=17=
=9B=A1=DC=A8}=A9=9E=B2=C6 z=DA&j:+v=89=A8=BE=07=AB=91=EA=E7zZ+=80=CA+zf=
=A3=A2=B7h=9A=88=A7~=86=AD=86=DBi=FF=FB=E0z=B9=1E=AEw=A5=A2=B8?=99=A8=E8=
=AD=DA&=A2)=DF=A2=1Bf=94=F9^j=C7=ABy=A7m=85=E1@A=ABa=B6=DA=7F=FF=0C0=B6=
=ECh=AE=0F=E5=92i=7F
