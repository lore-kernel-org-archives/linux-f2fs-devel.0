From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2 v2] f2fs: expose /sys/fs/f2fs/features
Date: Fri, 28 Jul 2017 20:40:10 +0800
Message-ID: <e8c0eba5-9560-7528-429f-88a2c10545e4@kernel.org>
References: <20170726012921.53002-1-jaegeuk@kernel.org>
 <20170726214426.GD66153@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726214426.GD66153@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/7/27 5:44, Jaegeuk Kim wrote:
> Change log from v1:
>  - add /sys/fs/f2fs/dev/features
> 
> This patch exposes what features are supported by current f2fs build to sysfs
> entry via:
> 
> /sys/fs/f2fs/features/> /sys/fs/f2fs/dev/features
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 138 +++++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 112 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 5a78b9af92ef..83ab0dd73b2c 100644
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
> @@ -76,6 +76,28 @@ static ssize_t lifetime_write_kbytes_show(struct f2fs_attr *a,
>  			BD_PART_WRITTEN(sbi)));
>  }
>  
> +static ssize_t features_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	struct super_block *sb = sbi->sb;
> +	int len = 0;
> +
> +	if (!sb->s_bdev->bd_part)
> +		return snprintf(buf, PAGE_SIZE, "0\n");
> +
> +	if (f2fs_sb_has_crypto(sb))
> +		len += snprintf(buf, PAGE_SIZE - len, "%s\n", "encryption");

How about printing as below:
len += snprintf(buf, PAGE_SIZE - len, "%s\n", "encryption ");

It avoids unneeded ',' in the beginning of output string:
cat /sys/fs/f2fs/zram0/features
, extra_attr, projquota, inode_checksum

> +	if (f2fs_sb_mounted_blkzoned(sb))
> +		len += snprintf(buf, PAGE_SIZE - len, "%s\n", ", blkzoned");

len += snprintf(buf, PAGE_SIZE - len, "%s\n", "blkzoned ");

> +	if (f2fs_sb_has_extra_attr(sb))
> +		len += snprintf(buf, PAGE_SIZE - len, "%s\n", ", extra_attr");

ditto

> +	if (f2fs_sb_has_project_quota(sb))
> +		len += snprintf(buf, PAGE_SIZE - len, "%s\n", ", projquota");

ditto

> +	if (f2fs_sb_has_inode_chksum(sb))
> +		len += snprintf(buf, PAGE_SIZE - len, "%s\n", ", inode_checksum");

ditto

> +	return len;
> +}
> +
>  static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>  			struct f2fs_sb_info *sbi, char *buf)
>  {
> @@ -155,6 +177,24 @@ static void f2fs_sb_release(struct kobject *kobj)
>  	complete(&sbi->s_kobj_unregister);
>  }
>  
> +enum feat_id {
> +	FEAT_CRYPTO = 0,
> +	FEAT_BLKZONED,
> +	FEAT_ATOMIC_WRITE,

Adds below missing macro:
FEAT_EXTRA_ATTR,
FEAT_PROJECT_QUOTA,
FEAT_INODE_CHECKSUM,

> +};
> +
> +static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	switch (a->id) {
> +	case FEAT_CRYPTO:
> +	case FEAT_BLKZONED:
> +	case FEAT_ATOMIC_WRITE:

case FEAT_EXTRA_ATTR:
case FEAT_PROJECT_QUOTA:
case FEAT_INODE_CHECKSUM:

> +		return snprintf(buf, PAGE_SIZE, "supported\n");
> +	}
> +	return 0;
> +}
> +
>  #define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
>  static struct f2fs_attr f2fs_attr_##_name = {			\
>  	.attr = {.name = __stringify(_name), .mode = _mode },	\
> @@ -172,6 +212,13 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
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
> @@ -196,6 +243,15 @@ F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
>  F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
>  #endif
>  F2FS_GENERAL_RO_ATTR(lifetime_write_kbytes);
> +F2FS_GENERAL_RO_ATTR(features);
> +
> +#ifdef CONFIG_F2FS_FS_ENCRYPTION
> +F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
> +#endif
> +#ifdef CONFIG_BLK_DEV_ZONED
> +F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
> +#endif
> +F2FS_FEATURE_RO_ATTR(atomic_write, FEAT_ATOMIC_WRITE);

F2FS_FEATURE_RO_ATTR(extra_attr, FEAT_EXTRA_ATTR);
F2FS_FEATURE_RO_ATTR(project_quota, FEAT_PROJECT_QUOTA);
F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);

>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
> @@ -222,21 +278,50 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(inject_type),
>  #endif
>  	ATTR_LIST(lifetime_write_kbytes),
> +	ATTR_LIST(features),
>  	ATTR_LIST(reserved_blocks),
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

ATTR_LIST(extra_attr),
ATTR_LIST(project_quota),
ATTR_LIST(inode_checksum),

Thanks,

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
> @@ -306,18 +391,29 @@ F2FS_PROC_FILE_DEF(segment_bits);
>  
>  int __init f2fs_init_sysfs(void)
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
>  void f2fs_exit_sysfs(void)
>  {
> -	kset_unregister(f2fs_kset);
> +	kobject_put(&f2fs_feat);
> +	kset_unregister(&f2fs_kset);
>  	remove_proc_entry("fs/f2fs", NULL);
> +	f2fs_proc_root = NULL;
>  }
>  
>  int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
> @@ -325,6 +421,13 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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
> @@ -334,32 +437,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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
>  void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
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
