Return-Path: <SRS0=B6y3=CJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68487C433E2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2020 02:10:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2155F2076D;
	Mon, 31 Aug 2020 02:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fAqaNwZX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="m8HcGrmi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4cn6i0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2155F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kCZGo-0004c5-FA; Mon, 31 Aug 2020 02:10:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kCZGl-0004bv-C5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Aug 2020 02:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YZA4Jxp1/LovkIERwC8cRY8LKXjFkLRRUzr+YgrmuJM=; b=fAqaNwZXU76OFhmVMlqvmaKwcg
 8407o60eFsmL9WBv8JLYvaT1cnXLE6C4CruWK07M/BhqrQqqadfmjSC1eLkt0i73O/KT9o/5d9CTB
 zjsvJBEfv5a+FHNHFOjogdkJEc0V2NXaac0OfkIwalH/fzbFPGco1bgxYf/l/q78VtIw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YZA4Jxp1/LovkIERwC8cRY8LKXjFkLRRUzr+YgrmuJM=; b=m
 8HcGrmi7mknMsFTfVqz12qFyd6jFOod+8MJLk+9l7WcDzE5+XDgFnYblpA67q2VIicCpAxJKJMIK+
 TVb+/J9oksnnBVX0WqTJNuCOqYF5yPoXSy43XdW+t7iYMjCNyEp/2txf+OzwwL536h9qPdJJnstwz
 0WXxmcFS5Sf2mFE0=;
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kCZGj-007UeC-EQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Aug 2020 02:10:03 +0000
Received: by mail-pf1-f196.google.com with SMTP id 17so3715217pfw.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2020 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YZA4Jxp1/LovkIERwC8cRY8LKXjFkLRRUzr+YgrmuJM=;
 b=R4cn6i0AMPdk0bD8kYRDnEkMkspxSvJEzFNyjc6q1ZprCAa8Q4k/n8KgM4niF+mlRh
 r/8SfOLdZb0Gt8K55TjxH9nMYXsbVe4bt8e9FmZEVW4IgTBqhquqqR7D0Ux8mNcX1W+L
 gX12loSHdxpLB3fasawc1h176DRu+RsW/juqMuX/8jxZJxLY3/wgxuOca7TdPyviNBe9
 TxulGl/BF3W9GbmHxgVAaRiPWGC2vHI8GX4344pWk8fTQ7HaihQXkjVJakI6YDyWl78Q
 DAzZAwP5M+F4dsPB0vHvQKKVLNaOkLL8NhsvGzMHXhpJ6AdipuKQ5qfXQRz9V2zJ2VNL
 mxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YZA4Jxp1/LovkIERwC8cRY8LKXjFkLRRUzr+YgrmuJM=;
 b=JKa0kxInZCpg4bUNjAPq7tYpjEk6yreOp57WeHm0R/EVPXWED4mRfwPpqqj6tKEFPL
 ndaKjQ/ZjVjoEI5Ab6Re/KQjEKTIUIA/Mj2WeN9GiDNzM8lYoO7DpPMsBzEuvpfeRX1r
 chmTFOjBdaE51QqYR9S5dWYfUuRiEtxJasuMzD1fZqY6nwkUwbAhlQVSTFxvoIkRqdOq
 YIrAxlVblhNCVsPt8y2kYL4IqoguE4kEgBzFHqTUWmVnNbzD0kfwWAyPDxaSzIclK/HK
 pnNnd6b3L/5WVPv5R5Lhsl+dSu6PdTK+Tf0HSMLundrCNASAhIWvWSquH6D7B2JiTdvC
 AvDw==
X-Gm-Message-State: AOAM533boWR7oAwk0MW3lLcpuhDZIdBlsrGriud2GDKpp7FXi1yiaccD
 0R2uJwk0ibWPXuJOzLu5+oKb3ywVSf4=
X-Google-Smtp-Source: ABdhPJyph/vYXHaoDuzLw6oSx9KKY6yc0pI+qOzxSdYQiGFrnNK3kZitaLxd0YmuOPySIBuv8d5fIQ==
X-Received: by 2002:a63:110c:: with SMTP id g12mr6364680pgl.91.1598839795696; 
 Sun, 30 Aug 2020 19:09:55 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
 by smtp.gmail.com with ESMTPSA id m24sm5524916pgn.44.2020.08.30.19.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 19:09:55 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 31 Aug 2020 11:09:49 +0900
Message-Id: <20200831020949.3218854-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
X-Headers-End: 1kCZGj-007UeC-EQ
Subject: [f2fs-dev] [PATCH] f2fs: change compr_blocks of superblock info to
 64bit
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Current compr_blocks of superblock info is not 64bit value. We are
accumulating each i_compr_blocks count of inodes to this value and
those are 64bit values. So, need to change this to 64bit value.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/debug.c | 6 +++---
 fs/f2fs/f2fs.h  | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 4276c0f79beb..257e658b3a5e 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -131,7 +131,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
 	si->compr_inode = atomic_read(&sbi->compr_inode);
-	si->compr_blocks = atomic_read(&sbi->compr_blocks);
+	si->compr_blocks = atomic64_read(&sbi->compr_blocks);
 	si->append = sbi->im[APPEND_INO].ino_num;
 	si->update = sbi->im[UPDATE_INO].ino_num;
 	si->orphans = sbi->im[ORPHAN_INO].ino_num;
@@ -342,7 +342,7 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_inode);
 		seq_printf(s, "  - Inline_dentry Inode: %u\n",
 			   si->inline_dir);
-		seq_printf(s, "  - Compressed Inode: %u, Blocks: %u\n",
+		seq_printf(s, "  - Compressed Inode: %u, Blocks: %llu\n",
 			   si->compr_inode, si->compr_blocks);
 		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
 			   si->orphans, si->append, si->update);
@@ -542,7 +542,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inline_inode, 0);
 	atomic_set(&sbi->inline_dir, 0);
 	atomic_set(&sbi->compr_inode, 0);
-	atomic_set(&sbi->compr_blocks, 0);
+	atomic64_set(&sbi->compr_blocks, 0);
 	atomic_set(&sbi->inplace_count, 0);
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 02811ce15059..f60414805e05 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1552,7 +1552,7 @@ struct f2fs_sb_info {
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	atomic_t compr_inode;			/* # of compressed inodes */
-	atomic_t compr_blocks;			/* # of compressed blocks */
+	atomic64_t compr_blocks;		/* # of compressed blocks */
 	atomic_t vw_cnt;			/* # of volatile writes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	atomic_t max_vw_cnt;			/* max # of volatile writes */
@@ -3533,7 +3533,8 @@ struct f2fs_stat_info {
 	int nr_discard_cmd;
 	unsigned int undiscard_blks;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
-	int compr_inode, compr_blocks;
+	int compr_inode;
+	unsigned long long compr_blocks;
 	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
@@ -3618,9 +3619,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 			(atomic_dec(&F2FS_I_SB(inode)->compr_inode));	\
 	} while (0)
 #define stat_add_compr_blocks(inode, blocks)				\
-		(atomic_add(blocks, &F2FS_I_SB(inode)->compr_blocks))
+		(atomic64_add(blocks, &F2FS_I_SB(inode)->compr_blocks))
 #define stat_sub_compr_blocks(inode, blocks)				\
-		(atomic_sub(blocks, &F2FS_I_SB(inode)->compr_blocks))
+		(atomic64_sub(blocks, &F2FS_I_SB(inode)->compr_blocks))
 #define stat_inc_meta_count(sbi, blkaddr)				\
 	do {								\
 		if (blkaddr < SIT_I(sbi)->sit_base_addr)		\
-- 
2.28.0.402.g5ffc5be6b7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
