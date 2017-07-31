From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: support journelled quota
Date: Mon, 31 Jul 2017 14:04:57 -0700
Message-ID: <20170731210457.GA3993@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170725161502.13520-1-chao@kernel.org>
 <20170730073538.GB13058@jaegeuk-macbookpro.roam.corp.google.com>
 <470db7bc-10ad-9a74-e76d-29e07d782d99@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <470db7bc-10ad-9a74-e76d-29e07d782d99@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/30, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/7/30 15:35, Jaegeuk Kim wrote:
> > Hi Chao,
> > 
> > When I add this patch, xfstests/fsstress are giving some weird kernel hang
> > or panic now. Without only this patch, I can't see any problem. Can you review
> > this patch one more time in terms of memory and lock usages.
> 
> Recently, in last 4.13-rc1 kernel, I have the same issue when testing quota
> patches with zram device as backend storage. Did you test with zram? If so,
> could you apply patch in below link and retest?

I don't use zram. ;)

> 
> https://patchwork.kernel.org/patch/9861253/
> 
> Anyway, let me double check this patch first.
> 
> Thanks,
> 
> > 
> > I'm doing xfstests without quota though.
> > 
> > Thanks,
> > 
> > On 07/26, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> This patch supports to enable f2fs to accept quota information through
> >> mount option:
> >> - {usr,grp,prj}jquota=<quota file path>
> >> - jqfmt=<quota type>
> >>
> >> Then, in ->mount flow, we can recover quota file during log replaying,
> >> by this, journelled quota can be supported.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v2: fix warning in f2fs_remount.
> >>  Documentation/filesystems/f2fs.txt |   9 ++
> >>  fs/f2fs/f2fs.h                     |   7 +
> >>  fs/f2fs/recovery.c                 |  25 +++-
> >>  fs/f2fs/super.c                    | 284 +++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 322 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> >> index b39d189c9677..b87067683297 100644
> >> --- a/Documentation/filesystems/f2fs.txt
> >> +++ b/Documentation/filesystems/f2fs.txt
> >> @@ -165,6 +165,15 @@ io_bits=%u             Set the bit size of write IO requests. It should be set
> >>  usrquota               Enable plain user disk quota accounting.
> >>  grpquota               Enable plain group disk quota accounting.
> >>  prjquota               Enable plain project quota accounting.
> >> +usrjquota=<file>       Appoint specified file and type during mount, so that quota
> >> +grpjquota=<file>       information can be properly updated during recovery flow,
> >> +prjjquota=<file>       <quota file>: must be in root directory;
> >> +jqfmt=<quota type>     <quota type>: [vfsold,vfsv0,vfsv1].
> >> +offusrjquota           Turn off user journelled quota.
> >> +offgrpjquota           Turn off group journelled quota.
> >> +offprjjquota           Turn off project journelled quota.
> >> +quota                  Enable plain user disk quota accounting.
> >> +noquota                Disable all plain disk quota option.
> >>  dax                    Use direct access (no page cache). See
> >>                         Documentation/filesystems/dax.txt.
> >>  
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index c57b83f7b108..a6259660e401 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -97,6 +97,7 @@ extern char *fault_name[FAULT_MAX];
> >>  #else
> >>  #define F2FS_MOUNT_DAX			0
> >>  #endif
> >> +#define F2FS_MOUNT_QUOTA		0x00800000
> >>  
> >>  #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
> >>  #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
> >> @@ -1100,6 +1101,12 @@ struct f2fs_sb_info {
> >>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >>  	struct f2fs_fault_info fault_info;
> >>  #endif
> >> +
> >> +#ifdef CONFIG_QUOTA
> >> +	/* Names of quota files with journalled quota */
> >> +	char *s_qf_names[MAXQUOTAS];
> >> +	int s_jquota_fmt;			/* Format of quota to use */
> >> +#endif
> >>  };
> >>  
> >>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> >> index 2d9b8182691f..998568ec9b06 100644
> >> --- a/fs/f2fs/recovery.c
> >> +++ b/fs/f2fs/recovery.c
> >> @@ -69,20 +69,34 @@ static struct fsync_inode_entry *get_fsync_inode(struct list_head *head,
> >>  }
> >>  
> >>  static struct fsync_inode_entry *add_fsync_inode(struct f2fs_sb_info *sbi,
> >> -					struct list_head *head, nid_t ino)
> >> +			struct list_head *head, nid_t ino, bool quota_inode)
> >>  {
> >>  	struct inode *inode;
> >>  	struct fsync_inode_entry *entry;
> >> +	int err;
> >>  
> >>  	inode = f2fs_iget_retry(sbi->sb, ino);
> >>  	if (IS_ERR(inode))
> >>  		return ERR_CAST(inode);
> >>  
> >> +	err = dquot_initialize(inode);
> >> +	if (err)
> >> +		goto err_out;
> >> +
> >> +	if (quota_inode) {
> >> +		err = dquot_alloc_inode(inode);
> >> +		if (err)
> >> +			goto err_out;
> >> +	}
> >> +
> >>  	entry = f2fs_kmem_cache_alloc(fsync_entry_slab, GFP_F2FS_ZERO);
> >>  	entry->inode = inode;
> >>  	list_add_tail(&entry->list, head);
> >>  
> >>  	return entry;
> >> +err_out:
> >> +	iput(inode);
> >> +	return ERR_PTR(err);
> >>  }
> >>  
> >>  static void del_fsync_inode(struct fsync_inode_entry *entry)
> >> @@ -107,7 +121,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> >>  
> >>  	entry = get_fsync_inode(dir_list, pino);
> >>  	if (!entry) {
> >> -		entry = add_fsync_inode(F2FS_I_SB(inode), dir_list, pino);
> >> +		entry = add_fsync_inode(F2FS_I_SB(inode), dir_list,
> >> +							pino, false);
> >>  		if (IS_ERR(entry)) {
> >>  			dir = ERR_CAST(entry);
> >>  			err = PTR_ERR(entry);
> >> @@ -226,18 +241,22 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
> >>  
> >>  		entry = get_fsync_inode(head, ino_of_node(page));
> >>  		if (!entry) {
> >> +			bool quota_inode = false;
> >> +
> >>  			if (!check_only &&
> >>  					IS_INODE(page) && is_dent_dnode(page)) {
> >>  				err = recover_inode_page(sbi, page);
> >>  				if (err)
> >>  					break;
> >> +				quota_inode = true;
> >>  			}
> >>  
> >>  			/*
> >>  			 * CP | dnode(F) | inode(DF)
> >>  			 * For this case, we should not give up now.
> >>  			 */
> >> -			entry = add_fsync_inode(sbi, head, ino_of_node(page));
> >> +			entry = add_fsync_inode(sbi, head, ino_of_node(page),
> >> +								quota_inode);
> >>  			if (IS_ERR(entry)) {
> >>  				err = PTR_ERR(entry);
> >>  				if (err == -ENOENT) {
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index c73ad4adb075..d7c8f6bee446 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -25,6 +25,7 @@
> >>  #include <linux/quotaops.h>
> >>  #include <linux/f2fs_fs.h>
> >>  #include <linux/sysfs.h>
> >> +#include <linux/quota.h>
> >>  
> >>  #include "f2fs.h"
> >>  #include "node.h"
> >> @@ -107,9 +108,20 @@ enum {
> >>  	Opt_fault_injection,
> >>  	Opt_lazytime,
> >>  	Opt_nolazytime,
> >> +	Opt_quota,
> >> +	Opt_noquota,
> >>  	Opt_usrquota,
> >>  	Opt_grpquota,
> >>  	Opt_prjquota,
> >> +	Opt_usrjquota,
> >> +	Opt_grpjquota,
> >> +	Opt_prjjquota,
> >> +	Opt_offusrjquota,
> >> +	Opt_offgrpjquota,
> >> +	Opt_offprjjquota,
> >> +	Opt_jqfmt_vfsold,
> >> +	Opt_jqfmt_vfsv0,
> >> +	Opt_jqfmt_vfsv1,
> >>  	Opt_dax,
> >>  	Opt_err,
> >>  };
> >> @@ -146,9 +158,20 @@ static match_table_t f2fs_tokens = {
> >>  	{Opt_fault_injection, "fault_injection=%u"},
> >>  	{Opt_lazytime, "lazytime"},
> >>  	{Opt_nolazytime, "nolazytime"},
> >> +	{Opt_quota, "quota"},
> >> +	{Opt_noquota, "noquota"},
> >>  	{Opt_usrquota, "usrquota"},
> >>  	{Opt_grpquota, "grpquota"},
> >>  	{Opt_prjquota, "prjquota"},
> >> +	{Opt_usrjquota, "usrjquota=%s"},
> >> +	{Opt_grpjquota, "grpjquota=%s"},
> >> +	{Opt_prjjquota, "prjjquota=%s"},
> >> +	{Opt_offusrjquota, "usrjquota="},
> >> +	{Opt_offgrpjquota, "grpjquota="},
> >> +	{Opt_offprjjquota, "prjjquota="},
> >> +	{Opt_jqfmt_vfsold, "jqfmt=vfsold"},
> >> +	{Opt_jqfmt_vfsv0, "jqfmt=vfsv0"},
> >> +	{Opt_jqfmt_vfsv1, "jqfmt=vfsv1"},
> >>  	{Opt_dax, "dax"},
> >>  	{Opt_err, NULL},
> >>  };
> >> @@ -172,6 +195,105 @@ static void init_once(void *foo)
> >>  	inode_init_once(&fi->vfs_inode);
> >>  }
> >>  
> >> +#ifdef CONFIG_QUOTA
> >> +static const char * const quotatypes[] = INITQFNAMES;
> >> +#define QTYPE2NAME(t) (quotatypes[t])
> >> +static int f2fs_set_qf_name(struct super_block *sb, int qtype,
> >> +							substring_t *args)
> >> +{
> >> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >> +	char *qname;
> >> +	int ret = -1;
> >> +
> >> +	if (sb_any_quota_loaded(sb) && !sbi->s_qf_names[qtype]) {
> >> +		f2fs_msg(sb, KERN_ERR,
> >> +			"Cannot change journaled "
> >> +			"quota options when quota turned on");
> >> +		return -1;
> >> +	}
> >> +	qname = match_strdup(args);
> >> +	if (!qname) {
> >> +		f2fs_msg(sb, KERN_ERR,
> >> +			"Not enough memory for storing quotafile name");
> >> +		return -1;
> >> +	}
> >> +	if (sbi->s_qf_names[qtype]) {
> >> +		if (strcmp(sbi->s_qf_names[qtype], qname) == 0)
> >> +			ret = 1;
> >> +		else
> >> +			f2fs_msg(sb, KERN_ERR,
> >> +				 "%s quota file already specified",
> >> +				 QTYPE2NAME(qtype));
> >> +		goto errout;
> >> +	}
> >> +	if (strchr(qname, '/')) {
> >> +		f2fs_msg(sb, KERN_ERR,
> >> +			"quotafile must be on filesystem root");
> >> +		goto errout;
> >> +	}
> >> +	sbi->s_qf_names[qtype] = qname;
> >> +	set_opt(sbi, QUOTA);
> >> +	return 0;
> >> +errout:
> >> +	kfree(qname);
> >> +	return ret;
> >> +}
> >> +
> >> +static int f2fs_clear_qf_name(struct super_block *sb, int qtype)
> >> +{
> >> +
> >> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >> +
> >> +	if (sb_any_quota_loaded(sb) && sbi->s_qf_names[qtype]) {
> >> +		f2fs_msg(sb, KERN_ERR, "Cannot change journaled quota options"
> >> +			" when quota turned on");
> >> +		return -1;
> >> +	}
> >> +	kfree(sbi->s_qf_names[qtype]);
> >> +	sbi->s_qf_names[qtype] = NULL;
> >> +	return 1;
> >> +}
> >> +
> >> +static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
> >> +{
> >> +	/*
> >> +	 * We do the test below only for project quotas. 'usrquota' and
> >> +	 * 'grpquota' mount options are allowed even without quota feature
> >> +	 * to support legacy quotas in quota files.
> >> +	 */
> >> +	if (test_opt(sbi, PRJQUOTA) && !f2fs_sb_has_project_quota(sbi->sb)) {
> >> +		f2fs_msg(sbi->sb, KERN_ERR, "Project quota feature not enabled. "
> >> +			 "Cannot enable project quota enforcement.");
> >> +		return -1;
> >> +	}
> >> +	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA] ||
> >> +			sbi->s_qf_names[PRJQUOTA]) {
> >> +		if (test_opt(sbi, USRQUOTA) && sbi->s_qf_names[USRQUOTA])
> >> +			clear_opt(sbi, USRQUOTA);
> >> +
> >> +		if (test_opt(sbi, GRPQUOTA) && sbi->s_qf_names[GRPQUOTA])
> >> +			clear_opt(sbi, GRPQUOTA);
> >> +
> >> +		if (test_opt(sbi, PRJQUOTA) && sbi->s_qf_names[PRJQUOTA])
> >> +			clear_opt(sbi, PRJQUOTA);
> >> +
> >> +		if (test_opt(sbi, GRPQUOTA) || test_opt(sbi, USRQUOTA) ||
> >> +				test_opt(sbi, PRJQUOTA)) {
> >> +			f2fs_msg(sbi->sb, KERN_ERR, "old and new quota "
> >> +					"format mixing");
> >> +			return -1;
> >> +		}
> >> +
> >> +		if (!sbi->s_jquota_fmt) {
> >> +			f2fs_msg(sbi->sb, KERN_ERR, "journaled quota format "
> >> +					"not specified");
> >> +			return -1;
> >> +		}
> >> +	}
> >> +	return 0;
> >> +}
> >> +#endif
> >> +
> >>  static int parse_options(struct super_block *sb, char *options)
> >>  {
> >>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >> @@ -179,6 +301,7 @@ static int parse_options(struct super_block *sb, char *options)
> >>  	substring_t args[MAX_OPT_ARGS];
> >>  	char *p, *name;
> >>  	int arg = 0;
> >> +	int ret;
> >>  
> >>  	if (!options)
> >>  		return 0;
> >> @@ -390,6 +513,7 @@ static int parse_options(struct super_block *sb, char *options)
> >>  			sb->s_flags &= ~MS_LAZYTIME;
> >>  			break;
> >>  #ifdef CONFIG_QUOTA
> >> +		case Opt_quota:
> >>  		case Opt_usrquota:
> >>  			set_opt(sbi, USRQUOTA);
> >>  			break;
> >> @@ -399,10 +523,64 @@ static int parse_options(struct super_block *sb, char *options)
> >>  		case Opt_prjquota:
> >>  			set_opt(sbi, PRJQUOTA);
> >>  			break;
> >> +		case Opt_usrjquota:
> >> +			ret = f2fs_set_qf_name(sb, USRQUOTA, &args[0]);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >> +		case Opt_grpjquota:
> >> +			ret = f2fs_set_qf_name(sb, GRPQUOTA, &args[0]);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >> +		case Opt_prjjquota:
> >> +			ret = f2fs_set_qf_name(sb, PRJQUOTA, &args[0]);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >> +		case Opt_offusrjquota:
> >> +			ret = f2fs_clear_qf_name(sb, USRQUOTA);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >> +		case Opt_offgrpjquota:
> >> +			ret = f2fs_clear_qf_name(sb, GRPQUOTA);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >> +		case Opt_offprjjquota:
> >> +			ret = f2fs_clear_qf_name(sb, PRJQUOTA);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >> +		case Opt_jqfmt_vfsold:
> >> +			sbi->s_jquota_fmt = QFMT_VFS_OLD;
> >> +			break;
> >> +		case Opt_jqfmt_vfsv0:
> >> +			sbi->s_jquota_fmt = QFMT_VFS_V0;
> >> +			break;
> >> +		case Opt_jqfmt_vfsv1:
> >> +			sbi->s_jquota_fmt = QFMT_VFS_V1;
> >> +			break;
> >> +		case Opt_noquota:
> >> +			clear_opt(sbi, QUOTA);
> >> +			clear_opt(sbi, USRQUOTA);
> >> +			clear_opt(sbi, GRPQUOTA);
> >> +			clear_opt(sbi, PRJQUOTA);
> >> +			break;
> >>  #else
> >>  		case Opt_usrquota:
> >>  		case Opt_grpquota:
> >>  		case Opt_prjquota:
> >> +		case Opt_usrjquota:
> >> +		case Opt_grpjquota:
> >> +		case Opt_prjjquota:
> >> +		case Opt_offusrjquota:
> >> +		case Opt_offgrpjquota:
> >> +		case Opt_offprjjquota:
> >> +		case Opt_jqfmt_vfsold:
> >> +		case Opt_jqfmt_vfsv0:
> >> +		case Opt_jqfmt_vfsv1:
> >>  			f2fs_msg(sb, KERN_INFO,
> >>  					"quota operations not supported");
> >>  			break;
> >> @@ -423,6 +601,10 @@ static int parse_options(struct super_block *sb, char *options)
> >>  			return -EINVAL;
> >>  		}
> >>  	}
> >> +#ifdef CONFIG_QUOTA
> >> +	if (f2fs_check_quota_options(sbi))
> >> +		return -EINVAL;
> >> +#endif
> >>  
> >>  	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
> >>  		f2fs_msg(sb, KERN_ERR,
> >> @@ -669,6 +851,10 @@ static void f2fs_put_super(struct super_block *sb)
> >>  
> >>  	destroy_device_list(sbi);
> >>  	mempool_destroy(sbi->write_io_dummy);
> >> +#ifdef CONFIG_QUOTA
> >> +	for (i = 0; i < MAXQUOTAS; i++)
> >> +		kfree(sbi->s_qf_names[i]);
> >> +#endif
> >>  	destroy_percpu_info(sbi);
> >>  	for (i = 0; i < NR_PAGE_TYPE; i++)
> >>  		kfree(sbi->write_io[i]);
> >> @@ -802,6 +988,40 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >>  	return 0;
> >>  }
> >>  
> >> +static inline void f2fs_show_quota_options(struct seq_file *seq,
> >> +					   struct super_block *sb)
> >> +{
> >> +#ifdef CONFIG_QUOTA
> >> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >> +
> >> +	if (sbi->s_jquota_fmt) {
> >> +		char *fmtname = "";
> >> +
> >> +		switch (sbi->s_jquota_fmt) {
> >> +		case QFMT_VFS_OLD:
> >> +			fmtname = "vfsold";
> >> +			break;
> >> +		case QFMT_VFS_V0:
> >> +			fmtname = "vfsv0";
> >> +			break;
> >> +		case QFMT_VFS_V1:
> >> +			fmtname = "vfsv1";
> >> +			break;
> >> +		}
> >> +		seq_printf(seq, ",jqfmt=%s", fmtname);
> >> +	}
> >> +
> >> +	if (sbi->s_qf_names[USRQUOTA])
> >> +		seq_show_option(seq, "usrjquota", sbi->s_qf_names[USRQUOTA]);
> >> +
> >> +	if (sbi->s_qf_names[GRPQUOTA])
> >> +		seq_show_option(seq, "grpjquota", sbi->s_qf_names[GRPQUOTA]);
> >> +
> >> +	if (sbi->s_qf_names[PRJQUOTA])
> >> +		seq_show_option(seq, "prjjquota", sbi->s_qf_names[PRJQUOTA]);
> >> +#endif
> >> +}
> >> +
> >>  static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> >>  {
> >>  	struct f2fs_sb_info *sbi = F2FS_SB(root->d_sb);
> >> @@ -875,6 +1095,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> >>  				sbi->fault_info.inject_rate);
> >>  #endif
> >>  #ifdef CONFIG_QUOTA
> >> +	if (test_opt(sbi, QUOTA))
> >> +		seq_puts(seq, ",quota");
> >>  	if (test_opt(sbi, USRQUOTA))
> >>  		seq_puts(seq, ",usrquota");
> >>  	if (test_opt(sbi, GRPQUOTA))
> >> @@ -882,6 +1104,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> >>  	if (test_opt(sbi, PRJQUOTA))
> >>  		seq_puts(seq, ",prjquota");
> >>  #endif
> >> +	f2fs_show_quota_options(seq, sbi->sb);
> >>  #ifdef CONFIG_FS_DAX
> >>  	if (test_opt(sbi, DAX))
> >>  		seq_puts(seq, ",dax");
> >> @@ -934,6 +1157,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >>  	struct f2fs_fault_info ffi = sbi->fault_info;
> >>  #endif
> >> +#ifdef CONFIG_QUOTA
> >> +	int s_jquota_fmt;
> >> +	char *s_qf_names[MAXQUOTAS];
> >> +	int i, j;
> >> +#endif
> >>  
> >>  	/*
> >>  	 * Save the old mount options in case we
> >> @@ -943,6 +1171,23 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >>  	old_sb_flags = sb->s_flags;
> >>  	active_logs = sbi->active_logs;
> >>  
> >> +#ifdef CONFIG_QUOTA
> >> +	s_jquota_fmt = sbi->s_jquota_fmt;
> >> +	for (i = 0; i < MAXQUOTAS; i++) {
> >> +		if (sbi->s_qf_names[i]) {
> >> +			s_qf_names[i] = kstrdup(sbi->s_qf_names[i],
> >> +							 GFP_KERNEL);
> >> +			if (!s_qf_names[i]) {
> >> +				for (j = 0; j < i; j++)
> >> +					kfree(s_qf_names[j]);
> >> +				return -ENOMEM;
> >> +			}
> >> +		} else {
> >> +			s_qf_names[i] = NULL;
> >> +		}
> >> +	}
> >> +#endif
> >> +
> >>  	/* recover superblocks we couldn't write due to previous RO mount */
> >>  	if (!(*flags & MS_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
> >>  		err = f2fs_commit_super(sbi, false);
> >> @@ -1038,6 +1283,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >>  		stop_gc_thread(sbi);
> >>  	}
> >>  restore_opts:
> >> +#ifdef CONFIG_QUOTA
> >> +	sbi->s_jquota_fmt = s_jquota_fmt;
> >> +	for (i = 0; i < MAXQUOTAS; i++) {
> >> +		kfree(sbi->s_qf_names[i]);
> >> +		sbi->s_qf_names[i] = s_qf_names[i];
> >> +	}
> >> +#endif
> >>  	sbi->mount_opt = org_mount_opt;
> >>  	sbi->active_logs = active_logs;
> >>  	sb->s_flags = old_sb_flags;
> >> @@ -1154,6 +1406,30 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
> >>  	return &F2FS_I(inode)->i_reserved_quota;
> >>  }
> >>  
> >> +static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
> >> +{
> >> +	return dquot_quota_on_mount(sbi->sb, sbi->s_qf_names[type],
> >> +						sbi->s_jquota_fmt, type);
> >> +}
> >> +
> >> +static void f2fs_enable_quota_files(struct f2fs_sb_info *sbi)
> >> +{
> >> +	int i, ret;
> >> +
> >> +	/* Needed for iput() to work correctly and not trash data */
> >> +	sbi->sb->s_flags |= MS_ACTIVE;
> >> +	/* Turn on quotas so that they are updated correctly */
> >> +	for (i = 0; i < MAXQUOTAS; i++) {
> >> +		if (sbi->s_qf_names[i]) {
> >> +			ret = f2fs_quota_on_mount(sbi, i);
> >> +			if (ret < 0)
> >> +				f2fs_msg(sbi->sb, KERN_ERR,
> >> +					"Cannot turn on journaled "
> >> +					"quota: error %d", ret);
> >> +		}
> >> +	}
> >> +}
> >> +
> >>  static int f2fs_quota_sync(struct super_block *sb, int type)
> >>  {
> >>  	struct quota_info *dqopt = sb_dqopt(sb);
> >> @@ -2212,6 +2488,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>  	if (err)
> >>  		goto free_root_inode;
> >>  
> >> +#ifdef CONFIG_QUOTA
> >> +	f2fs_enable_quota_files(sbi);
> >> +#endif
> >> +
> >>  	/* recover fsynced data */
> >>  	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
> >>  		/*
> >> @@ -2314,6 +2594,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>  	for (i = 0; i < NR_PAGE_TYPE; i++)
> >>  		kfree(sbi->write_io[i]);
> >>  	destroy_percpu_info(sbi);
> >> +#ifdef CONFIG_QUOTA
> >> +	for (i = 0; i < MAXQUOTAS; i++)
> >> +		kfree(sbi->s_qf_names[i]);
> >> +#endif
> >>  	kfree(options);
> >>  free_sb_buf:
> >>  	kfree(raw_super);
> >> -- 
> >> 2.13.0.90.g1eb437020
