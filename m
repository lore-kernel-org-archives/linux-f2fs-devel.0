From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: hide unused procfs helpers
Date: Fri, 13 Jul 2018 17:02:06 +0800
Message-ID: <643f0ef2-f74a-8ea9-b24c-fb1cc231b8ba@huawei.com>
References: <20180713035304.18520-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713035304.18520-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

On 2018/7/13 11:53, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> fs/f2fs/sysfs.c:519:12: warning: ‘segment_info_seq_show’ defined but not used [-Wunused-function]
>  static int segment_info_seq_show(struct seq_file *seq, void *offset)
>             ^
> fs/f2fs/sysfs.c:546:12: warning: ‘segment_bits_seq_show’ defined but not used [-Wunused-function]
>  static int segment_bits_seq_show(struct seq_file *seq, void *offset)
>             ^
> fs/f2fs/sysfs.c:570:12: warning: ‘iostat_info_seq_show’ defined but not used [-Wunused-function]
>  static int iostat_info_seq_show(struct seq_file *seq, void *offset)
> 
> We can fix the warning by adding the same #ifdef around them.

Could you check below patch sent from Randy Dunlap? It has already fixed this
issue, anyway, thanks for your patch. :)

[PATCH] f2fs: fix defined but not used build warnings

Thanks,

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/f2fs/sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 2e7e611..7d45e65 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -516,6 +516,7 @@ static struct kobject f2fs_feat = {
>  	.kset	= &f2fs_kset,
>  };
>  
> +#ifdef CONFIG_PROC_FS
>  static int segment_info_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct super_block *sb = seq->private;
> @@ -608,6 +609,7 @@ static int iostat_info_seq_show(struct seq_file *seq, void *offset)
>  
>  	return 0;
>  }
> +#endif
>  
>  int __init f2fs_init_sysfs(void)
>  {
> 
