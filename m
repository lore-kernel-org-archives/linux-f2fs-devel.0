From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: add -O features to tune the bits
Date: Thu, 19 Apr 2018 19:52:16 -0700
Message-ID: <20180420025216.GA36912@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180419205432.21624-1-jaegeuk@kernel.org>
 <185f5873-dd55-82f2-7e81-fa67ef78480e@huawei.com>
 <13c34f59-6f6a-8252-0a9f-effccbcd6db0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f9M9x-0006h2-8F
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Apr 2018 02:52:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9M9v-006jO6-9b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Apr 2018 02:52:25 +0000
Content-Disposition: inline
In-Reply-To: <13c34f59-6f6a-8252-0a9f-effccbcd6db0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 04/20, Chao Yu wrote:
> On 2018/4/20 9:46, Junling Zheng wrote:
> > Hi, Jaegeuk
> > 
> > On 2018/4/20 4:54, Jaegeuk Kim wrote:
> >> This patch add -O features for fsck.f2fs in order to tune the feature bits.
> >> Currently, it supports -O encrypt only.
> >>
> > 
> > Shall we introduce a new tool like tune.f2fs to tune the parameters of f2fs?
> > Maybe we will tune others parameters in the future, not only features bits in sb :)

Of course, that'd be better. But, I don't have strong motivation to add it
for now. In order to tune one feature flag, do we have to say we need another
tool?

> 
> Agreed, one concern is we'd better separate tune functionality from fsck, other
> is that it will be more comfortable to use misc tools for the user changed their
> fs from extx to f2fs.

That's very likely to be a TODO item. ;)

Thanks,

> 
> Thanks,
> 
> > 
> >> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >> ---
> >>  fsck/fsck.h   |  1 +
> >>  fsck/main.c   |  9 ++++++++-
> >>  fsck/mount.c  | 39 ++++++++++++++++++++++++++++++++++++++-
> >>  fsck/resize.c | 18 +-----------------
> >>  4 files changed, 48 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/fsck/fsck.h b/fsck/fsck.h
> >> index 8e133fa..3e13fc6 100644
> >> --- a/fsck/fsck.h
> >> +++ b/fsck/fsck.h
> >> @@ -176,6 +176,7 @@ extern void move_curseg_info(struct f2fs_sb_info *, u64);
> >>  extern void write_curseg_info(struct f2fs_sb_info *);
> >>  extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
> >>  extern void write_checkpoint(struct f2fs_sb_info *);
> >> +extern void write_superblock(struct f2fs_super_block *);
> >>  extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
> >>  extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
> >>  
> >> diff --git a/fsck/main.c b/fsck/main.c
> >> index 9256d21..c4dd8b1 100644
> >> --- a/fsck/main.c
> >> +++ b/fsck/main.c
> >> @@ -28,6 +28,8 @@ struct f2fs_fsck gfsck;
> >>  extern struct sparse_file *f2fs_sparse_file;
> >>  #endif
> >>  
> >> +INIT_FEATURE_TABLE;
> >> +
> >>  static char *absolute_path(const char *file)
> >>  {
> >>  	char *ret;
> >> @@ -54,6 +56,7 @@ void fsck_usage()
> >>  	MSG(0, "  -d debug level [default:0]\n");
> >>  	MSG(0, "  -f check/fix entire partition\n");
> >>  	MSG(0, "  -g add default options\n");
> >> +	MSG(0, "  -O feature1[feature2,feature3,...] e.g. \"encrypt\"\n");
> >>  	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
> >>  	MSG(0, "  -S sparse_mode\n");
> >>  	MSG(0, "  -t show directory tree\n");
> >> @@ -180,7 +183,7 @@ void f2fs_parse_options(int argc, char *argv[])
> >>  	}
> >>  
> >>  	if (!strcmp("fsck.f2fs", prog)) {
> >> -		const char *option_string = ":ad:fg:p:q:StyV";
> >> +		const char *option_string = ":ad:fg:O:p:q:StyV";
> >>  		int opt = 0;
> >>  		struct option long_opt[] = {
> >>  			{"dry-run", no_argument, 0, 1},
> >> @@ -203,6 +206,10 @@ void f2fs_parse_options(int argc, char *argv[])
> >>  				if (!strcmp(optarg, "android"))
> >>  					c.defset = CONF_ANDROID;
> >>  				break;
> >> +			case 'O':
> >> +				if (parse_feature(feature_table, optarg))
> >> +					fsck_usage();
> >> +				break;
> >>  			case 'p':
> >>  				/* preen mode has different levels:
> >>  				 *  0: default level, the same as -a
> >> diff --git a/fsck/mount.c b/fsck/mount.c
> >> index e5574c5..b374b46 100644
> >> --- a/fsck/mount.c
> >> +++ b/fsck/mount.c
> >> @@ -2144,6 +2144,22 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
> >>  	ASSERT(ret >= 0);
> >>  }
> >>  
> >> +void write_superblock(struct f2fs_super_block *new_sb)
> >> +{
> >> +	int index, ret;
> >> +	u_int8_t *buf;
> >> +
> >> +	buf = calloc(BLOCK_SZ, 1);
> >> +
> >> +	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
> >> +	for (index = 0; index < 2; index++) {
> >> +		ret = dev_write_block(buf, index);
> >> +		ASSERT(ret >= 0);
> >> +	}
> >> +	free(buf);
> >> +	DBG(0, "Info: Done to rebuild superblock\n");
> >> +}
> >> +
> >>  void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
> >>  {
> >>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> >> @@ -2314,6 +2330,26 @@ static int check_sector_size(struct f2fs_super_block *sb)
> >>  	return 0;
> >>  }
> >>  
> >> +static void tune_sb_features(struct f2fs_sb_info *sbi)
> >> +{
> >> +	int sb_changed = 0;
> >> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> >> +
> >> +	if (!(sb->feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) &&
> >> +			c.feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
> >> +		sb->feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
> >> +		MSG(0, "Info: Set Encryption feature\n");
> >> +		sb_changed = 1;
> >> +	}
> >> +	/* TODO: quota needs to allocate inode numbers */
> >> +
> >> +	c.feature = sb->feature;
> >> +	if (!sb_changed)
> >> +		return;
> >> +
> >> +	write_superblock(sb);
> >> +}
> >> +
> >>  int f2fs_do_mount(struct f2fs_sb_info *sbi)
> >>  {
> >>  	struct f2fs_checkpoint *cp = NULL;
> >> @@ -2365,7 +2401,8 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
> >>  	}
> >>  
> >>  	c.bug_on = 0;
> >> -	c.feature = sb->feature;
> >> +
> >> +	tune_sb_features(sbi);
> >>  
> >>  	/* precompute checksum seed for metadata */
> >>  	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> >> diff --git a/fsck/resize.c b/fsck/resize.c
> >> index 019da71..d285dd7 100644
> >> --- a/fsck/resize.c
> >> +++ b/fsck/resize.c
> >> @@ -569,22 +569,6 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
> >>  	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
> >>  }
> >>  
> >> -static void rebuild_superblock(struct f2fs_super_block *new_sb)
> >> -{
> >> -	int index, ret;
> >> -	u_int8_t *buf;
> >> -
> >> -	buf = calloc(BLOCK_SZ, 1);
> >> -
> >> -	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
> >> -	for (index = 0; index < 2; index++) {
> >> -		ret = dev_write_block(buf, index);
> >> -		ASSERT(ret >= 0);
> >> -	}
> >> -	free(buf);
> >> -	DBG(0, "Info: Done to rebuild superblock\n");
> >> -}
> >> -
> >>  int f2fs_resize(struct f2fs_sb_info *sbi)
> >>  {
> >>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> >> @@ -636,6 +620,6 @@ int f2fs_resize(struct f2fs_sb_info *sbi)
> >>  	migrate_nat(sbi, new_sb);
> >>  	migrate_sit(sbi, new_sb, offset_seg);
> >>  	rebuild_checkpoint(sbi, new_sb, offset_seg);
> >> -	rebuild_superblock(new_sb);
> >> +	write_superblock(new_sb);
> >>  	return 0;
> >>  }
> >>
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
