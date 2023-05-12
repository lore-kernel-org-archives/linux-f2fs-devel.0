Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1696C77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 May 2023 10:04:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pxPdS-0001bx-OJ;
	Fri, 12 May 2023 10:04:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pxPdQ-0001be-8S
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 May 2023 10:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9OGaAI6KWCZIi5QuBXlNlysRj9smTmNlfNfeT4/RIX4=; b=mxIlKpREfYvOZDDAGhStDBG7VL
 CByShBomEZfpP4WsBx0H7UeL13KBlkga04TQ6ifEnBGsy46jiZyDky9MnaPefAEdy5hp4/62KzvVa
 3O9aq0wy30HCuEXYLGnbjauX9+NAEUukmrpY4RhExHEiEF3ORzaGime4yWGnetbCUS3s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9OGaAI6KWCZIi5QuBXlNlysRj9smTmNlfNfeT4/RIX4=; b=N
 lfOJg3Ehibtk3dXfhGa49MAX/Uiy93OE4NdnO9DS++izDDk3W/9BwOEC0ar7s9ro+0BzQIrZ5VPqF
 1vYrCrFFa6AkZ0RS9mtg4AmAOFxIeGDjLcwo7Nv3flkVuD8ojLn3DZNeRVTlOx+PxmA67qS5ucmPK
 UaYeD9w+t/7ytk6s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pxPdQ-004LeM-Hs for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 May 2023 10:04:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 277D36549A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 May 2023 10:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB10C433D2;
 Fri, 12 May 2023 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683885858;
 bh=vjqBAsfPouhQxFola4pEXzWAL5pk+TSfG0Ed+7gdtN4=;
 h=From:To:Cc:Subject:Date:From;
 b=n5uah4O+yZoznAXwp548veXBMfsY0p+YmJtHcMvkH9K7p6hRlfsSB+YtTbuhUX5Zm
 JvAHRHO9VxcPsqEV0KpI+hFjNx1p3d1tDpCFR6CFoQmxsB12y+s7VOmDavSDfyMOsC
 Yb/ktSjJSz0J5lCkO+6ih1jkdW5ligrN9eohUFOfoYnbfrmPL5vA4l8rPuZXsMchQU
 0siBDUrrPlqRyIJQH3dS1Gt0nvoZNRZPilzV5+M2FwVvpRL7KnqCJB2974fQmbKlbv
 DhAHbPxSbyI4UDOohokEJ4A3H3G8ty3FHCldaNvuBWqgi6oMFxgJxNlGaVs3XLZ+Ni
 pBlICNAX0gYrA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 12 May 2023 18:03:51 +0800
Message-Id: <20230512100354.4072489-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1pxPdQ-004LeM-Hs
Subject: [f2fs-dev] [PATCH 1/4] fsck.f2fs: wrap openned codes into
 fsck_sanity_check_nid()
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

read_all_xattrs() is the only user of fsck_sanity_check_nid(), wrap
openned codes of read_all_xattrs() into fsck_sanity_check_nid().

Then fsck_sanity_check_nid() can be reused later.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/fsck.c  | 16 ++++++++++++----
 fsck/fsck.h  |  3 +--
 fsck/xattr.c | 12 +-----------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 324c3d5..64db1e5 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -515,11 +515,19 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 }
 
 int fsck_sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
-			struct f2fs_node *node_blk,
-			enum FILE_TYPE ftype, enum NODE_TYPE ntype,
-			struct node_info *ni)
+			enum FILE_TYPE ftype, enum NODE_TYPE ntype)
 {
-	return sanity_check_nid(sbi, nid, node_blk, ftype, ntype, ni);
+	struct f2fs_node *node_blk = NULL;
+	struct node_info ni;
+	int ret;
+
+	node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk != NULL);
+
+	ret = sanity_check_nid(sbi, nid, node_blk, ftype, ntype, &ni);
+
+	free(node_blk);
+	return ret;
 }
 
 static int fsck_chk_xattr_blk(struct f2fs_sb_info *sbi, u32 ino,
diff --git a/fsck/fsck.h b/fsck/fsck.h
index dabd8b9..02dcff8 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -166,8 +166,7 @@ extern int fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_quota_node(struct f2fs_sb_info *);
 extern int fsck_chk_quota_files(struct f2fs_sb_info *);
 extern int fsck_sanity_check_nid(struct f2fs_sb_info *, u32,
-			struct f2fs_node *, enum FILE_TYPE, enum NODE_TYPE,
-			struct node_info *);
+					enum FILE_TYPE, enum NODE_TYPE);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
 		enum FILE_TYPE, enum NODE_TYPE, u32 *,
 		struct f2fs_compr_blk_cnt *, struct child_info *);
diff --git a/fsck/xattr.c b/fsck/xattr.c
index 8e66873..04c2879 100644
--- a/fsck/xattr.c
+++ b/fsck/xattr.c
@@ -25,17 +25,7 @@ void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
 	nid_t xnid = le32_to_cpu(inode->i.i_xattr_nid);
 
 	if (c.func == FSCK && xnid) {
-		struct f2fs_node *node_blk = NULL;
-		struct node_info ni;
-		int ret;
-
-		node_blk = (struct f2fs_node *)calloc(BLOCK_SZ, 1);
-		ASSERT(node_blk != NULL);
-
-		ret = fsck_sanity_check_nid(sbi, xnid, node_blk,
-					F2FS_FT_XATTR, TYPE_XATTR, &ni);
-		free(node_blk);
-		if (ret)
+		if (fsck_sanity_check_nid(sbi, xnid, F2FS_FT_XATTR, TYPE_XATTR))
 			return NULL;
 	}
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
