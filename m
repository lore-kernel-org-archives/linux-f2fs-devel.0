Return-Path: <SRS0=qRZ7=WR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF87C3A59E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BACF22CF7;
	Wed, 21 Aug 2019 15:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DfoznYo0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="haoT9ZCF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK2EaPhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BACF22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i0SPf-0003GQ-1v; Wed, 21 Aug 2019 15:20:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1i0SPd-0003Fs-Dg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Aug 2019 15:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A20lXGlqhp7sc1d8iX8Z2rTGVZUgD/NUlh0eLBoYPMk=; b=DfoznYo0+PRfADKuX2uFgmOP83
 fvj/Vxjvx8piOPnJF3tHdXBhyJXfzAYF5EQ2kVVKS7tpwwgRDLD7A0M1/cuFSrAnRXvhTtPK8wW2U
 1AuV3lZOxVb/aVjQXYmhUugbpEdOG4xxcCglmidwnOD467NnOIUNCdt5mWFF6mieupn0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A20lXGlqhp7sc1d8iX8Z2rTGVZUgD/NUlh0eLBoYPMk=; b=h
 aoT9ZCF/J82ZZ4jtH2HqPZd4QXQALhO9pxFhG4urKXmsS1IvfF328rdy8+LJQ9xGpMjo016QthbTo
 M56l149m0eyNMRmYjHA/+Q/KW4Vhrvi1oydT2lZE6FLTvurLSVw7u98bCl0+XRW0NdgorQrBdi55S
 ghWMM/qIicKFihww=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i0SPU-00B8os-Dh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Aug 2019 15:20:33 +0000
Received: from localhost.localdomain (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B1A822CF7;
 Wed, 21 Aug 2019 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566400822;
 bh=xn5X0H02QC9UnQmvkCaxsYaQdqhUjG5IK0khgW+BxeU=;
 h=From:To:Cc:Subject:Date:From;
 b=bK2EaPhrFhBIZwJs7DpsIUw1wPrf+l0bUIFL1lcZPrGoDgJp7voKgDEaknNE0N34B
 xp1K8CP4qjDIPBGTidAtpAO1aoBc2Ox+vruFRYHpOl8nw09pOTeSR5RXNno4hrfXPW
 jOMPEqP0qiSjbk6DKW3VY8lq1HqvWifyqhm6wQ5c=
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 21 Aug 2019 23:13:34 +0800
Message-Id: <20190821151335.21312-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1i0SPU-00B8os-Dh
Subject: [f2fs-dev] [PATCH 1/2] f2fs: introduce f2fs_match_name() for cleanup
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch introduces f2fs_match_name() for cleanup.

BTW, it avoids to fallback to normal comparison once it doesn't
match casefolded name.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index dac07d17cdbd..e34c17106084 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -136,6 +136,34 @@ int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
 }
 #endif
 
+static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
+					struct f2fs_dir_entry *de,
+					struct fscrypt_name *fname,
+					unsigned long bit_pos,
+					f2fs_hash_t namehash)
+{
+	struct inode *parent = d->inode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(parent);
+#ifdef CONFIG_UNICODE
+	struct qstr entry;
+#endif
+
+	if (de->hash_code != namehash)
+		return false;
+
+#ifdef CONFIG_UNICODE
+	entry.name = d->filename[bit_pos];
+	entry.len = de->name_len;
+
+	if (sbi->s_encoding && IS_CASEFOLDED(parent))
+		return !f2fs_ci_compare(parent, fname->usr_fname, &entry);
+#endif
+	if (fscrypt_match_name(fname, d->filename[bit_pos],
+				le16_to_cpu(de->name_len)))
+		return true;
+	return false;
+}
+
 struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
 			struct f2fs_dentry_ptr *d)
@@ -143,9 +171,6 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
 	int max_len = 0;
-#ifdef CONFIG_UNICODE
-	struct qstr entry;
-#endif
 
 	if (max_slots)
 		*max_slots = 0;
@@ -157,28 +182,14 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 		}
 
 		de = &d->dentry[bit_pos];
-#ifdef CONFIG_UNICODE
-		entry.name = d->filename[bit_pos];
-		entry.len = de->name_len;
-#endif
 
 		if (unlikely(!de->name_len)) {
 			bit_pos++;
 			continue;
 		}
-		if (de->hash_code == namehash) {
-#ifdef CONFIG_UNICODE
-			if (F2FS_SB(d->inode->i_sb)->s_encoding &&
-					IS_CASEFOLDED(d->inode) &&
-					!f2fs_ci_compare(d->inode,
-						fname->usr_fname, &entry))
-				goto found;
 
-#endif
-			if (fscrypt_match_name(fname, d->filename[bit_pos],
-						le16_to_cpu(de->name_len)))
-				goto found;
-		}
+		if (f2fs_match_name(d, de, fname, bit_pos, namehash))
+			goto found;
 
 		if (max_slots && max_len > *max_slots)
 			*max_slots = max_len;
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
