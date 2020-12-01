Return-Path: <SRS0=qLlU=FF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0243C64E8A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Dec 2020 04:08:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0410120663;
	Tue,  1 Dec 2020 04:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZG9YoY0y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JSBrEvhW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6qJdLZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0410120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kjwxs-00030j-5Z; Tue, 01 Dec 2020 04:08:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kjwxp-00030b-VV
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 Dec 2020 04:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jE3125qtgCcvfVOdGXVIuHLlo/pTilZkAQEoLFhiTKM=; b=ZG9YoY0yIubL8yqRkeE4lq0A6V
 DX2pjqtjNxZmmJwktlwrq3V/H35f4bcL2C9xEinpi62Zt1YR2LZfpTvG4hVMs+1Y+IWSWzWDesIlu
 hXf18ueDaWFUYnOtSdnzdKyPTrj1NfOKiKujgrfGikgjyi+LKvKdaODzBMzqbm+w0yls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jE3125qtgCcvfVOdGXVIuHLlo/pTilZkAQEoLFhiTKM=; b=JSBrEvhWwWxf0Hh1MTogJLgXa4
 HBdZxwD25erbYF4qO9xezuUyGw5aek6n/UvKFOJQ3HagW3UhAcKtT+/RXRG19ffF8EuL3xhxyndnY
 DGQ+sZzwvv8rw81CDE/3POK38ZifukszfwTM8aMPRVi359A5u0I1ntfiHlb1H/s1+tIY=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kjwxh-008MpT-M5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 Dec 2020 04:08:29 +0000
Received: by mail-pl1-f195.google.com with SMTP id t18so407973plo.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 30 Nov 2020 20:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jE3125qtgCcvfVOdGXVIuHLlo/pTilZkAQEoLFhiTKM=;
 b=N6qJdLZ4Dz+2EsFvQkQDmi1GrVzzyaeh39kULeLQNm0Ei1He+/0dtXTdfmpo+F2ukE
 NxSrUKHYWxOzT5o8NTbOs3zErwXo3/VlNSYe+yb1uFiMTHziMAJbNWRHZj439Om7h1Ur
 QBTB3Gy7IZsUNOAuwKDhWPYuVnaIlPYXGh9eebxRNElg1lSujDhl20kGyfmuI1+8ecAD
 JoGBmYwIzaqCAXSQJUQw8d8cp55HDSAmtSbGnv5TOSzrHLlVzEJnFctSFRrAmP+82kiL
 SHeN1904fSc471ZbI0xQBMp8XYSkxiHeuTFdDnrOxqrRnx7lzkrcN6xxxo1YKaugieJD
 XfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jE3125qtgCcvfVOdGXVIuHLlo/pTilZkAQEoLFhiTKM=;
 b=Jc8Bl3Rg+yJ05F/F72SBnwcmDt6wjpK4gSbYDu6vCEtMcRnCbIbCQevupAzCbSPHau
 qlhXr2mdblxvZjB8Lwm9jsFf+WJRls2AHfSmEmrNNjkAW6cgBTfHdjrVDt4+sG+bwisH
 WeEep/9pq021yPq7SbvkteS/PARvxtEx5M681IBXwVRK6Zg/9H9bhxtLGBpfdLi1TmxN
 rw7PEoq6/aVqoDOEf3CzhlVp/ZtCJ/hpkS6cuLnVjyu4ZvECWBC3UJQNl6UKjmV1k7om
 a+bN10qwMmOP4YTZ/rpXiqJMXVz8PXwFAw6oOgJXVWgG+7iQcRCHI0LOpoiZUfOebMHp
 EHuA==
X-Gm-Message-State: AOAM5308YZxehKyDg/HRtac/5hMrZmIdErC64aHPlRXYoWE0VK6BYRRU
 NPXFNwhRyt4Bv1YbDhN1HC4=
X-Google-Smtp-Source: ABdhPJxKsPkzn1jDGlos/QDoM/r+L2oOMBRZvvK8F5cwudmMgnRq6B3YvUitwJC4vKfeNpYPcpJl4w==
X-Received: by 2002:a17:90a:7c44:: with SMTP id
 e4mr786807pjl.138.1606795696138; 
 Mon, 30 Nov 2020 20:08:16 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:11:a6ae:11ff:fe18:6ce2])
 by smtp.gmail.com with ESMTPSA id e141sm606733pfh.13.2020.11.30.20.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 20:08:15 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  1 Dec 2020 13:08:03 +0900
Message-Id: <20201201040803.3590442-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201201040803.3590442-1-daeho43@gmail.com>
References: <20201201040803.3590442-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kjwxh-008MpT-M5
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
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

Added two ioctl to decompress/compress explicitly the compression
enabled file in "compress_mode=user" mount option.

Using these two ioctls, the users can make a control of compression
and decompression of their files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: reformed codes based on comments and put gradual flush routine
---
 fs/f2fs/file.c            | 185 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/f2fs.h |   2 +
 2 files changed, 187 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be8db06aca27..300355fe25f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4026,6 +4026,185 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
+{
+	DEFINE_READAHEAD(ractl, NULL, inode->i_mapping, page_idx);
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	pgoff_t redirty_idx = page_idx;
+	int i, page_len = 0, ret = 0;
+
+	page_cache_ra_unbounded(&ractl, len, 0);
+
+	for (i = 0; i < len; i++, page_idx++) {
+		page = read_cache_page(mapping, page_idx, NULL, NULL);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
+			break;
+		}
+		page_len++;
+	}
+
+	for (i = 0; i < page_len; i++, redirty_idx++) {
+		page = find_lock_page(mapping, redirty_idx);
+		if (!page)
+			ret = -ENOENT;
+		set_page_dirty(page);
+		f2fs_put_page(page, 1);
+		f2fs_put_page(page, 0);
+	}
+
+	return ret;
+}
+
+static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	pgoff_t page_idx = 0, last_idx;
+	unsigned int blk_per_seg = sbi->blocks_per_seg, dirtied = 0;
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, ret;
+
+	if (!f2fs_sb_has_compression(sbi) ||
+			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (!f2fs_is_compress_backend_ready(inode))
+		return -ENOPKG;
+
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_mmap_file(inode)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
+	if (ret)
+		goto out;
+
+	if (!atomic_read(&fi->i_compr_blocks))
+		goto out;
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	count = last_idx - page_idx;
+	while (count) {
+		int len = min(cluster_size, count);
+
+		ret = redirty_blocks(inode, page_idx, len);
+		if (ret < 0)
+			break;
+
+		count -= len;
+		page_idx += len;
+		dirtied += len;
+		if (dirtied >= blk_per_seg) {
+			filemap_fdatawrite(inode->i_mapping);
+			dirtied = 0;
+		}
+	}
+
+	if (!ret)
+		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+							LLONG_MAX);
+
+	if (ret)
+		f2fs_warn(sbi, "%s: The file might be partially decompressed "
+				"(errno=%d). Please delete the file.\n",
+				__func__, ret);
+out:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
+static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t page_idx = 0, last_idx;
+	unsigned int blk_per_seg = sbi->blocks_per_seg, dirtied = 0;
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, ret;
+
+	if (!f2fs_sb_has_compression(sbi) ||
+			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
+
+	if (!f2fs_is_compress_backend_ready(inode))
+		return -ENOPKG;
+
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_mmap_file(inode)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
+	if (ret)
+		goto out;
+
+	set_inode_flag(inode, FI_ENABLE_COMPRESS);
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	count = last_idx - page_idx;
+	while (count) {
+		int len = min(cluster_size, count);
+
+		ret = redirty_blocks(inode, page_idx, len);
+		if (ret < 0)
+			break;
+
+		count -= len;
+		page_idx += len;
+		dirtied += len;
+		if (dirtied >= blk_per_seg) {
+			filemap_fdatawrite(inode->i_mapping);
+			dirtied = 0;
+		}
+	}
+
+	if (!ret)
+		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+							LLONG_MAX);
+
+	clear_inode_flag(inode, FI_ENABLE_COMPRESS);
+
+	if (ret)
+		f2fs_warn(sbi, "%s: The file might be partially compressed "
+				"(errno=%d). Please delete the file.\n",
+				__func__, ret);
+out:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
 static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -4113,6 +4292,10 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_get_compress_option(filp, arg);
 	case F2FS_IOC_SET_COMPRESS_OPTION:
 		return f2fs_ioc_set_compress_option(filp, arg);
+	case F2FS_IOC_DECOMPRESS_FILE:
+		return f2fs_ioc_decompress_file(filp, arg);
+	case F2FS_IOC_COMPRESS_FILE:
+		return f2fs_ioc_compress_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4352,6 +4535,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_SEC_TRIM_FILE:
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 	case F2FS_IOC_SET_COMPRESS_OPTION:
+	case F2FS_IOC_DECOMPRESS_FILE:
+	case F2FS_IOC_COMPRESS_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index f00199a2e38b..352a822d4370 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -40,6 +40,8 @@
 						struct f2fs_comp_option)
 #define F2FS_IOC_SET_COMPRESS_OPTION	_IOW(F2FS_IOCTL_MAGIC, 22,	\
 						struct f2fs_comp_option)
+#define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
+#define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
-- 
2.29.2.454.gaff20da3a2-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
