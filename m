Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284FD606A334
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TuPDNN0V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qik5c+0d;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OYS9W3hO;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j7mdH2Hw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NHkISQK8+TDJ50cPmwK+JAf5SCXno9TY5sEVpqj22wM=; b=TuPDNN0V2VqYzV07l5hFEaxP98
	SGeynb69RIdA2PH5kuEogEyeMTCfs3nOnxq7dM67I7mKHV8Nksih6uL/HsBIzgqZhGI3+b4708mxK
	1Xsv0BOna5RFegd19W7ggAsMIvDim/ptrRS+yV1AM8Hz3q7HyO4B83hPDuvY8JNuCQEM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOw5j-000000006TJ-3YlS;
	Thu, 05 Nov 2026 11:57:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOw5P-000000006Ss-2I7E
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:56:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nLWgWt4BnslkaMJq2Nml0U4unW/O/XancfYoUJ4qlpY=; b=Qik5c+0dXgNdH9VhhvwzDAXxYE
 gDnvfOmLKJtHe59AsNNRoPS7b5QYyG2xnjsa0fqa3KrV1yVul4qHqf309W2B2+rArHSDw6/OFIL/Z
 DtYgwgua5DAYK2rByraBapknCgsjqFvmlqF14aE1cN1G1fWSVam5kkcQTwRKkAj7gx1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nLWgWt4BnslkaMJq2Nml0U4unW/O/XancfYoUJ4qlpY=; b=OYS9W3hO6oJ+WqBorpoDUAilD1
 XCljmcGlq+fDmetzwDpCFryfNCk7naBq7YKVNHQXSH4Y/aQus3t2uTuxVP4T8M1Q5iwR9kX0NVgtl
 tSCiUxuQdK9XopmCz8wRLta7EfTg0NiXr5S5oHiCCM/T+na5sS2gSeNS+xD6hQ1EZkEo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOw5O-000000002Do-3u7L
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:56:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50A7F605F4;
 Thu,  5 Nov 2026 11:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81EF1F00A17;
 Thu,  5 Nov 2026 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793879809;
 bh=nLWgWt4BnslkaMJq2Nml0U4unW/O/XancfYoUJ4qlpY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j7mdH2HwkOWECtcq+fuA5uoIYOF4T04KVSxvtXk6Sbqc1V8qzVSDWMd+BXpJ/tGPC
 h1Dab8z+24a8iLJeiijSWRzyDMnD39afB9QzMxB1xt2VndJtB/dW7ialpENcmDUYXI
 NQULeSdbg0dRdw2c1i8QgxnJ0wWREYiywTytiABFPTIXBqnwW2fNCHg0GRGDWNv7ai
 liTnSxEbfj4Za1enqG0/SSQnnv8Dyy3Nr1/BJ46Ax7afK7ltl/ts/2HfT5ztrB8v7R
 mnbWoF5MmRPETcrFqXV/K0rpUKAhpB9lRpWnoQqsQsEO6jVxEA6c5FQpHTe2liMtPb
 nHSZrAEJXf2MA==
To: ebiggers@kernel.org, hch@lst.de, fsverity@lists.linux.dev, dsterba@suse.com
Date: Thu,  5 Nov 2026 12:55:27 +0100
Message-ID: <20261105115532.613467-3-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105115532.613467-1-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOw5O-000000002Do-3u7L
Subject: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
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
Cc: tytso@mit.edu, brauner@kernel.org, Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
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
