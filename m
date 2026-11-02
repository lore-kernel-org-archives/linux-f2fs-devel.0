Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CD606D80E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VeOK3Nfw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ug93qTNk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ShnDoDS9;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UTwNAXzD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=uRrZUJdGwesGZcUKBKYFnmZDDQHBlS6ZuwooBq0ZHxo=; b=VeOK3Nfw9oFe+e7scc3ikRDWg/
	hFRAhuBGGowtDIfUPfdVX+GsdCX8g1JTAGoNoxjIjACCtSUjDTf0sVuCRJAneEqMY1SOjTuxS7eoh
	z46Hn7V0q809gBgjZ2lfZvSmue1cs5VmhZ45glyGzFTdHbYvGH0DGdFVB4VB9vQjSHoY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtV-000000004iX-1MpI;
	Mon, 02 Nov 2026 19:40:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtU-000000004iJ-1EAw
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZAHV4AOSytaNVCMWbh36iatuZvGOCaiBEcBiUAm2wlE=; b=Ug93qTNk71Kso4gH2RFE7JrkRu
 wnL9Zx7ekkCBluYM28WdB4PTpyBetQuxf9OV7CrKl3XF0Elj4MSgpEaaDH4cZnwE2FGGlxEFYSj8l
 3EVJkEdbyIm0kh33nf29TNbBQG6I1oHZTHlL2SQ68dJlANMi+X6FcANZ1sHNffE9eQB4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZAHV4AOSytaNVCMWbh36iatuZvGOCaiBEcBiUAm2wlE=; b=ShnDoDS9SbQB3ZXG2KZH/mqCFQ
 nqgIi9nCwWhPneFhdfts/LhI12fEGjTrYF5cdW8KjY9RSbi9FD9YVZ6Wz/elzO7zhQPeLeSc8miwN
 wv2dDmspHFZfCNhtLX05EFyHZYXv6mpCw+ucBzfRMFxx0YPvPta/hxBKdXdSsN3CbJXc=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtS-000000002De-3oIj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:36 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8ac1f2ff78dso730760b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648429; x=1794253229; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZAHV4AOSytaNVCMWbh36iatuZvGOCaiBEcBiUAm2wlE=;
 b=UTwNAXzDJvXHay8X3AH+llEQyju6S/SPeuza6AXZisH2We5fAN684I1EnecrzbuyqJ
 aCdTQI7ASmLDXidksarS/VDRpaBY/5mD3K0+TyxyYuI3gTGZxtEnw4NJSSqwe5g0PljC
 F1GXAvc7aclSdvzQJdGuk3vXwHU+YmSAwjFkJsjwjRxpx4yA+3HjU9NHI9cr+Upa8+yM
 SH/5M2ouIM8giOuYaqt2b7in95BdlJebZt7PY42DBKi3rGMX++LAI5zJ19WwL8wfGE/f
 0MNK/fSWiBnoqkukpAameVzlBpK81z52fMjkKCOi7W+QYh8Ea+ybRpakEO7fP99P4F8c
 b6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648429; x=1794253229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZAHV4AOSytaNVCMWbh36iatuZvGOCaiBEcBiUAm2wlE=;
 b=Pmq9hFh1dez7ntrLW5VpxOFZi6Lt7c3uMUEbbE63PJGo3s4Dr8de6fo1NsaPQdLIr2
 0eoSTzR1wkyM5snQxnGxKE0ZSDYofylSrOLvvNFHZfgve81SpXfJRTBPCPFP3z63NrrZ
 4pTskGyHNB6WJM+X+JeIl/ib0uEs9egGWbKvxj6qPUA9lPtYqFDhIbfhrsi2pEfcvuIh
 O2+GdJD7M5aucrRVZmcfwNuA0lsqq5LEPVCCah8LoEQO5tnDbnDRP4eUPmIWE9W/F3YS
 f5kVwoiZQUiAFoXWZrP7+y59fXaCmeNoHXUL6A2LFjgC8+QIz3SCGF5TZtTYx9kxU58L
 uiow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNlW1TzgHjHJ8CexeKx6trocU9Umc2PDM1AZ6ZbBQBnSYGO4SLUEpbfaluFURrgHn/jM5hcsd7cISdJfbewL5x@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK019qdAq1g8MyqLQl6pkdydT9QQYmb0cFFOP6MPLFcknaDeeMA
 tepAUEjyeEC1TQf4JbP1DLLaj29sjleEa5wo3MiHCEgOp30g6vNBmVUa
X-Gm-Gg: AYBFou0wAA6WdH5KSS7kcNiWtxklee03u0luH6LufkH4S8pQjjHVhf+yG4LwNBqjT/A
 rx3v6fIXUUbewxcEz4anHq8X9ZhLZGQwgHDaddwcIAEgQ5qRcLucHwtjPISuKjKs/8UTavSACwe
 aFzUaHqEPSFKFslKrtCAPfyYovol/8MezO6eDIXX1DfA2fNQm52gVExKaxIFjEsvVdqAmsY5inV
 1OIs+jrTqbcgr098f2g9Mogd5tYsGipnxdIBL/EyxHR4lUFEI+XdSWxWTAXOqY/szdT09R+wLAN
 n2tjVWdbK/bUWNrkn9GksHllOG66z+1Kt3EEfvPbIeHxW5C3nuW79heQ8wNegRvRPmaJW34AB4I
 2IrPzapg48zWJe9nGNZgKho9V9z7jL8j4UHYgbA6PEEh3njd8XZ+SKaMdrQyGzqtfb7YTLtgPgn
 5clKBK5Yrym2mzYNTN/uiA4P8P4a9U2c7I56onItIuGvhTgScxYwvR/adqGZt9nHR2jstQb6VOT
 mjThaloMZFRKyI5wDUdI6fTAjxqmgN4Or/FXk3ajM+WweuLnZvKH4m5OeFfOC3nFLbNR6HctZOU
 M/7A4Ikm4fi/bdQu6wLQKNejgRT6ZIomEBnKpss9G3IOgNBzCwqojRYzsAFMqzjlg00uMvKvSMK
 3yMCKXsxbTwPqElCRMik2iwzzlVVYTSM89c2lNTW9+qsa5w==
X-Received: by 2002:a05:6a20:3ca5:b0:3e2:8c65:b229 with SMTP id
 adf61e73a8af0-3e913ae6ea5mr12470406637.11.1793648429145; 
 Mon, 02 Nov 2026 11:40:29 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:27 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:43 -0800
Message-ID: <20261102193952.3002018-12-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtS-000000002De-3oIj
Subject: [f2fs-dev] [PATCH 11/20] f2fs: support subpage blocks in move range
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

Folios at both ends of the moved ranges can straddle the range
boundaries. Write back and truncate the page cache from PAGE_SIZE
boundaries, and hold invalidate_lock of both inodes during the exchange
so that faults and readahead cannot bring back stale data. The page
cache was not truncated before, so this also applies when the block
size equals PAGE_SIZE. Remove the -EOPNOTSUPP check.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3ef810653bb2..0fad86267256 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3501,17 +3501,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (ret)
 		goto out_unlock;
 
-	/* write out all dirty pages from offset */
-	ret = filemap_write_and_wait_range(src->i_mapping,
-					pos_in, pos_in + len);
-	if (ret)
-		goto out_unlock;
-
-	ret = filemap_write_and_wait_range(dst->i_mapping,
-					pos_out, pos_out + len);
-	if (ret)
-		goto out_unlock;
-
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
@@ -3521,6 +3510,31 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out_src;
 	}
 
+	/*
+	 * Hold invalidate_lock across writeback, truncation and the block
+	 * exchange so neither faults nor readahead can repopulate the page
+	 * cache with pre-exchange data.
+	 */
+	filemap_invalidate_lock_two(src->i_mapping, dst->i_mapping);
+
+	/* write out all dirty pages from offset */
+	ret = filemap_write_and_wait_range(src->i_mapping,
+					round_down(pos_in, PAGE_SIZE),
+					round_up(pos_in + len, PAGE_SIZE) - 1);
+	if (ret)
+		goto out_inval;
+
+	ret = filemap_write_and_wait_range(dst->i_mapping,
+					round_down(pos_out, PAGE_SIZE),
+					round_up(pos_out + len, PAGE_SIZE) - 1);
+	if (ret)
+		goto out_inval;
+
+	truncate_pagecache_range(src, round_down(pos_in, PAGE_SIZE),
+				 round_up(pos_in + len, PAGE_SIZE) - 1);
+	truncate_pagecache_range(dst, round_down(pos_out, PAGE_SIZE),
+				 round_up(pos_out + len, PAGE_SIZE) - 1);
+
 	f2fs_lock_op(sbi, &lc);
 	ret = __exchange_data_block(src, dst, F2FS_BYTES_TO_BLK(sbi, pos_in),
 				F2FS_BYTES_TO_BLK(sbi, pos_out),
@@ -3534,6 +3548,12 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 	f2fs_unlock_op(sbi, &lc);
 
+	/* the exchange may have extended dst past its old EOF folio */
+	if (i_size_read(dst) > dst_osize)
+		pagecache_isize_extended(dst, dst_osize, i_size_read(dst));
+out_inval:
+	filemap_invalidate_unlock_two(src->i_mapping, dst->i_mapping);
+
 	if (src != dst)
 		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
 out_src:
@@ -3588,9 +3608,6 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 {
 	struct f2fs_move_range range;
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(file_inode(filp))))
-		return -EOPNOTSUPP;
-
 	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
