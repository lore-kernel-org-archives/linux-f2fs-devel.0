From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: issue discard commands if gc_urgent is set
Date: Mon, 28 Aug 2017 17:20:35 +0800
Message-ID: <a392efd5-a0af-68d7-134b-d20bccd3c3ce@huawei.com>
References: <20170821205647.67775-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821205647.67775-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/22 4:56, Jaegeuk Kim wrote:
> It's time to issue all the discard commands, if user sets the idle time.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 6 +++++-
>  fs/f2fs/sysfs.c   | 5 +++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1387925a0d83..e3922f902c8c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -21,6 +21,7 @@
>  #include "f2fs.h"
>  #include "segment.h"
>  #include "node.h"
> +#include "gc.h"
>  #include "trace.h"
>  #include <trace/events/f2fs.h>
>  
> @@ -1194,8 +1195,11 @@ static int issue_discard_thread(void *data)
>  		if (kthread_should_stop())
>  			return 0;
>  
> -		if (dcc->discard_wake)
> +		if (dcc->discard_wake) {
>  			dcc->discard_wake = 0;
> +			if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> +				mark_discard_range_all(sbi);
> +		}
>  
>  		sb_start_intwrite(sbi->sb);
>  
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 4bcaa9059026..b9ad9041559f 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -178,8 +178,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
>  		f2fs_reset_iostat(sbi);
>  	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
> +		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
>  		sbi->gc_thread->gc_wake = 1;
>  		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
> +
> +		dcc->discard_wake = 1;
> +		wake_up_interruptible_all(&dcc->discard_wait_queue);
>  	}
>  
>  	return count;
> 
