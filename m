Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B760A2618
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TB9IkGpr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=brj5W0EP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aHs0PtWX;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvCCwFMh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WieJW6KA7EMW4ZKlEZfRZv5fkLV34xUoN8W/gyjrxEk=; b=TB9IkGprwypcGaIGMRCmTxuC2c
	LdoiRAT0+16+dAEdVv/3g6yFdObQOX7kEx3/dqjMnSLN5K+DCe1P3Z/b/lDO0Zuf/quyVsbg0Md0t
	N/WPQ1lUJQL774Qh+eN9L9TUxEfVO1p9W5AX9aonST24kxJyt0ztcpjYaVCcpNS4LIRM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQwM-000000003wH-3r4Z;
	Fri, 20 Nov 2026 15:54:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQwJ-000000003vf-34yw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lizTcuSYWUIopycLWQe3gYcaIwLecJSICxRsK0lO5ko=; b=brj5W0EPPh7H9wvsINdPT5S9z3
 ebiGpgvKjjiYO9kQPy3dFmbFGP+bglbRzqFEdjSbfR1gTFWfj3XFZ3UWyKptt1smJz/M9vN/x94Cy
 oNwqk0mb98jYqxOWivH+0r894bvTE5jOLYCMRzB+QncLUlnZ6SFEs8EJL6/0bO4x5CQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lizTcuSYWUIopycLWQe3gYcaIwLecJSICxRsK0lO5ko=; b=aHs0PtWX0xWJkg/eWPI/uUAEVj
 orNLXRSNdHI/DYq5OJcwIR2vFhMgwdkRRMwFxFh5HGfC5XXEPTM0YNst0nsSG0fZYyyD3OBB8txvR
 Q5bKNFLb6mOP4IAFBdGJUj9+a3dUf57jQh2V4+LOEYrWIgxAT8BQy1ZKzXewbXr1jSN0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQwH-00000000249-3mIR
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5670B60628;
 Fri, 20 Nov 2026 15:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FFE1F000D8;
 Fri, 20 Nov 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190048;
 bh=lizTcuSYWUIopycLWQe3gYcaIwLecJSICxRsK0lO5ko=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bvCCwFMhsQWRjiP1hJiUE6LV1/P46aaO5AIF6IxzeOCc14fu1mtW5JAEQfk+drYil
 QewEclk2ajj2tnmJHjZUEkX7/xVYvP6ociRqTa+/h1GGAT+3rJ7L7g3ynC7OHvuZtF
 7Ve7l+bbX6Ja3+vPyWvi4WyZdD5om5GroDOcfJREj9aakQ6nd0/JBF0dz3i+3+aSGA
 8lAfF6XmGh2YXyodTtVOm7L19ruC4vMliEc8iNZfRJoTnZwFUZBmUk5si4BG5aEh1J
 yG98zpJySaVfsH1tVnrx4ylKCHlipL8tT7f469CJ8v2wozFV2X7X43KvYFte6HjjTu
 LQMdICwS1XB4Q==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:27 +0100
Message-ID: <20261120155032.187246-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120155032.187246-1-aalbersh@kernel.org>
References: <20261120155032.187246-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQwH-00000000249-3mIR
Subject: [f2fs-dev] [PATCH v3 5/7] btrfs: use I_VERITY_BUILDING instead of
 private flags
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

Now that the VFS tracks an inode whose Merkle tree is under construction
via I_VERITY_BUILDING and handles the concurrent-enable guard in the
generic fs-verity enable path, drop the inode runtime flags that
duplicated this.

btrfs only used BTRFS_INODE_VERITY_IN_PROGRESS internally, so remove it
outright.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |  7 -------
 fs/btrfs/verity.c      | 12 ++----------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 0782f917fccc..5c752b947b56 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -78,13 +78,6 @@ enum {
 	 * the file range, inode's io_tree).
 	 */
 	BTRFS_INODE_NO_DELALLOC_FLUSH,
-	/*
-	 * Set when we are working on enabling verity for a file. Computing and
-	 * writing the whole Merkle tree can take a while so we want to prevent
-	 * races where two separate tasks attempt to simultaneously start verity
-	 * on the same file.
-	 */
-	BTRFS_INODE_VERITY_IN_PROGRESS,
 	/* Set when this inode is a free space inode. */
 	BTRFS_INODE_FREE_SPACE_INODE,
 	/* Set when there are no capabilities in XATTs for the inode. */
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 79ace98714ad..c7eec8886e49 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -461,7 +461,6 @@ static int rollback_verity(struct btrfs_inode *inode)
 
 	btrfs_assert_inode_locked(inode);
 	truncate_inode_pages(inode->vfs_inode.i_mapping, inode->vfs_inode.i_size);
-	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
 	ret = btrfs_drop_verity_items(inode);
 	if (ret) {
 		btrfs_handle_fs_error(root->fs_info, ret,
@@ -513,7 +512,6 @@ static int rollback_verity(struct btrfs_inode *inode)
  * - mark the inode with the verity flag
  * - delete the orphan item
  * - mark the ro compat bit
- * - clear the in progress bit
  *
  * Returns 0 on success, negative error code on failure.
  */
@@ -555,7 +553,6 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
 		goto end_trans;
 	/* Now that rollback is no longer possible, set S_VERITY. */
 	btrfs_sync_inode_flags_to_i_flags(inode);
-	clear_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
 	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
 end_trans:
 	if (ret)
@@ -570,8 +567,8 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
  *
  * @filp:  file to enable verity on
  *
- * Begin enabling fsverity for the file. We drop any existing verity items, add
- * an orphan and set the in progress bit.
+ * Begin enabling fsverity for the file. We drop any existing verity items and
+ * add an orphan.
  *
  * Returns 0 on success, negative error code on failure.
  */
@@ -587,9 +584,6 @@ static int btrfs_begin_enable_verity(struct file *filp)
 	if (IS_ENCRYPTED(&inode->vfs_inode))
 		return -EOPNOTSUPP;
 
-	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
-		return -EBUSY;
-
 	/*
 	 * This should almost never do anything, but theoretically, it's
 	 * possible that we failed to enable verity on a file, then were
@@ -606,8 +600,6 @@ static int btrfs_begin_enable_verity(struct file *filp)
 		return PTR_ERR(trans);
 
 	ret = btrfs_orphan_add(trans, inode);
-	if (!ret)
-		set_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags);
 	btrfs_end_transaction(trans);
 
 	return ret;
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
