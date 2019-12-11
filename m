Return-Path: <SRS0=No8/=2B=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A33C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:12:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9DB24654;
	Wed, 11 Dec 2019 15:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iRb7auvz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="jhljGoun";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpN/04BO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9DB24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1if3eu-0004fV-QV; Wed, 11 Dec 2019 15:12:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1if3et-0004fN-3u
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Dec 2019 15:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zHQAAtSdOMCzVlgYj1YpUYKH+jwsR3MELPGcNh9sgA0=; b=iRb7auvz4npVcKMVJK3DiyJ3PQ
 e2GU+pMQnUHbFOYa5jP26yTr2ppky/HeZPq2fU1xdxa4saMlGYY9EbCVGk7Itlbj55XjvVgrjQekI
 eb5MXshrEo1wA0iBX9tXOpiAcvUbelD3uDV1py4dnIpJ+m4v8vmhWRHI5n07720Y7InY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zHQAAtSdOMCzVlgYj1YpUYKH+jwsR3MELPGcNh9sgA0=; b=jhljGoun805exQysAMF9Z6FTV7
 On7A6Lw08W7CXtWpJb6+6kW1Q1T04JhygTDveJLBZF1zjsi1Ehbt3XncwrWUPtsDvA9b+c+5G2mNv
 a61ucGl5Ml4fRTBRv/GljlGm3D3DWRH8mhRboIMDewupqyBYdpovYb/fQqROQOiq0d4k=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1if3eq-001Cq2-HD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Dec 2019 15:12:11 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8CAA24654;
 Wed, 11 Dec 2019 15:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576077120;
 bh=JFe0CvYvNH9NhMvkbtbi+KVjCwqrazzQlnR7wVfT8Ec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mpN/04BOBrL0mifeHJQbwbkXa4mls4a+cR9pPsoCtD2TrJkYCzX+HgENMhbXVaBRu
 gWhIMIelgRZNBKtBhW4dMvhSmOh8ISElYmTdmyeH4An0WebyQrABdxfK66mJ0/3g74
 ORwl6554vSFHiOVgYN9p83kFUau86u/DOpxmDnkU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed, 11 Dec 2019 10:09:45 -0500
Message-Id: <20191211151150.19073-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1if3eq-001Cq2-HD
Subject: [f2fs-dev] [PATCH AUTOSEL 5.4 009/134] f2fs: fix to update time in
 lazytime mode
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit fe1897eaa6646f5a64a4cee0e6473ed9887d324b ]

generic/018 reports an inconsistent status of atime, the
testcase is as below:
- open file with O_SYNC
- write file to construct fraged space
- calc md5 of file
- record {a,c,m}time
- defrag file --- do nothing
- umount & mount
- check {a,c,m}time

The root cause is, as f2fs enables lazytime by default, atime
update will dirty vfs inode, rather than dirtying f2fs inode (by set
with FI_DIRTY_INODE), so later f2fs_write_inode() called from VFS will
fail to update inode page due to our skip:

f2fs_write_inode()
	if (is_inode_flag_set(inode, FI_DIRTY_INODE))
		return 0;

So eventually, after evict(), we lose last atime for ever.

To fix this issue, we need to check whether {a,c,m,cr}time is
consistent in between inode cache and inode page, and only skip
f2fs_update_inode() if f2fs inode is not dirty and time is
consistent as well.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  | 23 +++++++++++++++--------
 fs/f2fs/inode.c |  6 +++++-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4024790028aab..f078cd20dab88 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2704,6 +2704,20 @@ static inline void clear_file(struct inode *inode, int type)
 	f2fs_mark_inode_dirty_sync(inode, true);
 }
 
+static inline bool f2fs_is_time_consistent(struct inode *inode)
+{
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
+		return false;
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
+		return false;
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
+		return false;
+	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
+						&F2FS_I(inode)->i_crtime))
+		return false;
+	return true;
+}
+
 static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 {
 	bool ret;
@@ -2721,14 +2735,7 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 			i_size_read(inode) & ~PAGE_MASK)
 		return false;
 
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
-		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
-		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
-		return false;
-	if (!timespec64_equal(F2FS_I(inode)->i_disk_time + 3,
-						&F2FS_I(inode)->i_crtime))
+	if (!f2fs_is_time_consistent(inode))
 		return false;
 
 	down_read(&F2FS_I(inode)->i_sem);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index db4fec30c30df..386ad54c13c3a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -615,7 +615,11 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return 0;
 
-	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
+	/*
+	 * atime could be updated without dirtying f2fs inode in lazytime mode
+	 */
+	if (f2fs_is_time_consistent(inode) &&
+		!is_inode_flag_set(inode, FI_DIRTY_INODE))
 		return 0;
 
 	if (!f2fs_is_checkpoint_ready(sbi))
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
