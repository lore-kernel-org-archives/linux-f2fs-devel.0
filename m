Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB99C369B1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:48:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u4vdS-0003SL-9e;
	Wed, 16 Apr 2025 05:48:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u4vdR-0003SD-5T
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Apr 2025 05:48:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qz/N8jvL+Qa7sh1TnUkYSp7wkFrIaiRN511sKkeMAt4=; b=QPs69XPIqoZgTwMJYPM3uH+Fho
 ZCynysVAJ52gaAvo1xGtNblMsvKrOyY8iZnNMV8Q5IitDSPRRbF5VTtsaZv8i/wb4FKGDufIfIAt/
 ZH1Hubg913m/oE1pxE7dDppQWYtfWEdli0RV223ivcsKbV642EHyeNbvQJD08y5pnXK4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qz/N8jvL+Qa7sh1TnUkYSp7wkFrIaiRN511sKkeMAt4=; b=h
 TzqjDt4DiJBXS5V7KlB53cr3etxnIXoizvjlt30dGQXHd5eoUyt1HtM87EasdE5zmXoW0/IdXpt1b
 txrRJGzWhXEy9I/gxlsLVVKzIPN6fryMS/wAEYR+RhXtdl6bLPdWMF9uZo6JvTyXLE0wgnhwjfZtg
 5vw8487YcQyR7jbo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u4vdA-0006X3-OZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Apr 2025 05:48:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 60DB55C5998
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Apr 2025 05:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEBC4CEE2;
 Wed, 16 Apr 2025 05:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744782491;
 bh=UCyiDm2TjAms0gkzQqN29nR6SyF2kYY1rrXuh5bVPl4=;
 h=From:To:Cc:Subject:Date:From;
 b=rb6zamL73hlRkYjswss586a+WyYKWcZA+Al7696J2ed8vVoxj0/81ZZKv7ne4iG8S
 IMjjKc+voKz7sAHYEkI9fbvXRGSDHtIk/0FGUv1hzYaflh+gjN6sq1iWSFeUOLK+C3
 yT9otbXfui49oq5Gi5gFY58kjjp9UM3i8qfCaYyUSDL5hwQqmG6r7PS7SCmBO2ZNJK
 eiaXm1mgWkKEUCai9Nz9CP7twwvuoqh70XecPNWe5dPKBUnvHlQ73e+NkIKR+4S2n1
 piWh1SijtvMPZ4hIveHFp+yZ/WYTw5npdGSj2AAWhOGdqz4uHdJb+/cpFaaA/93lhr
 fo5I+ZXpXGn+w==
To: jaegeuk@kernel.org
Date: Wed, 16 Apr 2025 13:48:04 +0800
Message-ID: <20250416054805.1416834-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
MIME-Version: 1.0
X-Headers-End: 1u4vdA-0006X3-OZ
Subject: [f2fs-dev] [PATCH 1/2] f2fs: sysfs: add encoding_flags entry
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch adds a new sysfs entry /sys/fs/f2fs/<disk>/encoding_flags,
it is a read-only entry to show the value of sb.s_encoding_flags, the
value is hexadecimal.

===========================      ==========
Flag_Name                        Flag_Value
===========================      ==========
SB_ENC_STRICT_MODE_FL            0x00000001
SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
===========================      ==========

case#1
mkfs.f2fs -f -O casefold -C utf8:strict /dev/vda
mount /dev/vda /mnt/f2fs
cat /sys/fs/f2fs/vda/encoding_flags
1

case#2
mkfs.f2fs -f -O casefold -C utf8 /dev/vda
fsck.f2fs --nolinear-lookup=1 /dev/vda
mount /dev/vda /mnt/f2fs
cat /sys/fs/f2fs/vda/encoding_flags
2

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 13 +++++++++++++
 fs/f2fs/sysfs.c                         |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 59adb7dc6f9e..0dbe6813b709 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -846,3 +846,16 @@ Description:	For several zoned storage devices, vendors will provide extra space
 		reserved_blocks. However, it is not enough, since this extra space should
 		not be shown to users. So, with this new sysfs node, we can hide the space
 		by substracting reserved_blocks from total bytes.
+
+What:		/sys/fs/f2fs/<disk>/encoding_flags
+Date:		April 2025
+Contact:	"Chao Yu" <chao@kernel.org>
+Description:	This is a read-only entry to show the value of sb.s_encoding_flags, the
+		value is hexadecimal.
+
+		===========================      ==========
+		Flag_Name                        Flag_Value
+		===========================      ==========
+		SB_ENC_STRICT_MODE_FL            0x00000001
+		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
+		===========================      ==========
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 3a3485622691..cf98c5cbb98a 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -274,6 +274,13 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 	return sysfs_emit(buf, "(none)\n");
 }
 
+static ssize_t encoding_flags_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	return sysfs_emit(buf, "%x\n",
+		le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_encoding_flags));
+}
+
 static ssize_t mounted_time_sec_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1158,6 +1165,7 @@ F2FS_GENERAL_RO_ATTR(features);
 F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
+F2FS_GENERAL_RO_ATTR(encoding_flags);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
 F2FS_GENERAL_RO_ATTR(pending_discard);
@@ -1270,6 +1278,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(reserved_blocks),
 	ATTR_LIST(current_reserved_blocks),
 	ATTR_LIST(encoding),
+	ATTR_LIST(encoding_flags),
 	ATTR_LIST(mounted_time_sec),
 #ifdef CONFIG_F2FS_STAT_FS
 	ATTR_LIST(cp_foreground_calls),
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
