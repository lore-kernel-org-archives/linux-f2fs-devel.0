Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3660A3810
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XotfQO6K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TZLsq0Bj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VsTPr8TJ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/uUqSwQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lVGkckXSF9mFJAbffjxzXUgBgIfpP8TUpC+ewJjmCx0=; b=XotfQO6KPhnl/WFjsHa13H1clE
	OkexfdZdtjfv4OjkHyIpatiFTalCrf1FJ2hzgMh8VufcwpM/bVxa7vUy/6YHutTOr46jPF3ezEQ4s
	VMwx0Fu7QNlkRbzFh+4m1fUMqeP5E5Ssj0PmTlC+z/DJCi1MmE/6QQy784vTMf30MbJY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQwD-000000003uM-3dJ0;
	Fri, 20 Nov 2026 15:54:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQwC-000000003tw-02QO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgJExFJD0MvkSRlPMmIUjXU/tY14HBrHfd9zhs/d7KI=; b=TZLsq0Bjg+epi7UwAfik8KtiKI
 7Z65tF2ls1qwyF/z0OA1z7sqrWQx/ouTQf90vgw6w4JYlINadLqVOWlxzPXpyY1jtXRV8yVm5QcKC
 k6m0znIR8ipfvzK0UWh+kL6HhKEBXsPz1kFrMQkFIotT6BtCB/xtRuRICkQdQdlLHE+E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgJExFJD0MvkSRlPMmIUjXU/tY14HBrHfd9zhs/d7KI=; b=VsTPr8TJR2waxmAzkyrettiD96
 lyfDKlwiFiWSx6X8433eJ2pIEdpthEU6MhbtPFQQxV3RBImPkXT+4ovz1HGvC6ZlHdLYaHmTCBJCa
 vqqxs7SfDPTsjurKBjqy9v2VRqXB1MmgYQTBwNfr4Fln/kyaqHYKX91/NVlGvz1IwBVM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQwA-000000003xs-1OX6
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7CC960628;
 Fri, 20 Nov 2026 15:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC21F000D4;
 Fri, 20 Nov 2026 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190039;
 bh=jgJExFJD0MvkSRlPMmIUjXU/tY14HBrHfd9zhs/d7KI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W/uUqSwQlEGBX2CWp8jRHad+I9Pl0CqzqlEEeV39pfTU4xLAJBP2uP9dJ7bGAMgYQ
 /ePlnFAyKU8b6ZbL9pRNJr49r70/a2cSmBpA4hP8e1cNG7vKD8lG3RS2dth1sRYAhv
 IPfd6UGUJKs8S2EwkY+FFtVtYBjmW968Bzr+hrL5JiqLPr5Vo5VVFIiioIX89UCmgu
 oidgWZU6oQi7hhL3J1U8awMs+njO5uToVzKOb8KS1aKjhD6ML9DsaM/+DX+gKALYqS
 Vo02m+yAzs2n2KHLHUJI1QmpbjqhqeJ8uGPXTdD66YO0/g+aWIuuUPhyAE6lpN1mbx
 B3Vfi1spvCIMw==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:25 +0100
Message-ID: <20261120155032.187246-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120155032.187246-1-aalbersh@kernel.org>
References: <20261120155032.187246-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQwA-000000003xs-1OX6
Subject: [f2fs-dev] [PATCH v3 3/7] fs,
 fsverity: add I_VERITY_BUILDING inode state flag
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
Cc: tytso@mit.edu, viro@zeniv.linux.org.uk, jaegeuk@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, Christoph Hellwig <hch@lst.de>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/verity/enable.c               | 22 +++++++++++++++++++---
 include/linux/fs.h               |  6 ++++++
 include/linux/fsverity.h         | 26 ++++++++++++++++++++++++--
 include/trace/events/writeback.h |  3 ++-
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index fe8493280b77..d820c8d348ca 100644
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
+	} else if (fsverity_is_building(inode)) {
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
index 5c62a968fbde..3bf953351e11 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -708,6 +708,11 @@ is_uncached_acl(struct posix_acl *acl)
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
@@ -742,6 +747,7 @@ enum inode_state_flags_enum {
 	I_SYNC_QUEUED		= (1U << 17),
 	I_PINNING_NETFS_WB	= (1U << 18),
 	I_METADATA_WRITEBACK	= (1U << 19),
+	I_VERITY_BUILDING	= (1U << 20),
 };
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 61fe96ccdff6..e02f79682e33 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -36,11 +36,12 @@ struct fsverity_operations {
 	 * @filp: a readonly file descriptor for the file
 	 *
 	 * The filesystem must do any needed filesystem-specific preparations
-	 * for enabling verity, e.g. evicting inline data.  It also must return
-	 * -EBUSY if verity is already being enabled on the given file.
+	 * for enabling verity, e.g. evicting inline data.
 	 *
 	 * i_rwsem is held for write.
 	 *
+	 * I_VERITY_BUILDING is set on the inode for the duration of enabling.
+	 *
 	 * Return: 0 on success, -errno on failure
 	 */
 	int (*begin_enable_verity)(struct file *filp);
@@ -164,6 +165,22 @@ static inline bool fsverity_active(const struct inode *inode)
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
+	return inode_state_read_once(inode) & I_VERITY_BUILDING;
+}
+
 struct fsverity_info *__fsverity_get_info(const struct inode *inode);
 /**
  * fsverity_get_info - get fsverity information for an inode
@@ -217,6 +234,11 @@ static inline bool fsverity_active(const struct inode *inode)
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
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076ccd16..6d0473d0f270 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -28,7 +28,8 @@
 		{I_DONTCACHE,		"I_DONTCACHE"},		\
 		{I_SYNC_QUEUED,		"I_SYNC_QUEUED"},	\
 		{I_PINNING_NETFS_WB,	"I_PINNING_NETFS_WB"},	\
-		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"}	\
+		{I_LRU_ISOLATING,	"I_LRU_ISOLATING"},	\
+		{I_VERITY_BUILDING,	"I_VERITY_BUILDING"}	\
 	)
 
 /* enums need to be exported to user space */
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
