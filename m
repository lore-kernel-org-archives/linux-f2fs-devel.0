From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: set ioprio of GC kthread to idle
Date: Tue, 26 Sep 2017 19:44:56 +0800
Message-ID: <142cb691-1df6-eb4d-e599-27ca372ebad2@huawei.com>
References: <20170926023626.864-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dwoIZ-0002C5-H0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Sep 2017 11:45:11 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dwoIX-0003Kw-9A
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Sep 2017 11:45:11 +0000
In-Reply-To: <20170926023626.864-1-qkrwngud825@gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Park Ju Hyung <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Park,

On 2017/9/26 10:36, Park Ju Hyung wrote:
> GC should run conservatively as possible to reduce latency spikes to the user.
> 
> Setting ioprio to idle class will allow the kernel to schedule GC thread's I/O
> to not affect any other processes' I/O requests.

IMO, we'd better not simply changing our IO priority of background GC, because
before doing real garbage collection we will try to grab gc_mutex lock, which is
shared with checkpoint flow. So while background GC is running, if there it
comes higher priority IOs and a sudden checkpoint, the checkpoint flow will be
block for longer time when it try to grab gc_mutex, since most time checkpoint
comes from foreground application, so it may effects user experience.

What about adding IO aware point before triggering each IO inside GC flow, and
when it hits other IO, let's give up background GC?

Thanks,

> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> ---
>  fs/f2fs/gc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index bfe6a8ccc3a0..54d2d74e9afe 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -143,6 +143,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
>  		kfree(gc_th);
>  		sbi->gc_thread = NULL;
>  	}
> +	set_task_ioprio(sbi->gc_thread->f2fs_gc_task,
> +			IOPRIO_PRIO_VALUE(IOPRIO_CLASS_IDLE, 0));
>  out:
>  	return err;
>  }
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
