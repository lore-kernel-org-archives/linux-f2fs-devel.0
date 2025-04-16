Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A529C369B1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:48:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u4vda-0008K1-J4;
	Wed, 16 Apr 2025 05:48:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1u4vdW-0008Jt-U8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Apr 2025 05:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pyavCkMtnaQdQpLVI/seQPJNPpPXDD/01WJCd3nkXMY=; b=TmeLeBfjFQ3ZXLqDhTaGRGT6J3
 PNf/m7mvsafcx9oaAXjDDMMHjHom1Q27RyhMwrjgfHD7okV2kbDtqBygiRjNVmB4+qCr8yMdYByOT
 u7ZnEw1XcyDMiK+rM30REPGmD0KyvK3r6jU6nlqcT9Q3A3dhcj6509TKEB6SjgsGRSi4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pyavCkMtnaQdQpLVI/seQPJNPpPXDD/01WJCd3nkXMY=; b=Awmmsue8BxX93yClSjSbU6bnbh
 GXEqZmnyN042jr/MsAzjLkO3EOeEC9BJ8Wy4fFU5eUFMvNMQJ7GxuptrSY5EBdTCeQpJf3RKHz34z
 i5IR/zDu/Qyz0fOI3KHjZjgndeiJ9Llj6xiHfJz93aMb6jMfBCuPRGnqnPwJTkARrRaY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u4vdH-0006XL-9C for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Apr 2025 05:48:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DC7755C5B3C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Apr 2025 05:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90054C4CEED;
 Wed, 16 Apr 2025 05:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744782492;
 bh=qdCdlu7tKUGA39tkiG/iDETYPNa4obDh5AWDVouR1fM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J8Js1QaI+Y2c7rNdePKqR8YHFRnZEz6F/tGHq4Es+GfyR/Cis/PaQD/8AK3fRD0XH
 b/bjZBtD9rM5mB4Yn4H6WUJxi/zaByLYkPTsLwhQM1XwKt0jAe/jbDRGhH7YI9OXH6
 QLfKnEIyUR8rKOgxZd3Dl0AAfesUF0tLjiw4/9geXdX3/y8i6WMVDxL/P6nR0ta/kQ
 H3Lvtvkwx72Ae2o8PfhKBNmNKTVaAs3zFjZ+xWejLd+2D47qSBwXlKJyysNvhCOF7e
 XixC496HXTliP3xnEk611EjQr00c/Uwktnup46zHtkD9fwy/mzQtfZFwLJMVweSxWG
 Rv8MHYU4GXO5g==
To: jaegeuk@kernel.org
Date: Wed, 16 Apr 2025 13:48:05 +0800
Message-ID: <20250416054805.1416834-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250416054805.1416834-1-chao@kernel.org>
References: <20250416054805.1416834-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1u4vdH-0006XL-9C
Subject: [f2fs-dev] [PATCH 2/2] f2fs: sysfs: export linear_lookup in
 features directory
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

cat /sys/fs/f2fs/features/linear_lookup
supported

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 fs/f2fs/sysfs.c                         | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0dbe6813b709..c805a48dd3dc 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -270,7 +270,7 @@ Description:	Shows all enabled kernel features.
 		inode_checksum, flexible_inline_xattr, quota_ino,
 		inode_crtime, lost_found, verity, sb_checksum,
 		casefold, readonly, compression, test_dummy_encryption_v2,
-		atomic_write, pin_file, encrypted_casefold.
+		atomic_write, pin_file, encrypted_casefold, linear_lookup.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index cf98c5cbb98a..75134d69a0bd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1207,6 +1207,9 @@ F2FS_FEATURE_RO_ATTR(readonly);
 F2FS_FEATURE_RO_ATTR(compression);
 #endif
 F2FS_FEATURE_RO_ATTR(pin_file);
+#ifdef CONFIG_UNICODE
+F2FS_FEATURE_RO_ATTR(linear_lookup);
+#endif
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1356,6 +1359,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 	BASE_ATTR_LIST(compression),
 #endif
 	BASE_ATTR_LIST(pin_file),
+#ifdef CONFIG_UNICODE
+	BASE_ATTR_LIST(linear_lookup),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
