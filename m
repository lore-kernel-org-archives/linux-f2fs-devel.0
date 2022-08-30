Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA2AC0502E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Aug 2022 10:36:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oSyc5-0000oq-En;
	Tue, 30 Aug 2022 10:36:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oSybx-0000o4-4b
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Aug 2022 10:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oTA3fVfu2rP8BGg9XsDRJSC2WgzZ0u8H+qbgV7L1QLU=; b=DmQg9RtHQycEFd4RiKyGJiFABw
 koI5IOTAt5QbkzqvWGLSfxawTTrV2otgopqGmUpx0/zDw6S5FJs/jzDZC2c9Hzz6jHKSIo5kTWj8p
 WO15LAcFNoSICGkDLDqlbgnWa4Tg6jFDWYrX+EALewLp9R7xQfAIxGfccTYaU7wLKbDE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oTA3fVfu2rP8BGg9XsDRJSC2WgzZ0u8H+qbgV7L1QLU=; b=f
 ibdg4VAbrH0TeGj+gfWGnz+7G0LIbhqR56n9thyZb11tVscqUnTw/aLsdQFKTEgRIVM1UBrbztJIu
 JV9FZ5Le1PdLqAUYNnzRYAX6UiVLTg9GRWLyulT9RBsT7Y1DkmgDLMub8qrjgQ2TI1U6G8V2f9AZs
 FHvCqDG4GMI/nDTU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oSybu-0000LV-9N for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Aug 2022 10:36:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 684F1B80CAE;
 Tue, 30 Aug 2022 10:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA552C433D6;
 Tue, 30 Aug 2022 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661855793;
 bh=qMxTTqR/dvJqVgbe2yPKA71cHreZYwt3vwlAgjXYGnU=;
 h=From:To:Cc:Subject:Date:From;
 b=cqF+UG+12ZAeOzOfz4Z+24tIYfifvohzAdEvG1r60pvvToyo79BCQOctrx/Ygc7v4
 OEfy86rp2tj7nQ268x6curSzOOHoHNLd3uZAgY2rp8hhva+TQHwgOEPRqevvvz0U2W
 UJ8Hwv7Y9tuxFtvWDoTHvKA7vlYh4+B8UEh0CfdTwHkhT1BZ9WO3u9Y5KYwFLChg8w
 hZOjTs8j2wyT2cmsTsw3JFNjh54+j7Aw2bl87e7vo15HUNYR9DVUN4dkM7TZsKRO3l
 UFMk3HdeITdLnhLHG9xnNvbcIaC2S5GeC95VyuVtvklbjMQCXYoEln2pcnV9z+cboC
 70FV0B5ZTjUkQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 30 Aug 2022 18:36:25 +0800
Message-Id: <20220830103625.79034-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oSybu-0000LV-9N
Subject: [f2fs-dev] [PATCH] f2fs: fix to disallow getting inner inode via
 f2fs_iget()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao.yu@oppo.com>

Introduce f2fs_iget_inner() for f2fs_fill_super() to get inner inode:
meta inode, node inode or compressed inode, and add f2fs_check_nid_range()
in f2fs_iget() to avoid getting inner inode from external interfaces.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/inode.c    | 10 +++++++++-
 fs/f2fs/super.c    |  4 ++--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 730256732a9e..c38b22bb6432 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1947,7 +1947,7 @@ int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
 	if (!test_opt(sbi, COMPRESS_CACHE))
 		return 0;
 
-	inode = f2fs_iget(sbi->sb, F2FS_COMPRESS_INO(sbi));
+	inode = f2fs_iget_inner(sbi->sb, F2FS_COMPRESS_INO(sbi));
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 	sbi->compress_inode = inode;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 408d8034ed74..35f9e1a6a1bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3467,6 +3467,7 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
 void f2fs_set_inode_flags(struct inode *inode);
 bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
+struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 6d11c365d7b4..0ab3ae9b2110 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -480,7 +480,7 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
-struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
+struct inode *f2fs_iget_inner(struct super_block *sb, unsigned long ino)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct inode *inode;
@@ -568,6 +568,14 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	return ERR_PTR(ret);
 }
 
+struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
+{
+	if (f2fs_check_nid_range(F2FS_SB(sb), ino))
+		return -EINVAL;
+
+	return f2fs_iget_inner(sb, ino);
+}
+
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 {
 	struct inode *inode;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b8e5fe244596..a5f5e7483791 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4157,7 +4157,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_xattr_cache;
 
 	/* get an inode for meta space */
-	sbi->meta_inode = f2fs_iget(sb, F2FS_META_INO(sbi));
+	sbi->meta_inode = f2fs_iget_inner(sb, F2FS_META_INO(sbi));
 	if (IS_ERR(sbi->meta_inode)) {
 		f2fs_err(sbi, "Failed to read F2FS meta data inode");
 		err = PTR_ERR(sbi->meta_inode);
@@ -4265,7 +4265,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_nm;
 
 	/* get an inode for node space */
-	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
+	sbi->node_inode = f2fs_iget_inner(sb, F2FS_NODE_INO(sbi));
 	if (IS_ERR(sbi->node_inode)) {
 		f2fs_err(sbi, "Failed to read node inode");
 		err = PTR_ERR(sbi->node_inode);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
