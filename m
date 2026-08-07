Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40353C5AC7A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Uqwky7ezT727rvKRY5zQ6rS54Get5glygy19PPd0PLQ=; b=baVOAxG+H0QyYinusfxLVQdGPQ
	A9U4AEHpGRiEvxxOvnLvaVxGNsBJa0j+sLRopKhLqP5d9J+HW5CHAqrfhruBY/RJhLDq7HNxpYoaC
	X9mU1ot/H37c+sirf9mgifgCKRNVrgyEGVcaVjiUy0zNCpacWktVeZZUyXz2hIAGSlDE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsO6U-0007eu-2c;
	Fri, 07 Aug 2026 17:11:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wsO6R-0007eo-3q
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 17:11:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CD+Tc8ou/SLZL4axIb3F9T/mpwJDND0UivAiDuGmhN8=; b=PNa/5/O/LAs2tLnYTsLVd1yN46
 sQYMVIYpElag3gObnJ6eAR+M9+sUwxmTsiiOLd2Bnc8UOi05oCkKUna2RKx8ygiV+uuULd0nF2Ln/
 hOlvluyquJz402AO6R/dUY1phwETHiy6uFQxeAQykJ/Ubon2dVG+nW2Q9R65QsxbZ6Rw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CD+Tc8ou/SLZL4axIb3F9T/mpwJDND0UivAiDuGmhN8=; b=C
 HM0JVU6Gf2ujJgQBZSq3zkfk0Yy+7MZwYjo/3fbG6hvECP2Bid7ym/y5hGo2Mu9EjQxFpOyLQUeHa
 zUEJ4WSvWg9wbKm/elpa6POWAIkUm9VxrdtbLysD1++kUCr54UspNlyV/njFG0qrEsaEmKT97EuBx
 n1X+iU+4KeGoGYWs=;
Received: from 011.lax.mailroute.net ([199.89.1.14])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsO6R-0005ys-7j for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 17:11:24 +0000
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4hGrK247y0z1XM30g;
 Fri,  7 Aug 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:mime-version:x-mailer:message-id:date
 :date:subject:subject:from:from:received:received; s=mr01; t=
 1786122672; x=1788714673; bh=CD+Tc8ou/SLZL4axIb3F9T/mpwJDND0UivA
 iDuGmhN8=; b=iw8qetHdRE2ENnt7YV0Alm2yH/ueuF7Mt4Fhb0JJccN/DHBHRm8
 eIRue4533KfaAYGPxaemlYnJhj1jGr2R+oGgYyCZRKFH0nV8YTrL49pkTi9ipW/t
 IccwzFMrLtnJ6Jl4LcWZd2uwxO4DRLZnHjd7HL6Og6NliZ3wuKuEcOe2n8iXyTha
 fIbQnAceAjp378RqlqXeV6fzyqC+txsPZtb2NPfT3t8AiFLZyfAC3n4PA8g4KnN8
 5bXyxgy+U76dejGqPAMDSSFKJcfBblM/Qpdg615BOZyIdH5yKREvqar3F+IMEkCw
 2RoJf9E8mOnjMHgTIL0ptZWPWSWYtOd3Bew==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7rz3pcTHoE2V; Fri,  7 Aug 2026 17:11:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hGrJt6lF7z1XM6JX;
 Fri,  7 Aug 2026 17:11:10 +0000 (UTC)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri,  7 Aug 2026 10:10:56 -0700
Message-ID: <31b06883a88b8169f2d9be8ac7303bfe14cf1530.1786122586.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
MIME-Version: 1.0
X-Headers-End: 1wsO6R-0005ys-7j
Subject: [f2fs-dev] [PATCH] f2fs: Fix multiple sparse warnings
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fix the following sparse warnings:

fs/f2fs/file.c:3738:36: warning: incorrect type in argument 1 (different base types)
fs/f2fs/file.c:3738:36:    expected unsigned short const [usertype] *pwcs
fs/f2fs/file.c:3738:36:    got restricted __le16 *
fs/f2fs/file.c:3774:28: warning: incorrect type in argument 4 (different base types)
fs/f2fs/file.c:3774:28:    expected unsigned short [usertype] *pwcs
fs/f2fs/file.c:3774:28:    got restricted __le16 *

fs/f2fs/super.c:489:19: warning: symbol 'f2fs_cf_name_slab' was not declared. Should it be static?

fs/f2fs/data.c:2553:39: warning: Using plain integer as NULL pointer

fs/f2fs/xattr.c:851:1: warning: no newline at end of file

fs/f2fs/compress.c:1921:39: warning: symbol 'f2fs_compress_aops' was not declared. Should it be static?

No functionality has been modified.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c              | 2 +-
 fs/f2fs/f2fs.h              | 7 +++++++
 fs/f2fs/file.c              | 8 ++++----
 fs/f2fs/inode.c             | 4 ----
 fs/f2fs/super.c             | 1 -
 fs/f2fs/xattr.c             | 2 +-
 include/trace/events/f2fs.h | 3 ++-
 7 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac1cf4de3d62..2d24c38ad116 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2550,7 +2550,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
-	struct f2fs_map_blocks map = {0, };
+	struct f2fs_map_blocks map = {};
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1774d4e18d2..a4a299591c65 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -654,6 +654,10 @@ struct f2fs_filename {
 #endif
 };
 
+#if IS_ENABLED(CONFIG_UNICODE)
+extern struct kmem_cache *f2fs_cf_name_slab;
+#endif
+
 struct f2fs_dentry_ptr {
 	struct inode *inode;
 	void *bitmap;
@@ -4652,6 +4656,9 @@ enum cluster_check_type {
 	CLUSTER_COMPR_BLKS, /* return # of compressed blocks in a cluster */
 	CLUSTER_RAW_BLKS    /* return # of raw blocks in a cluster */
 };
+
+extern const struct address_space_operations f2fs_compress_aops;
+
 bool f2fs_is_compressed_page(struct folio *folio);
 struct folio *f2fs_compress_control_folio(struct folio *folio);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..a20bc791774a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3735,9 +3735,9 @@ static int f2fs_ioc_getfslabel(struct file *filp, unsigned long arg)
 		return -ENOMEM;
 
 	f2fs_down_read(&sbi->sb_lock);
-	count = utf16s_to_utf8s(sbi->raw_super->volume_name,
-			ARRAY_SIZE(sbi->raw_super->volume_name),
-			UTF16_LITTLE_ENDIAN, vbuf, MAX_VOLUME_NAME);
+	count = utf16s_to_utf8s((__force wchar_t *)sbi->raw_super->volume_name,
+				ARRAY_SIZE(sbi->raw_super->volume_name),
+				UTF16_LITTLE_ENDIAN, vbuf, MAX_VOLUME_NAME);
 	f2fs_up_read(&sbi->sb_lock);
 
 	if (copy_to_user((char __user *)arg, vbuf,
@@ -3771,7 +3771,7 @@ static int f2fs_ioc_setfslabel(struct file *filp, unsigned long arg)
 	memset(sbi->raw_super->volume_name, 0,
 			sizeof(sbi->raw_super->volume_name));
 	utf8s_to_utf16s(vbuf, strlen(vbuf), UTF16_LITTLE_ENDIAN,
-			sbi->raw_super->volume_name,
+			(__force wchar_t *)sbi->raw_super->volume_name,
 			ARRAY_SIZE(sbi->raw_super->volume_name));
 
 	err = f2fs_commit_super(sbi, false);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c95e0b126da4..65758c60632a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -20,10 +20,6 @@
 
 #include <trace/events/f2fs.h>
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-extern const struct address_space_operations f2fs_compress_aops;
-#endif
-
 void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 {
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a87ec20d3363..09123894394d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -486,7 +486,6 @@ f2fs_sb_read_encoding(const struct f2fs_super_block *sb)
 	return NULL;
 }
 
-struct kmem_cache *f2fs_cf_name_slab;
 static int __init f2fs_create_casefold_cache(void)
 {
 	f2fs_cf_name_slab = f2fs_kmem_cache_create("f2fs_casefolded_name",
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ed33e5110f2a..0129800af0bb 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -848,4 +848,4 @@ int __init f2fs_init_xattr_cache(void)
 void f2fs_destroy_xattr_cache(void)
 {
 	kmem_cache_destroy(inline_xattr_slab);
-}
\ No newline at end of file
+}
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 270c1a2c24c4..7f5ce92afe0f 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1493,7 +1493,8 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
 		show_dev_ino(__entry),
 		(unsigned long)__entry->index,
 		__print_flags(__entry->flags, "|", FAULT_FLAG_TRACE),
-		__print_flags(__entry->ret, "|", VM_FAULT_RESULT_TRACE))
+		__print_flags((__force unsigned long)__entry->ret, "|",
+			      VM_FAULT_RESULT_TRACE))
 );
 
 DEFINE_EVENT(f2fs_mmap, f2fs_filemap_fault,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
