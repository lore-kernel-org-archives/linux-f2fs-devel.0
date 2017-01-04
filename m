From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 03/10 v2] f2fs: add submit_bio tracepoint
Date: Wed, 4 Jan 2017 15:35:06 -0800
Message-ID: <20170104233506.GC1011@jaegeuk.local>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <20161230185117.3832-3-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161230185117.3832-3-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 - remove F2FS_OP
 - share single tracing structure, f2fs__bio
 - split f2fs_prepare_read/write_io and f2fs_submit_read/write_io

>From f5c6ab0f19fb627ebf28ab6a18c0a32b4c8f914f Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 21 Dec 2016 12:13:03 -0800
Subject: [PATCH] f2fs: add submit_bio tracepoint

This patch adds final submit_bio() tracepoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c              | 12 ++++++++----
 include/trace/events/f2fs.h | 45 ++++++++++++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2c5df1dc1479..a06b2d187aec 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -175,6 +175,10 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
 	}
+	if (is_read_io(bio_op(bio)))
+		trace_f2fs_submit_read_bio(sbi->sb, type, bio);
+	else
+		trace_f2fs_submit_write_bio(sbi->sb, type, bio);
 	submit_bio(bio);
 }
 
@@ -185,12 +189,12 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	if (!io->bio)
 		return;
 
+	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
+
 	if (is_read_io(fio->op))
-		trace_f2fs_submit_read_bio(io->sbi->sb, fio, io->bio);
+		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type, io->bio);
 	else
-		trace_f2fs_submit_write_bio(io->sbi->sb, fio, io->bio);
-
-	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
+		trace_f2fs_prepare_write_bio(io->sbi->sb, fio->type, io->bio);
 
 	__submit_bio(io->sbi, io->bio, fio->type);
 	io->bio = NULL;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 4c942599581b..04c527410ecc 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -784,12 +784,11 @@ DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_mbio,
 	TP_CONDITION(page->mapping)
 );
 
-DECLARE_EVENT_CLASS(f2fs__submit_bio,
+DECLARE_EVENT_CLASS(f2fs__bio,
 
-	TP_PROTO(struct super_block *sb, struct f2fs_io_info *fio,
-						struct bio *bio),
+	TP_PROTO(struct super_block *sb, int type, struct bio *bio),
 
-	TP_ARGS(sb, fio, bio),
+	TP_ARGS(sb, type, bio),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
@@ -802,9 +801,9 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
-		__entry->op		= fio->op;
-		__entry->op_flags	= fio->op_flags;
-		__entry->type		= fio->type;
+		__entry->op		= bio_op(bio);
+		__entry->op_flags	= bio->bi_opf;
+		__entry->type		= type;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->size		= bio->bi_iter.bi_size;
 	),
@@ -817,22 +816,38 @@ DECLARE_EVENT_CLASS(f2fs__submit_bio,
 		__entry->size)
 );
 
-DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_write_bio,
+DEFINE_EVENT_CONDITION(f2fs__bio, f2fs_prepare_write_bio,
+
+	TP_PROTO(struct super_block *sb, int type, struct bio *bio),
+
+	TP_ARGS(sb, type, bio),
+
+	TP_CONDITION(bio)
+);
+
+DEFINE_EVENT_CONDITION(f2fs__bio, f2fs_prepare_read_bio,
+
+	TP_PROTO(struct super_block *sb, int type, struct bio *bio),
+
+	TP_ARGS(sb, type, bio),
+
+	TP_CONDITION(bio)
+);
+
+DEFINE_EVENT_CONDITION(f2fs__bio, f2fs_submit_read_bio,
 
-	TP_PROTO(struct super_block *sb, struct f2fs_io_info *fio,
-							struct bio *bio),
+	TP_PROTO(struct super_block *sb, int type, struct bio *bio),
 
-	TP_ARGS(sb, fio, bio),
+	TP_ARGS(sb, type, bio),
 
 	TP_CONDITION(bio)
 );
 
-DEFINE_EVENT_CONDITION(f2fs__submit_bio, f2fs_submit_read_bio,
+DEFINE_EVENT_CONDITION(f2fs__bio, f2fs_submit_write_bio,
 
-	TP_PROTO(struct super_block *sb, struct f2fs_io_info *fio,
-							struct bio *bio),
+	TP_PROTO(struct super_block *sb, int type, struct bio *bio),
 
-	TP_ARGS(sb, fio, bio),
+	TP_ARGS(sb, type, bio),
 
 	TP_CONDITION(bio)
 );
-- 
2.11.0
