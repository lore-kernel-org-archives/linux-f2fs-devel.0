Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387CEC433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:52:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B0D20734;
	Thu, 18 Jun 2020 12:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="P+PiMluo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Pr/6Wh5H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLtp7mqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B0D20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jlu1a-0003na-LN; Thu, 18 Jun 2020 12:52:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1jlu1Z-0003nM-AC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 12:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CUwPsjBZ0Y6RYhhJECu3dA7XcS6hBp4lJzkJd2Rawh4=; b=P+PiMluo30vZTpNOsDnw8mFzYB
 CZNFqTEqEivhAgrkXtv0NkBGDjYu5JlvfwYuRGqRwOEOadEE/euvdyn57A383hYGIg7mu0K05qNXm
 4d10NTCCqCffFHWZlQkocEqS+tEzKTxesIT0GbysQ8OBAVdxK6HZ9lvecBxVw+WmUjLE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CUwPsjBZ0Y6RYhhJECu3dA7XcS6hBp4lJzkJd2Rawh4=; b=P
 r/6Wh5HMZVAhexeX1G3UL+ga2snqwWLohrBLer2qciQ12a6uVIZ62WfmmvAfF5n6EB6RG6Y3f11ap
 JYB5LEdIlPegbkBeArskGFmL/yUMKD9/hb9kTh2hrj6UKDERuggSnUNGfpcDupVvYBMOCnDK19Wod
 EfNGvofB3nGES/gc=;
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jlu1Y-00AdxO-0F
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 12:52:09 +0000
Received: by mail-pg1-f195.google.com with SMTP id u128so2855302pgu.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2020 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CUwPsjBZ0Y6RYhhJECu3dA7XcS6hBp4lJzkJd2Rawh4=;
 b=vLtp7mqbtO8BRs7ABDVJGV/NZ8iMxV9IswHlF/sFIAT2zNejnRm3FuIxAxltbzEmR6
 2s/CrJMSvxbFlOcWCiOiiitE+lObTcwcUCJ9M8x6lUFOqrhYyphJB3lPjyVqAbbnlMyD
 0s3Ro+IWw0MmrnNtIy7bKxGR0nWZHif7smTMWyb7nSUCLhuhleLInR00SiAmuuuJDCkH
 hyZ71ufi4WNVM7JWuHH4JAEDUIdds8nV1Q9+E3ZffRO1aOmH5O6Wruc5C3xl8/HeFrW5
 T9/O4s8CLvb3gSHaB1+rhMTVrKc2tV9sm4CyKIByUQpF8I+fvM1Z2JWNiIsNM1HQHVmi
 4xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CUwPsjBZ0Y6RYhhJECu3dA7XcS6hBp4lJzkJd2Rawh4=;
 b=OPK1NJY37qe/7BZVrJwBLNNQQpDDNUlmFOLdjTymJ3iySdbCoTFtBzrJ677uduS+R8
 7Gk/ZkLTfIzxtOPyC8n8dWxHo8z9ezCQg0C51sj6TcX1Bm/IvbKVPzaFoP5vA47BKCip
 X/5ORQ7MlX8M2E+JrRAYohJMx85LNL7PHkKVRIKjhZNDCO5zLgrrryNDuQSxUhCk7KzN
 mUUywTIGrTeXP2XCAy6NZlMlQw4PuJD8R6ADPL7fpyd+Ny5aIp3CgSC0jB8SG3DNMdTa
 A20Kvx+2elZWw38Q7SYIFtghes/pz+Ny2XXAoQasa80A2HT/0AWYlISl3tqVFluoC4jC
 PLPg==
X-Gm-Message-State: AOAM5321gk3wY4I33nGTn+rJJpKUA2cG/o/t638gU5HX6D4DEQz8hBKZ
 tZ2y+Ppl13Ct/TplfGSUfnU=
X-Google-Smtp-Source: ABdhPJw0wFs3zsG0Qckyygwka0IjqeAfcLnc5+f6LJAKWhIN4YeGLNtZRhthuheCEvHVwsn93+9wpw==
X-Received: by 2002:aa7:8a4c:: with SMTP id n12mr3472270pfa.326.1592484721658; 
 Thu, 18 Jun 2020 05:52:01 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
 by smtp.gmail.com with ESMTPSA id i20sm3029575pfd.81.2020.06.18.05.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:52:01 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 18 Jun 2020 21:51:52 +0900
Message-Id: <20200618125152.84099-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
X-Headers-End: 1jlu1Y-00AdxO-0F
Subject: [f2fs-dev] [PATCH v4] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
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

Added a new ioctl to send discard commands or/and zero out
to selected data area of a regular file for security reason.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  15 +++++
 fs/f2fs/file.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c812fb8e2d9c..3763d9e03ca8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -434,6 +434,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 					_IOR(F2FS_IOCTL_MAGIC, 18, __u64)
 #define F2FS_IOC_RESERVE_COMPRESS_BLOCKS				\
 					_IOR(F2FS_IOCTL_MAGIC, 19, __u64)
+#define F2FS_IOC_SEC_TRIM_FILE		_IOW(F2FS_IOCTL_MAGIC, 20,	\
+						struct f2fs_sectrim_range)
 
 #define F2FS_IOC_GET_VOLUME_NAME	FS_IOC_GETFSLABEL
 #define F2FS_IOC_SET_VOLUME_NAME	FS_IOC_SETFSLABEL
@@ -453,6 +455,13 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 #define F2FS_GOING_DOWN_METAFLUSH	0x3	/* going down with meta flush */
 #define F2FS_GOING_DOWN_NEED_FSCK	0x4	/* going down to trigger fsck */
 
+/*
+ * Flags used by F2FS_IOC_SEC_TRIM_FILE
+ */
+#define F2FS_TRIM_FILE_DISCARD		0x1	/* send discard command */
+#define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
+#define F2FS_TRIM_FILE_MASK		0x3
+
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
 /*
  * ioctl commands in 32 bit emulation
@@ -488,6 +497,12 @@ struct f2fs_flush_device {
 	u32 segments;		/* # of segments to flush */
 };
 
+struct f2fs_sectrim_range {
+	u64 start;
+	u64 len;
+	u64 flags;
+};
+
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
 static inline int get_extra_isize(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index dfa1ac2d751a..ef7ea4fcfa61 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/uuid.h>
 #include <linux/file.h>
 #include <linux/nls.h>
+#include <linux/sched/signal.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -3749,6 +3750,181 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_secure_erase(struct block_device *bdev, block_t block,
+					block_t len, u32 flags)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	sector_t sector = SECTOR_FROM_BLOCK(block);
+	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
+	int ret = 0;
+
+	if (!q)
+		return -ENXIO;
+
+	if (flags & F2FS_TRIM_FILE_DISCARD)
+		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
+						blk_queue_secure_erase(q) ?
+						BLKDEV_DISCARD_SECURE : 0);
+
+	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT))
+		ret = blkdev_issue_zeroout(bdev, sector, nr_sects, GFP_NOFS, 0);
+
+	return ret;
+}
+
+static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	struct block_device *prev_bdev = NULL;
+	struct f2fs_sectrim_range range;
+	pgoff_t index, pg_end;
+	block_t prev_block = 0, len = 0;
+	u64 end_addr;
+	bool to_end;
+	int ret = 0;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&range, (struct f2fs_sectrim_range __user *)arg,
+				sizeof(range)))
+		return -EFAULT;
+
+	if (range.flags == 0 || (range.flags & ~F2FS_TRIM_FILE_MASK) ||
+			!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((range.flags & F2FS_TRIM_FILE_DISCARD) &&
+			!f2fs_hw_support_discard(sbi))
+		return -EOPNOTSUPP;
+
+	file_start_write(filp);
+	inode_lock(inode);
+
+	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (inode->i_size == 0)
+		goto err;
+
+	end_addr = range.start + range.len;
+	if (end_addr > inode->i_size) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	to_end = (end_addr == inode->i_size);
+	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
+			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	index = F2FS_BYTES_TO_BLK(range.start);
+	pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);
+
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		goto err;
+
+	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	down_write(&F2FS_I(inode)->i_mmap_sem);
+
+	ret = filemap_write_and_wait_range(mapping, range.start, end_addr - 1);
+	if (ret)
+		goto out;
+
+	truncate_inode_pages_range(mapping, range.start,
+			to_end ? -1 : end_addr - 1);
+
+	while (index < pg_end) {
+		struct dnode_of_data dn;
+		pgoff_t end_offset, count;
+		int i;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		if (ret) {
+			if (ret == -ENOENT) {
+				index = f2fs_get_next_page_offset(&dn, index);
+				continue;
+			}
+			goto out;
+		}
+
+		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
+		count = min(end_offset - dn.ofs_in_node, pg_end - index);
+		for (i = 0; i < count; i++, dn.ofs_in_node++) {
+			struct block_device *cur_bdev;
+			block_t blkaddr = f2fs_data_blkaddr(&dn);
+
+			if (!__is_valid_data_blkaddr(blkaddr))
+				continue;
+
+			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
+						DATA_GENERIC_ENHANCE)) {
+				ret = -EFSCORRUPTED;
+				f2fs_put_dnode(&dn);
+				goto out;
+			}
+
+			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
+			if (f2fs_is_multi_device(sbi)) {
+				int di = f2fs_target_device_index(sbi, blkaddr);
+
+				blkaddr -= FDEV(di).start_blk;
+			}
+
+			if (len) {
+				if (prev_bdev == cur_bdev &&
+					blkaddr == prev_block + len) {
+					len++;
+				} else {
+					ret = f2fs_secure_erase(prev_bdev,
+						prev_block, len, range.flags);
+					if (ret) {
+						f2fs_put_dnode(&dn);
+						goto out;
+					}
+
+					len = 0;
+				}
+			}
+
+			if (!len) {
+				prev_bdev = cur_bdev;
+				prev_block = blkaddr;
+				len = 1;
+			}
+		}
+
+		f2fs_put_dnode(&dn);
+		index += count;
+
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
+		cond_resched();
+	}
+
+	if (len)
+		ret = f2fs_secure_erase(prev_bdev, prev_block, len,
+				range.flags);
+out:
+	up_write(&F2FS_I(inode)->i_mmap_sem);
+	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+err:
+	inode_unlock(inode);
+	file_end_write(filp);
+
+	return ret;
+}
+
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
@@ -3835,6 +4011,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_release_compress_blocks(filp, arg);
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
 		return f2fs_reserve_compress_blocks(filp, arg);
+	case F2FS_IOC_SEC_TRIM_FILE:
+		return f2fs_sec_trim_file(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -4004,6 +4182,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GET_COMPRESS_BLOCKS:
 	case F2FS_IOC_RELEASE_COMPRESS_BLOCKS:
 	case F2FS_IOC_RESERVE_COMPRESS_BLOCKS:
+	case F2FS_IOC_SEC_TRIM_FILE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.27.0.290.gba653c62da-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
