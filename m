From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: support quota sys files
Date: Thu, 2 Nov 2017 20:37:38 -0700
Message-ID: <20171103033738.GB11335@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171031034030.26719-1-jaegeuk@kernel.org>
 <20171031034030.26719-2-jaegeuk@kernel.org>
 <74cfa9eb-0a37-3a23-288e-7f140ba584b2@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1eASni-0005ZP-IE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 03:37:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eASnh-0004M5-3D
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Nov 2017 03:37:46 +0000
Content-Disposition: inline
In-Reply-To: <74cfa9eb-0a37-3a23-288e-7f140ba584b2@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 11/02, Chao Yu wrote:
> On 2017/10/31 11:40, Jaegeuk Kim wrote:
> > This patch supports hidden quota files in the system, which will be used for
> > Android. It requires up-to-date f2fs-tools later than v1.9.0.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c |   9 +++-
> >  fs/f2fs/f2fs.h       |   9 +++-
> >  fs/f2fs/recovery.c   |   8 ++-
> >  fs/f2fs/super.c      | 145 ++++++++++++++++++++++++++++++++++++++++++++++-----
> >  4 files changed, 153 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 6b52d4b66c7b..78e1b2998bbd 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -615,6 +615,9 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >  	block_t start_blk, orphan_blocks, i, j;
> >  	unsigned int s_flags = sbi->sb->s_flags;
> >  	int err = 0;
> > +#ifdef CONFIG_QUOTA
> > +	int quota_enabled;
> > +#endif
> >  
> >  	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
> >  		return 0;
> > @@ -627,8 +630,9 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >  #ifdef CONFIG_QUOTA
> >  	/* Needed for iput() to work correctly and not trash data */
> >  	sbi->sb->s_flags |= MS_ACTIVE;
> > +
> >  	/* Turn on quotas so that they are updated correctly */
> > -	f2fs_enable_quota_files(sbi);
> > +	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & MS_RDONLY);
> >  #endif
> >  
> >  	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
> > @@ -656,7 +660,8 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >  out:
> >  #ifdef CONFIG_QUOTA
> >  	/* Turn quotas off */
> > -	f2fs_quota_off_umount(sbi->sb);
> > +	if (quota_enabled)
> > +		f2fs_quota_off_umount(sbi->sb);
> >  #endif
> >  	sbi->sb->s_flags = s_flags; /* Restore MS_RDONLY status */
> >  
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9a1c7ffa6845..e1d3a940d9f8 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1384,6 +1384,13 @@ static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
> >  	return le64_to_cpu(cp->checkpoint_ver);
> >  }
> >  
> > +static inline unsigned long f2fs_qf_ino(struct super_block *sb, int type)
> > +{
> > +	if (type < F2FS_QUOTA_INO)
> 
> Why not just use F2FS_MAX_QUOTAS instead of F2FS_QUOTA_INO? since in patch 1/2
> we have defined qf_ino array with upper-boundary F2FS_MAX_QUOTAS.

It was intended to indicate # of enabled quotas. ;)

> 
> 	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
> 
> Other part looks good to me. ;)
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > +		return le32_to_cpu(F2FS_SB(sb)->raw_super->qf_ino[type]);
> > +	return 0;
> > +}
> > +
> >  static inline __u64 cur_cp_crc(struct f2fs_checkpoint *cp)
> >  {
> >  	size_t crc_offset = le32_to_cpu(cp->checksum_offset);
> > @@ -2526,7 +2533,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
> >   */
> >  int f2fs_inode_dirtied(struct inode *inode, bool sync);
> >  void f2fs_inode_synced(struct inode *inode);
> > -void f2fs_enable_quota_files(struct f2fs_sb_info *sbi);
> > +int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
> >  void f2fs_quota_off_umount(struct super_block *sb);
> >  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
> >  int f2fs_sync_fs(struct super_block *sb, int sync);
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 9626758bc762..92c57ace1939 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -594,6 +594,9 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >  	int ret = 0;
> >  	unsigned long s_flags = sbi->sb->s_flags;
> >  	bool need_writecp = false;
> > +#ifdef CONFIG_QUOTA
> > +	int quota_enabled;
> > +#endif
> >  
> >  	if (s_flags & MS_RDONLY) {
> >  		f2fs_msg(sbi->sb, KERN_INFO, "orphan cleanup on readonly fs");
> > @@ -604,7 +607,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >  	/* Needed for iput() to work correctly and not trash data */
> >  	sbi->sb->s_flags |= MS_ACTIVE;
> >  	/* Turn on quotas so that they are updated correctly */
> > -	f2fs_enable_quota_files(sbi);
> > +	quota_enabled = f2fs_enable_quota_files(sbi, s_flags & MS_RDONLY);
> >  #endif
> >  
> >  	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
> > @@ -665,7 +668,8 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
> >  out:
> >  #ifdef CONFIG_QUOTA
> >  	/* Turn quotas off */
> > -	f2fs_quota_off_umount(sbi->sb);
> > +	if (quota_enabled)
> > +		f2fs_quota_off_umount(sbi->sb);
> >  #endif
> >  	sbi->sb->s_flags = s_flags; /* Restore MS_RDONLY status */
> >  
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 96e145c34ba2..0ca7b055e4e0 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -213,6 +213,12 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
> >  			"quota options when quota turned on");
> >  		return -EINVAL;
> >  	}
> > +	if (f2fs_sb_has_quota_ino(sb)) {
> > +		f2fs_msg(sb, KERN_INFO,
> > +			"QUOTA feature is enabled, so ignore qf_name");
> > +		return 0;
> > +	}
> > +
> >  	qname = match_strdup(args);
> >  	if (!qname) {
> >  		f2fs_msg(sb, KERN_ERR,
> > @@ -291,6 +297,18 @@ static int f2fs_check_quota_options(struct f2fs_sb_info *sbi)
> >  			return -1;
> >  		}
> >  	}
> > +
> > +	if (f2fs_sb_has_quota_ino(sbi->sb) && sbi->s_jquota_fmt) {
> > +		f2fs_msg(sbi->sb, KERN_INFO,
> > +			"QUOTA feature is enabled, so ignore jquota_fmt");
> > +		sbi->s_jquota_fmt = 0;
> > +	}
> > +	if (f2fs_sb_has_quota_ino(sbi->sb) && sb_rdonly(sbi->sb)) {
> > +		f2fs_msg(sbi->sb, KERN_INFO,
> > +			 "Filesystem with quota feature cannot be mounted RDWR "
> > +			 "without CONFIG_QUOTA");
> > +		return -1;
> > +	}
> >  	return 0;
> >  }
> >  #endif
> > @@ -1172,6 +1190,7 @@ static void default_options(struct f2fs_sb_info *sbi)
> >  #endif
> >  }
> >  
> > +static int f2fs_enable_quotas(struct super_block *sb);
> >  static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> > @@ -1238,6 +1257,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >  	if (f2fs_readonly(sb) && (*flags & MS_RDONLY))
> >  		goto skip;
> >  
> > +#ifdef CONFIG_QUOTA
> >  	if (!f2fs_readonly(sb) && (*flags & MS_RDONLY)) {
> >  		err = dquot_suspend(sb, -1);
> >  		if (err < 0)
> > @@ -1245,9 +1265,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> >  	} else {
> >  		/* dquot_resume needs RW */
> >  		sb->s_flags &= ~MS_RDONLY;
> > -		dquot_resume(sb, -1);
> > +		if (sb_any_quota_suspended(sb)) {
> > +			dquot_resume(sb, -1);
> > +		} else if (f2fs_sb_has_quota_ino(sb)) {
> > +			err = f2fs_enable_quotas(sb);
> > +			if (err)
> > +				goto restore_opts;
> > +		}
> >  	}
> > -
> > +#endif
> >  	/* disallow enable/disable extent_cache dynamically */
> >  	if (no_extent_cache == !!test_opt(sbi, EXTENT_CACHE)) {
> >  		err = -EINVAL;
> > @@ -1454,19 +1480,91 @@ static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
> >  						sbi->s_jquota_fmt, type);
> >  }
> >  
> > -void f2fs_enable_quota_files(struct f2fs_sb_info *sbi)
> > +int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly)
> >  {
> > -	int i, ret;
> > +	int enabled = 0;
> > +	int i, err;
> > +
> > +	if (f2fs_sb_has_quota_ino(sbi->sb) && rdonly) {
> > +		err = f2fs_enable_quotas(sbi->sb);
> > +		if (err) {
> > +			f2fs_msg(sbi->sb, KERN_ERR,
> > +					"Cannot turn on quota_ino: %d", err);
> > +			return 0;
> > +		}
> > +		return 1;
> > +	}
> >  
> >  	for (i = 0; i < MAXQUOTAS; i++) {
> >  		if (sbi->s_qf_names[i]) {
> > -			ret = f2fs_quota_on_mount(sbi, i);
> > -			if (ret < 0)
> > -				f2fs_msg(sbi->sb, KERN_ERR,
> > -					"Cannot turn on journaled "
> > -					"quota: error %d", ret);
> > +			err = f2fs_quota_on_mount(sbi, i);
> > +			if (!err) {
> > +				enabled = 1;
> > +				continue;
> > +			}
> > +			f2fs_msg(sbi->sb, KERN_ERR,
> > +				"Cannot turn on quotas: %d on %d", err, i);
> > +		}
> > +	}
> > +	return enabled;
> > +}
> > +
> > +static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
> > +			     unsigned int flags)
> > +{
> > +	struct inode *qf_inode;
> > +	unsigned long qf_inum;
> > +	int err;
> > +
> > +	BUG_ON(!f2fs_sb_has_quota_ino(sb));
> > +
> > +	qf_inum = f2fs_qf_ino(sb, type);
> > +	if (!qf_inum)
> > +		return -EPERM;
> > +
> > +	qf_inode = f2fs_iget(sb, qf_inum);
> > +	if (IS_ERR(qf_inode)) {
> > +		f2fs_msg(sb, KERN_ERR,
> > +			"Bad quota inode %u:%lu", type, qf_inum);
> > +		return PTR_ERR(qf_inode);
> > +	}
> > +
> > +	/* Don't account quota for quota files to avoid recursion */
> > +	qf_inode->i_flags |= S_NOQUOTA;
> > +	err = dquot_enable(qf_inode, type, format_id, flags);
> > +	iput(qf_inode);
> > +	return err;
> > +}
> > +
> > +static int f2fs_enable_quotas(struct super_block *sb)
> > +{
> > +	int type, err = 0;
> > +	unsigned long qf_inum;
> > +	bool quota_mopt[MAXQUOTAS] = {
> > +		test_opt(F2FS_SB(sb), USRQUOTA),
> > +		test_opt(F2FS_SB(sb), GRPQUOTA),
> > +		test_opt(F2FS_SB(sb), PRJQUOTA),
> > +	};
> > +
> > +	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
> > +	for (type = 0; type < MAXQUOTAS; type++) {
> > +		qf_inum = f2fs_qf_ino(sb, type);
> > +		if (qf_inum) {
> > +			err = f2fs_quota_enable(sb, type, QFMT_VFS_V1,
> > +				DQUOT_USAGE_ENABLED |
> > +				(quota_mopt[type] ? DQUOT_LIMITS_ENABLED : 0));
> > +			if (err) {
> > +				f2fs_msg(sb, KERN_ERR,
> > +					"Failed to enable quota tracking "
> > +					"(type=%d, err=%d). Please run "
> > +					"fsck to fix.", type, err);
> > +				for (type--; type >= 0; type--)
> > +					dquot_quota_off(sb, type);
> > +				return err;
> > +			}
> >  		}
> >  	}
> > +	return 0;
> >  }
> >  
> >  static int f2fs_quota_sync(struct super_block *sb, int type)
> > @@ -1537,7 +1635,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
> >  	f2fs_quota_sync(sb, type);
> >  
> >  	err = dquot_quota_off(sb, type);
> > -	if (err)
> > +	if (err || f2fs_sb_has_quota_ino(sb))
> >  		goto out_put;
> >  
> >  	inode_lock(inode);
> > @@ -2364,7 +2462,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  
> >  #ifdef CONFIG_QUOTA
> >  	sb->dq_op = &f2fs_quota_operations;
> > -	sb->s_qcop = &f2fs_quotactl_ops;
> > +	if (f2fs_sb_has_quota_ino(sb))
> > +		sb->s_qcop = &dquot_quotactl_sysfile_ops;
> > +	else
> > +		sb->s_qcop = &f2fs_quotactl_ops;
> >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> >  #endif
> >  
> > @@ -2535,10 +2636,24 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  	if (err)
> >  		goto free_root_inode;
> >  
> > +#ifdef CONFIG_QUOTA
> > +	/*
> > +	 * Turn on quotas which were not enabled for read-only mounts if
> > +	 * filesystem has quota feature, so that they are updated correctly.
> > +	 */
> > +	if (f2fs_sb_has_quota_ino(sb) && !sb_rdonly(sb)) {
> > +		err = f2fs_enable_quotas(sb);
> > +		if (err) {
> > +			f2fs_msg(sb, KERN_ERR,
> > +				"Cannot turn on quotas: error %d", err);
> > +			goto free_sysfs;
> > +		}
> > +	}
> > +#endif
> >  	/* if there are nt orphan nodes free them */
> >  	err = recover_orphan_inodes(sbi);
> >  	if (err)
> > -		goto free_sysfs;
> > +		goto free_meta;
> >  
> >  	/* recover fsynced data */
> >  	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
> > @@ -2572,7 +2687,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  			err = -EINVAL;
> >  			f2fs_msg(sb, KERN_ERR,
> >  				"Need to recover fsync data");
> > -			goto free_sysfs;
> > +			goto free_meta;
> >  		}
> >  	}
> >  skip_recovery:
> > @@ -2606,6 +2721,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >  	return 0;
> >  
> >  free_meta:
> > +#ifdef CONFIG_QUOTA
> > +	if (f2fs_sb_has_quota_ino(sb) && !sb_rdonly(sb))
> > +		f2fs_quota_off_umount(sbi->sb);
> > +#endif
> >  	f2fs_sync_inode_meta(sbi);
> >  	/*
> >  	 * Some dirty meta pages can be produced by recover_orphan_inodes()
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
