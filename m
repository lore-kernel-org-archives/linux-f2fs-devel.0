Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D65606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Crm+f8fS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HrOR5qm4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aZcDRKx4;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MS4JLAKM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=bP0ct1b0OM4vGhgQdI+N+QJQz4S7uyYFRGZQrvknrPc=; b=Crm+f8fSeFJ8L84S53BBUJ0KwA
	uXcUto0DXUFJGYCOUSQ86KSWEotDlV471vanLxA/+HOlRgEX4gvtaUF8w+GwnEojidRCcg+VDso7w
	6XaHMddsCW+8c2rsgpw/no2rkDUPV3NggzTiQLr9RU0Zw4nWJL2CpFLDp+AwhIyLyhrk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu1-00000000447-3329;
	Mon, 02 Nov 2026 19:41:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtk-0000000041d-0fHo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tLGRuSUuH80iDbi4ysKjfpv0HJCSkYOa62c0IAzagSw=; b=HrOR5qm4s2j6DrulPoinuRwDzT
 frdgiB9p+/oOGRtioVyfwExTZSc6rRVbcjkyu+n8vtbX4A5BFr4jd1IayciPgfyX1EnPfscEkKT7D
 /B8hPHOp6fN+hEcFJeOUw+qWAb4W/h63F04Ye1jYX1zHmuW0/Qmo2mAZXrhG4g00FKzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tLGRuSUuH80iDbi4ysKjfpv0HJCSkYOa62c0IAzagSw=; b=aZcDRKx4BaY/xANDCWFi/kWzCh
 7K504iSHGbJ9lgle3oR9Q/AHXe2G0awjCMQBjxcw5F78kl2paz69vxOwMMbwvttjM+xCeB/MX+UbM
 8XQe3chCIhUD9stKDV1l4Sn4ow1tGXcSR3u6PCGZgK3FVgqzukEpW32U/05INVfBjxlI=;
Received: from mail-pf1-f179.google.com ([209.85.210.179])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtY-000000002Dy-1lAh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:43 +0000
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a05e3f0d23so1415649b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648435; x=1794253235; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tLGRuSUuH80iDbi4ysKjfpv0HJCSkYOa62c0IAzagSw=;
 b=MS4JLAKMi19sTzoQXB+2Zu+Jdql2UrVcmYozu9AZioM56+I2sbB7vi/OTbVAANd6qR
 YLzlMB3AvdSsKiHeGREi49eKu950SO/BQh7mKb8t2f+kH1Bw8PhiLcaZAVAwVLExgjAZ
 k81rNenp602JQzA9lbznZmalGX6sqe8RDruKSh06VQ3/ACsraQni/fe2cDiHwQ1bUsyK
 fFry9a5TLa8ViKxBxDLa4O4jcay6xpTDKtDTrF/qTENxXRoWNQuQOsqTaW//4BOYuBR+
 LRI+0FIzKjkyX6+ucUXXLH4eNmsNldiJi14fbMnrda7HOZSvqCK0kDg+XZMEiXiBwQV9
 vnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648435; x=1794253235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tLGRuSUuH80iDbi4ysKjfpv0HJCSkYOa62c0IAzagSw=;
 b=DvUz1byD7bx1pKR6Zkaoawy5jZSY6iBwQWBShoBnrrNv0IyfAT2LUqitYnDwu6BgxZ
 zVl+3LbpmtQkETvFCCfIJ9jrygWCR7qPxxW8o1vvBZUMiFj3AO5sFs8IhFNKBrXfkU51
 tSWWWMBf41Z2pt+ov8WqINC/Xoj3EvewChD0OehCI2/49QASvfBIXL9+wToIIb4j/LOf
 rTjtoq55TP1ocrlaebJ0egKzWzi59d5uIRlay+VVfXjfbwjVjIPzHT7s6I1g5olHYRiv
 hAQQ8lsvgiIwIiByTN6Tx3VwHTFMjlm3ch26sdewbSmWJ0lGkKVW5z2LeAFihpc+OMDr
 Goog==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5PbNF8q+TLh1nOoec94AKN5KuK9FsIbxnooNWX5mCEzkBs2e4AVfH45nIHftOhpktKLVxqWBME6CfmXwltsci@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ4jdmbHX2IR9EusNfuqza0vFa5E8vBUM525Ibq8RGis4rcjv9i
 9pXggcm79iRyh0ygXwM2qPY9Qgr78LHKBYbuF+e/q9C6wyzZ7KaGDqg7
X-Gm-Gg: AYBFou22E1q6Pmck5uQGpxdNZsvfcz/20yVI+RKYHXChGr6whrrAsvx1tCJ2NMSQNZS
 9Q9IEQStsE6A2h7l25uI6cOsj+cY7PEFONEPKEx7TvfX0i+iy7ao5qzKP+ASONh4HNdFoAFSEyi
 ev1PAWfdjjaPw52iN2UJ6I070kY4pEC3ho59TgeleKaY4afI2R58ucGxlI4eUOXdCThG+ZQx175
 obKdQbiLWLEiPTWVgcUGVDZsordR2d4A2Ls9FOS68AEtZ/MqsCb/VI5GFN3VIdc2vEJQOLuBCZ8
 ITjlSNN5sDUxOVhi8mMvfeGyjZnPf9/vMwMBIAGpTLNQRss0Pza4MJItBXF+lx7g44Xys1Y8jIx
 M5W/1vkOy3XkkioLVNam8LtR5isBgaYI7tlDvTxMyKIX1fbjF/5lT/pv32s46DsKUuqg3zJOFSb
 BHAJaQ6FN33X7vUqdUiXLQ2fm41/pNo4mWoAUWXxYVEtybsi5kgvJdNxwyh0Wqqs4fmRgoWA8B6
 VesV+2CzEoZY7Mzq46w1s2ekqOQ3g9r/Rqceete8iVBLPa96xuXzW4EvQGNoIFt9sy/NtlyxMLs
 R41kb6q2TZ02WAJ5uQd+HBLb/Yb4mCA63ggfRABdq/V0XAJDMZMlJdqdx/2/LSyKdJTL9KE1hlo
 pO3FzMoZV2aO+RZN3VZ2PnX5KzBSpaFTS24dGLPdBLso8SA==
X-Received: by 2002:a05:6300:6d8a:10b0:3eb:4b16:1afb with SMTP id
 adf61e73a8af0-3eb4b161f51mr2904282637.56.1793648434687; 
 Mon, 02 Nov 2026 11:40:34 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:33 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:47 -0800
Message-ID: <20261102193952.3002018-16-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtY-000000002Dy-1lAh
Subject: [f2fs-dev] [PATCH 15/20] f2fs: support subpage blocks in atomic
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
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

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 24 ++++++++++++++++--------
 fs/f2fs/file.c |  5 +----
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a23fd4b01a4c..4e4d1b0d6004 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4624,7 +4624,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		}
 
 		if (f2fs_has_subpage_blocks(sbi) &&
-		    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+		    f2fs_compressed_file(inode)) {
 			WARN_ON_ONCE(1);
 			mapping_set_error(mapping, -EOPNOTSUPP);
 			folio_clear_dirty_for_io(folio);
@@ -5247,7 +5247,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	int err = 0;
 
 	if (f2fs_has_subpage_blocks(sbi) &&
-	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode)))
+	    f2fs_compressed_file(inode))
 		return -EOPNOTSUPP;
 
 	/*
@@ -5359,13 +5359,16 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
 	/* Inline data must have been converted before reaching here. */
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	start = folio->index + (ori_off >> PAGE_SHIFT);
-	end = folio->index + ((ori_off + len - 1) >> PAGE_SHIFT);
+	start = f2fs_folio_lblk(sbi, folio) + (ori_off >> sbi->log_blocksize);
+	end = f2fs_folio_lblk(sbi, folio) +
+		((ori_off + len - 1) >> sbi->log_blocksize);
 
 	for (index = start; index <= end; index++) {
+		loff_t block_start = F2FS_BLK_TO_BYTES(sbi, index);
+		loff_t block_end = block_start + F2FS_BLKSIZE(sbi);
 		block_t blkaddr = NULL_ADDR;
 		bool node_changed = false;
-		size_t off = (index - folio->index) << PAGE_SHIFT;
+		size_t off = f2fs_folio_byte_offset(sbi, folio, index);
 
 		err = prepare_atomic_write_begin(sbi, inode, index,
 						&blkaddr, &node_changed,
@@ -5373,12 +5376,17 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
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
 
@@ -5436,7 +5444,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 	if (f2fs_has_subpage_blocks(sbi) &&
-	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+	    f2fs_compressed_file(inode)) {
 		err = -EOPNOTSUPP;
 		goto fail;
 	}
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1c440b5fa9bd..91f792cf879f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2299,7 +2299,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
-		if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+		if (f2fs_compressed_file(inode)) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
@@ -2553,9 +2553,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	loff_t isize;
 	int ret;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
