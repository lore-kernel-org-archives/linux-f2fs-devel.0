Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74708606A872
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZKcJcsld;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YHWiMnw+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B4EKNjpw;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JV8zWonE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NHkISQK8+TDJ50cPmwK+JAf5SCXno9TY5sEVpqj22wM=; b=ZKcJcsldGMdjIv/jRM98d+9U9S
	mLLQlVWOs5JEBWYRzE5mKk6GSWd6a5r6Am5EVKQXvYHceQfQYLWbn37rn5Jn92PC+pRGbK7rrgcgp
	8z2D6a87fxbQb+9/gXvlr9V+fglrJixnq5IldjOTmmrtL0YltEF4LPGfk1w7YijrrUt8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOgwe-000000000pg-3lnc;
	Wed, 04 Nov 2026 19:46:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOgwb-000000000oy-2zzF
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nLWgWt4BnslkaMJq2Nml0U4unW/O/XancfYoUJ4qlpY=; b=YHWiMnw+f2rWyZaMYU4psfQlJp
 A9lwUtj6zQ0ONldp5Y4oVrAImO+DM7EUWfEXZZqGVIy+SvZdFxvU9gqVvMxQTjuDFlrdQo4VvQtdx
 cPSpxDIHMQziJtnAAH2gpnvVoLvFS77lcUJ2oC5I042Rg+eQeVC2XeE1Co8DLfa4Tmq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nLWgWt4BnslkaMJq2Nml0U4unW/O/XancfYoUJ4qlpY=; b=B4EKNjpwEJXxTh9uoyqCwI+BKn
 Ays+Ziy0+Jv8GLmW5HrjZf2V/j1yt3LJcRBrojegrZ3FUsBdeq0iOntceyLA6BekK8f3S3ttDN8fu
 OJP71Ukh54y+kIk6/i1Hcd6qxwD3ZpANLojMH+FMJXGNAGhnDfGaZ6J4ukUiHmd5GZpE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOgwX-000000004N6-2yMf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D7BF435AA;
 Wed,  4 Nov 2026 19:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF741F00A16;
 Wed,  4 Nov 2026 19:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821600;
 bh=nLWgWt4BnslkaMJq2Nml0U4unW/O/XancfYoUJ4qlpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JV8zWonEqR4h/SA8OGbd0OSvNnOISgTde/PJZyQvV1QYh4hIfYDy6ZUo3B/Tsa7zS
 KRnPzr0RRgpZaOo3XRH9Ca6/X1rXXlfmG42parV4Tii1FPjJF7/17Et/xBBEuGDeDe
 7TYoSGkCtI07xrLzEX4p+1MoUXAYaWShcL0vimgdoVfQ9lF+4WWgJJ3M5MlqDATX1x
 nfE2/ikrKF0aXkVED6MPX7LDtqUR7TMLZuXVw2c+EoMTlkzeJegvDNBCT0keEmtRPs
 +Me/+ExzC7K3eVvS41POcZA5uk5r9XRL3lRh3a6P/frCL8jNfLH52V05V5KeQTFrB7
 3npT5IofCfN3w==
To: ebiggers@kernel.org,
	hch@lst.de,
	fsverity@lists.linux.dev
Date: Wed,  4 Nov 2026 20:46:11 +0100
Message-ID: <20261104194618.103332-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104194618.103332-1-aalbersh@kernel.org>
References: <20261104194618.103332-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOgwX-000000004N6-2yMf
Subject: [f2fs-dev] [PATCH 2/5] fsverity: add I_VERITY_BUILDING inode state
 flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every filesystem that supports fs-verity keeps a private runtime inode
flag meaning Merkle tree is currently being built *_VERITY_IN_PROGRESS.
They all serve the same two purposes: reject a concurrent enable with
-EBUSY and let the write paths recognize the special writes done while
the tree is under construction.

Hoist this flag into the VFS as a new inode state flag,
I_VERITY_BUILDING, and manage its lifetime in the generic fs-verity
enable path. The flag is set after ->begin_enable_verity() succeeds and
cleared after ->end_enable_verity() returns (both on the success and the
rollback paths). Add the concurrent-enable guard.

A new helper, fsverity_is_building(), is provided for filesystems to
query the flag. No filesystem uses it yet; the per-fs flags are
converted in following patches.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/enable.c       | 22 +++++++++++++++++++---
 include/linux/fs.h       |  6 ++++++
 include/linux/fsverity.h | 21 +++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index fe8493280b77..65d3571c62b5 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -229,13 +229,23 @@ static int enable_verity(struct file *filp,
 
 	/*
 	 * Start enabling verity on this file, serialized by the inode lock.
-	 * Fail if verity is already enabled or is already being enabled.
+	 * Fail if verity is already enabled or is already being enabled. Set
+	 * I_VERITY_BUILDING inode runtime flag which will be cleared when
+	 * enablement succeeded or rolled back.
 	 */
 	inode_lock(inode);
-	if (IS_VERITY(inode))
+	if (IS_VERITY(inode)) {
 		err = -EEXIST;
-	else
+	} else if (inode_state_read_once(inode) & I_VERITY_BUILDING) {
+		err = -EBUSY;
+	} else {
 		err = vops->begin_enable_verity(filp);
+		if (!err) {
+			spin_lock(&inode->i_lock);
+			inode_state_set(inode, I_VERITY_BUILDING);
+			spin_unlock(&inode->i_lock);
+		}
+	}
 	inode_unlock(inode);
 	if (err)
 		goto out;
@@ -291,6 +301,9 @@ static int enable_verity(struct file *filp,
 	 */
 	inode_lock(inode);
 	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
+	spin_lock(&inode->i_lock);
+	inode_state_clear(inode, I_VERITY_BUILDING);
+	spin_unlock(&inode->i_lock);
 	inode_unlock(inode);
 	if (err) {
 		fsverity_err(inode, "%ps() failed with err %d",
@@ -317,6 +330,9 @@ static int enable_verity(struct file *filp,
 rollback:
 	inode_lock(inode);
 	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size);
+	spin_lock(&inode->i_lock);
+	inode_state_clear(inode, I_VERITY_BUILDING);
+	spin_unlock(&inode->i_lock);
 	inode_unlock(inode);
 	goto out;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..7c90ce09f797 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -707,6 +707,11 @@ is_uncached_acl(struct posix_acl *acl)
  * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
  *			i_count.
  *
+ * I_VERITY_BUILDING	fs-verity is being enabled on the inode: the Merkle
+ *			tree is under construction.  The file is effectively
+ *			read-only to userspace; the only writes happening are
+ *			for the fs-verity metadata.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  *
  * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
@@ -741,6 +746,7 @@ enum inode_state_flags_enum {
 	I_SYNC_QUEUED		= (1U << 17),
 	I_PINNING_NETFS_WB	= (1U << 18),
 	I_METADATA_WRITEBACK	= (1U << 19),
+	I_VERITY_BUILDING	= (1U << 20),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 61fe96ccdff6..c72edec57e30 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -164,6 +164,22 @@ static inline bool fsverity_active(const struct inode *inode)
 	return false;
 }
 
+/**
+ * fsverity_is_building() - is fs-verity being enabled on the inode
+ * @inode: inode to check
+ *
+ * This checks whether the inode's Merkle tree is currently being built.
+ * While this is the case the file is read-only to userspace and the only writes
+ * allowed are for the fs-verity metadata. This becomes false when fsverity
+ * metadata is fully created and written to disk or building failed.
+ *
+ * Return: true if fs-verity is being enabled on the inode
+ */
+static inline bool fsverity_is_building(const struct inode *inode)
+{
+	return inode_state_read_once((struct inode *)inode) & I_VERITY_BUILDING;
+}
+
 struct fsverity_info *__fsverity_get_info(const struct inode *inode);
 /**
  * fsverity_get_info - get fsverity information for an inode
@@ -217,6 +233,11 @@ static inline bool fsverity_active(const struct inode *inode)
 	return false;
 }
 
+static inline bool fsverity_is_building(const struct inode *inode)
+{
+	return false;
+}
+
 static inline struct fsverity_info *fsverity_get_info(const struct inode *inode)
 {
 	return NULL;
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
