Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF9606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YL5ELh0k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=biBzOhiq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QI/WG+5J;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WvXAZODp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=GoWIBXpZJJDeNA/kkuA8rEtck/vUPz1cAtRvLuCgMSo=; b=YL5ELh0krmphgSlbr8+gX4ISY8
	6V4v2Z5SFe4bzCcDd9auHlLykewzR6+cc42BWC3iTuJflWJOe6SKrnnp05EKw0tM8jXeWqID3Al91
	SHTMdDJHlyJemBr5wbSWpVrNRV5b7XggQwWTKOlfs74SxapsPQg/3CFbTp4YM7gcx7PU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu4-000000003Va-2I5g;
	Mon, 02 Nov 2026 19:41:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtY-000000003RK-2KfP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/EfsdsBU5GGCMcSg3xK/a0oN6TfPFwO3ihDHCjXuTkY=; b=biBzOhiqG8pTreJoNP/npFwEFS
 npBoqo4LUaNeOzjd7l/teSRPy4fYEkw+vqQtRs60xJUSMOiv8LjsS6PLFmRtMEqd2VkhRw0cq4kKi
 7SBdc1y8a93JaytCE34ZGnY3zdrJiC2KWHmdIpa3t0G4zQQxjW+g/iUfC8j51NzERjqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/EfsdsBU5GGCMcSg3xK/a0oN6TfPFwO3ihDHCjXuTkY=; b=QI/WG+5JiEZdqtPA0AnirDaoZh
 2dF+MSZBDOuCQ4UPKUrjVWEyZJlMgEmJzSbcDoOuhxsF5dli4VobE6WqAkkCvCnzsTECjRWkDRaDC
 hvvPcWHTJ2TnrMSgCyh/3FlxixzGElqGLELmPUBymDgqa+A6Jbu0wI62Z53BjCDClF7w=;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtX-000000002Dt-0kA8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:40 +0000
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc7d154ec4fso1486569a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648433; x=1794253233; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/EfsdsBU5GGCMcSg3xK/a0oN6TfPFwO3ihDHCjXuTkY=;
 b=WvXAZODpCfBSJdRd038QcsE5Yvh5ngRxVDKlC5jyGF3Il2QO2xE5yXOhEf84PKTGD3
 f3NBpO1qOlV7iwyBgbEuSYncCrIby5Lct7oOK2Uv/QI8zBo4tpexu8YJNDIV/U4A9geI
 njJnFVpETpRcYmLd00s/TNMvNuFUuaXUH9VFsFzYQA521y0bmRpUyzEhEJfvBQYw0fkP
 cTr7Iq/GlV/Tp2TxisjoidbPxsOG6ZbAbJFSYvAiW7i93KKlDK0ztPN4h3WQknweWOXe
 mDdPQMrKo1yxG1Bva0QQgHBOtGnZSA9Zpk10Uio1Ja8JvRUdifHhHEhOlqjIgGrm1q69
 j3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648433; x=1794253233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/EfsdsBU5GGCMcSg3xK/a0oN6TfPFwO3ihDHCjXuTkY=;
 b=m7ad48JdpjMYF6SRsW/+eMChW47ptI5pZ9kuQSMSbrJh+YWyeJbwnV1Wa+UbuyJpJ5
 NAIec0aKqOtL1qw7KCuOKYMSjwgu6ID4MYjEqtDX6/DcjjXhaEIT/PFWxagaJOQb1Uri
 F85IKh8JdB2MBHAPFwLTBSBCaW2u2NGEr6hEiWFpxvBPuZYETNX5z3plm0Nkgv/v6W12
 JaDPXshci4anz7tQYn15ZCkZuZ20xr3X6RK5SrjrfGy4ndajhYsVrShzzPv4x3oyADqG
 0oNPdus77jXi6HHC9HfYV7Rcg6xevpSe4uy7332efWp7gLP/RIhqWHTwieiEHoTQ4+kd
 ZvSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAlNsHxG7cwU5PSnMxhQ0bId6k1xOOlORqxJUnwvUGXu1e41ILnAcdANVIxLiufpRjGCJx03wiH7Y2L8gn7Yvd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJvu1FRUUKn5SEh/AU02ykU7LShi88Wqv7CWTlazcLAyz9cC/dW
 ztQ/BkmBJwu59CAlZYq1fMEywPPcqw9/H42bV5ugBnJe+VCrSSiR0+pa
X-Gm-Gg: AYBFou24c9Bd9xEwLzd3Hk3dUbNV5JMYE2/IlABbfrE3Erpo9+PqHMsNbMq5eXnXj4T
 Cg+ixRxmkZ0H1ytrpH/K6Efa0wnNzn1imfsagKvQbFobYMAlwYHDVPRunM+l4JVpqTZK8nydnTl
 6+LZxnSY93jHRTlf7JnZtRQEm3nSUxxmwOffjqOXNx9aflYQdLgNiJskB2sybvChuWGDY5/iu4G
 Pz6ASvUMKqiOdAC3QeHZK1aEL5P9LaoroZdozpLKKFwOp2mHoUJxox+OCviQqc5mXxpyUf4+TJk
 4lqY/sO6vba//XuiQN0n27vrpKJ/OYE9es973ZGAMQ6iifM5jCe9CwG9PlEjMx/fvPwFGVQqKzE
 /GgRjV5ckZMQyhULoksURlEZ0om62rTtk/ZoIsIp1ue1VI6d3JMg6kxyDkyhjqMmb2p//hb47B2
 GxYQyMSmtOCbkVl26+Q3CUgjs2t7Dmp1XgGXl6ikAujaGErql5VGx1BElHrK0O85LaQNDvJtXoo
 BAcUw0iNKoayEFhCjNgk14T2je61YKfSo3rfeq0IFPDNPWXzDSF5JLNjOd3wNACjlw/j8fDavEx
 3k8i9gzwkfExIeTrNE/JhjkxRSfZph7V5mU9j/ye+wanjZhTLZd5NUJfd+AzTZD/ALp+4edW1MP
 7wBwUXrEeIlRH5vWYt78nBCMVRwJtAzzApjYAOdy252/dIQ==
X-Received: by 2002:a05:6a20:6a0b:b0:3e0:e242:5ff with SMTP id
 adf61e73a8af0-3e928a29f0bmr10451690637.56.1793648433516; 
 Mon, 02 Nov 2026 11:40:33 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:32 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:46 -0800
Message-ID: <20261102193952.3002018-15-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtX-000000002Dt-0kA8
Subject: [f2fs-dev] [PATCH 14/20] f2fs: support subpage blocks in fs-verity
 enablement
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Check verity per block. While enabling verity, dirty and write back
only the data blocks below i_size in the folios before the verity
metadata. Remove the -EOPNOTSUPP checks. The changes for enabling
verity also apply to large folios when the block size equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c   | 15 ++++++++-------
 fs/f2fs/f2fs.h   |  5 +++++
 fs/f2fs/file.c   |  3 ---
 fs/f2fs/verity.c |  8 --------
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 929a2beef379..a23fd4b01a4c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1671,7 +1671,7 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 static inline struct fsverity_info *f2fs_need_verity(const struct inode *inode,
 						     pgoff_t idx)
 {
-	if (idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+	if (idx < F2FS_BLK_ALIGN(F2FS_SB(inode->i_sb), inode->i_size))
 		return fsverity_get_info(inode);
 	return NULL;
 }
@@ -2924,11 +2924,11 @@ struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
 		pgoff_t first_lblk = f2fs_folio_lblk(sbi, folio);
 		pgoff_t valid_blocks = 0;
 
-		if (f2fs_verity_in_progress(inode))
-			valid_blocks = nr_blocks;
-		else if (first_lblk < last_lblk)
+		if (first_lblk < last_lblk)
 			valid_blocks = min_t(pgoff_t, nr_blocks,
 					     last_lblk - first_lblk);
+		else if (f2fs_verity_in_progress(inode))
+			valid_blocks = nr_blocks;
 
 		if (valid_blocks)
 			bitmap_set(ffs->state, nr_blocks, valid_blocks);
@@ -3657,7 +3657,7 @@ static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 			return ret;
 	}
 
-	vi = f2fs_need_verity(inode, folio->index);
+	vi = f2fs_need_verity(inode, f2fs_folio_lblk(F2FS_I_SB(inode), folio));
 	if (vi)
 		fsverity_readahead(vi, folio->index, folio_nr_pages(folio));
 	return f2fs_mpage_readpages(inode, vi, NULL, folio);
@@ -3677,7 +3677,8 @@ static void f2fs_readahead(struct readahead_control *rac)
 	if (f2fs_has_inline_data(inode))
 		return;
 
-	vi = f2fs_need_verity(inode, readahead_index(rac));
+	vi = f2fs_need_verity(inode, F2FS_BYTES_TO_BLK(F2FS_I_SB(inode),
+						      readahead_pos(rac)));
 	if (vi)
 		fsverity_readahead(vi, readahead_index(rac),
 				   readahead_count(rac));
@@ -4717,7 +4718,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			op_locked = true;
 		}
 
-		if (!verity_in_progress) {
+		if (!verity_in_progress || end_pos <= f2fs_verity_metadata_pos(inode)) {
 			poff = offset_in_folio(folio, isize);
 			end_index = isize >> PAGE_SHIFT;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e3224eacdb5..8e38d46c446c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5345,6 +5345,11 @@ static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 	return sbi->aligned_blksize;
 }
 
+static inline loff_t f2fs_verity_metadata_pos(const struct inode *inode)
+{
+	return round_up(i_size_read(inode), 65536);
+}
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
 					unsigned long type, enum fault_option fo);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29cfc0e2719a..1c440b5fa9bd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4273,9 +4273,6 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
-		return -EOPNOTSUPP;
-
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index af1b7f21c1d8..5f579d0b917b 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -32,11 +32,6 @@
 
 #define F2FS_VERIFY_VER	(1)
 
-static inline loff_t f2fs_verity_metadata_pos(const struct inode *inode)
-{
-	return round_up(inode->i_size, 65536);
-}
-
 /*
  * Write some verity metadata to the inode for FS_IOC_ENABLE_VERITY.
  * kernel_write() can't be used because the file descriptor is readonly.
@@ -94,9 +89,6 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int err;
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
-		return -EOPNOTSUPP;
-
 	if (f2fs_verity_in_progress(inode))
 		return -EBUSY;
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
