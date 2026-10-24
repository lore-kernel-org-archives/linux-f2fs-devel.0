Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EDA606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GrSbb+dA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OFsSNOHB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TxZUuSJT;
	dkim=neutral header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=GOAbD0Zh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Date:To:Mime-Version:Message-Id:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=LADoLgwlU8yEMBTH5mMyf40e3tAXvPNssu+32YS+qsQ=; b=GrSbb+dAVe/YpIVM88zTx2FFBE
	Yzu8TmeWIhu5uHoqCnRECznKEPPlyeBZjHSPNzGa5ukzdxQuNcHwj6n4Mgm+WLSfFKop8UxBG187Y
	NaTd5Lty1lX9q9qP+ZCHJvMfrW3KTuVpBajGL1GP7VocVqZl0sLjUSmsCsE6gjbMMTBE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKaZa-000000001Mr-1z55;
	Sat, 24 Oct 2026 12:10:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <luojiahao.fs@bytedance.com>)
 id 1xKaZZ-000000001Ml-2Fcu
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 24 Oct 2026 12:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Date:Cc:To:Mime-Version:Subject:From:
 Content-Transfer-Encoding:Message-Id:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PDj4fWndRKPK2C3AFlrPKjKgtw4YZAPM7XpLbaxt01I=; b=OFsSNOHBonTZFIM57Co9xhAVSK
 6JpRV6JSvPpaPILZbyjcaz0qWjyQAvWHtwJJtusq6VJDI41yjqJWxZ1fWJxIurA4PrhBP5x0US0WG
 tyVvVAVslWCCZXAQ0lXnHxAJnM8sEb25qgy1dspPLpUZV0n0ysejEml/zxZWrpKRrCGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Content-Type:Date:Cc:To:Mime-Version:Subject:From:
 Content-Transfer-Encoding:Message-Id:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PDj4fWndRKPK2C3AFlrPKjKgtw4YZAPM7XpLbaxt01I=; b=TxZUuSJTv/6K4JawP5fmlfxL/1
 prcoX0pZh2miBRl+OSZQ9bjeOwp7Na551u1qzXxQCwwKk7TxFiz6NjYyRwvbuA//pE1Mo5iQ6xekN
 rKzGwhxHAMOLRdJuFaczuzSe0BgwaoruL6Dyn/ZIN2ea70TgRbVIp8A0vfGH82djb2W0=;
Received: from sg-3-111.ptr.tlmpb.com ([101.45.255.111])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKaZW-000000003WK-1ya0
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 24 Oct 2026 12:10:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792842255; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PDj4fWndRKPK2C3AFlrPKjKgtw4YZAPM7XpLbaxt01I=;
 b=GOAbD0ZhwniJK3hB/mReHVrDmaw31sFep5S3gmFsgNGLwprekd4WnGBBOMPtgVhRj7SjiF
 Fqq72ypKisaoX1gRBd/EcepuYYG+dYHmwNrRBqfcsKrZ3GBp1hAhFosipWr9+WTUaxrJc9
 yPcVESxrGfZTCTd0Xe6SkV8WpnmCEPqJ8g0VJiV+asIQH6c8zP5Rp+PbTJPmVT4I4ZOwnp
 yGw1XXHTLa8V3NVZh0+cvdRTjC/qzypa4WyAIi/IzeoT0NYKVm2ibaapydmbvIYQWaqaJg
 4EGNrXqwAWrDgqDrlW5h/DbKRPCB+v1w2N85p8nnY1StBzzCnjZ6j6Zzmpd+0Q==
Message-Id: <20261024114316.1604043-1-luojiahao.fs@bytedance.com>
X-Original-From: Jiahao Luo <luojiahao.fs@bytedance.com>
X-Lms-Return-Path: <lba+26adc9a0d+acf5eb+lists.sourceforge.net+luojiahao.fs@bytedance.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
To: "Jaegeuk Kim" <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>
Date: Sat, 24 Oct 2026 19:43:16 +0800
X-Mailer: git-send-email 2.20.1
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKaZW-000000003WK-1ya0
Subject: [f2fs-dev] [PATCH] f2fs: avoid false corruption report for stale
 file handles
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jiahao Luo via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jiahao Luo <luojiahao.fs@bytedance.com>
Cc: Jiahao Luo <luojiahao.fs@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

File handles do not pin inodes. Once an unlinked inode loses its last
reference, F2FS may free its nid and later allocate that nid as a
non-inode node belonging to another file.

f2fs_nfs_get_inode() currently uses f2fs_iget(), which requests an inode
node before it can compare i_generation. If a stale handle's nid now
identifies a non-inode node, footer validation reports an inconsistent
node, sets SBI_NEED_FSCK, and records a filesystem error even though the
filesystem is consistent.

Add a handle-specific iget path that reads the nid as NODE_TYPE_REGULAR.
This preserves the generic node footer checks, but allows a valid
non-inode node to be recognized and returned as -ESTALE without parsing
it as an inode. Keep the existing strict inode lookup for all internal
callers. A nid reused as another inode remains subject to the existing
generation check in f2fs_nfs_get_inode().

Fixes: e34438c903b6 ("f2fs: fix to do sanity check with node footer and iblocks")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jiahao Luo <luojiahao.fs@bytedance.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/inode.c | 27 +++++++++++++++++++++++----
 fs/f2fs/super.c |  7 +++----
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aedba8b79baa..019fb2383165 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3999,6 +3999,7 @@ void f2fs_set_inode_flags(struct inode *inode);
 bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
+struct inode *f2fs_iget_handle(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
 void f2fs_update_inode(struct inode *inode, struct f2fs_cached_block *entry);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9164a2b5d9f0..4260e8264555 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -422,7 +422,7 @@ static void init_idisk_time(struct inode *inode)
 	fi->i_disk_time[2] = inode_get_mtime(inode);
 }
 
-static int do_read_inode(struct inode *inode)
+static int do_read_inode(struct inode *inode, bool from_handle)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -434,9 +434,17 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_check_nid_range(sbi, inode->i_ino))
 		return -EINVAL;
 
-	node_entry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (from_handle)
+		node_entry = f2fs_get_node_cache(sbi, inode->i_ino,
+						 NODE_TYPE_REGULAR);
+	else
+		node_entry = f2fs_get_inode_cache(sbi, inode->i_ino);
 	if (IS_ERR(node_entry))
 		return PTR_ERR(node_entry);
+	if (from_handle && !IS_INODE(sbi, node_entry)) {
+		f2fs_put_cache(node_entry, true);
+		return -ESTALE;
+	}
 
 	ri = F2FS_INODE(node_entry);
 
@@ -574,7 +582,8 @@ static int do_read_inode(struct inode *inode)
 	return 0;
 }
 
-struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
+static struct inode *__f2fs_iget(struct super_block *sb, unsigned long ino,
+				 bool from_handle)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct inode *inode;
@@ -589,7 +598,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		return inode;
 	}
 
-	ret = do_read_inode(inode);
+	ret = do_read_inode(inode, from_handle);
 	if (ret)
 		goto bad_inode;
 
@@ -637,6 +646,16 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	return ERR_PTR(ret);
 }
 
+struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
+{
+	return __f2fs_iget(sb, ino, false);
+}
+
+struct inode *f2fs_iget_handle(struct super_block *sb, unsigned long ino)
+{
+	return __f2fs_iget(sb, ino, true);
+}
+
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 {
 	struct inode *inode;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 857cc2b29946..4d68737da65e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3902,11 +3902,10 @@ static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 		return ERR_PTR(-ESTALE);
 
 	/*
-	 * f2fs_iget isn't quite right if the inode is currently unallocated!
-	 * However f2fs_iget currently does appropriate checks to handle stale
-	 * inodes so everything is OK.
+	 * A deleted inode's nid can be reused for a non-inode node.  Treat such
+	 * reuse as a stale file handle instead of filesystem corruption.
 	 */
-	inode = f2fs_iget(sb, ino);
+	inode = f2fs_iget_handle(sb, ino);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (unlikely(generation && inode->i_generation != generation)) {

base-commit: fd106ada4dee4b8adefec791ee9b9681b7b77501
-- 
2.20.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
