Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E26606A33F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mam0q9Kr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SuXFtmTa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lKBDp9xr;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1t43GCd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Fz02g+ibPyxjQipoHV30Lj4QYj0jPypowV3InGR/ByU=; b=Mam0q9KrVWy96BwdqcYcXz3Pub
	vsZu7gwUL+juhmGTV6wisvr6kktLiLx6HrOypqlFkCxz9mW0gxLdwuUlDB1NiaWO5otYMdQ+D1Kd/
	m5jY5WwWa+NmHUbr2InZOWtzBOSe7yYbbyTv4W1h6YnRragHvwiYub8nOiTZ3LowBNYk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo24-000000001Hz-3NbW;
	Mon, 16 Nov 2026 04:09:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo23-000000001Hg-422j
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X33thUbLKIiMz+y447VVVI/W+Uwf4DWtbchYH8A4ZZg=; b=SuXFtmTaTcMC0HTCWQ/4UZEjcw
 ixmSlv65H6wx5kzia0ERjMVlV9hbMqxpE427od3cfnanl6iIF+xy6qqrOUTEpEoqaac+jBvHRF8wJ
 YnXwtWe2xwSE8AjMyd/tW2NZlCUJ+5MtFJ7BH1anC8lq0Y6RL7WB7U7xuPws98SivopY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X33thUbLKIiMz+y447VVVI/W+Uwf4DWtbchYH8A4ZZg=; b=lKBDp9xrpklk8r5IIG6YQYmfoi
 e7cdhkAQAO+eAY2V4euv9WZ3p13eMpVrD2IJCgDG9GAtm/nD6ZITLzXPn45GHTJqQVIg+M2o/LxPu
 3IruAXCkHk0Rk/AzmFjTSsk33PW2rAUYPt0p1YVzfd0pKi2Nmv7BKAalYTaZvbIv924U=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo22-000000007cS-2MGQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:27 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b1535be329so2233750a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802161; x=1795406961; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X33thUbLKIiMz+y447VVVI/W+Uwf4DWtbchYH8A4ZZg=;
 b=j1t43GCdJ+5D9eKQUC6v4TGRMFhdM99GF+JabS0MmDOjUPdtnUony0V96kKARdtZNG
 ss16yWShnDAmRFwxJ/OLol4wNXwzFscLJ2lPOSAByf0jORhuYB0V/amEOIdnam+g5YtG
 rKkfEXk0ydaijmb0pRhTyA7SmYra5arEIzx1veZfFr0FFY0qQFA88xskSVSczk/8qOu7
 KYbMuCwb6OBFGEyFbfzjFuh+86vmn4NvfP8S5fdHx8kCHp/dRTuq1twrCNaGuIS/Sgyn
 YDwJFq/UreW1tU5fWEsvZXLyuii0CEkpYDAKvwzMF0tl16oEVvgkNu25sRLp47ywGPO4
 u7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802161; x=1795406961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X33thUbLKIiMz+y447VVVI/W+Uwf4DWtbchYH8A4ZZg=;
 b=YBMKyzB9XV785rLRjkVLihjygG71QxNkgfPVdUJ2shCG9OirNudaTJXNLfhBi3Clxt
 F73iFySJzmCb6DIL6ViJGCxFc65rzV4bLbJJEs6WEVHjWsCrpeBEmob8UY8PxFu5+0Bh
 RVaQI3YKpy0qUJIFp559iqeQ0fV6TfiOnY8B1o453CjOiDnZTpltxpRJ4Gm88KAQBEom
 KKzWTnLUepmdh1vCp0I4Qbuzh953CjiNHk2tvyxPQtO7kaqzldmGokI0L4AfJlNObIMP
 D1XGknIKaI2ZB8r4QK+QS1CmpTo0/ONdizQtCN087pmTmDRbxpd6h4HM0MsipAJbyqMb
 4TXA==
X-Forwarded-Encrypted: i=1;
 AL+hErEtR+8hCRvoKR/9seEgUk7PY5CxIGVhE4S088tll+G+5NyapB9HFStN1U2At6eGiYaToVREMatcDmYWyIPxoh85@lists.sourceforge.net
X-Gm-Message-State: APuU4Z89sKOB1NrQgSHZAHLV4rKAXltHMp4FSDw/lSDPsgLV+M0JopNb
 9UAgAZQFvtmCIr/mmJrj6Kz1dOTzjU1D6OJdVkY2eK2FFNe16jIfyTtb
X-Gm-Gg: AYBFou0rfxABXd3A4zUPkQstLNgmMeYxmUSGq8iNlCJEj1eio7n5+iJok59jkKURZlO
 0JED5seU5Z1uprt1fFedAZQXWSowMs5A//Cpy8eKHLuWIRPRTeMgCP06j8kH+nxRF2K8F4u+2sw
 rGBS1O2kcLaYArE9OEM7n1ourmwLFSNUOZQIs9EyLHvtyXnf31fKnfkeoJdPszMgUnUyeRPZtMk
 qw5J0HcWRPZ4eogym7WmIcO3uW5yQQPFf7yne5YtUs7P6yYx0oOZ2yNbK2srGxs6yDXJy2if9E4
 oRxeIBAe9E7ai152WGJH6tp4pnU0l2izmszfKNViNsZep9bCcwJjAuerCCfRugVWddg4JlQig6V
 QGEK9YFNwcsdkwxuD1bZJ1MSSu+3CrLHcn3fHBXmb4y/SsK018p5yNOPfgddzXVCVtTzh89m6BF
 hHhMIrUNKv6ZL+WkLdDUgqqSplvoO3eq3CI9/NCuYJAmfNZtDlDzBFmr06yEYpkQUpREjr4ZYgb
 m+EfP23g+m1CFdRXoi9J6VD4dxwnbtz+W+lCanucTBgDA5f2Q02YTUvtLWhbEnzoLa76/uxu3Mc
 VCllIe/Qx8QfpLMzqPzTZH4pYGSOsQXDA72PDCksLyJXMXrWR+9yT0K9xHDH4WOMgpG48XxQ5Vh
 Gr/cfSjs7qDnanRMnEwmbmcijdzhh/ejSL4DgOLxF7UUAPIwU
X-Received: by 2002:a17:90b:1dc3:b0:3b0:9782:8721 with SMTP id
 98e67ed59e1d1-3b1b0a0e116mr8704980a91.36.1794802160765; 
 Sun, 15 Nov 2026 20:09:20 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:18 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:42 -0800
Message-ID: <20261116040851.2849696-12-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo22-000000007cS-2MGQ
Subject: [f2fs-dev] [PATCH v2 11/20] f2fs: support subpage blocks in move
 range
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

Folios at both ends of the moved ranges can straddle the range
boundaries. Write back and truncate the page cache from PAGE_SIZE
boundaries, and hold invalidate_lock of both inodes during the exchange
so that faults and readahead cannot bring back stale data. After the
exchange, also after one that failed part way, drop the source blocks
that it read into the page cache, and call pagecache_isize_extended()
for the gap between the old EOF of dst and the moved data. The page
cache was not truncated before, so this also applies when the block
size equals PAGE_SIZE. Remove the -EOPNOTSUPP check.

Zero the cached data past the old EOF of dst with
f2fs_zero_post_eof_page() before the move extends dst over it, as the
other paths that extend a file do. Otherwise data stored past EOF
through a mapping becomes file data. This also applies when the block
size equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 73 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d4472143dea0..4499a461be86 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3435,7 +3435,7 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	size_t olen = len;
 	loff_t dst_max_i_size = 0;
 	loff_t dst_osize, dst_end;
-	int ret;
+	int ret, err;
 
 	if (file_in->f_path.mnt != file_out->f_path.mnt ||
 				src->i_sb != dst->i_sb)
@@ -3516,17 +3516,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
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
@@ -3536,6 +3525,39 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out_src;
 	}
 
+	/*
+	 * Hold invalidate_lock across writeback, truncation and the block
+	 * exchange so neither faults nor readahead can repopulate the page
+	 * cache with pre-exchange data.
+	 */
+	filemap_invalidate_lock_two(src->i_mapping, dst->i_mapping);
+
+	/*
+	 * Zero the cached data past the old EOF of dst, such as mmap stores
+	 * past EOF, before the move extends dst over it.
+	 */
+	ret = f2fs_zero_post_eof_page(dst, dst_end, false, false);
+	if (ret)
+		goto out_inval;
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
@@ -3549,6 +3571,30 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 	f2fs_unlock_op(sbi, &lc);
 
+	/*
+	 * __clone_blkaddrs() reads the checkpointed source blocks into the
+	 * page cache before punching them, so drop them again. Do it after a
+	 * failed exchange too: the blocks moved before the failure were
+	 * punched as well.
+	 */
+	err = filemap_write_and_wait_range(src->i_mapping,
+					round_down(pos_in, PAGE_SIZE),
+					round_up(pos_in + len, PAGE_SIZE) - 1);
+	if (!err)
+		truncate_pagecache_range(src, round_down(pos_in, PAGE_SIZE),
+					 round_up(pos_in + len, PAGE_SIZE) - 1);
+	if (!ret)
+		ret = err;
+
+	/*
+	 * Write-protect the folio straddling the old EOF of dst, so that mmap
+	 * stores to the blocks between it and the moved data fault.
+	 */
+	if (i_size_read(dst) > dst_osize)
+		pagecache_isize_extended(dst, dst_osize, pos_out);
+out_inval:
+	filemap_invalidate_unlock_two(src->i_mapping, dst->i_mapping);
+
 	if (src != dst)
 		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
 out_src:
@@ -3603,9 +3649,6 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
 {
 	struct f2fs_move_range range;
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(file_inode(filp))))
-		return -EOPNOTSUPP;
-
 	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
