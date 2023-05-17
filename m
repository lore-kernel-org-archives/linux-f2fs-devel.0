Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CFC77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 09:43:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzDgo-0004u9-77;
	Wed, 17 May 2023 09:43:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pzDgm-0004u3-2v
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 09:43:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wrd3rnjogE4z5YskSPD4B2j266sZkgmZzC6MGwtZYdo=; b=HVN5eqK+72tKtTITR1pEbb2WeT
 9y3NU7/MZOjvBPSVLxrThY8gc+YIeQk0axokYTb03ZxIPOpeYn3UHPX39hQeHyn0QXIOhROqmY3y6
 VJSTUN/k7yswRcZbBKQ0m+3ICTLR6TIY3v5sR+6+j4qulK5yPmlMMYHU2GQXU1YreV3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Wrd3rnjogE4z5YskSPD4B2j266sZkgmZzC6MGwtZYdo=; b=HWjg5RzUOah8/XE/F4GchiIDs1
 f/1S25yTtJYWg7vuX5qOAnmXWVuDm0y78pZD9fzy0egxmbYxLgZXL/6nSWAPWApAPtn7WP0t7tu3J
 /xeHAQRyVrGt3yf3Fas7JAdKtFwD6Jw/G4EneDOcGAaVQd9hwcI+TkwyrKaJxJWD23IU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzDgl-00AvDD-9y for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 09:43:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E7E4C64495
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 May 2023 09:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C68C4339E;
 Wed, 17 May 2023 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684316593;
 bh=NO+AbaDYG5micS/+RgkrizmeaZsrsZUua0A4BGzvgC8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V94AZLKo/ELXGH07H2m+B7Oghu8UwtDrEKGx8ZIIlBgFEOZIhAy2e4q7FzXOlDBTT
 ggqG8bgkOp53Bg/VcSGYeVAkj5g585ZUhDtzfNJMaY2Qx29hJEXobDimsa17npqSeU
 asobe+cbbCHg06C9HDqqIh6CUgK9EoDEDR+VJJlCjlVbwDwlvphKu7T0oAv5XWIif0
 j4M9cNJt0GA1PS2l8nZ3f3skNQrcPy7xXp7Ya7If/H82DaP+qVCLmvk15LxdOlFBXn
 1pPYa1u5atr859EbrG8wPdHtBWFvW/PhrdZKU8mMVMseJIfa27Ds6cOhTf6QRHIcof
 TIl2n+GOBd4Yg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 17 May 2023 17:42:50 +0800
Message-Id: <20230517094250.1407910-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517094250.1407910-1-chao@kernel.org>
References: <20230517094250.1407910-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pzDgl-00AvDD-9y
Subject: [f2fs-dev] [PATCH 2/2] f2fs: renew value of F2FS_FEATURE_*
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Define F2FS_FEATURE_* macro w/ 32-bits value rather than 16-bits value.

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6719cf1c5596..8d4eaf4d2246 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -186,21 +186,21 @@ struct f2fs_mount_info {
 	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
 };
 
-#define F2FS_FEATURE_ENCRYPT		0x0001
-#define F2FS_FEATURE_BLKZONED		0x0002
-#define F2FS_FEATURE_ATOMIC_WRITE	0x0004
-#define F2FS_FEATURE_EXTRA_ATTR		0x0008
-#define F2FS_FEATURE_PRJQUOTA		0x0010
-#define F2FS_FEATURE_INODE_CHKSUM	0x0020
-#define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
-#define F2FS_FEATURE_QUOTA_INO		0x0080
-#define F2FS_FEATURE_INODE_CRTIME	0x0100
-#define F2FS_FEATURE_LOST_FOUND		0x0200
-#define F2FS_FEATURE_VERITY		0x0400
-#define F2FS_FEATURE_SB_CHKSUM		0x0800
-#define F2FS_FEATURE_CASEFOLD		0x1000
-#define F2FS_FEATURE_COMPRESSION	0x2000
-#define F2FS_FEATURE_RO			0x4000
+#define F2FS_FEATURE_ENCRYPT			0x00000001
+#define F2FS_FEATURE_BLKZONED			0x00000002
+#define F2FS_FEATURE_ATOMIC_WRITE		0x00000004
+#define F2FS_FEATURE_EXTRA_ATTR			0x00000008
+#define F2FS_FEATURE_PRJQUOTA			0x00000010
+#define F2FS_FEATURE_INODE_CHKSUM		0x00000020
+#define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x00000040
+#define F2FS_FEATURE_QUOTA_INO			0x00000080
+#define F2FS_FEATURE_INODE_CRTIME		0x00000100
+#define F2FS_FEATURE_LOST_FOUND			0x00000200
+#define F2FS_FEATURE_VERITY			0x00000400
+#define F2FS_FEATURE_SB_CHKSUM			0x00000800
+#define F2FS_FEATURE_CASEFOLD			0x00001000
+#define F2FS_FEATURE_COMPRESSION		0x00002000
+#define F2FS_FEATURE_RO				0x00004000
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
