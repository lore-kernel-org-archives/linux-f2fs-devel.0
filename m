From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: expose /sys/fs/f2fs/features
Date: Thu, 27 Jul 2017 13:36:06 +0800
Message-ID: <3e7ed741-8aee-02a3-a04a-b62a72beb8ef@huawei.com>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
 <765ab60d-b0fc-7233-83b5-86a617e4134f@kernel.org>
 <20170726214326.GC66153@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dabTH-0001A8-Rg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jul 2017 05:36:27 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dabTD-00028z-NB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Jul 2017 05:36:27 +0000
In-Reply-To: <20170726214326.GC66153@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/7/27 5:43, Jaegeuk Kim wrote:
> On 07/26, Chao Yu wrote:
>> On 2017/7/26 9:29, Jaegeuk Kim wrote:
>>> This patch exposes what features are supported by current f2fs build to sysfs
>>> entry.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Minor thing, can you exchange below function name to follow ext4:
>> f2fs_init_sysfs <-> f2fs_register_sysfs
>> f2fs_exit_sysfs <-> f2fs_unregister_sysfs
>>
>>From 4cf8a3138f3ee171750ae279fefd4de672a0ee29 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 26 Jul 2017 11:24:13 -0700
> Subject: [PATCH] f2fs: avoid naming confusion of sysfs init
> 
> This patch changes the function names of sysfs init to follow ext4.
> 
> f2fs_init_sysfs <-> f2fs_register_sysfs
> f2fs_exit_sysfs <-> f2fs_unregister_sysfs
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reivewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h  |  8 ++++----
>  fs/f2fs/super.c | 10 +++++-----
>  fs/f2fs/sysfs.c |  8 ++++----
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d486539086b6..a1bfd0b9be44 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2820,10 +2820,10 @@ void destroy_extent_cache(void);
>  /*
>   * sysfs.c
>   */
> -int __init f2fs_register_sysfs(void);
> -void f2fs_unregister_sysfs(void);
> -int f2fs_init_sysfs(struct f2fs_sb_info *sbi);
> -void f2fs_exit_sysfs(struct f2fs_sb_info *sbi);
> +int __init f2fs_init_sysfs(void);
> +void f2fs_exit_sysfs(void);
> +int f2fs_register_sysfs(struct f2fs_sb_info *sbi);
> +void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi);
>  
>  /*
>   * crypto support
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1241739f4d54..12513caabe6e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -649,7 +649,7 @@ static void f2fs_put_super(struct super_block *sb)
>  
>  	kfree(sbi->ckpt);
>  
> -	f2fs_exit_sysfs(sbi);
> +	f2fs_unregister_sysfs(sbi);
>  
>  	sb->s_fs_info = NULL;
>  	if (sbi->s_chksum_driver)
> @@ -2145,7 +2145,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_root_inode;
>  	}
>  
> -	err = f2fs_init_sysfs(sbi);
> +	err = f2fs_register_sysfs(sbi);
>  	if (err)
>  		goto free_root_inode;
>  
> @@ -2216,7 +2216,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  free_sysfs:
>  	f2fs_sync_inode_meta(sbi);
> -	f2fs_exit_sysfs(sbi);
> +	f2fs_unregister_sysfs(sbi);
>  free_root_inode:
>  	dput(sb->s_root);
>  	sb->s_root = NULL;
> @@ -2334,7 +2334,7 @@ static int __init init_f2fs_fs(void)
>  	err = create_extent_cache();
>  	if (err)
>  		goto free_checkpoint_caches;
> -	err = f2fs_register_sysfs();
> +	err = f2fs_init_sysfs();
>  	if (err)
>  		goto free_extent_cache;
>  	err = register_shrinker(&f2fs_shrinker_info);
> @@ -2373,7 +2373,7 @@ static void __exit exit_f2fs_fs(void)
>  	f2fs_destroy_root_stats();
>  	unregister_filesystem(&f2fs_fs_type);
>  	unregister_shrinker(&f2fs_shrinker_info);
> -	f2fs_unregister_sysfs();
> +	f2fs_exit_sysfs();
>  	destroy_extent_cache();
>  	destroy_checkpoint_caches();
>  	destroy_segment_manager_caches();
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 71191d89917d..5a78b9af92ef 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -304,7 +304,7 @@ static const struct file_operations f2fs_seq_##_name##_fops = {		\
>  F2FS_PROC_FILE_DEF(segment_info);
>  F2FS_PROC_FILE_DEF(segment_bits);
>  
> -int __init f2fs_register_sysfs(void)
> +int __init f2fs_init_sysfs(void)
>  {
>  	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
>  
> @@ -314,13 +314,13 @@ int __init f2fs_register_sysfs(void)
>  	return 0;
>  }
>  
> -void f2fs_unregister_sysfs(void)
> +void f2fs_exit_sysfs(void)
>  {
>  	kset_unregister(f2fs_kset);
>  	remove_proc_entry("fs/f2fs", NULL);
>  }
>  
> -int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
> +int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>  {
>  	struct super_block *sb = sbi->sb;
>  	int err;
> @@ -351,7 +351,7 @@ int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
>  	return err;
>  }
>  
> -void f2fs_exit_sysfs(struct f2fs_sb_info *sbi)
> +void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>  {
>  	kobject_del(&sbi->s_kobj);
>  	kobject_put(&sbi->s_kobj);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
