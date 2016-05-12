From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v2 4/4] f2fs: move fault injection to
	sysfs
Date: Thu, 12 May 2016 13:12:52 -0700
Message-ID: <20160512201252.GA23536@jaegeuk.gateway>
References: <1462957697-6900-1-git-send-email-shengyong1@huawei.com>
	<1462957697-6900-4-git-send-email-shengyong1@huawei.com>
	<5733FC59.4080300@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b0wyj-0007Do-T9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 May 2016 20:13:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b0wyi-0005O5-LB
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 May 2016 20:13:01 +0000
Content-Disposition: inline
In-Reply-To: <5733FC59.4080300@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

Could you send one patch which has 2, 3, and 4 together?
And also, we don't need drop the mount option.
Instead, we can turn on all the fault types with default values, once we get
the option. Then, we can turn off any specific types dynamically.

Thanks,

On Thu, May 12, 2016 at 11:45:29AM +0800, Sheng Yong wrote:
> Replace mount option "f2fs_injection" by injection attributes in sysfs.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fs/f2fs/f2fs.h  | 24 ++++++++++++++++++------
>  fs/f2fs/super.c | 18 ------------------
>  2 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e18390b..81e3fad 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -60,15 +60,28 @@ struct f2fs_fault_info {
>  };
> 
>  extern struct f2fs_fault_info f2fs_fault;
> -extern u32 f2fs_fault_rate;
> -extern atomic_t f2fs_ops;
>  extern char *fault_name[FAULT_MAX];
> 
>  static inline bool time_to_inject(int type)
>  {
> -	atomic_inc(&f2fs_ops);
> -	if (f2fs_fault_rate && (atomic_read(&f2fs_ops) >= f2fs_fault_rate)) {
> -		atomic_set(&f2fs_ops, 0);
> +	if (!f2fs_fault.inject_rate)
> +		return false;
> +	if (type == FAULT_KMALLOC && !f2fs_fault.inject_kmalloc)
> +		return false;
> +	else if (type == FAULT_PAGE_ALLOC && !f2fs_fault.inject_page_alloc)
> +		return false;
> +	else if (type == FAULT_ALLOC_NID && !f2fs_fault.inject_nid_alloc)
> +		return false;
> +	else if (type == FAULT_ORPHAN && !f2fs_fault.inject_orphan)
> +		return false;
> +	else if (type == FAULT_BLOCK && !f2fs_fault.inject_block)
> +		return false;
> +	else if (type == FAULT_DIR_DEPTH && !f2fs_fault.inject_dir_depth)
> +		return false;
> +
> +	atomic_inc(&f2fs_fault.inject_ops);
> +	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
> +		atomic_set(&f2fs_fault.inject_ops, 0);
>  		printk("%sF2FS-fs : inject %s in %pF\n",
>  				KERN_INFO,
>  				fault_name[type],
> @@ -98,7 +111,6 @@ static inline bool time_to_inject(int type)
>  #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
>  #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
>  #define F2FS_MOUNT_DATA_FLUSH		0x00008000
> -#define F2FS_MOUNT_FAULT_INJECTION	0x00010000
> 
>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a9066e4..df36152 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -41,8 +41,6 @@ static struct kset *f2fs_kset;
> 
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  struct f2fs_fault_info f2fs_fault;
> -u32 f2fs_fault_rate = 0;
> -atomic_t f2fs_ops;
> 
>  char *fault_name[FAULT_MAX] = {
>  	[FAULT_KMALLOC]		= "kmalloc",
> @@ -89,7 +87,6 @@ enum {
>  	Opt_noextent_cache,
>  	Opt_noinline_data,
>  	Opt_data_flush,
> -	Opt_fault_injection,
>  	Opt_err,
>  };
> 
> @@ -115,7 +112,6 @@ static match_table_t f2fs_tokens = {
>  	{Opt_noextent_cache, "noextent_cache"},
>  	{Opt_noinline_data, "noinline_data"},
>  	{Opt_data_flush, "data_flush"},
> -	{Opt_fault_injection, "fault_injection=%u"},
>  	{Opt_err, NULL},
>  };
> 
> @@ -365,9 +361,6 @@ static int parse_options(struct super_block *sb, char *options)
>  	char *p, *name;
>  	int arg = 0;
> 
> -#ifdef CONFIG_F2FS_FAULT_INJECTION
> -	f2fs_fault_rate = 0;
> -#endif
>  	if (!options)
>  		return 0;
> 
> @@ -501,17 +494,6 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_data_flush:
>  			set_opt(sbi, DATA_FLUSH);
>  			break;
> -		case Opt_fault_injection:
> -			if (args->from && match_int(args, &arg))
> -				return -EINVAL;
> -#ifdef CONFIG_F2FS_FAULT_INJECTION
> -			f2fs_fault_rate = arg;
> -			atomic_set(&f2fs_ops, 0);
> -#else
> -			f2fs_msg(sb, KERN_INFO,
> -				"FAULT_INJECTION was not selected");
> -#endif
> -			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> -- 
> 2.7.1

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
