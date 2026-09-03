Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EE9C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+HddTFM5JTusJUmCyBLjDs1+clvriGlAsATkJwsewTk=; b=ZM5CB40Zoaj//fEdGdzOOX5WtP
	R1XqWjXMgEd8RNlDrCLQtJLP3w33wqUdPY2vt5WL3p7EPNfASX5Px9KHCroRAGw48345rMAooq6zG
	HKoyZuvFhDBvLB8CfARnhWy/aiQD4+QtWmrhuzfnTN0+t4oEZEx65Q/tane+Z7vN2FP0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2HIF-0006lD-M0;
	Thu, 03 Sep 2026 23:56:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2HIE-0006l2-UC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzZggu0453tGRKVkTcHNa67VAVh0WqG17qQs+4BQESY=; b=gVmlWYelF514ke33vpiX115Tmo
 /KcwXLI/WRtUEyiFdyu6UP5Kj2hhTH7ECNGV2LAt3Ah/A4eV0Ls6lLkouxB8ptOV0wopLX0m4r1xa
 TR/IBE3Gmf7r6TaWn5saOYOuM6utQxaUoGqLFrX5Q+QNOUytPbStXG1Osj9GSPbx86q0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QzZggu0453tGRKVkTcHNa67VAVh0WqG17qQs+4BQESY=; b=NjdGFdwzqTeSuohuczcJpGa9As
 sMz9KhPQ8D8XsQbvdLkwoRQzF3HBA1nW3OXdH2h9j1JgjJ+YOaQvewIELnCLhaCC5xzQkyDPKNaDQ
 HeynhGyxYOH4FijCaFEhj+en9zVdbp3RC99GOiWoNRa028lkQlV+hhXrKjWhUZltA7HI=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2HIE-0008TK-TQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:31 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3964dfb5a69so538625a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788479785; x=1789084585; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QzZggu0453tGRKVkTcHNa67VAVh0WqG17qQs+4BQESY=;
 b=YsFWkkjspYhclz0JPH85KttH8b94qiQaiVzINzgVOCz40FP7alUbmm+HRtDUTeC17G
 nqLJiQ54xGoShPwq2T6e0FAKnqpGONqf7ccKG6X8YJdTeKOCmdtRkgXBw5s2urKr19lA
 PzBQ4PQoS9lEsuuaFnyPKkn0wJ0/q8SSLimf4e3N6XcIsOvvj71LGn1HJnEmHRvpCr4m
 numZqnv5I9lmBxz2tSLdTEKNC+qkgR9ZHT7hZlROAt/9kvd7pHnMqhSw1Gy8T7SpXTfs
 0nIYruRBkXYm7/JcmwFo5/SMuZiQUpA3NbVUQ4heNuqKPFba/aJFOx1ZWjWzG/tQJWml
 5B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788479785; x=1789084585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QzZggu0453tGRKVkTcHNa67VAVh0WqG17qQs+4BQESY=;
 b=SqEOr41MSzJbuegu/U5zyL5ZColCBvBHnWIKon2iBkRK4sQYADLQZ605jachbb81Jx
 4vTANvDeiAZXuoKzWzF+W8BaiHWspDJvvNYNElg56bnFCJefDFHnTY4w0eiNnQH4BKqN
 /aydVs8KKqYTtGxqqQ+jLBg4AqJLJH0Wvv8DlZ75jnzMYDJq/2LdrbPtC/9/nYIvry8k
 SjMhYhBrAUgiTfp5Zae9iyk/IzyOSE0uOoAp1SZibZtKeY7RqVTuGbL7PkK4mqYZtvqF
 IwNLuEZNt6fMYuGhgF6IAMObIMLBDa3ozn45BtLlsn7DikNOiouel3UtFzzFSu37Ncfv
 jkjg==
X-Gm-Message-State: AFuF++mx4yJRpQPNxU/Ha11Z87XM0NmF+aBoQQnkfPufB+WirYyVlK0Q
 yGu6sWM77UPspKqeCer7bIuR1D8gn2l2Ju0ASUmGCZ8+eY7GX3RIOwPsjzRqdbZyovA=
X-Gm-Gg: AYBFou3gB4Te8W5Vi+qCSekKD6XkbBEuylh4um/nh/y88+kuLVRJMayLzBijWtlFYO7
 f6sKaqpn6plkpag7i4ZkQLWXt9AngX99MdJuRWYQauKwD+BsFflO5E1EFaM2+DRDFlm18rzQ2rT
 HXxAWH+7NWhCRYbnbGLP3VgsQMjNXEsLV/9Kf3mQranHSqK3IYpnNYD7WNNrr85MVps8cPYMM7x
 HVn4WZ8sMSQ5cebbXQsB52IbBvK9GIKyzZXkjpcCviq27cCuFUeYzmFV6Creqgj+ncot02sFSZn
 Q3Oa80mGq/cHaZRu/mUH1179hbbCBsdDuO2o5EHVzT1e+S5ihkeukv7lR43P+r7n2DwnutZoshI
 lZ4fDeO5XvVmcOfrM6o1VVotqOd3q+NjJ9RqazPRANUMdEnBVqJ2KhvuztozOVW5ItdNeNB3DFa
 nrusj9ZuGPipXvUBf/yYBLq1BszMLQj/SfP9YlhnOaXwGfft1WOy8ltuZ8HGShfH4KtJUTq09iw
 w6puQ==
X-Received: by 2002:a17:90b:2ccd:b0:398:b88c:2b7b with SMTP id
 98e67ed59e1d1-39b260d7297mr3541846a91.8.1788479785112; 
 Thu, 03 Sep 2026 16:56:25 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143243a9388sm2373680c88.10.2026.09.03.16.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:56:24 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:56:14 -0700
Message-ID: <10843e36038ce78374ef20fe8c19f6ec392bc078.1788479509.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788479509.git.zhangxp1998@gmail.com>
References: <cover.1788479509.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2HIE-0008TK-TQ
Subject: [f2fs-dev] [PATCH v9 02/11] f2fs: describe SIT block layout
 dynamically
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

An SIT block consists of an on-disk array of struct f2fs_sit_entry elements
whose total capacity depends on the filesystem block size. The existing
fixed SIT_ENTRY_PER_BLOCK macro hardcodes a 4KB block size.

Convert the entries array in struct f2fs_sit_block into a C flexible array
member, and calculate sbi->sit_entries_per_block dynamically in
init_sb_info().

Parameterize SIT indexing helpers (SIT_ENTRY_PER_BLOCK, SIT_BLOCK_OFFSET,
SIT_BLK_CNT, and f2fs_start_segno) to take struct f2fs_sb_info *sbi, and
update all call sites across segment management, checkpointing, and mount.

This is a layout-only change; valid 4KB filesystems retain identical
runtime geometry and behavior.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    |  2 +-
 fs/f2fs/f2fs.h          |  3 +++
 fs/f2fs/segment.c       | 15 ++++++++-------
 fs/f2fs/segment.h       | 22 +++++++++++++---------
 fs/f2fs/super.c         |  4 +++-
 include/linux/f2fs_fs.h |  9 ++++++---
 6 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index cf88b463fde5..7fcda18e9cda 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -487,7 +487,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 				goto out;
 			/* get sit block addr */
 			fio.new_blkaddr = current_sit_addr(sbi,
-					blkno * SIT_ENTRY_PER_BLOCK);
+					blkno * SIT_ENTRY_PER_BLOCK(sbi));
 			break;
 		case META_SSA:
 		case META_CP:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f7ab5888b07..cd49b03befa3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1862,6 +1862,7 @@ struct f2fs_sb_info {
 	unsigned int log_sectors_per_block;	/* log2 sectors per block */
 	unsigned int log_blocksize;		/* log2 block size */
 	unsigned int blocksize;			/* block size */
+	unsigned int sit_entries_per_block;	/* SIT entries in a block */
 	unsigned int root_ino_num;		/* root inode number*/
 	unsigned int node_ino_num;		/* node inode number*/
 	unsigned int meta_ino_num;		/* meta inode number*/
@@ -2250,6 +2251,8 @@ static inline struct f2fs_sb_info *F2FS_F_SB(const struct folio *folio)
 	return F2FS_M_SB(folio->mapping);
 }
 
+#define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
+
 static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
 {
 	return (struct f2fs_super_block *)(sbi->raw_super);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b712d3d599..2427649402f6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4706,7 +4706,7 @@ static struct folio *get_next_sit_folio(struct f2fs_sb_info *sbi,
 	seg_info_to_sit_folio(sbi, folio, start);
 
 	folio_mark_dirty(folio);
-	set_to_next_sit(sit_i, start);
+	set_to_next_sit(sbi, sit_i, start);
 
 	return folio;
 }
@@ -4745,10 +4745,11 @@ static void adjust_sit_entry_set(struct sit_entry_set *ses,
 	list_move_tail(&ses->set_list, head);
 }
 
-static void add_sit_entry(unsigned int segno, struct list_head *head)
+static void add_sit_entry(struct f2fs_sb_info *sbi, unsigned int segno,
+		struct list_head *head)
 {
 	struct sit_entry_set *ses;
-	unsigned int start_segno = START_SEGNO(segno);
+	unsigned int start_segno = f2fs_start_segno(sbi, segno);
 
 	list_for_each_entry(ses, head, set_list) {
 		if (ses->start_segno == start_segno) {
@@ -4773,7 +4774,7 @@ static void add_sits_in_set(struct f2fs_sb_info *sbi)
 	unsigned int segno;
 
 	for_each_set_bit(segno, bitmap, MAIN_SEGS(sbi))
-		add_sit_entry(segno, set_list);
+		add_sit_entry(sbi, segno, set_list);
 }
 
 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
@@ -4791,7 +4792,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 		dirtied = __mark_sit_entry_dirty(sbi, segno);
 
 		if (!dirtied)
-			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
+			add_sit_entry(sbi, segno, &SM_I(sbi)->sit_entry_set);
 	}
 	update_sits_in_cursum(journal, -i);
 	up_write(&curseg->journal_rwsem);
@@ -4841,7 +4842,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		struct folio *folio = NULL;
 		struct f2fs_sit_block *raw_sit = NULL;
 		unsigned int start_segno = ses->start_segno;
-		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK,
+		unsigned int end = min(start_segno + SIT_ENTRY_PER_BLOCK(sbi),
 						(unsigned long)MAIN_SEGS(sbi));
 		unsigned int segno = start_segno;
 
@@ -5006,7 +5007,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	sit_i->written_valid_blocks = 0;
 	sit_i->bitmap_size = sit_bitmap_size;
 	sit_i->dirty_sentries = 0;
-	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
+	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK(sbi);
 	sit_i->elapsed_time = le64_to_cpu(sbi->ckpt->elapsed_time);
 	sit_i->mounted_time = ktime_get_boottime_seconds();
 	init_rwsem(&sit_i->sentry_lock);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5949aa5200ac..534e376cbc92 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -102,12 +102,15 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
 
 #define SIT_ENTRY_OFFSET(sit_i, segno)					\
 	((segno) % (sit_i)->sents_per_block)
-#define SIT_BLOCK_OFFSET(segno)					\
-	((segno) / SIT_ENTRY_PER_BLOCK)
-#define	START_SEGNO(segno)		\
-	(SIT_BLOCK_OFFSET(segno) * SIT_ENTRY_PER_BLOCK)
+#define SIT_BLOCK_OFFSET(sbi, segno)				\
+	((segno) / SIT_ENTRY_PER_BLOCK(sbi))
+static inline unsigned int
+f2fs_start_segno(struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	return SIT_BLOCK_OFFSET(sbi, segno) * SIT_ENTRY_PER_BLOCK(sbi);
+}
 #define SIT_BLK_CNT(sbi)			\
-	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK)
+	DIV_ROUND_UP(MAIN_SEGS(sbi), SIT_ENTRY_PER_BLOCK(sbi))
 #define f2fs_bitmap_size(nr)			\
 	(BITS_TO_LONGS(nr) * sizeof(unsigned long))
 
@@ -424,7 +427,7 @@ static inline void seg_info_to_sit_folio(struct f2fs_sb_info *sbi,
 	struct f2fs_sit_block *raw_sit;
 	struct seg_entry *se;
 	struct f2fs_sit_entry *rs;
-	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
+	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK(sbi),
 					(unsigned long)MAIN_SEGS(sbi));
 	int i;
 
@@ -869,7 +872,7 @@ static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
 						unsigned int start)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int offset = SIT_BLOCK_OFFSET(start);
+	unsigned int offset = SIT_BLOCK_OFFSET(sbi, start);
 	block_t blk_addr = sit_i->sit_base_addr + offset;
 
 	f2fs_bug_on(sbi, !valid_main_segno(sbi, start));
@@ -894,9 +897,10 @@ static inline pgoff_t next_sit_addr(struct f2fs_sb_info *sbi,
 	return block_addr + sit_i->sit_base_addr;
 }
 
-static inline void set_to_next_sit(struct sit_info *sit_i, unsigned int start)
+static inline void set_to_next_sit(struct f2fs_sb_info *sbi,
+				   struct sit_info *sit_i, unsigned int start)
 {
-	unsigned int block_off = SIT_BLOCK_OFFSET(start);
+	unsigned int block_off = SIT_BLOCK_OFFSET(sbi, start);
 
 	f2fs_change_bit(block_off, sit_i->sit_bitmap);
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index eda8dd8f4eb0..4e10a84b4142 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4329,7 +4329,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 		return 1;
 	}
 
-	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK);
+	sit_blk_cnt = DIV_ROUND_UP(main_segs, SIT_ENTRY_PER_BLOCK(sbi));
 	if (sit_bitmap_size * 8 < sit_blk_cnt) {
 		f2fs_err(sbi, "Wrong bitmap size: sit: %u, sit_blk_cnt:%u",
 			 sit_bitmap_size, sit_blk_cnt);
@@ -4382,6 +4382,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		le32_to_cpu(raw_super->log_sectors_per_block);
 	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
 	sbi->blocksize = BIT(sbi->log_blocksize);
+	sbi->sit_entries_per_block = sbi->blocksize /
+		sizeof(struct f2fs_sit_entry);
 	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
 	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bb2b6cd5d507..ecd6694af572 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -396,8 +396,6 @@ struct f2fs_nat_block {
  * Not allow to change this.
  */
 #define SIT_VBLOCK_MAP_SIZE 64
-#define SIT_ENTRY_PER_BLOCK (F2FS_BLKSIZE / sizeof(struct f2fs_sit_entry))
-
 /*
  * F2FS uses 4 bytes to represent block address. As a result, supported size of
  * disk is 16 TB for a 4K page size and 64 TB for a 16K page size and it equals
@@ -424,8 +422,13 @@ struct f2fs_sit_entry {
 	__le64 mtime;				/* segment age for cleaning */
 } __packed;
 
+/*
+ * The on-disk SIT block is a filesystem-block-sized array of SIT entries.
+ * Its entry count depends on the filesystem block size, so it must be
+ * calculated by the caller rather than implied by this C structure.
+ */
 struct f2fs_sit_block {
-	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+	DECLARE_FLEX_ARRAY(struct f2fs_sit_entry, entries);
 } __packed;
 
 /*
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
