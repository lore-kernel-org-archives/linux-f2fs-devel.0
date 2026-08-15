Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6775AC5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L75Knrh1so30kKD0Ti+0AbaBECoayTN5rCJVkPthj7M=; b=hrYZHhBirQBUBT39LTA6BQvx/l
	iUQz3kBwsHsnStuE1ntumiXULKVP8jkLleJefO+Us8zYUNu7Kus542Tc8KtF/uyeoRue6minwLnHA
	0jVCG38FGY5rNRBFo0BR1jKrOZMPRcFUHYv0HJNjRAaPNbms3KoNX79KjDnST1WEjWm4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wv2gM-00008B-8X;
	Sat, 15 Aug 2026 00:55:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wv2g2-00007s-2a
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 00:55:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jh9woRgo1yB+sOH6AcX4fM9oiWw/Q4nliNfwwNCN9Y0=; b=JseNwJJVe90BgETKOi7JOAIYuG
 4rwJLOAcH17hsW+sx/c+MpycSPXtv11iY/AAgJj26ue9BL0dkBoGsFjHmpoQqYQurN9gwRHfDcLgk
 c0stWPg5Rl83Q5meCAAcFqM1q7ZudTPglYVrSLWF6ermX2oNWHMUhmy+DVXq4Ich0Ex4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Jh9woRgo1yB+sOH6AcX4fM9oiWw/Q4nliNfwwNCN9Y0=; b=EzE9vJe8OvRBFaUTD/XWS4MLJ8
 3dZBhk3f4LgZzdTd1L5YkZNxt6xgVw3QGlRFwx69mJRuZmfuOYB+Hp33/Qkf0bQQeQv6+62bygyvY
 0N83m1opXEiXEXf7JAowid0AnYtmLpFjmWf0RCtPs7ic+PVs/D8leTTyeEDXgILG989E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wv2fx-0001J2-Sx for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 00:55:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E95741810
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 15 Aug 2026 00:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3949F1F000E9;
 Sat, 15 Aug 2026 00:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786755300;
 bh=Jh9woRgo1yB+sOH6AcX4fM9oiWw/Q4nliNfwwNCN9Y0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K2zdU/16D4waGZDaegS6i/jDHLndlvkN+u7Rb/kC86ix9RzR8RZfMjeQatvK8ANI5
 dl5iM53OC2quasbrMltX7q8IPt8A2pMPKBKFtSBmIMeKoCEebtlJODfvzxFqVdtJIz
 4yWLqoZzep9VvJ/j8kTwHc+vIntimF9ZbwNF/Lk4LeJ1yT/nu7mIx3o7tssC2mMwzA
 /b0XdQbQ2bdpb67+EJoelZ4gwj3XRUtfdCI7D+SiLMHF246kAzrMIIXyHXBAH9ZqVv
 pyAkvsT4jA6lrZ07ABzYXUtHxrnC3Q6kuN5eJ73wrF57SgbjdgjpsCcGVU/olvhy2X
 0/K8hQ+ZTJhfw==
To: jaegeuk@kernel.org
Date: Sat, 15 Aug 2026 08:54:40 +0800
Message-ID: <20260815005441.1444273-3-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260815005441.1444273-1-chao@kernel.org>
References: <20260815005441.1444273-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wv2fx-0001J2-Sx
Subject: [f2fs-dev] [PATCH 3/3] fsck.f2fs: sanity check quota file size in
 v2_init_io
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In v2_init_io(), quota file size is not bounded. A corrupted or crafted
quota inode with a large i_size can set dqi_blocks to a huge value
(e.g. 0xFFFFFFFC).

When scanning dquots in qtree_scan_dquots(), computing the bitmap size
as (info->dqi_blocks + 7) >> 3 causes an unsigned 32-bit integer wrap to 0,
allocating a 0-byte buffer via malloc(0). Later, report_block() performs
out-of-bounds bit-setting writes past the heap buffer.

This patch fixes the issue by:
1. Porting the e2fsprogs check (CVE-2019-5094) into v2_init_io() to cap
   quota file size at 2GB (1ULL << 31).
2. Casting info->dqi_blocks to size_t when calculating bitmap allocation
   size in qtree_scan_dquots() as defense-in-depth.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/quotaio_tree.c | 2 +-
 fsck/quotaio_v2.c   | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
index 40521c5..60cec7d 100644
--- a/fsck/quotaio_tree.c
+++ b/fsck/quotaio_tree.c
@@ -667,7 +667,7 @@ int qtree_scan_dquots(struct quota_handle *h,
 		return -1;
 
 	dquot->dq_h = h;
-	if (quota_get_memzero((info->dqi_blocks + 7) >> 3, &bitmap))
+	if (quota_get_memzero(((size_t)info->dqi_blocks + 7) >> 3, &bitmap))
 		goto out;
 	if (report_tree(dquot, QT_TREEOFF, 0, bitmap, &entries, process_dquot,
 				data))
diff --git a/fsck/quotaio_v2.c b/fsck/quotaio_v2.c
index e19f303..50daf26 100644
--- a/fsck/quotaio_v2.c
+++ b/fsck/quotaio_v2.c
@@ -206,6 +206,12 @@ static int v2_init_io(struct quota_handle *h, enum quota_type qtype)
 		f2fs_filesize_update(qf->sbi, qf->ino, filesize);
 	}
 
+	if (filesize > (1ULL << 31)) {
+		log_err("Quota inode %u corrupted: file size %" PRIu64
+			" too large", h->qh_qf.ino, filesize);
+		return -1;
+	}
+
 	if ((info->dqi_qtree.dqi_blocks >
 			(filesize + QT_BLKSIZE - 1) >> QT_BLKSIZE_BITS)) {
 		log_err("Quota inode %u corrupted: file size %" PRId64 "; "
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
