Return-Path: <SRS0=ovVE=EX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A19C56202
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2020 04:02:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4771B2468E;
	Tue, 17 Nov 2020 04:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X5fk+7UI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SGaFjJWU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkYxsh8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4771B2468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kesCk-0001hE-U5; Tue, 17 Nov 2020 04:02:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kesCf-0001gv-U3
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Nov 2020 04:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9fAZjYye7Ph2bsjAjt7cw819rQ1H4j6CmEpWwvi6edo=; b=X5fk+7UIb+blBN9a1c6K9oLiG+
 tlKB9frIPFqJdlQDOwge/rbmixAKH0xdX1AWS7S4okBnxfG8Ac9cYdYo8+J9dZV9Zh3TrnLv6ae3W
 GDPX9LW19/K0Z167nEDCdU9xfQ2PkijUjqRcgMbYsCl1MtqlcAatxnbi0aOSIy7naFr0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9fAZjYye7Ph2bsjAjt7cw819rQ1H4j6CmEpWwvi6edo=; b=SGaFjJWU9nCMBglAlg+fZ5qtzx
 Z/KeSiT+Cpp616WlJvXPWZHjLLlsq5uWu2U1jniylkZjKQ2ySRK/K+arue1SwBnrm7DuPj/oFFUiM
 kf1AVebYVdbpsTANWf4H8fBLDv9qj138WQ9QtThUYD6dx79DTqtm8etk/Azij/X9dUAk=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kesCa-00GiIp-Ad
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Nov 2020 04:02:49 +0000
Received: by mail-pl1-f195.google.com with SMTP id j5so9514305plk.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2020 20:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9fAZjYye7Ph2bsjAjt7cw819rQ1H4j6CmEpWwvi6edo=;
 b=BkYxsh8oPcF7huMQeaScZLSq6GL99iLWObrUwPq1rQDulUWYXfJn9BMm5FCAP2c8Zj
 NE20R6i5r3p5enGsPJFDLjDwJ9R2aPzsIGSPGF4prdMf9Q2GfYt9GjzNdeLwmC/sYkgV
 +xf8P7HmPRjJ0j7Ya4RzKDuVwnw77Si26YUPH1YWz2znUatOnk5ippJlEoIS3324RscE
 /b+BLQDzo7rImzR8t8h8yeyJvHK16XprLKo8t/QhGd2UT16f6GFmuoerRNxuid9e6gsK
 IgLeMdhNtXbwVGJeyyFTD4gETr2S+/zdEWl05JVpq37rBpKQ2ODg98JR6Dz3inscDqlL
 1p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9fAZjYye7Ph2bsjAjt7cw819rQ1H4j6CmEpWwvi6edo=;
 b=K6P1n2H+tZShSBSwc3+uFmtS0psYJncrVbxlASm0yo8ujG70igY/r+gPWP4lV46ayu
 3/c1kGmOVFUpC79luHIc8VXoKXPzjXB0PBIWdk/p0Xopm70aVjEP3cYFz9NKVP9Otl9W
 HJhLOG8GbReUoyClUW0ShMo0kLaiyttdqwuzPL25SsLSKRTYui9F1JYwVO4PHx/4MVVm
 QsillfC3pfdwSY+I0oDK5NC48s0kMyn3o5Ges2/F0UFOwRkXgniUblPMpVigNeNwL73B
 rL8TWI9jLs4n1XgLwdryBheTQn3f9C4h09aw0F+ZviqQOuJ5wHtM7s/Sik9zadr/UhRw
 8vEQ==
X-Gm-Message-State: AOAM532iMJkAiGirP5ORGg2eLzpQ3eYise7TW6bFbDr/alh7idSe93Rm
 /h/fZsPv2G1SRFcz7Kjb1QzutHxR7Po=
X-Google-Smtp-Source: ABdhPJzZufSYkiKvNIznu1DSwrvLbnx+CBFfUj4SXJSaGlG2bn4iy6c8nRRMV9Zx/bNKobMi3Oxw7w==
X-Received: by 2002:a17:902:684b:b029:d6:e482:9fee with SMTP id
 f11-20020a170902684bb02900d6e4829feemr15863990pln.10.1605585758781; 
 Mon, 16 Nov 2020 20:02:38 -0800 (PST)
Received: from daehojeong1.seo.corp.google.com ([100.102.127.132])
 by smtp.gmail.com with ESMTPSA id s18sm20388518pfc.5.2020.11.16.20.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 20:02:38 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 17 Nov 2020 13:02:23 +0900
Message-Id: <20201117040223.858979-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117040223.858979-1-daeho43@gmail.com>
References: <20201117040223.858979-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kesCa-00GiIp-Ad
Subject: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
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
enabled file in disable_auto_compr mount option.

Using these two ioctls, the users can make a control of compression
and decompression of their files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h |  10 ++-
 fs/f2fs/file.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c473c78699bc..0dd3be63ac66 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -436,6 +436,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 						struct f2fs_sectrim_range)
 #define F2FS_IOC_GET_COMPRESS_OPTION	_IOR(F2FS_IOCTL_MAGIC, 21,	\
 						struct f2fs_comp_option)
+#define F2FS_IOC_DECOMPRESS_FILE	_IO(F2FS_IOCTL_MAGIC, 23)
+#define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -762,6 +764,8 @@ enum {
 	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
+	FI_FORCE_UNCOMPRESS,	/* indicate forcing to disable file compression */
+	FI_FORCE_COMPRESS,	/* indicate forcing file compression */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -2841,7 +2845,11 @@ static inline int f2fs_compressed_file(struct inode *inode)
 
 static inline int f2fs_need_compress_write(struct inode *inode)
 {
-	if (test_opt(F2FS_I_SB(inode), DISABLE_AUTO_COMPR))
+	if (is_inode_flag_set(inode, FI_FORCE_UNCOMPRESS))
+		return 0;
+	else if (is_inode_flag_set(inode, FI_FORCE_COMPRESS))
+		return 1;
+	else if (test_opt(F2FS_I_SB(inode), DISABLE_AUTO_COMPR))
 		return 0;
 	return f2fs_compressed_file(inode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index bd52df84219d..1e7ff96d7c6e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3963,6 +3963,182 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 	return 0;
 }
 
+static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+	pgoff_t redirty_idx = page_idx;
+	int i, page_len = 0, ret = 0;
+
+	page_cache_readahead_unbounded(mapping, NULL, page_idx, len, 0);
+
+	for (i = 0; i < len; i++, page_idx++) {
+		page = read_cache_page(mapping, page_idx, NULL, NULL);
+		if (IS_ERR(page)) {
+			ret = PTR_ERR(page);
+			f2fs_warn(sbi, "%s: inode (%lu) : page_index (%lu) "
+				"couldn't be read (errno:%d).\n",
+				__func__, inode->i_ino, page_idx, ret);
+			break;
+		}
+		page_len++;
+	}
+
+	for (i = 0; i < page_len; i++, redirty_idx++) {
+		page = find_lock_page(mapping, redirty_idx);
+		if (!page) {
+			ret = -ENOENT;
+			f2fs_warn(sbi, "%s: inode (%lu) : page_index (%lu) "
+				"couldn't be found (errno:%d).\n",
+				__func__, inode->i_ino, redirty_idx, ret);
+		}
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
+	pgoff_t page_idx = 0, last_idx;
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, ret;
+
+	if (!f2fs_sb_has_compression(sbi))
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
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
+	if (!F2FS_I(inode)->i_compr_blocks)
+		goto out;
+
+	set_inode_flag(inode, FI_FORCE_UNCOMPRESS);
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	count = last_idx - page_idx;
+	while (count) {
+		int len = min(cluster_size, count);
+
+		ret = redirty_blocks(inode, page_idx, len);
+
+		if (ret < 0)
+			break;
+
+		page_idx += len;
+		count -= len;
+	}
+
+	if (!ret)
+		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+							LLONG_MAX);
+
+	clear_inode_flag(inode, FI_FORCE_UNCOMPRESS);
+
+	if (!ret) {
+		stat_sub_compr_blocks(inode, F2FS_I(inode)->i_compr_blocks);
+		F2FS_I(inode)->i_compr_blocks = 0;
+		f2fs_mark_inode_dirty_sync(inode, true);
+	} else {
+		f2fs_warn(sbi, "%s: The file might be partially decompressed "
+				"(errno=%d). Please delete the file.\n",
+				__func__, ret);
+	}
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
+	int cluster_size = F2FS_I(inode)->i_cluster_size;
+	int count, ret;
+
+	if (!f2fs_sb_has_compression(sbi))
+		return -EOPNOTSUPP;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (!f2fs_compressed_file(inode))
+		return -EINVAL;
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
+	set_inode_flag(inode, FI_FORCE_COMPRESS);
+
+	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+
+	count = last_idx - page_idx;
+	while (count) {
+		int len = min(cluster_size, count);
+
+		ret = redirty_blocks(inode, page_idx, len);
+
+		if (ret < 0)
+			break;
+
+		page_idx += len;
+		count -= len;
+	}
+
+	if (!ret)
+		ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+							LLONG_MAX);
+
+	clear_inode_flag(inode, FI_FORCE_COMPRESS);
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
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -4053,6 +4229,10 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_sec_trim_file(filp, arg);
 	case F2FS_IOC_GET_COMPRESS_OPTION:
 		return f2fs_ioc_get_compress_option(filp, arg);
+	case F2FS_IOC_DECOMPRESS_FILE:
+		return f2fs_ioc_decompress_file(filp, arg);
+	case F2FS_IOC_COMPRESS_FILE:
+		return f2fs_ioc_compress_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4224,6 +4404,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 	case F2FS_IOC_SEC_TRIM_FILE:
 	case F2FS_IOC_GET_COMPRESS_OPTION:
+	case F2FS_IOC_DECOMPRESS_FILE:
+	case F2FS_IOC_COMPRESS_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.29.2.299.gdc1121823c-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
