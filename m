From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add sysfs support for controlling
	the gc_thread
Date: Mon, 27 May 2013 10:46:54 +0900
Message-ID: <1369619214.10521.25.camel@kjgkr>
References: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5046686884936165052=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UgmXn-0001Kd-D9
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 May 2013 01:48:15 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UgmXk-00041x-GD for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 May 2013 01:48:15 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNF00E6TP048ND0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 May 2013 10:48:05 +0900 (KST)
In-reply-to: <1369533945-6955-1-git-send-email-linkinjeon@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net


--===============5046686884936165052==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-OqY9OrQ1q4scaTORAaCX"


--=-OqY9OrQ1q4scaTORAaCX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

This is an interesting functionality.
Could you describe why and when we need to do this?
What are pros and cons?
How can we use this?

IMO, when users try to control IO latencies, it seems that they can
trigger such the explicit GCs, but in order to do that, they also need
to know the status of current f2fs in more precisely. Does the debugfs
show it enoughly?

Afterwards, it is worth to add some information to
Document/filesystems/f2fs.txt.

Thanks,

2013-05-26 (=EC=9D=BC), 11:05 +0900, Namjae Jeon:
> From: Namjae Jeon <namjae.jeon@samsung.com>
>=20
> Add sysfs entries to control the timing parameters for
> f2fs gc thread and also provide a control flag, which will
> allow the user to forcefully start a FG garbage collection
> if required.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
> ---
>  fs/f2fs/f2fs.h  |    6 +++
>  fs/f2fs/gc.c    |   20 +++++---
>  fs/f2fs/gc.h    |   33 +++++++------
>  fs/f2fs/super.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 185 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 00c8c5f..40abd81 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -400,6 +400,8 @@ struct f2fs_sb_info {
>  	struct mutex gc_mutex;			/* mutex for GC */
>  	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
>  	unsigned int cur_victim_sec;		/* current victim section num */
> +	unsigned int forced_fg;			/* forced forgound gc */
> +
> =20
>  	/*
>  	 * for stat information.
> @@ -415,6 +417,10 @@ struct f2fs_sb_info {
>  #endif
>  	unsigned int last_victim[2];		/* last victim segment # */
>  	spinlock_t stat_lock;			/* lock for stat operations */
> +
> +	/* For sysfs suppport */
> +	struct kobject s_kobj;
> +	struct completion s_kobj_unregister;
>  };
> =20
>  /*
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index ddc2c67..8041d70 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -29,10 +29,11 @@ static struct kmem_cache *winode_slab;
>  static int gc_thread_func(void *data)
>  {
>  	struct f2fs_sb_info *sbi =3D data;
> +	struct f2fs_gc_kthread *gc_th =3D sbi->gc_thread;
>  	wait_queue_head_t *wq =3D &sbi->gc_thread->gc_wait_queue_head;
>  	long wait_ms;
> =20
> -	wait_ms =3D GC_THREAD_MIN_SLEEP_TIME;
> +	wait_ms =3D gc_th->min_sleep_time;
> =20
>  	do {
>  		if (try_to_freeze())
> @@ -45,7 +46,7 @@ static int gc_thread_func(void *data)
>  			break;
> =20
>  		if (sbi->sb->s_writers.frozen >=3D SB_FREEZE_WRITE) {
> -			wait_ms =3D GC_THREAD_MAX_SLEEP_TIME;
> +			wait_ms =3D gc_th->max_sleep_time;
>  			continue;
>  		}
> =20
> @@ -66,15 +67,15 @@ static int gc_thread_func(void *data)
>  			continue;
> =20
>  		if (!is_idle(sbi)) {
> -			wait_ms =3D increase_sleep_time(wait_ms);
> +			wait_ms =3D increase_sleep_time(gc_th, wait_ms);
>  			mutex_unlock(&sbi->gc_mutex);
>  			continue;
>  		}
> =20
>  		if (has_enough_invalid_blocks(sbi))
> -			wait_ms =3D decrease_sleep_time(wait_ms);
> +			wait_ms =3D decrease_sleep_time(gc_th, wait_ms);
>  		else
> -			wait_ms =3D increase_sleep_time(wait_ms);
> +			wait_ms =3D increase_sleep_time(gc_th, wait_ms);
> =20
>  #ifdef CONFIG_F2FS_STAT_FS
>  		sbi->bg_gc++;
> @@ -82,7 +83,7 @@ static int gc_thread_func(void *data)
> =20
>  		/* if return value is not zero, no victim was selected */
>  		if (f2fs_gc(sbi))
> -			wait_ms =3D GC_THREAD_NOGC_SLEEP_TIME;
> +			wait_ms =3D gc_th->no_gc_sleep_time;
>  	} while (!kthread_should_stop());
>  	return 0;
>  }
> @@ -101,7 +102,12 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>  		goto out;
>  	}
> =20
> +	gc_th->min_sleep_time =3D DEF_GC_THREAD_MIN_SLEEP_TIME;
> +	gc_th->max_sleep_time =3D DEF_GC_THREAD_MAX_SLEEP_TIME;
> +	gc_th->no_gc_sleep_time =3D DEF_GC_THREAD_NOGC_SLEEP_TIME;
> +
>  	sbi->gc_thread =3D gc_th;
> +
>  	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
>  	sbi->gc_thread->f2fs_gc_task =3D kthread_run(gc_thread_func, sbi,
>  			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
> @@ -677,7 +683,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi)
>  {
>  	struct list_head ilist;
>  	unsigned int segno, i;
> -	int gc_type =3D BG_GC;
> +	int gc_type =3D sbi->forced_fg ? FG_GC : BG_GC;
>  	int nfree =3D 0;
>  	int ret =3D -1;
> =20
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 2c6a6bd..f4bf44c 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -13,9 +13,9 @@
>  						 * whether IO subsystem is idle
>  						 * or not
>  						 */
> -#define GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
> -#define GC_THREAD_MAX_SLEEP_TIME	60000
> -#define GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
> +#define DEF_GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
> +#define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
> +#define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
>  #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
>  #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
> =20
> @@ -25,6 +25,11 @@
>  struct f2fs_gc_kthread {
>  	struct task_struct *f2fs_gc_task;
>  	wait_queue_head_t gc_wait_queue_head;
> +
> +	/* for gc sleep time */
> +	unsigned int min_sleep_time;
> +	unsigned int max_sleep_time;
> +	unsigned int no_gc_sleep_time;
>  };
> =20
>  struct inode_entry {
> @@ -56,25 +61,25 @@ static inline block_t limit_free_user_blocks(struct f=
2fs_sb_info *sbi)
>  	return (long)(reclaimable_user_blocks * LIMIT_FREE_BLOCK) / 100;
>  }
> =20
> -static inline long increase_sleep_time(long wait)
> +static inline long increase_sleep_time(struct f2fs_gc_kthread *gc_th, lo=
ng wait)
>  {
> -	if (wait =3D=3D GC_THREAD_NOGC_SLEEP_TIME)
> +	if (wait =3D=3D gc_th->no_gc_sleep_time)
>  		return wait;
> =20
> -	wait +=3D GC_THREAD_MIN_SLEEP_TIME;
> -	if (wait > GC_THREAD_MAX_SLEEP_TIME)
> -		wait =3D GC_THREAD_MAX_SLEEP_TIME;
> +	wait +=3D gc_th->min_sleep_time;
> +	if (wait > gc_th->max_sleep_time)
> +		wait =3D gc_th->max_sleep_time;
>  	return wait;
>  }
> =20
> -static inline long decrease_sleep_time(long wait)
> +static inline long decrease_sleep_time(struct f2fs_gc_kthread *gc_th, lo=
ng wait)
>  {
> -	if (wait =3D=3D GC_THREAD_NOGC_SLEEP_TIME)
> -		wait =3D GC_THREAD_MAX_SLEEP_TIME;
> +	if (wait =3D=3D gc_th->no_gc_sleep_time)
> +		wait =3D gc_th->max_sleep_time;
> =20
> -	wait -=3D GC_THREAD_MIN_SLEEP_TIME;
> -	if (wait <=3D GC_THREAD_MIN_SLEEP_TIME)
> -		wait =3D GC_THREAD_MIN_SLEEP_TIME;
> +	wait -=3D gc_th->min_sleep_time;
> +	if (wait <=3D gc_th->min_sleep_time)
> +		wait =3D gc_th->min_sleep_time;
>  	return wait;
>  }
> =20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3ac305d..ef16d2c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -22,16 +22,20 @@
>  #include <linux/exportfs.h>
>  #include <linux/blkdev.h>
>  #include <linux/f2fs_fs.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> =20
>  #include "f2fs.h"
>  #include "node.h"
>  #include "segment.h"
>  #include "xattr.h"
> +#include "gc.h"
> =20
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/f2fs.h>
> =20
>  static struct kmem_cache *f2fs_inode_cachep;
> +static struct kset *f2fs_kset;
> =20
>  enum {
>  	Opt_gc_background_off,
> @@ -57,6 +61,136 @@ static match_table_t f2fs_tokens =3D {
>  	{Opt_err, NULL},
>  };
> =20
> +/*Sysfs support for F2fs */
> +struct f2fs_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct f2fs_attr *, struct f2fs_sb_info *, char *);
> +	ssize_t (*store)(struct f2fs_attr *, struct f2fs_sb_info *,
> +			 const char *, size_t);
> +	int offset;
> +};
> +
> +static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
> +			   struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct f2fs_gc_kthread *gc_kth =3D sbi->gc_thread;
> +	unsigned int *ui =3D (unsigned int *) (((char *)gc_kth) + a->offset);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", *ui);
> +}
> +
> +static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
> +			    struct f2fs_sb_info *sbi,
> +			    const char *buf, size_t count)
> +{
> +	struct f2fs_gc_kthread *gc_kth =3D sbi->gc_thread;
> +	unsigned int *ui =3D (unsigned int *) (((char *)gc_kth) + a->offset);
> +	unsigned long t;
> +	ssize_t ret;
> +
> +	ret =3D kstrtoul(skip_spaces(buf), 0, &t);
> +	if (ret < 0)
> +		return ret;
> +	*ui =3D t;
> +	return count;
> +}
> +
> +static ssize_t f2fs_forced_fg_trigger(struct f2fs_attr *a,
> +					struct f2fs_sb_info *sbi,
> +					const char *buf, size_t count)
> +{
> +	unsigned long t;
> +	ssize_t ret;
> +
> +	ret =3D kstrtoul(skip_spaces(buf), 0, &t);
> +	if (ret < 0)
> +		return ret;
> +	if (t =3D=3D 0)
> +		return count;
> +	else if (t =3D=3D 1) {
> +		sbi->forced_fg =3D t;
> +		mutex_lock(&sbi->gc_mutex);
> +		f2fs_gc(sbi);
> +		sbi->forced_fg =3D 0;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t f2fs_forced_fg_show(struct f2fs_attr *a,
> +					struct f2fs_sb_info *sbi,
> +							char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%u\n", sbi->forced_fg);
> +}
> +
> +static ssize_t f2fs_attr_show(struct kobject *kobj,
> +				struct attribute *attr, char *buf)
> +{
> +	struct f2fs_sb_info *sbi =3D container_of(kobj, struct f2fs_sb_info,
> +								s_kobj);
> +	struct f2fs_attr *a =3D container_of(attr, struct f2fs_attr, attr);
> +
> +	return a->show ? a->show(a, sbi, buf) : 0;
> +}
> +
> +static ssize_t f2fs_attr_store(struct kobject *kobj, struct attribute *a=
ttr,
> +						const char *buf, size_t len)
> +{
> +	struct f2fs_sb_info *sbi =3D container_of(kobj, struct f2fs_sb_info,
> +									s_kobj);
> +	struct f2fs_attr *a =3D container_of(attr, struct f2fs_attr, attr);
> +
> +	return a->store ? a->store(a, sbi, buf, len) : 0;
> +}
> +
> +static void f2fs_sb_release(struct kobject *kobj)
> +{
> +	struct f2fs_sb_info *sbi =3D container_of(kobj, struct f2fs_sb_info,
> +								s_kobj);
> +	complete(&sbi->s_kobj_unregister);
> +}
> +
> +#define F2FS_ATTR_OFFSET(_name, _mode, _show, _store, _elname) \
> +static struct f2fs_attr f2fs_attr_##_name =3D {			\
> +	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },	\
> +	.show	=3D _show,					\
> +	.store	=3D _store,					\
> +	.offset =3D offsetof(struct f2fs_gc_kthread, _elname),	\
> +}
> +
> +#define F2FS_ATTR(name, mode, show, store) \
> +static struct f2fs_attr f2fs_attr_##name =3D __ATTR(name, mode, show, st=
ore)
> +
> +#define F2FS_RW_ATTR(name, elname)	\
> +	F2FS_ATTR_OFFSET(name, 0644, f2fs_sbi_show, f2fs_sbi_store, elname)
> +
> +F2FS_RW_ATTR(gc_min_sleep_time, min_sleep_time);
> +F2FS_RW_ATTR(gc_max_sleep_time, max_sleep_time);
> +F2FS_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
> +F2FS_ATTR(gc_forced_fg, 0644, f2fs_forced_fg_show, f2fs_forced_fg_trigge=
r);
> +
> +#define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> +static struct attribute *f2fs_attrs[] =3D {
> +	ATTR_LIST(gc_min_sleep_time),
> +	ATTR_LIST(gc_max_sleep_time),
> +	ATTR_LIST(gc_no_gc_sleep_time),
> +	ATTR_LIST(gc_forced_fg),
> +	NULL,
> +};
> +
> +static const struct sysfs_ops f2fs_attr_ops =3D {
> +	.show   =3D f2fs_attr_show,
> +	.store  =3D f2fs_attr_store,
> +};
> +
> +static struct kobj_type f2fs_ktype =3D {
> +	.default_attrs  =3D f2fs_attrs,
> +	.sysfs_ops      =3D &f2fs_attr_ops,
> +	.release        =3D f2fs_sb_release,
> +};
> +
> +
>  void f2fs_msg(struct super_block *sb, const char *level, const char *fmt=
, ...)
>  {
>  	struct va_format vaf;
> @@ -582,6 +716,7 @@ static int f2fs_fill_super(struct super_block *sb, vo=
id *data, int silent)
>  		mutex_init(&sbi->fs_lock[i]);
>  	mutex_init(&sbi->node_write);
>  	sbi->por_doing =3D 0;
> +	sbi->forced_fg =3D 0;
>  	spin_lock_init(&sbi->stat_lock);
>  	init_rwsem(&sbi->bio_sem);
>  	init_sb_info(sbi);
> @@ -691,6 +826,14 @@ static int f2fs_fill_super(struct super_block *sb, v=
oid *data, int silent)
>  					"the device does not support discard");
>  	}
> =20
> +	sbi->s_kobj.kset =3D f2fs_kset;
> +	init_completion(&sbi->s_kobj_unregister);
> +	err =3D kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
> +							"%s", sb->s_id);
> +	if (err)
> +		goto fail;
> +
> +
>  	return 0;
>  fail:
>  	stop_gc_thread(sbi);
> @@ -765,6 +908,9 @@ static int __init init_f2fs_fs(void)
>  	err =3D create_checkpoint_caches();
>  	if (err)
>  		goto fail;
> +	f2fs_kset =3D kset_create_and_add("f2fs", NULL, fs_kobj);
> +	if (!f2fs_kset)
> +		goto fail;
>  	err =3D register_filesystem(&f2fs_fs_type);
>  	if (err)
>  		goto fail;
> @@ -781,6 +927,7 @@ static void __exit exit_f2fs_fs(void)
>  	destroy_gc_caches();
>  	destroy_node_manager_caches();
>  	destroy_inodecache();
> +	kset_unregister(f2fs_kset);
>  }
> =20
>  module_init(init_f2fs_fs)

--=20
Jaegeuk Kim
Samsung

--=-OqY9OrQ1q4scaTORAaCX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRorsOAAoJEEAUqH6CSFDSgqcP/0ORTaQr8edrTbrnX73EPlUy
pD+SRNzCpS4bQzbUx4tqOWqdCQ1tTVLsOMW0JmvaN5s0tBhcIBVp8Ie/JoZarBIV
f5gjPgXbd51ialT3SgUp6//vOYEK5Wgi4WLYJG2RxPg8krJjywTkvtS8G0aACsP0
MfyesXK65OEXxRXiEGO1ujS6ca6bm0xPwgbmAWr6wHeWzFIuK7NnAKJeUrC1LeMs
Clt9FW8W+ysnp6lkIvnG/LJ8guLAFVfQxBtVOQ0imsdntmnwlfg2nBfFT1k4Fm28
hreRcHre8MJ2v6Y6LqzoRL9IrmHfBXgerfoIpMdkwplMarc1UaKEzOACb1vV5aHs
ZBiBPHvn9BQZEfKFcBQuVVQu247OlCerYgnrlZFxxoCTSLi53WwRlFEPag+DFBBJ
z/ITZPj3cm37cJ9L5AF3L0shWNeVzFQno+u18yZ2yNW+ReU185WqRVkKdmRelwkh
t41H0ppt6KTOMmhEeTuh5e5d5JBPYsYnS+WVHvI1b1cP/n7eyvd82BX75w1cxLKN
p8v3oBUh7XpgvvVBhPJ6JYAzxNvF0Fml41/V8ura+wvs31ZHO+2lh0n8Bz8tA03S
cY1NFezV4BehZ2lBXFWNh4rnxfoZ5yujoAzWLbSIIAbnVr29IYew1i9Y/rNGQbgQ
MB2fIT5IelAfDMVlO0rb
=U/uz
-----END PGP SIGNATURE-----

--=-OqY9OrQ1q4scaTORAaCX--



--===============5046686884936165052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--===============5046686884936165052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============5046686884936165052==--
