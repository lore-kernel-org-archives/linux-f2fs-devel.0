From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
Date: Tue, 2 Oct 2018 09:45:14 -0700
Message-ID: <20181002164514.GA93409@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <20181001000618.GC17407@jaegeuk-macbookpro.roam.corp.google.com>
 <cd4d60b9-3f24-d408-610a-af57e0cb0165@kernel.org>
 <20181001012911.GF17407@jaegeuk-macbookpro.roam.corp.google.com>
 <73df627f-5b12-71cd-9a52-41f187d5516d@kernel.org>
 <20181001014915.GG17407@jaegeuk-macbookpro.roam.corp.google.com>
 <143b572f-8044-eae2-d321-79040beba4f4@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <143b572f-8044-eae2-d321-79040beba4f4@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>, Weichao Guo <guoweichao@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/01, Chao Yu wrote:
> On 2018-10-1 9:49, Jaegeuk Kim wrote:
> > On 10/01, Chao Yu wrote:
> >> On 2018-10-1 9:29, Jaegeuk Kim wrote:
> >>> On 10/01, Chao Yu wrote:
> >>>> Hi Jaegeuk,
> >>>>
> >>>> On 2018-10-1 8:06, Jaegeuk Kim wrote:
> >>>>> Hi Chao,
> >>>>>
> >>>>> This fails on fsstress with godown without fault injection. Could you please
> >>>>> test a bit? I assumed that this patch should give no fsck failure along with
> >>>>> valid checkpoint having no flag.
> >>>>
> >>>> Okay, let me reproduce with that case.
> >>>>
> >>>>>
> >>>>> BTW, I'm in doubt that f2fs_lock_all covers entire quota modification. What
> >>>>> about prepare_write_begin() -> f2fs_get_block() ... -> inc_valid_block_count()?
> >>>>
> >>>> If quota data changed in above path, we will detect that in below condition:
> >>>>
> >>>> block_operation()
> >>>>
> >>>> 	down_write(&sbi->node_change);
> >>>>
> >>>> 	if (__need_flush_quota(sbi)) {
> >>>> 		up_write(&sbi->node_change);
> >>>> 		f2fs_unlock_all(sbi);
> >>>> 		goto retry_flush_quotas;
> >>>> 	}
> >>>>
> >>>> So there is no problem?
> >>>
> >>> We may need to check quota is dirty, since we have no way to detect by
> >>> f2fs structures?
> >>
> >> Below condition can check that.
> >>
> >> static bool __need_flush_quota(struct f2fs_sb_info *sbi)
> >> {
> >> ...
> >> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
> >> 		return true;
> >> 	if (get_pages(sbi, F2FS_DIRTY_QDATA))
> >> 		return true;
> >> ...
> >> }
> >>
> >> static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
> >> {
> >> ...
> >> 	ret = dquot_mark_dquot_dirty(dquot);
> >>
> >> 	/* if we are using journalled quota */
> >> 	if (is_journalled_quota(sbi))
> >> 		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> >> ...
> >> }
> > 
> > Okay, then, could you please run the above stress test to reproduce this?
> 
> Sure, let me try this case and fix it.
> 
> Could you check other patches in mailing list, and test them instead?

With the below change, the test result is much better for now.
Let me know, if you have further concern.

---
 fs/f2fs/checkpoint.c | 6 ++++++
 fs/f2fs/super.c      | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a1facfbfc5c7..b111c6201023 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1111,6 +1111,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 retry_flush_quotas:
 	if (__need_flush_quota(sbi)) {
+		int locked;
+
 		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
 			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
 			f2fs_lock_all(sbi);
@@ -1118,7 +1120,11 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		}
 		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 
+		/* only failed during mount/umount/freeze/quotactl */
+		locked = down_read_trylock(&sbi->sb->s_umount);
 		f2fs_quota_sync(sbi->sb, -1);
+		if (locked)
+			up_read(&sbi->sb->s_umount);
 	}
 
 	f2fs_lock_all(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a28c245b1288..b39f60d57120 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1706,6 +1706,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 				congestion_wait(BLK_RW_ASYNC, HZ/50);
 				goto repeat;
 			}
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			return PTR_ERR(page);
 		}
 
@@ -1717,6 +1718,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 		}
 		if (unlikely(!PageUptodate(page))) {
 			f2fs_put_page(page, 1);
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			return -EIO;
 		}
 
@@ -1758,6 +1760,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 				congestion_wait(BLK_RW_ASYNC, HZ/50);
 				goto retry;
 			}
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
 			break;
 		}
 
@@ -1794,7 +1797,6 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
 
 static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
 {
-
 	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
 		f2fs_msg(sbi->sb, KERN_ERR,
 			"quota sysfile may be corrupted, skip loading it");
-- 
2.19.0.605.g01d371f741-goog
