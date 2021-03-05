Return-Path: <SRS0=WIjR=ID=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6DDC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Mar 2021 05:43:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2426064F59;
	Fri,  5 Mar 2021 05:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2426064F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lI3FU-0005jr-U9; Fri, 05 Mar 2021 05:43:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lI3FS-0005ji-Kp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Mar 2021 05:43:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/MPjwn6IJ4Ocg3FM0rOIbsnQ0XKH4tLkO1TEzlkfTe4=; b=M0Vb/kDcde7vSK16K2X5WTZ9Kq
 V0fnMmGr42CMKGpvKPjUU4guvbhL1A5r+SGv/B4HXZKYiW5xqi4u9BP/g+LAmhyeP+J5TfamnyYln
 BicX5e+b7T7vtMWrtOe5XSUco1sl4RpjxNs3350mDEBRMze0+QtWXh12GRK/Xh7umAyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/MPjwn6IJ4Ocg3FM0rOIbsnQ0XKH4tLkO1TEzlkfTe4=; b=O
 WZvbaO/Cz5M26qhnj+0lrVFfGv2cQdF4iOfxMsDp4fdnkdX3FAEh3+3PMhPTrH5tdJhBNKdqNIFbI
 iUehoN0b5xMgC8tuh9fQ9fwArPBF7BVkLp5b+KfG0XCjOLZw1REOo5XHdmbP3VuGe+G2ym/dZGKkm
 o29Nt+ISbVQQS9iU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lI3FM-0007cS-SB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Mar 2021 05:43:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38BB865012;
 Fri,  5 Mar 2021 05:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614923007;
 bh=ESJG1Cpx46c5z4lZ4aLOjRYcODS94EpqUJphDHS/oWA=;
 h=From:To:Cc:Subject:Date:From;
 b=eY3I9r4zKVq7wGRyxFVjQJNsg4nFHMNpZtYjXoTV8ahtoOfthXGGemAtgEyV3hfrz
 RelYCaWoQCpxIyOTqJC+FBRMna5u0r8sjCXUjhYebD4RkfEhwd/Gy5bJeQ2PX4Bi81
 Oj3KsJV7emfoh0mZVevatXDMTGTiWN4U9P4fPdm3ckmprMrH9Zw4qDkPnb1KGqC8y5
 CoOXsdDTHNnLYYf//Ft6tu+wbAUgJctHaYltBSUFTUxqFAsJuKBImE1gymQbSfYSg6
 qNrIjWyz5a8x8dzYlkzHVhyYmH9skxhS8e3sEOIXBj7f5rVdixSwH3Xm5PS1triLQv
 7fk63epMqDAnw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  4 Mar 2021 21:43:10 -0800
Message-Id: <20210305054310.111011-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-Headers-End: 1lI3FM-0007cS-SB
Subject: [f2fs-dev] [PATCH v2] f2fs: fix error handling in
 f2fs_end_enable_verity()
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
Cc: linux-fscrypt@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

f2fs didn't properly clean up if verity failed to be enabled on a file:

- It left verity metadata (pages past EOF) in the page cache, which
  would be exposed to userspace if the file was later extended.

- It didn't truncate the verity metadata at all (either from cache or
  from disk) if an error occurred while setting the verity bit.

Fix these bugs by adding a call to truncate_inode_pages() and ensuring
that we truncate the verity metadata (both from cache and from disk) in
all error paths.  Also rework the code to cleanly separate the success
path from the error paths, which makes it much easier to understand.

Finally, log a message if f2fs_truncate() fails, since it might
otherwise fail silently.

Reported-by: Yunlei He <heyunlei@hihonor.com>
Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2: take i_gc_rwsem, and log a message if f2fs_truncate() fails.

 fs/f2fs/verity.c | 75 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 054ec852b5ea4..15ba36926fad7 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -152,40 +152,73 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
 				  size_t desc_size, u64 merkle_tree_size)
 {
 	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	u64 desc_pos = f2fs_verity_metadata_pos(inode) + merkle_tree_size;
 	struct fsverity_descriptor_location dloc = {
 		.version = cpu_to_le32(F2FS_VERIFY_VER),
 		.size = cpu_to_le32(desc_size),
 		.pos = cpu_to_le64(desc_pos),
 	};
-	int err = 0;
+	int err = 0, err2 = 0;
 
-	if (desc != NULL) {
-		/* Succeeded; write the verity descriptor. */
-		err = pagecache_write(inode, desc, desc_size, desc_pos);
+	/*
+	 * If an error already occurred (which fs/verity/ signals by passing
+	 * desc == NULL), then only clean-up is needed.
+	 */
+	if (desc == NULL)
+		goto cleanup;
 
-		/* Write all pages before clearing FI_VERITY_IN_PROGRESS. */
-		if (!err)
-			err = filemap_write_and_wait(inode->i_mapping);
-	}
+	/* Append the verity descriptor. */
+	err = pagecache_write(inode, desc, desc_size, desc_pos);
+	if (err)
+		goto cleanup;
+
+	/*
+	 * Write all pages (both data and verity metadata).  Note that this must
+	 * happen before clearing FI_VERITY_IN_PROGRESS; otherwise pages beyond
+	 * i_size won't be written properly.  For crash consistency, this also
+	 * must happen before the verity inode flag gets persisted.
+	 */
+	err = filemap_write_and_wait(inode->i_mapping);
+	if (err)
+		goto cleanup;
+
+	/* Set the verity xattr. */
+	err = f2fs_setxattr(inode, F2FS_XATTR_INDEX_VERITY,
+			    F2FS_XATTR_NAME_VERITY, &dloc, sizeof(dloc),
+			    NULL, XATTR_CREATE);
+	if (err)
+		goto cleanup;
 
-	/* If we failed, truncate anything we wrote past i_size. */
-	if (desc == NULL || err)
-		f2fs_truncate(inode);
+	/* Finally, set the verity inode flag. */
+	file_set_verity(inode);
+	f2fs_set_inode_flags(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 
 	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
+	return 0;
 
-	if (desc != NULL && !err) {
-		err = f2fs_setxattr(inode, F2FS_XATTR_INDEX_VERITY,
-				    F2FS_XATTR_NAME_VERITY, &dloc, sizeof(dloc),
-				    NULL, XATTR_CREATE);
-		if (!err) {
-			file_set_verity(inode);
-			f2fs_set_inode_flags(inode);
-			f2fs_mark_inode_dirty_sync(inode, true);
-		}
+cleanup:
+	/*
+	 * Verity failed to be enabled, so clean up by truncating any verity
+	 * metadata that was written beyond i_size (both from cache and from
+	 * disk) and clearing FI_VERITY_IN_PROGRESS.
+	 *
+	 * Taking i_gc_rwsem[WRITE] is needed to stop f2fs garbage collection
+	 * from re-instantiating cached pages we are truncating (since unlike
+	 * normal file accesses, garbage collection isn't limited by i_size).
+	 */
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	truncate_inode_pages(inode->i_mapping, inode->i_size);
+	err2 = f2fs_truncate(inode);
+	if (err2) {
+		f2fs_err(sbi, "Truncating verity metadata failed (errno=%d)",
+			 err2);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
-	return err;
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
+	return err ?: err2;
 }
 
 static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
-- 
2.30.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
