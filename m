From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs bug: Unable to mount big volumes in kernel 4.5
Date: Tue, 22 Mar 2016 13:05:28 -0700
Message-ID: <20160322200528.GA13356@jaegeuk.gateway>
References: <56EEC766.2030503@davizone.at>
	<20160320224654.GB4752@jaegeuk.hsd1.ca.comcast.net>
	<00d401d18320$75f94e80$61ebeb80$@samsung.com>
	<20160321103032.GA2739@schmorp.de>
	<20160321160359.GB6196@jaegeuk.gateway>
	<013e01d183ec$5142ae20$f3c80a60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aiSYd-0004B7-8c
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Mar 2016 20:05:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aiSYb-0006dn-4J
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 22 Mar 2016 20:05:39 +0000
Content-Disposition: inline
In-Reply-To: <013e01d183ec$5142ae20$f3c80a60$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Hi,

On Tue, Mar 22, 2016 at 11:37:53AM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, March 22, 2016 12:04 AM
> > To: Marc Lehmann
> > Cc: Chao Yu; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] f2fs bug: Unable to mount big volumes in kernel 4.5
> > 
> > On Mon, Mar 21, 2016 at 11:30:38AM +0100, Marc Lehmann wrote:
> > > On Mon, Mar 21, 2016 at 11:18:35AM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> > > > > As you pointed out, it seems there is a bug in sanity check routine, which
> > > > > doesn't cover the large section case.
> > > >
> > > > Actually, there is a bug in f2fs-tools 1.6.0, it will trigger sanity check failure
> > > > in f2fs kernel module since in mkfs.f2fs we will align segment_count and
> > > > segment_count_main with different size if parameter -s or -z is configured larger
> > > > than 1.
> > > >
> > > > Following commit in dev branch of f2fs-tools has fixed this issue, could you test this
> > > > patch firstly?
> > > > ("mkfs.f2fs: set segment_count in super block correctly")
> > >
> > > Stupid question from my side, does that mean we have to reformat existing
> > > volumes? Because mkfs clearly won't fix existing volumes, so fixing mkfs
> > > will not fix the issue.
> > 
> > Exactly.
> > The f2fs patch should be merged to take into account such the backward
> > compatibility.
> 
> Agreed.
> 
> > And, I don't think wrong segment_count hurts the f2fs behavior.
> 
> Now, we use segment_count to check our last blkaddr, if we ignore correctness
> of segment_count, our boundary checked should be wrong.
> 
> So how about enabling fsck.f2fs ability of repairing incorrect value of
> segment_count, and for f2fs module, warn our user to run fsck if we detect
> such error?

Got it.
IMO, however, it'd good to fix the wrong counts by calling commit_super at the
mount time like this.

Thanks,

>From a23eaeb33076cb97f3200af81bac4c75add63a7d Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sun, 20 Mar 2016 15:33:20 -0700
Subject: [PATCH] f2fs: cover large section in sanity check of super

This patch fixes the bug which does not cover a large section case when checking
the sanity of superblock.
If f2fs detects misalignment, it will fix the superblock during the mount time,
so it doesn't need to trigger fsck.f2fs further.

Reported-by: Matthias Prager <linux@matthiasprager.de>
Reported-by: David Gnedt <david.gnedt@davizone.at>
Cc: stable 4.5+ <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 96 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 15bb81f..c88c6c9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -984,9 +984,25 @@ static loff_t max_file_blocks(void)
 	return result;
 }
 
+static int __f2fs_commit_super(struct buffer_head *bh,
+			struct f2fs_super_block *super)
+{
+	lock_buffer(bh);
+	if (super)
+		memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
+	set_buffer_uptodate(bh);
+	set_buffer_dirty(bh);
+	unlock_buffer(bh);
+
+	/* it's rare case, we can do fua all the time */
+	return __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
+}
+
 static inline bool sanity_check_area_boundary(struct super_block *sb,
-					struct f2fs_super_block *raw_super)
+					struct buffer_head *bh)
 {
+	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
+					(bh->b_data + F2FS_SUPER_OFFSET);
 	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
 	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
 	u32 sit_blkaddr = le32_to_cpu(raw_super->sit_blkaddr);
@@ -1000,6 +1016,10 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
 	u32 segment_count_main = le32_to_cpu(raw_super->segment_count_main);
 	u32 segment_count = le32_to_cpu(raw_super->segment_count);
 	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
+	u64 main_end_blkaddr = main_blkaddr +
+				(segment_count_main << log_blocks_per_seg);
+	u64 seg_end_blkaddr = segment0_blkaddr +
+				(segment_count << log_blocks_per_seg);
 
 	if (segment0_blkaddr != cp_blkaddr) {
 		f2fs_msg(sb, KERN_INFO,
@@ -1044,22 +1064,39 @@ static inline bool sanity_check_area_boundary(struct super_block *sb,
 		return true;
 	}
 
-	if (main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
-		segment0_blkaddr + (segment_count << log_blocks_per_seg)) {
+	if (main_end_blkaddr > seg_end_blkaddr) {
 		f2fs_msg(sb, KERN_INFO,
-			"Wrong MAIN_AREA boundary, start(%u) end(%u) blocks(%u)",
+			"Wrong MAIN_AREA boundary, start(%u) end(%u) block(%u)",
 			main_blkaddr,
-			segment0_blkaddr + (segment_count << log_blocks_per_seg),
+			segment0_blkaddr +
+				(segment_count << log_blocks_per_seg),
 			segment_count_main << log_blocks_per_seg);
 		return true;
-	}
+	} else if (main_end_blkaddr < seg_end_blkaddr) {
+		int err;
 
+		raw_super->segment_count = cpu_to_le32((main_end_blkaddr -
+				segment0_blkaddr) >> log_blocks_per_seg);
+
+		err = __f2fs_commit_super(bh, NULL);
+		f2fs_msg(sb, KERN_INFO,
+			"Fix alignment : %s, start(%u) end(%u) block(%u)",
+			err ? "failed": "done",
+			main_blkaddr,
+			segment0_blkaddr +
+				(segment_count << log_blocks_per_seg),
+			segment_count_main << log_blocks_per_seg);
+		if (err)
+			return true;
+	}
 	return false;
 }
 
 static int sanity_check_raw_super(struct super_block *sb,
-			struct f2fs_super_block *raw_super)
+				struct buffer_head *bh)
 {
+	struct f2fs_super_block *raw_super = (struct f2fs_super_block *)
+					(bh->b_data + F2FS_SUPER_OFFSET);
 	unsigned int blocksize;
 
 	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
@@ -1126,7 +1163,7 @@ static int sanity_check_raw_super(struct super_block *sb,
 	}
 
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
-	if (sanity_check_area_boundary(sb, raw_super))
+	if (sanity_check_area_boundary(sb, bh))
 		return 1;
 
 	return 0;
@@ -1202,7 +1239,7 @@ static int read_raw_super_block(struct super_block *sb,
 {
 	int block;
 	struct buffer_head *bh;
-	struct f2fs_super_block *super, *buf;
+	struct f2fs_super_block *super;
 	int err = 0;
 
 	super = kzalloc(sizeof(struct f2fs_super_block), GFP_KERNEL);
@@ -1218,11 +1255,8 @@ static int read_raw_super_block(struct super_block *sb,
 			continue;
 		}
 
-		buf = (struct f2fs_super_block *)
-				(bh->b_data + F2FS_SUPER_OFFSET);
-
 		/* sanity checking of raw super */
-		if (sanity_check_raw_super(sb, buf)) {
+		if (sanity_check_raw_super(sb, bh)) {
 			f2fs_msg(sb, KERN_ERR,
 				"Can't find valid F2FS filesystem in %dth superblock",
 				block + 1);
@@ -1232,7 +1266,8 @@ static int read_raw_super_block(struct super_block *sb,
 		}
 
 		if (!*raw_super) {
-			memcpy(super, buf, sizeof(*super));
+			memcpy(super, bh->b_data + F2FS_SUPER_OFFSET,
+							sizeof(*super));
 			*valid_super_block = block;
 			*raw_super = super;
 		}
@@ -1252,42 +1287,29 @@ static int read_raw_super_block(struct super_block *sb,
 	return err;
 }
 
-static int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
+int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 {
-	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
 	struct buffer_head *bh;
 	int err;
 
-	bh = sb_getblk(sbi->sb, block);
+	/* write back-up superblock first */
+	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0: 1);
 	if (!bh)
 		return -EIO;
-
-	lock_buffer(bh);
-	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
-	set_buffer_uptodate(bh);
-	set_buffer_dirty(bh);
-	unlock_buffer(bh);
-
-	/* it's rare case, we can do fua all the time */
-	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
+	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
 	brelse(bh);
 
-	return err;
-}
-
-int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
-{
-	int err;
-
-	/* write back-up superblock first */
-	err = __f2fs_commit_super(sbi, sbi->valid_super_block ? 0 : 1);
-
 	/* if we are in recovery path, skip writing valid superblock */
 	if (recover || err)
 		return err;
 
 	/* write current valid superblock */
-	return __f2fs_commit_super(sbi, sbi->valid_super_block);
+	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
+	if (!bh)
+		return -EIO;
+	err = __f2fs_commit_super(bh, F2FS_RAW_SUPER(sbi));
+	brelse(bh);
+	return err;
 }
 
 static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785351&iu=/4140
