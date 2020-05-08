Return-Path: <SRS0=+YV0=6W=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB92C38A2A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 May 2020 11:57:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AAE2145D;
	Fri,  8 May 2020 11:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="hAYjDRh0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="jjy1uo20";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZvymGrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AAE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jX1cz-0006v0-6E; Fri, 08 May 2020 11:57:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1jX1cy-0006ut-0M
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 May 2020 11:57:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yYfioAcTDcx67ZCUByDfU2JLdR9CVckvTAFBAqOEES4=; b=hAYjDRh0w8geXWG8wF4jLVGICJ
 vvJOudfnq+qAm1WV9euriSWqglViI6cn1AuEs+bROyvKU9DDHalxb5kNMcCNbOrp1eFqy3vNFa6Ct
 hViFm/3R3nPWi0NTFSZL2eOq4Ak2v396ca9QQOE6I5agVOsgGI8c1S1zFNOY2t7nK5zo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yYfioAcTDcx67ZCUByDfU2JLdR9CVckvTAFBAqOEES4=; b=j
 jy1uo20NbjlhngROnMbtpXUBpCqfDlwOED0ztyfSsMlSqxi2TPsUh2VdluEt97HnLAAyR6E9kXtMY
 1VgVMaHjF8nLyuHQIA3xDkDy1WY1s0RGpcpyS4PCOCd4qhqEC/R8NFk1gdyY6TWqxcCdagmYVoG4J
 1Aye92bQhOeYnCCA=;
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jX1cu-00CT3A-1s
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 May 2020 11:57:15 +0000
Received: by mail-pj1-f65.google.com with SMTP id q24so4166678pjd.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 08 May 2020 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yYfioAcTDcx67ZCUByDfU2JLdR9CVckvTAFBAqOEES4=;
 b=FZvymGrTa1MERX8fJzzhbAkYE+IPKvxZl1qgOugT6SIdL/7NSn66LXKQjg1/YLrSVH
 PnYeb3SJ4qv2TwxiN0NMtQ7zGaVopx0MUwF92t+yNiDkZ4Ubui/GOZgZ2WJedPyLi8Ze
 Z+ztT8INw0ZkM24bOlJ8f3hO0Rl9ZOcV1h8YbltipLr5Sx79UhRFt4gms/bgNlFGOaTE
 VHd/qWC9+JlnUG6pko6hm2scb49kfSnR3UKhtucHkHBlIOHrMJFumwPh0Ew0QE/+ZEam
 XHcbUej18Jtkg5z6DzKa4VePdfsztbuzfzjBp7jah1qzu4ShFKAjjVRWbABxaZpvDE+t
 eUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yYfioAcTDcx67ZCUByDfU2JLdR9CVckvTAFBAqOEES4=;
 b=Ok8Y1H0ODrPP3nVYOkNdd22eD5JoAjlDIfoISSbLqmrPKWmkatfPrWUw5tOLr2KrQ1
 T1inYXccxnFyrSvmZclmeaQ2D2ezgBWOPZ7vOG7fDAbfnxCpMTBzTWVgInSlvNESj8hv
 Hj+T4aqoD3Ecmc57bmCr+u4wC0QbrijIhglgvw3OiqOPnAwoD5YH7A6iBARaTQRH1TEt
 J1J/kvcIEind7MhW3YzSVvstDc83N8A3Qo8wRnsuU/hf9zCMZs5cxyRL3L1Ov3EE9ejk
 //lxijYBWDJRMpopoJc0RJwwpvH3Jjk28JdZjgQAW17JyllFKAI57ZMTT4ZJCUxiUxtA
 OHMw==
X-Gm-Message-State: AGi0PuZAFrd2EIllvZ9OuIMZQezMyh7ljYxAzipOwyFtSND3FKZSr2ad
 CWLq8h9QzNcoSQO+hciY4NY=
X-Google-Smtp-Source: APiQypIBhmzbOA/Y5+MC/kJ+MFVHxiNTB4xlQrDB1LjemeFQGwmG90YJfedpFpyLKSnfIEOWWxmQTA==
X-Received: by 2002:a17:902:9a81:: with SMTP id
 w1mr2043242plp.289.1588939018869; 
 Fri, 08 May 2020 04:56:58 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
 by smtp.gmail.com with ESMTPSA id ft14sm2317226pjb.46.2020.05.08.04.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 04:56:58 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, jaegeuk@kernel.org, yuchao0@huawei.com
Date: Fri,  8 May 2020 20:56:52 +0900
Message-Id: <20200508115652.226158-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
X-Headers-End: 1jX1cu-00CT3A-1s
Subject: [f2fs-dev] [PATCH] f2fs: remove race condition in releasing cblocks
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Now, if writing pages and releasing compress blocks occur
simultaneously, and releasing cblocks is executed more than one time
to a file, then total block count of filesystem and block count of the
file could be incorrect and damaged.

We have to execute releasing compress blocks only one time for a file
without being interfered by writepages path.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4aab4b42d8ba..f7de2a1da528 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	pgoff_t page_idx = 0, last_idx;
 	unsigned int released_blocks = 0;
 	int ret;
+	int writecount;
 
 	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
@@ -3502,20 +3503,33 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	if (!F2FS_I(inode)->i_compr_blocks)
-		goto out;
-
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
 
 	inode_lock(inode);
 
-	if (!IS_IMMUTABLE(inode)) {
-		F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
-		f2fs_set_inode_flags(inode);
-		inode->i_ctime = current_time(inode);
-		f2fs_mark_inode_dirty_sync(inode, true);
+	writecount = atomic_read(&inode->i_writecount);
+	if ((filp->f_mode & FMODE_WRITE && writecount != 1) || writecount) {
+		ret = -EBUSY;
+		goto out;
 	}
 
+	if (IS_IMMUTABLE(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
+	if (ret)
+		goto out;
+
+	if (!F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
+	F2FS_I(inode)->i_flags |= F2FS_IMMUTABLE_FL;
+	f2fs_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
+
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	down_write(&F2FS_I(inode)->i_mmap_sem);
 
@@ -3554,9 +3568,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	up_write(&F2FS_I(inode)->i_mmap_sem);
-
-	inode_unlock(inode);
 out:
+	inode_unlock(inode);
+
 	mnt_drop_write_file(filp);
 
 	if (ret >= 0) {
-- 
2.26.2.645.ge9eca65c58-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
