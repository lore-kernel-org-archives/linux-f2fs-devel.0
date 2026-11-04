Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F760CBCC2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jVsmR72V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jOCm5/4p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AHqD+Bqx;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGHBzpuU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/60/bRsp0/ccR9GqoJ+GHDUWgKFTKP7hmEF/kJ9qruo=; b=jVsmR72VTKn8QM3vIopEWVtIUW
	2KXWrDg+xncTSxehyhl86BFonuPbzBu3rNdW1UGi4CCdEgEUov4oTvVuZkP2A5ebzwHpptH3emfhA
	BZpJhVhcsj2w3DtHW9UAAlCn2dT/b8CCj1kha51Nba2qKT15UCzi5GmSP0Ez/Rwkqvjc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOgwd-0000000036x-0jX3;
	Wed, 04 Nov 2026 19:46:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOgwb-0000000036g-2yNW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oUcPL85ei5U4d0RhTPCHJJ3QC2Sk5WoYZJdWFp/OwSg=; b=jOCm5/4ppXowUMNtqAWLExMyOn
 XG+/PnDjgVGC7PzEB4u4i0BJm3/H7lOePRkvkG3gcaZCd53SEn/cL/MTN79FYqBq0MQ5qjNDrQpOp
 a4K/Z/czNWpttIS4Cc4ip3LQv4M7LSdjPgH7Jc42bkJnMbR4rbHDTUGR/KNgevu90nyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oUcPL85ei5U4d0RhTPCHJJ3QC2Sk5WoYZJdWFp/OwSg=; b=AHqD+BqxJww/ZZLxaOnrHm8pMg
 ECZSmeV3mj0FiFG5CTA0948WkjNUeLJTRSfXnf+CI4XLniKRkb0k1SqytA0ES0oK0exKk6plJU/KQ
 64tD5eZ+wqlomvRFcc9eeEWCmJq0sh5Mob4D53X9sX0TJ39gFNCM3V/NSF5w1XsoE/lQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOgwa-000000006sk-2LEc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 046A860DB9;
 Wed,  4 Nov 2026 19:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFCE1F000C1;
 Wed,  4 Nov 2026 19:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821602;
 bh=oUcPL85ei5U4d0RhTPCHJJ3QC2Sk5WoYZJdWFp/OwSg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SGHBzpuU8UnmqexhEbiWAA20uJBNcu6XuwqLQ7V1psxJSeBN44dOujaKqLosA+wgl
 Ep6ep3fPvcC/sqScixQrr34pDRLsKuAR4Tg1iGrT/n5LrNp7j74+W9JfmXxnR46pbr
 0y/5K0URlBPSM6hufEUI61/VbCOMwyBRwraZpkQ2tRNH46tq27rG6UttS7EpWgFeOW
 XwCCqIpCGmMqu6yO0juELENSbdZDl2SojM/x7dzGlh/6/hSgJS86FvXJFbRkzXdUsq
 1gbdTMSZPmiEKm0MXwsZAj9L6z0dtKv91aOHJ+RPCBij9NituK5em8kZT3Vw+oTnRZ
 QqEHjk5GlvSVw==
To: ebiggers@kernel.org,
	hch@lst.de,
	fsverity@lists.linux.dev
Date: Wed,  4 Nov 2026 20:46:12 +0100
Message-ID: <20261104194618.103332-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104194618.103332-1-aalbersh@kernel.org>
References: <20261104194618.103332-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOgwa-000000006sk-2LEc
Subject: [f2fs-dev] [PATCH 3/5] btrfs: use I_VERITY_BUILDING instead of
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

Now that the VFS tracks an inode whose Merkle tree is under construction
via I_VERITY_BUILDING and handles the concurrent-enable guard in the
generic fs-verity enable path, drop the inode runtime flags that
duplicated this.

btrfs only used BTRFS_INODE_VERITY_IN_PROGRESS internally, so remove it
outright.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
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
index b34d2247cf84..82e2ebad0d3e 100644
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
 
 	return 0;
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
