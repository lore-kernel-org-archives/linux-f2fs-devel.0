From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 2/2] f2fs: add sysfs entries to select the gc
	policy
Date: Thu, 01 Aug 2013 11:20:39 +0800
Message-ID: <51F9D407.8040703@cn.fujitsu.com>
References: <1375281193-15560-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1V4jVG-0007Qw-2r
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Aug 2013 03:24:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V4jVD-00060F-IN for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Aug 2013 03:24:38 +0000
In-Reply-To: <1375281193-15560-1-git-send-email-linkinjeon@gmail.com>
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
Cc: Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jeon,

On 07/31/2013 10:33 PM, Namjae Jeon wrote:

> From: Namjae Jeon <namjae.jeon@samsung.com>
> 
> Add sysfs entries namely gc_long_idle and gc_short_idle to control the
> gc policy. Where long idle corresponds to selecting a cost benefit approach,
> while short idle corresponds to selecting a greedy approach to garbage
> collection. The selection is mutually exclusive one approach will work at
> any point.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |   12 +++++++
>  Documentation/filesystems/f2fs.txt      |    8 +++++
>  fs/f2fs/gc.c                            |   22 ++++++++++--
>  fs/f2fs/gc.h                            |    4 +++
>  fs/f2fs/super.c                         |   59 +++++++++++++++++++++++++++++--
>  5 files changed, 99 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 5f44095..96b62ea 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -19,4 +19,16 @@ Description:
>  		 Controls the default sleep time for gc_thread. Time
>  		 is in milliseconds.
>  
> +What:		/sys/fs/f2fs/<disk>/gc_long_idle
> +Date:		July 2013
> +Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
> +Description:
> +		 Controls the selection of gc policy. long_idle is used
> +		 to select the cost benefit approach for garbage collection.
>  
> +What:		/sys/fs/f2fs/<disk>/gc_short_idle
> +Date:		July 2013
> +Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
> +Description:
> +		 Controls the selection of gc policy. short_idle is used
> +		 to select the greedy approach for garbage collection.
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 2e9e873..06dd5d7 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -158,6 +158,14 @@ Files in /sys/fs/f2fs/<devname>
>                                time for the garbage collection thread. Time is
>                                in milliseconds.
>  
> + gc_long_idle                 This parameter controls the selection of cost
> +                              benefit approach for garbage collectoin. Writing
> +                              1 to this file will select the cost benefit policy.
> +
> + gc_short_idle                This parameter controls the selection of greedy
> +                              approach for the garbage collection. Writing 1
> +                              to this file will select the greedy policy.

Why introduce two opposite attributes? It'll cause some confusion condition if we
double enable/disable them.

> +
>  ================================================================================
>  USAGE
>  ================================================================================
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 60d4f67..af2d9d7 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -106,6 +106,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>  	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
>  	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
>  
> +	gc_th->long_idle = gc_th->short_idle = 0;
> +
>  	sbi->gc_thread = gc_th;
>  	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
>  	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
> @@ -130,9 +132,23 @@ void stop_gc_thread(struct f2fs_sb_info *sbi)
>  	sbi->gc_thread = NULL;
>  }
>  
> -static int select_gc_type(int gc_type)
> +static int select_gc_type(struct f2fs_gc_kthread *gc_th, int gc_type)
>  {
> -	return (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
> +	int gc_mode;
> +
> +	if (gc_th) {
> +		if (gc_th->long_idle) {
> +			gc_mode = GC_CB;
> +			goto out;
> +		} else if (gc_th->short_idle) {
> +			gc_mode = GC_GREEDY;
> +			goto out;
> +		}
> +	}
> +
> +	gc_mode = (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
> +out:
> +	return gc_mode;
>  }
>  
>  static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
> @@ -145,7 +161,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>  		p->dirty_segmap = dirty_i->dirty_segmap[type];
>  		p->ofs_unit = 1;
>  	} else {
> -		p->gc_mode = select_gc_type(gc_type);
> +		p->gc_mode = select_gc_type(sbi->gc_thread, gc_type);
>  		p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
>  		p->ofs_unit = sbi->segs_per_sec;
>  	}
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index f4bf44c..b2faae5 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -30,6 +30,10 @@ struct f2fs_gc_kthread {
>  	unsigned int min_sleep_time;
>  	unsigned int max_sleep_time;
>  	unsigned int no_gc_sleep_time;
> +
> +	/* for changing gc mode */
> +	unsigned int long_idle;
> +	unsigned int short_idle;

The same issue I mentioned in the front patch, they're per f2fs sb infos.

Regards,
Gu

>  };
>  
>  struct inode_entry {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 30de280..3db806b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -107,6 +107,56 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  	return count;
>  }
>  
> +static ssize_t f2fs_gc_long_idle_store(struct f2fs_attr *a,
> +			    struct f2fs_sb_info *sbi,
> +			    const char *buf, size_t count)
> +{
> +	struct f2fs_gc_kthread *gc_kth = sbi->gc_thread;
> +	unsigned long t;
> +	ssize_t ret;
> +
> +	if (!gc_kth)
> +		return -EFAULT;
> +
> +	ret = kstrtoul(skip_spaces(buf), 0, &t);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (t == 0)
> +		gc_kth->long_idle = 0;
> +	else if (t == 1) {
> +		gc_kth->long_idle = 1;
> +		gc_kth->short_idle = 0;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t f2fs_gc_short_idle_store(struct f2fs_attr *a,
> +			    struct f2fs_sb_info *sbi,
> +			    const char *buf, size_t count)
> +{
> +	struct f2fs_gc_kthread *gc_kth = sbi->gc_thread;
> +	unsigned long t;
> +	ssize_t ret;
> +
> +	if (!gc_kth)
> +		return -EFAULT;
> +
> +	ret = kstrtoul(skip_spaces(buf), 0, &t);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (t == 0)
> +		gc_kth->short_idle = 0;
> +	else if (t == 1) {
> +		gc_kth->short_idle = 1;
> +		gc_kth->long_idle = 0;
> +	}
> +
> +	return count;
> +}
> +
>  static ssize_t f2fs_attr_show(struct kobject *kobj,
>  				struct attribute *attr, char *buf)
>  {
> @@ -142,21 +192,24 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
>  	.offset = offsetof(struct f2fs_gc_kthread, _elname),	\
>  }
>  
> -#define F2FS_ATTR(name, mode, show, store) \
> -static struct f2fs_attr f2fs_attr_##name = __ATTR(name, mode, show, store)
> -
>  #define F2FS_RW_ATTR(name, elname)	\
>  	F2FS_ATTR_OFFSET(name, 0644, f2fs_sbi_show, f2fs_sbi_store, elname)
>  
>  F2FS_RW_ATTR(gc_min_sleep_time, min_sleep_time);
>  F2FS_RW_ATTR(gc_max_sleep_time, max_sleep_time);
>  F2FS_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
> +F2FS_ATTR_OFFSET(gc_long_idle, 0644, f2fs_sbi_show,
> +			 f2fs_gc_long_idle_store, long_idle);
> +F2FS_ATTR_OFFSET(gc_short_idle, 0644, f2fs_sbi_show,
> +			 f2fs_gc_short_idle_store, short_idle);
>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(gc_min_sleep_time),
>  	ATTR_LIST(gc_max_sleep_time),
>  	ATTR_LIST(gc_no_gc_sleep_time),
> +	ATTR_LIST(gc_long_idle),
> +	ATTR_LIST(gc_short_idle),
>  	NULL,
>  };
>  



------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
