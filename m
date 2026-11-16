Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F71606A88F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bQBNEj6/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bniMuHvq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U9L3gNPy;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZZdl2A0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Cp2o2/X+Y4b03EOktA4t+o5ZLIh6u1dxaDobTHwgPAE=; b=bQBNEj6/tc7gNjZypAgXy2oLvM
	rzi92jWwXCOJ+jzDLDuc90LgGSvr4qlvk+Nx7+A9jssBOhJrNgvUbWV6ak45QkUYTdivntOM16ylt
	kyxtcn30JEwtzuQ0NZQCkmbwhI/XqaertSoLSXjV2vRBRfHsEz01FAAaSYExYRMuPSvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2C-000000001K2-485E;
	Mon, 16 Nov 2026 04:09:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo2B-000000001Jm-34rf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jTVVyfonP/unKYGJ3+1FS2r8XOwbDzqwSJPNB4V2nCw=; b=bniMuHvqQs2ZEU4QVoUoyZeRwn
 mnhF1A/Rp+c8BvF45GYz4trFP2HAOqqtOhYqz5eACEL0BdiBOBLRMEXwsIXL7FfAVvDVEq6khk1U3
 N/nlB8pN5WlZor7Us/02tYo96NDhtDgpjH6sL7vg/jkEmd7LdALIPhhtur8bBtbTDkOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jTVVyfonP/unKYGJ3+1FS2r8XOwbDzqwSJPNB4V2nCw=; b=U9L3gNPyLHNqcRdTpql6w5kEOb
 v3QblqjWgi4mPIfIUyQG+bjbhUeO8VUL6Ok725Ph6qh4c1xVvTkH4out4zRUgkOQ/IF+Qz5TCdt2Y
 Oj4rXOMH+iGC4zHkDSnUgspKPcG6Z+Rr+WXifdcGD5YJYPTUnOfwaxMG2At8cDRYKN3A=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo2B-000000005gq-0J7g
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:35 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cd60c5da24cso2383029a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802169; x=1795406969; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTVVyfonP/unKYGJ3+1FS2r8XOwbDzqwSJPNB4V2nCw=;
 b=kZZdl2A0/n8hcDt2T+QBLW5uua0Kyiu/gw+vUHdcaMrtRPCCzV6tf9Kx+LXVCGs+lU
 +zn7AARKoCqNsGzm/WLkiAh0ZTa9s2/RY4jQ5JK3lgvHaf83RL/QmX7CXP94XYtBmSns
 581+DGFywkuGQ11w3R74+NLPw7chllLqIvbtsUmjEhM7ryyawBxAN8Y6iOqm6ObB0Bug
 9IKp5gJe7qqvcQd48dVmLKD0NhRlf/szYPsnNylbruHyaKg4oU26V7+UATV3SB4otqRt
 Do1LKGfZB86F/lnXELBp3ifz2SlljAjJD1ulkuLuqLV9h4DUukOYbHhkhBVUkKj1+pqZ
 wFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802169; x=1795406969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTVVyfonP/unKYGJ3+1FS2r8XOwbDzqwSJPNB4V2nCw=;
 b=VAyysZtNpAiZ1QBh/1zAjeWoAwi9MLJ0VEjAFEwSqcPr+e4q4l4OaJKrNH9TypVLDi
 4p4QMupQRlHrGNdwA++RuTuakYkYwdhw4h7g+XxZ57IPZozTV6Jv6Pq07FLRE/L5nBkX
 tkIVFlI4eNG1kxaoA1cJkT8b4zr27nKxBNSt4VTbs193PuTcSNNAdY862Nw/K3ttjfTc
 1Q2M2NiK/g/dKd/N/3twDFDikl3RffP6AiWMMqmK4R01GI3jPDkRJHei4pPIsMb3CjMV
 zF9U4L2+z+VhG+R29isAvxA13NV21MNaxN70284HDzB3glOqzwl5emAAnohgMuFvcMHd
 vQcw==
X-Forwarded-Encrypted: i=1;
 AL+hErEGWTBlcXXzp51E6JE0PZrjIOTC5w5I2419tK5HvqnfYirFqhkEvY9kL5Xlt9WFewDajNHZuJdledrDeAz95WGa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ngLUINERp1AQL3VNk70dvg8B5c3sH36bVKege1olaA8NK9wyc
 piJYpQz1OC8UpEDjjXnVH/68UdCVb3cHJuTM/Ae5yx5MdwewegHteXfR
X-Gm-Gg: AYBFou2kLVd7z+AnCM/ntzLH5XE9MQT2qiy9RvQ8So9suxnsWPHQ44deQxtRXJcHqji
 1jYNXfrEP/Y7v/gKjeYUSybF4gFgVSl4kg5Yi7qDQfu86k4vJVTJTmxZLlgHj1ZsIv0FpQ669rQ
 mN4F6ekplWLly1ZP7GIVam1z0+mdfX/p+zoNdmukWfL5N4L4Qk/5yGBfJuXlf/BHuVzoy/w26Iq
 fotGTEb8dhgnhfESVmP45VPLVSpNznRfPVdJEYAgxGkfRvJV4cAZZxicQDXDUVQ9xpqKn4xXHOP
 YYA+qDL+CgPdInk5iQcgYHK4qZIoW3Lv2IaqPTNx5zqQHCmmIVcOrvaH8kX3Vma7SX1voVbV4/4
 SRStrUfUt4XwP5Y+Hsfcgp2IdlM6WgxZ56H6OasHg0f6j+CsLAJbNH4WEVds+5tVsDLAiTwO7Eb
 RiIGPLf86/CRbD9nyojxJ07CSocxPyppqVwiAwEZSqGFAx7rjDOP8UchUtOF2DYLrolTP4s49XG
 izlFQCa1xG46gWWTnP6hottwO0lDJLstJ6dkz9JDiEUpa/TGj2zdC9+DKQ41A7OZKTItq6GvvQV
 xeq6rZSM//t8V46zIY0kfKYq+MvR+cHlkW01rlFRpLNu2o9E4QmN1GFt/F5EJIkONR1e6ZpvF0h
 Ms1zvsqP8jBVtOoUhZFoplSNTAjFpOXEEllg5Eq8IP4gx9gag
X-Received: by 2002:a17:90b:4acb:b0:3a4:f75d:d194 with SMTP id
 98e67ed59e1d1-3b1b0a20d40mr10265125a91.36.1794802169283; 
 Sun, 15 Nov 2026 20:09:29 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:27 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:46 -0800
Message-ID: <20261116040851.2849696-16-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo2B-000000005gq-0J7g
Subject: [f2fs-dev] [PATCH v2 15/20] f2fs: support subpage blocks in atomic
 writes
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Writeback already writes dirty blocks to the COW inode per block. Make
write_begin of atomic files reserve and read COW blocks per block as
well, and remove the -EOPNOTSUPP checks. Skipping the read of the
blocks that a write fully covers also applies to large folios when the
block size equals PAGE_SIZE.

Aborting atomic writes drops the page cache and restores i_size without
i_gc_rwsem[WRITE] and invalidate_lock. With subpage blocks, a page fault
in between can make a folio writable with only the blocks within the
smaller i_size prepared, and a read can zero-fill the blocks beyond it
and mark them uptodate, while they are inside the restored i_size. GC
reads through the page cache as well once FI_ATOMIC_FILE is cleared, and
then moves the zeroes. Hold both locks across it as
f2fs_ioc_start_atomic_write() does, except at eviction, where no one
else uses the inode.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c    | 24 ++++++++++++++++--------
 fs/f2fs/file.c    | 30 ++++++++++++++++++++++--------
 fs/f2fs/inode.c   |  1 +
 fs/f2fs/segment.c |  7 +++++++
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9f7f8214d10e..b4f16afccc51 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4698,7 +4698,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		}
 
 		if (f2fs_has_subpage_blocks(sbi) &&
-		    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+		    f2fs_compressed_file(inode)) {
 			WARN_ON_ONCE(1);
 			mapping_set_error(mapping, -EOPNOTSUPP);
 			folio_clear_dirty_for_io(folio);
@@ -5325,7 +5325,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	int err = 0;
 
 	if (f2fs_has_subpage_blocks(sbi) &&
-	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode)))
+	    f2fs_compressed_file(inode))
 		return -EOPNOTSUPP;
 
 	/*
@@ -5441,13 +5441,16 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
 	/* Inline data must have been converted before reaching here. */
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	start = folio->index + (ori_off >> PAGE_SHIFT);
-	end = folio->index + ((ori_off + len - 1) >> PAGE_SHIFT);
+	start = f2fs_folio_lblk(sbi, folio) + F2FS_BYTES_TO_BLK(sbi, ori_off);
+	end = f2fs_folio_lblk(sbi, folio) +
+		F2FS_BYTES_TO_BLK(sbi, ori_off + len - 1);
 
 	for (index = start; index <= end; index++) {
+		loff_t block_start = F2FS_BLK_TO_BYTES(sbi, index);
+		loff_t block_end = block_start + F2FS_BLKSIZE(sbi);
 		block_t blkaddr = NULL_ADDR;
 		bool node_changed = false;
-		size_t off = (index - folio->index) << PAGE_SHIFT;
+		size_t off = f2fs_folio_byte_offset(sbi, folio, index);
 
 		err = prepare_atomic_write_begin(sbi, inode, index,
 						&blkaddr, &node_changed,
@@ -5455,12 +5458,17 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
 		if (err)
 			return err;
 
+		/* Skip read if the write covers the entire block. */
+		if (pos <= block_start && pos + len >= block_end)
+			goto balance;
+
 		if (f2fs_ffs_test_blk_uptodate(folio, index))
 			goto balance;
 
 		if (blkaddr == NEW_ADDR) {
-			folio_zero_segment(folio, off, off + PAGE_SIZE);
-			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+			folio_zero_segment(folio, off, off + F2FS_BLKSIZE(sbi));
+			f2fs_ffs_mark_subrange_uptodate(folio, off,
+							F2FS_BLKSIZE(sbi));
 			goto balance;
 		}
 
@@ -5517,7 +5525,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 	if (f2fs_has_subpage_blocks(sbi) &&
-	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+	    f2fs_compressed_file(inode)) {
 		err = -EOPNOTSUPP;
 		goto fail;
 	}
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8540613e3b22..d6304b705e06 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2314,7 +2314,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
-		if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+		if (f2fs_compressed_file(inode)) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
@@ -2358,6 +2358,23 @@ static long f2fs_fallocate(struct file *file, int mode,
 	return ret;
 }
 
+/*
+ * Abort atomic writes with inode_lock held. Until i_size is restored, GC,
+ * page faults and reads would see the i_size of the aborted writes, so keep
+ * them away as f2fs_ioc_start_atomic_write() does.
+ */
+static void f2fs_abort_atomic_write_locked(struct inode *inode, bool clean)
+{
+	if (!f2fs_is_atomic_file(inode))
+		return;
+
+	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_abort_atomic_write(inode, clean);
+	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+}
+
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
 	if (atomic_dec_and_test(&F2FS_I(inode)->open_count))
@@ -2372,7 +2389,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 		return 0;
 
 	inode_lock(inode);
-	f2fs_abort_atomic_write(inode, true);
+	f2fs_abort_atomic_write_locked(inode, true);
 	inode_unlock(inode);
 
 	return 0;
@@ -2391,7 +2408,7 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	if (F2FS_I(inode)->atomic_write_task == current &&
 				(current->flags & PF_EXITING)) {
 		inode_lock(inode);
-		f2fs_abort_atomic_write(inode, true);
+		f2fs_abort_atomic_write_locked(inode, true);
 		inode_unlock(inode);
 	}
 
@@ -2568,9 +2585,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	loff_t isize;
 	int ret;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
@@ -2702,7 +2716,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		if (!ret)
 			ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 
-		f2fs_abort_atomic_write(inode, ret);
+		f2fs_abort_atomic_write_locked(inode, ret);
 	} else {
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
@@ -2730,7 +2744,7 @@ static int f2fs_ioc_abort_atomic_write(struct file *filp)
 
 	inode_lock(inode);
 
-	f2fs_abort_atomic_write(inode, true);
+	f2fs_abort_atomic_write_locked(inode, true);
 
 	inode_unlock(inode);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 5c6a64b31b05..2bc15fa192be 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -851,6 +851,7 @@ static void f2fs_pre_evict_inode(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
+	/* No one else uses the inode now, so the locks are not needed. */
 	f2fs_abort_atomic_write(inode, true);
 
 	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 93f165151c0f..5bff57723e2d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -186,6 +186,13 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
 }
 
+/*
+ * The callers hold i_gc_rwsem[WRITE] and invalidate_lock as
+ * f2fs_ioc_start_atomic_write() does, so that no page is read, by GC either,
+ * or made writable between dropping the page cache and restoring i_size, i.e.
+ * with the i_size of the aborted writes. Only the eviction does not, as no one
+ * else uses the inode then.
+ */
 void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
