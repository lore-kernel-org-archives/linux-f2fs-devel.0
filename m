Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91C1C7EE2C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 28 May 2023 08:07:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3BRJ-0006IW-Mr;
	Sun, 28 May 2023 08:07:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q3BRD-0006IQ-NF
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 28 May 2023 08:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ISSE8g7sv15zohDeboQHPQSZKZpnzyb/e1r+YAyquts=; b=L3xbqEClSkht1B7H6nw9+Soz+f
 1oazJ97XhLrYn5Gsh237weyoPHcam73hHemMt2GmFltNEdyR2/UcKVScF/uhrS61dPD0NkMSHniPw
 Chpfokhkx2w/QAphy2gYy5SpDwLs92xtT6b+tYqmRgvfdoOjjJt9TqPx3hy/1VNZE5OU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ISSE8g7sv15zohDeboQHPQSZKZpnzyb/e1r+YAyquts=; b=Q
 PAVkrKCDbpVAdkLgAt/pqXQnH9BXrhxNejN+Tqp0IDpLtWHzmpyg7CcMJ0GWLTNXnj7xguNnGozpr
 FzGSVQbPBPjFjQHpTS+z3Tbr2Pas/Nlbku7hOjeeDOV1wKHBGRjynOhD8WgQ0HsZdlCWXXHS84jJq
 VHLfxhDePEjO8Pyg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q3BR9-000497-PF for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 28 May 2023 08:07:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5FAA560C2E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 28 May 2023 08:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBAFC433EF;
 Sun, 28 May 2023 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685261249;
 bh=AQnMGixjKPitlp8xCpkid3gRUBaphHUrvP25RpuL5ss=;
 h=From:To:Cc:Subject:Date:From;
 b=c58Gi4O0yN/YJjBG4dPtLYUjFTf+uh+aauyGI4NCvQVDeDenzTd9I2dFqB9fViSaP
 Mg4bZ8RbDjBaU6i6SMI94Vfs3fXkM/JtMzrWMDMJhIV1tIZy/fECm82q9BPrZe5mfy
 RAUnn7Ow2iS76MDmyIvcSP0losCSTFlZSK+K1hkj4pyjSImF+psN+C5tC1q9FdOSrN
 pGBMNRAEnamOMeQvi40sgH4g82GBlxwz9ii+6zv0i+gaIiIcOFzz4Rz3VcAdhCUibG
 Vd2RdgP09RwmHnYsXIYGggPqC0bywnSaJJmNfP2NlnBsDI1yFPE5PZZvUp46pSA6QR
 qAKgVJbIJsv5Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun, 28 May 2023 16:07:09 +0800
Message-Id: <20230528080709.1692640-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q3BR9-000497-PF
Subject: [f2fs-dev] [PATCH] fsck.f2fs: clean up codes with IS_INODE()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

and use le32_to_cpu() in IS_INODE().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/fsck.c  | 7 +++----
 fsck/mount.c | 4 ++--
 fsck/node.h  | 3 ++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e6ad71d..a4db2a3 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -247,7 +247,7 @@ static int is_valid_summary(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		goto out;
 
 	/* check its block address */
-	if (node_blk->footer.nid == node_blk->footer.ino) {
+	if (IS_INODE(node_blk)) {
 		int ofs = get_extra_isize(node_blk);
 
 		if (ofs + ofs_in_node >= DEF_ADDRS_PER_INODE)
@@ -447,8 +447,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 				nid, ni->ino, le32_to_cpu(node_blk->footer.ino));
 		return -EINVAL;
 	}
-	if (ntype != TYPE_INODE &&
-			node_blk->footer.nid == node_blk->footer.ino) {
+	if (ntype != TYPE_INODE && IS_INODE(node_blk)) {
 		ASSERT_MSG("nid[0x%x] footer.nid[0x%x] footer.ino[0x%x]",
 				nid, le32_to_cpu(node_blk->footer.nid),
 				le32_to_cpu(node_blk->footer.ino));
@@ -3080,7 +3079,7 @@ static int fsck_reconnect_file(struct f2fs_sb_info *sbi)
 			ASSERT(err >= 0);
 
 			/* reconnection will restore these nodes if needed */
-			if (node->footer.ino != node->footer.nid) {
+			if (!IS_INODE(node)) {
 				DBG(1, "Not support non-inode node [0x%x]\n",
 				    nid);
 				continue;
diff --git a/fsck/mount.c b/fsck/mount.c
index f1fb525..90ecabf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2394,7 +2394,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 	ASSERT(ret >= 0);
 
 	/* check its block address */
-	if (node_blk->footer.nid == node_blk->footer.ino) {
+	if (IS_INODE(node_blk)) {
 		int ofs = get_extra_isize(node_blk);
 
 		oldaddr = le32_to_cpu(node_blk->i.i_addr[ofs + ofs_in_node]);
@@ -2409,7 +2409,7 @@ void update_data_blkaddr(struct f2fs_sb_info *sbi, nid_t nid,
 	}
 
 	/* check extent cache entry */
-	if (node_blk->footer.nid != node_blk->footer.ino) {
+	if (!IS_INODE(node_blk)) {
 		get_node_info(sbi, le32_to_cpu(node_blk->footer.ino), &ni);
 
 		/* read inode block */
diff --git a/fsck/node.h b/fsck/node.h
index 99139b1..2ba7b8c 100644
--- a/fsck/node.h
+++ b/fsck/node.h
@@ -20,7 +20,8 @@
 
 static inline int IS_INODE(struct f2fs_node *node)
 {
-	return ((node)->footer.nid == (node)->footer.ino);
+	return le32_to_cpu(node->footer.ino) ==
+			le32_to_cpu(node->footer.nid);
 }
 
 static inline unsigned int ADDRS_PER_PAGE(struct f2fs_sb_info *sbi,
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
