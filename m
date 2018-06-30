From: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH] f2fs: avoid the global name 'fault_name'
Date: Sun, 1 Jul 2018 00:06:04 +0800
Message-ID: <174b5d84-8d41-4b8e-4e87-39f8cc3948ae@huawei.com>
References: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gaoxiang25@huawei.com>) id 1fZIOi-0000DZ-9n
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Jun 2018 16:06:52 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fZIOg-00DUJd-Bb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 Jun 2018 16:06:52 +0000
In-Reply-To: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net


Oh, I just found the same patch written by Chao at:
https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev

I just fixed the erofs name conflicts, so fixed f2fs as well.
Please ignore this one.

Thanks, 
Gao Xiang

On 2018/6/30 23:57, Gao Xiang wrote:
> Non-prefix global name 'fault_name' will pollute global
> namespace, fix it.
> 
> Refer to:
> https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html
> 
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/f2fs/f2fs.h  | 4 ++--
>  fs/f2fs/super.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4d8b1de..11a2e09 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -65,7 +65,7 @@ struct f2fs_fault_info {
>  	unsigned int inject_type;
>  };
>  
> -extern char *fault_name[FAULT_MAX];
> +extern char *f2fs_fault_name[FAULT_MAX];
>  #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
>  #endif
>  
> @@ -1279,7 +1279,7 @@ struct f2fs_sb_info {
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  #define f2fs_show_injection_info(type)				\
>  	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
> -		KERN_INFO, fault_name[type],			\
> +		KERN_INFO, f2fs_fault_name[type],		\
>  		__func__, __builtin_return_address(0))
>  static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>  {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3995e92..df12dcd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -41,7 +41,7 @@
>  
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  
> -char *fault_name[FAULT_MAX] = {
> +char *f2fs_fault_name[FAULT_MAX] = {
>  	[FAULT_KMALLOC]		= "kmalloc",
>  	[FAULT_KVMALLOC]	= "kvmalloc",
>  	[FAULT_PAGE_ALLOC]	= "page alloc",
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
