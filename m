From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v2] fsck.f2fs: write checkpoint out of
 place first
Date: Mon, 20 Aug 2018 19:38:07 -0700
Message-ID: <20180821023807.GC20263@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180726205405.158146-1-guoweichao@huawei.com>
 <0f5c562c-1718-83a6-034c-9a384aa94347@huawei.com>
 <20180817183233.GC58612@jaegeuk-macbookpro.roam.corp.google.com>
 <32914790-e213-9265-0ad8-70a0856b85b5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1frwYk-00078a-2e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Aug 2018 02:38:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1frwYg-009Voi-SM
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 21 Aug 2018 02:38:18 +0000
Content-Disposition: inline
In-Reply-To: <32914790-e213-9265-0ad8-70a0856b85b5@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: guoweichao <guoweichao@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 08/20, guoweichao wrote:
> Hi Jaegeuk,
> 
> Is your test using a kernel include some unstable patches like "f2fs: guarantee journalled quota data by checkpoint"?
> I am planing to reproduce the problem with dev branch. Is that OK? Any hints for reproducing?

I actually removed such the patches. Could you please test with dev now which
would be targetting to -rc.

Thanks,

> 
> Thank,
> Weichao
> 
> On 2018/8/18 2:32, Jaegeuk Kim wrote:
> > Hi Weichao,
> > 
> > This is corrupting the checkpoint showing dangling nids when running my test
> > where injects faults with shutdown loop.
> > 
> > Thanks,
> > 
> > On 07/28, Chao Yu wrote:
> >> On 2018/7/27 4:54, Weichao Guo wrote:
> >>> We may encounter both checkpoints invalid in such a case:
> >>> 1. write checkpoint A, B, C;
> >>> 2. sudden power-cut during write checkpoint D;
> >>> 3. fsck changes the total block count of checkpoint C;
> >>> 4. sudden power-cut during fsck write checkpoint C in place
> >>>
> >>>  ---------           ---------
> >>> |  ver C  |         |  ver D  |
> >>> |   ...   |         |   ...   |
> >>> | content |         | content |
> >>> |   ...   |         |   ...   |
> >>> |  ver C  |         |         |
> >>> |  ver A  |         |  ver B  |
> >>>  ---------           ---------
> >>>
> >>> As the total # of checkpoint C is changed, an old cp block
> >>> like ver A or an invalid cp block may be referenced.
> >>> To avoid both checkpoints invalid, and considering fsck should
> >>> not update the checkpoint version, fsck could write checkpoint
> >>> out of place first and then write checkpoint in place. This
> >>> makes sure the file system is fixed by fsck and at least one
> >>> of the two checkpoints is valid.
> >>>
> >>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> >>> ---
> >>>  fsck/defrag.c |  2 +-
> >>>  fsck/fsck.c   | 14 +++++++++++++-
> >>>  fsck/fsck.h   |  1 +
> >>>  fsck/mount.c  | 16 ++++++++++++++--
> >>>  fsck/sload.c  |  2 +-
> >>>  5 files changed, 30 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fsck/defrag.c b/fsck/defrag.c
> >>> index bea0293..9fc932f 100644
> >>> --- a/fsck/defrag.c
> >>> +++ b/fsck/defrag.c
> >>> @@ -96,7 +96,7 @@ int f2fs_defragment(struct f2fs_sb_info *sbi, u64 from, u64 len, u64 to, int lef
> >>>  	/* flush dirty sit entries */
> >>>  	flush_sit_entries(sbi);
> >>>  
> >>> -	write_checkpoint(sbi);
> >>> +	__write_checkpoint(sbi);
> >>>  
> >>>  	return 0;
> >>>  }
> >>> diff --git a/fsck/fsck.c b/fsck/fsck.c
> >>> index 91c8529..f2ff4bc 100644
> >>> --- a/fsck/fsck.c
> >>> +++ b/fsck/fsck.c
> >>> @@ -1943,7 +1943,7 @@ static void flush_curseg_sit_entries(struct f2fs_sb_info *sbi)
> >>>  	free(sit_blk);
> >>>  }
> >>>  
> >>> -static void fix_checkpoint(struct f2fs_sb_info *sbi)
> >>> +static void __fix_checkpoint(struct f2fs_sb_info *sbi)
> >>>  {
> >>>  	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> >>>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> >>> @@ -2004,6 +2004,18 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
> >>>  		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
> >>>  }
> >>>  
> >>> +static void fix_checkpoint(struct f2fs_sb_info *sbi)
> >>> +{
> >>> +	int i = 0;
> >>> +
> >>> +	for (i = 0; i < 2; i++) {
> >>> +		/* write checkpoint out of place first */
> >>> +		sbi->cur_cp = sbi->cur_cp % 2 + 1;
> >>> +		__fix_checkpoint(sbi);
> >>> +		f2fs_fsync_device();
> >>
> >> It needs to check return value here.
> >>
> >> We can add below codes in the end of __fix_checkpoint()?
> >>
> >> 	ret = f2fs_fsync_device();
> >> 	ASSERT(ret >= 0);
> >>
> >>> +	}
> >>> +}
> >>> +
> >>>  int check_curseg_offset(struct f2fs_sb_info *sbi)
> >>>  {
> >>>  	int i;
> >>> diff --git a/fsck/fsck.h b/fsck/fsck.h
> >>> index 8e133fa..068dd34 100644
> >>> --- a/fsck/fsck.h
> >>> +++ b/fsck/fsck.h
> >>> @@ -175,6 +175,7 @@ extern void flush_sit_entries(struct f2fs_sb_info *);
> >>>  extern void move_curseg_info(struct f2fs_sb_info *, u64);
> >>>  extern void write_curseg_info(struct f2fs_sb_info *);
> >>>  extern int find_next_free_block(struct f2fs_sb_info *, u64 *, int, int);
> >>> +extern void __write_checkpoint(struct f2fs_sb_info *);
> >>>  extern void write_checkpoint(struct f2fs_sb_info *);
> >>>  extern void update_data_blkaddr(struct f2fs_sb_info *, nid_t, u16, block_t);
> >>>  extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
> >>> diff --git a/fsck/mount.c b/fsck/mount.c
> >>> index e5574c5..8a29421 100644
> >>> --- a/fsck/mount.c
> >>> +++ b/fsck/mount.c
> >>> @@ -1856,7 +1856,7 @@ void flush_journal_entries(struct f2fs_sb_info *sbi)
> >>>  	int n_sits = flush_sit_journal_entries(sbi);
> >>>  
> >>>  	if (n_nats || n_sits)
> >>> -		write_checkpoint(sbi);
> >>> +		__write_checkpoint(sbi);
> >>>  }
> >>>  
> >>>  void flush_sit_entries(struct f2fs_sb_info *sbi)
> >>> @@ -2079,7 +2079,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
> >>>  	free(nat_block);
> >>>  }
> >>>  
> >>> -void write_checkpoint(struct f2fs_sb_info *sbi)
> >>> +void __write_checkpoint(struct f2fs_sb_info *sbi)
> >>>  {
> >>>  	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
> >>>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> >>> @@ -2144,6 +2144,18 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
> >>>  	ASSERT(ret >= 0);
> >>>  }
> >>>  
> >>> +void write_checkpoint(struct f2fs_sb_info *sbi)
> >>> +{
> >>> +	int i = 0;
> >>> +
> >>> +	for (i = 0; i < 2; i++) {
> >>> +		/* write checkpoint out of place first */
> >>> +		sbi->cur_cp = sbi->cur_cp % 2 + 1;
> >>> +		__write_checkpoint(sbi);
> >>> +		f2fs_fsync_device();
> >>
> >> Ditto.
> >>
> >> Thanks,
> >>
> >>> +	}
> >>> +}
> >>> +
> >>>  void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
> >>>  {
> >>>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> >>> diff --git a/fsck/sload.c b/fsck/sload.c
> >>> index 2842f2c..53d80fa 100644
> >>> --- a/fsck/sload.c
> >>> +++ b/fsck/sload.c
> >>> @@ -325,6 +325,6 @@ int f2fs_sload(struct f2fs_sb_info *sbi)
> >>>  	/* flush dirty sit entries */
> >>>  	flush_sit_entries(sbi);
> >>>  
> >>> -	write_checkpoint(sbi);
> >>> +	__write_checkpoint(sbi);
> >>>  	return 0;
> >>>  }
> >>>
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
