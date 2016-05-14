From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 2/2] f2fs: add fault injection to sysfs
Date: Fri, 13 May 2016 17:57:27 -0700
Message-ID: <20160514005727.GC27525@jaegeuk.gateway>
References: <1463106160-16183-1-git-send-email-shengyong1@huawei.com>
	<1463106160-16183-2-git-send-email-shengyong1@huawei.com>
	<20160513024746.GA26357@jaegeuk.gateway>
	<57354D7C.7040507@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b1Nti-0002QC-9F
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 00:57:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b1Ntg-00050J-MZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 00:57:38 +0000
Content-Disposition: inline
In-Reply-To: <57354D7C.7040507@huawei.com>
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

On Fri, May 13, 2016 at 11:43:56AM +0800, Sheng Yong wrote:
> Hi, Kim
> 
> On 5/13/2016 10:47 AM, Jaegeuk Kim wrote:
> > Hi Sheng,
> > 
> > On Fri, May 13, 2016 at 10:22:40AM +0800, Sheng Yong wrote:
> >> This patch introduces a new struct f2fs_fault_info and a global f2fs_fault
> >> to save fault injection status. All fault injection interfaces are created
> >> in /sys/fs/f2fs/fault_injection during initializing f2fs module.
> >>
> >> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> >> ---
> >>  fs/f2fs/f2fs.h  | 35 +++++++++++++++++++----
> >>  fs/f2fs/super.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >>  2 files changed, 109 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index ec978b44..54b9984 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -48,15 +48,40 @@ enum {
> >>  	FAULT_MAX,
> >>  };
> >>  
> >> -extern u32 f2fs_fault_rate;
> >> -extern atomic_t f2fs_ops;
> >> +struct f2fs_fault_info {
> >> +	unsigned int inject_rate;
> >> +	atomic_t inject_ops;
> >> +	unsigned int inject_kmalloc;
> >> +	unsigned int inject_page_alloc;
> >> +	unsigned int inject_nid_alloc;
> >> +	unsigned int inject_orphan;
> >> +	unsigned int inject_block;
> >> +	unsigned int inject_dir_depth;
> > 
> > How about using a single variable to represent each types as bits?
> Yes, we can do this. But in this way, we may need new show and store
> functions for fault injection attributes to specify the corresponding
> bit in inject_type. This seems a little bit duplicated. Or we have to
> add all FAULT_xxx to attribute types like the following, so that
> f2fs_sbi_[show|store] can tell which bit is specified. I'm not sure
> which way should be used :(

I meant one sysfs entry, and user needs to set proper bits at once accordingly.

Something like this?

struct f2fs_fault_info {
	unsigned int inject_rate;
	unsigned int inject_type;
};

F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);

In f2fs_sbi_store(),
#ifdef CONFIG_F2FS_FAULT_INJECTION
	if (a->struct_type == FAULT_INFO_TYPE && t >= (1 << FAULT_MAX))
		return -EINVAL;
#endif

static struct attribute *f2fs_fault_attrs[] = {
	ATTR_LIST(inject_rate),
	ATTR_LIST(inject_type),
	NULL
};

Thanks,

}
>
> 
> enum {
> 	GC_THREAD,
> 	SM_INOF,
> 	NM_INFO,
> 	F2FS_SBI,
> #ifdef CONFIG_F2FS_FAULT_INJECTION
> 	FAULT_INFO_RATE,
> 	FAULT_KMALLOC,
> 	FAULT_PAGE_ALLOC,
> 	...
> #endif
> };
> 
> thanks,
> Sheng
> > 
> >> +};
> >> +
> >> +extern struct f2fs_fault_info f2fs_fault;
> >>  extern char *fault_name[FAULT_MAX];
> >>  
> >>  static inline bool time_to_inject(int type)
> >>  {
> >> -	atomic_inc(&f2fs_ops);
> >> -	if (f2fs_fault_rate && (atomic_read(&f2fs_ops) >= f2fs_fault_rate)) {
> >> -		atomic_set(&f2fs_ops, 0);
> >> +	if (!f2fs_fault.inject_rate)
> >> +		return false;
> >> +	if (type == FAULT_KMALLOC && !f2fs_fault.inject_kmalloc)
> > 
> > Something like:
> > 	if (type == FAULT_KMALLOC && !(f2fs_fault.type & (1 << FAULT_MALLOC)))
> > 
> >> +		return false;
> >> +	else if (type == FAULT_PAGE_ALLOC && !f2fs_fault.inject_page_alloc)
> >> +		return false;
> >> +	else if (type == FAULT_ALLOC_NID && !f2fs_fault.inject_nid_alloc)
> >> +		return false;
> >> +	else if (type == FAULT_ORPHAN && !f2fs_fault.inject_orphan)
> >> +		return false;
> >> +	else if (type == FAULT_BLOCK && !f2fs_fault.inject_block)
> >> +		return false;
> >> +	else if (type == FAULT_DIR_DEPTH && !f2fs_fault.inject_dir_depth)
> >> +		return false;
> >> +
> >> +	atomic_inc(&f2fs_fault.inject_ops);
> >> +	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
> >> +		atomic_set(&f2fs_fault.inject_ops, 0);
> >>  		printk("%sF2FS-fs : inject %s in %pF\n",
> >>  				KERN_INFO,
> >>  				fault_name[type],
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 0e54e84..02c432c 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -40,8 +40,7 @@ static struct kmem_cache *f2fs_inode_cachep;
> >>  static struct kset *f2fs_kset;
> >>  
> >>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >> -u32 f2fs_fault_rate = 0;
> >> -atomic_t f2fs_ops;
> >> +struct f2fs_fault_info f2fs_fault;
> >>  
> >>  char *fault_name[FAULT_MAX] = {
> >>  	[FAULT_KMALLOC]		= "kmalloc",
> >> @@ -51,6 +50,21 @@ char *fault_name[FAULT_MAX] = {
> >>  	[FAULT_BLOCK]		= "no more block",
> >>  	[FAULT_DIR_DEPTH]	= "too big dir depth",
> >>  };
> >> +
> >> +static void f2fs_build_fault_attr(unsigned int rate)
> >> +{
> >> +	if (rate) {
> >> +		f2fs_fault.inject_rate = rate;
> >> +		atomic_set(&f2fs_fault.inject_ops, 0);
> >> +		f2fs_fault.inject_kmalloc = 1;
> >> +		f2fs_fault.inject_page_alloc = 1;
> >> +		f2fs_fault.inject_nid_alloc = 1;
> >> +		f2fs_fault.inject_orphan = 1;
> >> +		f2fs_fault.inject_block = 1;
> >> +		f2fs_fault.inject_dir_depth = 1;
> >> +	} else
> >> +		memset(&f2fs_fault, 0, sizeof(struct f2fs_fault_info));
> > 
> > Need to do like:
> > 
> > 	if () {
> > 	} else {
> > 	}
> > 
> >> +}
> >>  #endif
> >>  
> >>  /* f2fs-wide shrinker description */
> >> @@ -118,6 +132,10 @@ enum {
> >>  	SM_INFO,	/* struct f2fs_sm_info */
> >>  	NM_INFO,	/* struct f2fs_nm_info */
> >>  	F2FS_SBI,	/* struct f2fs_sb_info */
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	FAULT_INFO_RATE,
> >> +	FAULT_INFO,
> >> +#endif
> >>  };
> >>  
> >>  struct f2fs_attr {
> >> @@ -139,6 +157,10 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
> >>  		return (unsigned char *)NM_I(sbi);
> >>  	else if (struct_type == F2FS_SBI)
> >>  		return (unsigned char *)sbi;
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	else if (struct_type == FAULT_INFO_RATE || struct_type == FAULT_INFO)
> >> +		return (unsigned char *)&f2fs_fault;
> >> +#endif
> >>  	return NULL;
> >>  }
> >>  
> >> @@ -188,6 +210,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
> >>  	ret = kstrtoul(skip_spaces(buf), 0, &t);
> >>  	if (ret < 0)
> >>  		return ret;
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	if (a->struct_type == FAULT_INFO && t > 1)
> >> +		return -EINVAL;
> >> +#endif
> >>  	*ui = t;
> >>  	return count;
> >>  }
> >> @@ -253,6 +279,15 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
> >>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> >>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
> >>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
> >> +F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_kmalloc, inject_kmalloc);
> >> +F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_page_alloc, inject_page_alloc);
> >> +F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_nid_alloc, inject_nid_alloc);
> >> +F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_orphan, inject_orphan);
> >> +F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_block, inject_block);
> >> +F2FS_RW_ATTR(FAULT_INFO, f2fs_fault_info, inject_dir_depth, inject_dir_depth);
> >> +#endif
> >>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> >>  
> >>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
> >> @@ -289,6 +324,27 @@ static struct kobj_type f2fs_ktype = {
> >>  	.release	= f2fs_sb_release,
> >>  };
> >>  
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +/* sysfs for f2fs fault injection */
> >> +static struct kobject f2fs_fault_inject;
> >> +
> >> +static struct attribute *f2fs_fault_attrs[] = {
> >> +	ATTR_LIST(inject_rate),
> >> +	ATTR_LIST(inject_kmalloc),
> >> +	ATTR_LIST(inject_page_alloc),
> >> +	ATTR_LIST(inject_nid_alloc),
> >> +	ATTR_LIST(inject_orphan),
> >> +	ATTR_LIST(inject_block),
> >> +	ATTR_LIST(inject_dir_depth),
> >> +	NULL
> >> +};
> >> +
> >> +static struct kobj_type f2fs_fault_ktype = {
> >> +	.default_attrs	= f2fs_fault_attrs,
> >> +	.sysfs_ops	= &f2fs_attr_ops,
> >> +};
> >> +#endif
> >> +
> >>  void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
> >>  {
> >>  	struct va_format vaf;
> >> @@ -316,9 +372,6 @@ static int parse_options(struct super_block *sb, char *options)
> >>  	char *p, *name;
> >>  	int arg = 0;
> >>  
> >> -#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> -	f2fs_fault_rate = 0;
> >> -#endif
> > 
> > Let's reset when user remounts the partition.
> > 
> > #ifdef CONFIG_F2FS_FAULT_INJECTION
> > 	f2fs_build_fault_attr(0);
> > #endif
> > 
> > Thanks,
> > 
> >>  	if (!options)
> >>  		return 0;
> >>  
> >> @@ -456,8 +509,7 @@ static int parse_options(struct super_block *sb, char *options)
> >>  			if (args->from && match_int(args, &arg))
> >>  				return -EINVAL;
> >>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >> -			f2fs_fault_rate = arg;
> >> -			atomic_set(&f2fs_ops, 0);
> >> +			f2fs_build_fault_attr(arg);
> >>  #else
> >>  			f2fs_msg(sb, KERN_INFO,
> >>  				"FAULT_INJECTION was not selected");
> >> @@ -1726,6 +1778,9 @@ free_sbi:
> >>  		shrink_dcache_sb(sb);
> >>  		goto try_onemore;
> >>  	}
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	f2fs_build_fault_attr(0);
> >> +#endif
> >>  	return err;
> >>  }
> >>  
> >> @@ -1797,6 +1852,16 @@ static int __init init_f2fs_fs(void)
> >>  		err = -ENOMEM;
> >>  		goto free_extent_cache;
> >>  	}
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	f2fs_fault_inject.kset = f2fs_kset;
> >> +	f2fs_build_fault_attr(0);
> >> +	err = kobject_init_and_add(&f2fs_fault_inject, &f2fs_fault_ktype,
> >> +				NULL, "fault_injection");
> >> +	if (err) {
> >> +		f2fs_fault_inject.kset = NULL;
> >> +		goto free_kset;
> >> +	}
> >> +#endif
> >>  	err = register_shrinker(&f2fs_shrinker_info);
> >>  	if (err)
> >>  		goto free_kset;
> >> @@ -1815,6 +1880,10 @@ free_filesystem:
> >>  free_shrinker:
> >>  	unregister_shrinker(&f2fs_shrinker_info);
> >>  free_kset:
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	if (f2fs_fault_inject.kset)
> >> +		kobject_put(&f2fs_fault_inject);
> >> +#endif
> >>  	kset_unregister(f2fs_kset);
> >>  free_extent_cache:
> >>  	destroy_extent_cache();
> >> @@ -1841,6 +1910,9 @@ static void __exit exit_f2fs_fs(void)
> >>  	destroy_segment_manager_caches();
> >>  	destroy_node_manager_caches();
> >>  	destroy_inodecache();
> >> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> >> +	kobject_put(&f2fs_fault_inject);
> >> +#endif
> >>  	kset_unregister(f2fs_kset);
> >>  	f2fs_destroy_trace_ios();
> >>  }
> >> -- 
> >> 2.7.1
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Mobile security can be enabling, not merely restricting. Employees who
> >> bring their own devices (BYOD) to work are irked by the imposition of MDM
> >> restrictions. Mobile Device Manager Plus allows you to control only the
> >> apps on BYO-devices by containerizing them, leaving personal data untouched!
> >> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
