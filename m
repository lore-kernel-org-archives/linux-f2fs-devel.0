Return-Path: <SRS0=5JGq=JC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8995BC433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Apr 2021 08:41:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454B26138A;
	Mon,  5 Apr 2021 08:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454B26138A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lTKnM-0006rN-IQ; Mon, 05 Apr 2021 08:41:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1lTKnK-0006qy-M4
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Apr 2021 08:41:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gvnAkCRTM74HgZWRukEb8+gZs2QXzxJSIO816c26p/o=; b=lyidpNyN2dEY9OB5at3miWLSi6
 0Si6R+WIIddRfNgXUf1OZr+1CyNQmcWvVKoFdDjQpMw9+QnTvGvUMhcpKAOj8qWqA1z0QexR1lWrS
 2ezYEhI1c1cwQSWa2fRnSVp5+BiHwDSAh/OI+U5L6zVPXA9mO1juwhqUkHCHnnb+4uZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gvnAkCRTM74HgZWRukEb8+gZs2QXzxJSIO816c26p/o=; b=E
 7nzF5E3VKW8QzGlGdYeqAVn05+CFc8HHJa7EMWZCB6WcDcEmuPnc710RMWKGHWSOGwQh/doPW3Vp7
 iaqYNYfp38J56ZxZGGBs8uS2V/rwOeyr/jJq9rU8AR78/C3Jr6snY+/spbrHt/2/pW4vJf03z8fHR
 Yd8SYKCCr7STX2L4=;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1lTKnG-003djr-P5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Apr 2021 08:41:14 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 kk2-20020a17090b4a02b02900c777aa746fso5496928pjb.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Apr 2021 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gvnAkCRTM74HgZWRukEb8+gZs2QXzxJSIO816c26p/o=;
 b=lDPkaumQ87DCyIgphQDTDfFS5lcgc7IHoeKcAGelg0SDjrqnK9j68wcFJ6tl93L3Qj
 9YLk6SiS42HOhhsvlZUZD41jtnd9Ej5bl2EYKg8sXnINfZlNiF836bdnDfqvIQnq5vJU
 yDNCEFb314vgWCYRwJqXOuCbcmtePwAUWbEFDNkLon60elWAPRhDy/5Y5I1fm2a3b02r
 Y6fVjUP5Z3hMmQHx4M/xWI8jRE4lxCam64xk7JUMG5x/6rn5DNMzMypVpU10Wuv+ypt/
 N0PmTzHUtPzwlTeq+NuM2kLFHHyoLPNn8DwaWxDUqH5EU6P4MjwrkPZ0a6lcIamYJRrS
 cRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gvnAkCRTM74HgZWRukEb8+gZs2QXzxJSIO816c26p/o=;
 b=kVzofBaam4M7sSrbthi/JTDQD5N0ib1/ZOZgUkfUVLM7cSha962Gow1uz9+59xcgi0
 rqOOLZ4UUR90JZqNECMafDL+KBLqIfmYVxMuWaYmCj9JYxcrsH+BHiFKHTYFEqTH0Ldk
 zWdppSZ2NS1HdQOgHMOSCiYBqtgNaoZf8naYYmmQX59Q3vSbFImrCrxvDPdXh9EMT6Df
 sUUmJGIgtlj93wkR7mg4oWX36VwmIxkD8lmjRC4qFcbMvgHfN4loVo54Ex2j+9QeJK49
 OH0dm8C5NAO2qYs600+peRfuWPM/r3kE9gzLIBm6iOCOYYa9tOwf9PDaOAc3V7bm4Zc6
 fXfA==
X-Gm-Message-State: AOAM5323gIj+PTaOT0jj4XtNfoKv5RTN5I77cpvEZ6TQY8/bvASS/AkS
 bSFxLkmN3ZF4Sm5CI+FaeePvZRTTf/+ejg==
X-Google-Smtp-Source: ABdhPJy+PSD/H08mQHkFgEkSq+erU32iV1ljFcKg2Afkzn7ox31fBclm62SYEcR4xprHaHYpvfmqKQ==
X-Received: by 2002:a17:90a:7896:: with SMTP id
 x22mr814991pjk.182.1617612064869; 
 Mon, 05 Apr 2021 01:41:04 -0700 (PDT)
Received: from localhost.localdomain ([114.71.101.153])
 by smtp.gmail.com with ESMTPSA id j3sm13665321pfc.49.2021.04.05.01.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Apr 2021 01:41:04 -0700 (PDT)
From: Park Ju Hyung <qkrwngud825@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  5 Apr 2021 17:40:56 +0900
Message-Id: <20210405084056.63423-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Headers-End: 1lTKnG-003djr-P5
Subject: [f2fs-dev] [PATCH] f2fs: prevent mounting devices with unsupported
 features
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Mounting f2fs devices with future options leads to unwanted behaviors
incurring errors and data destruction.

Implement a long overdue safeguard to prevent mounting devices with
unsupported features.

This can be further extended to allow read-only mounts on certain
incompatible features, but that doesn't seem necessary for now with
how f2fs features has been added.

Cc: stable@vger.kernel.org
Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/f2fs.h  | 11 +++++++++++
 fs/f2fs/super.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e2d302ae3a46..12d274492d6f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -153,6 +153,9 @@ struct f2fs_mount_info {
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 };
 
+/*
+ * All features listed here should be appended to F2FS_SUPPORTED_FEATURES
+ */
 #define F2FS_FEATURE_ENCRYPT		0x0001
 #define F2FS_FEATURE_BLKZONED		0x0002
 #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
@@ -168,6 +171,14 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_CASEFOLD		0x1000
 #define F2FS_FEATURE_COMPRESSION	0x2000
 
+/* Currently supported features by this version of f2fs */
+#define F2FS_SUPPORTED_FEATURES \
+	(F2FS_FEATURE_ENCRYPT | F2FS_FEATURE_BLKZONED | F2FS_FEATURE_ATOMIC_WRITE | \
+	 F2FS_FEATURE_EXTRA_ATTR | F2FS_FEATURE_PRJQUOTA | F2FS_FEATURE_INODE_CHKSUM | \
+	 F2FS_FEATURE_FLEXIBLE_INLINE_XATTR | F2FS_FEATURE_QUOTA_INO | F2FS_FEATURE_INODE_CRTIME | \
+	 F2FS_FEATURE_LOST_FOUND | F2FS_FEATURE_VERITY | F2FS_FEATURE_SB_CHKSUM | \
+	 F2FS_FEATURE_CASEFOLD | F2FS_FEATURE_COMPRESSION)
+
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
 #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 82592b19b4e0..91d77985cf9b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3610,6 +3610,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	int recovery, i, valid_super_block;
 	struct curseg_info *seg_i;
 	int retry_cnt = 1;
+	__le32 unsupported;
 
 try_onemore:
 	err = -EINVAL;
@@ -3647,6 +3648,15 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
+	/* check supported features */
+	unsupported = raw_super->feature & ~F2FS_SUPPORTED_FEATURES;
+	if (unsupported) {
+		f2fs_err(sbi, "unsupported features: 0x%x\n", unsupported);
+		f2fs_err(sbi, "please update your kernel or adjust the mkfs.f2fs option\n", unsupported);
+		err = -EOPNOTSUPP;
+		goto free_sb_buf;
+	}
+
 	/* precompute checksum seed for metadata */
 	if (f2fs_sb_has_inode_chksum(sbi))
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
-- 
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
