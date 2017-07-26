From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: expose /sys/fs/f2fs/features
Date: Wed, 26 Jul 2017 22:31:56 +0800
Message-ID: <765ab60d-b0fc-7233-83b5-86a617e4134f@kernel.org>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726012921.53002-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/26 9:29, Jaegeuk Kim wrote:
> This patch exposes what features are supported by current f2fs build to sysfs
> entry.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Minor thing, can you exchange below function name to follow ext4:
f2fs_init_sysfs <-> f2fs_register_sysfs
f2fs_exit_sysfs <-> f2fs_unregister_sysfs

Thanks,

> ---
>  fs/f2fs/f2fs.h  |   6 +++
>  fs/f2fs/file.c  |   3 +-
>  fs/f2fs/sysfs.c | 114 +++++++++++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 96 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1833eefe47b3..a336021b777f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2864,6 +2864,12 @@ static inline int f2fs_sb_has_project_quota(struct super_block *sb)
>  	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_PRJQUOTA);
>  }
>  
> +static inline int f2fs_sb_support_atomic_write(void)
> +{
> +	/* Validated with sqlite */
> +	return 1;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>  			struct block_device *bdev, block_t blkaddr)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e4a45f02cd4e..0f4dbeb61845 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2384,7 +2384,8 @@ static int f2fs_ioc_get_features(struct file *filp, unsigned long arg)
>  	u32 sb_feature = le32_to_cpu(F2FS_I_SB(inode)->raw_super->feature);
>  
>  	/* Must validate to set it with SQLite behavior in Android. */
> -	sb_feature |= F2FS_FEATURE_ATOMIC_WRITE;
> +	if (f2fs_sb_support_atomic_write())
> +		sb_feature |= F2FS_FEATURE_ATOMIC_WRITE;
>  
>  	return put_user(sb_feature, (u32 __user *)arg);
>  }
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 71191d89917d..0bd57e8769c6 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -18,7 +18,6 @@
>  #include "gc.h"
>  
>  static struct proc_dir_entry *f2fs_proc_root;
> -static struct kset *f2fs_kset;
>  
>  /* Sysfs support for f2fs */
>  enum {
> @@ -41,6 +40,7 @@ struct f2fs_attr {
>  			 const char *, size_t);
>  	int struct_type;
>  	int offset;
> +	int id;
>  };
>  
>  static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
> @@ -155,6 +155,24 @@ static void f2fs_sb_release(struct kobject *kobj)
>  	complete(&sbi->s_kobj_unregister);
>  }
>  
> +enum feat_id {
> +	FEAT_CRYPTO = 0,
> +	FEAT_BLKZONED,
> +	FEAT_ATOMIC_WRITE,
> +};
> +
> +static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	switch (a->id) {
> +	case FEAT_CRYPTO:
> +	case FEAT_BLKZONED:
> +	case FEAT_ATOMIC_WRITE:
> +		return snprintf(buf, PAGE_SIZE, "supported\n");
> +	}
> +	return 0;
> +}
> +
>  #define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
>  static struct f2fs_attr f2fs_attr_##_name = {			\
>  	.attr = {.name = __stringify(_name), .mode = _mode },	\
> @@ -172,6 +190,13 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
>  #define F2FS_GENERAL_RO_ATTR(name) \
>  static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
>  
> +#define F2FS_FEATURE_RO_ATTR(_name, _id)			\
> +static struct f2fs_attr f2fs_attr_##_name = {			\
> +	.attr = {.name = __stringify(_name), .mode = 0444 },	\
> +	.show	= f2fs_feature_show,				\
> +	.id	= _id,						\
> +}
> +
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
>  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
> @@ -197,6 +222,14 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
>  #endif
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
>  
> +#ifdef CONFIG_F2FS_FS_ENCRYPTION
> +F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
> +#endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> +#endif
> +F2FS_FEATURE_RO_ATTR(atomic_write, FEAT_ATOMIC_WRITE);
> +
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(gc_min_sleep_time),
> @@ -226,17 +259,45 @@ static struct attribute *f2fs_attrs[] = {
>  	NULL,
>  };
>  
> +static struct attribute *f2fs_feat_attrs[] = {
> +#ifdef CONFIG_F2FS_FS_ENCRYPTION
> +	ATTR_LIST(encryption),
> +#endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	ATTR_LIST(block_zoned),
> +#endif
> +	ATTR_LIST(atomic_write),
> +	NULL,
> +};
> +
>  static const struct sysfs_ops f2fs_attr_ops = {
>  	.show	= f2fs_attr_show,
>  	.store	= f2fs_attr_store,
>  };
>  
> -static struct kobj_type f2fs_ktype = {
> +static struct kobj_type f2fs_sb_ktype = {
>  	.default_attrs	= f2fs_attrs,
>  	.sysfs_ops	= &f2fs_attr_ops,
>  	.release	= f2fs_sb_release,
>  };
>  
> +static struct kobj_type f2fs_ktype = {
> +	.sysfs_ops	= &f2fs_attr_ops,
> +};
> +
> +static struct kset f2fs_kset = {
> +	.kobj   = {.ktype = &f2fs_ktype},
> +};
> +
> +static struct kobj_type f2fs_feat_ktype = {
> +	.default_attrs	= f2fs_feat_attrs,
> +	.sysfs_ops	= &f2fs_attr_ops,
> +};
> +
> +static struct kobject f2fs_feat = {
> +	.kset	= &f2fs_kset,
> +};
> +
>  static int segment_info_seq_show(struct seq_file *seq, void *offset)
>  {
>  	struct super_block *sb = seq->private;
> @@ -306,18 +367,29 @@ F2FS_PROC_FILE_DEF(segment_bits);
>  
>  int __init f2fs_register_sysfs(void)
>  {
> -	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
> +	int ret;
>  
> -	f2fs_kset = kset_create_and_add("f2fs", NULL, fs_kobj);
> -	if (!f2fs_kset)
> -		return -ENOMEM;
> -	return 0;
> +	kobject_set_name(&f2fs_kset.kobj, "f2fs");
> +	f2fs_kset.kobj.parent = fs_kobj;
> +	ret = kset_register(&f2fs_kset);
> +	if (ret)
> +		return ret;
> +
> +	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
> +				   NULL, "features");
> +	if (ret)
> +		kset_unregister(&f2fs_kset);
> +	else
> +		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
> +	return ret;
>  }
>  
>  void f2fs_unregister_sysfs(void)
>  {
> -	kset_unregister(f2fs_kset);
> +	kobject_put(&f2fs_feat);
> +	kset_unregister(&f2fs_kset);
>  	remove_proc_entry("fs/f2fs", NULL);
> +	f2fs_proc_root = NULL;
>  }
>  
>  int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
> @@ -325,6 +397,13 @@ int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
>  	struct super_block *sb = sbi->sb;
>  	int err;
>  
> +	sbi->s_kobj.kset = &f2fs_kset;
> +	init_completion(&sbi->s_kobj_unregister);
> +	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
> +				"%s", sb->s_id);
> +	if (err)
> +		return err;
> +
>  	if (f2fs_proc_root)
>  		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
>  
> @@ -334,32 +413,15 @@ int f2fs_init_sysfs(struct f2fs_sb_info *sbi)
>  		proc_create_data("segment_bits", S_IRUGO, sbi->s_proc,
>  				 &f2fs_seq_segment_bits_fops, sb);
>  	}
> -
> -	sbi->s_kobj.kset = f2fs_kset;
> -	init_completion(&sbi->s_kobj_unregister);
> -	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_ktype, NULL,
> -							"%s", sb->s_id);
> -	if (err)
> -		goto err_out;
>  	return 0;
> -err_out:
> -	if (sbi->s_proc) {
> -		remove_proc_entry("segment_info", sbi->s_proc);
> -		remove_proc_entry("segment_bits", sbi->s_proc);
> -		remove_proc_entry(sb->s_id, f2fs_proc_root);
> -	}
> -	return err;
>  }
>  
>  void f2fs_exit_sysfs(struct f2fs_sb_info *sbi)
>  {
> -	kobject_del(&sbi->s_kobj);
> -	kobject_put(&sbi->s_kobj);
> -	wait_for_completion(&sbi->s_kobj_unregister);
> -
>  	if (sbi->s_proc) {
>  		remove_proc_entry("segment_info", sbi->s_proc);
>  		remove_proc_entry("segment_bits", sbi->s_proc);
>  		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
>  	}
> +	kobject_del(&sbi->s_kobj);
>  }
> 
