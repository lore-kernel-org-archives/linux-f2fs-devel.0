Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF94DC77B75
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 09:43:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzDgl-0004et-57;
	Wed, 17 May 2023 09:43:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pzDgk-0004en-0e
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 09:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZfFYmBDQSlgRefs2pfZMDOuojj6OrQQO90lYWBgdeAA=; b=FOv7avzAIAqc+FzFv2yXJ5nx3n
 jCJYgplbV2tMpQB/4USrGzuOW9PCjYaVMNUwT6no+PaO4rQFZwv/md56IKHt4GuR0bt4OHdWu5C9R
 cWSRNNFtODkvQEsF/x/R1UKGNbeVzaIjM+oroTJXuIt70PbWRm4r+XSlah6vrK8p5uKk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZfFYmBDQSlgRefs2pfZMDOuojj6OrQQO90lYWBgdeAA=; b=l
 4dRA+ZoF9qhLh/fASHujp3CfZgtUrW4Z+qEeSW3maXF43PmRtjbdqmqEQ/prqBAH9A9M6M+Fdrh1U
 L6e+b8eFplDKe98fKy9QrO1YDnfpPilUvUPsAedUqPnKaUISERfyyropNUwMIR+lSJwa1sgyQUvdB
 C4EcxaFYKJ/vBlgE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzDgj-00AvD8-LP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 09:43:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4A1B264492
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 May 2023 09:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F51C433D2;
 Wed, 17 May 2023 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684316591;
 bh=8r7M5a3OEqoDbb+pxrJPm+TfUU/r1Lo2eHF4tZCywJE=;
 h=From:To:Cc:Subject:Date:From;
 b=p/ACQTlqdZsahA9Sbserch1JIbqI1qzvMKCUtrIYtrPz/Hb7+6myrsSbo7KgQiKuU
 sa6EO5nHINxLXMD8zGkTLZ1kjHt3W89lMoqBBvnA1GePIgCf4YBrtsMfvQe5pKJg/h
 dDHqs00QbhzxI71CdryJ/bJ2abirHDmy0/ebgw/bM6SvimLJmVtH5mkf9e01wm4d/V
 czR476P8kJ/T+7oqLmOEGf0+ZSlhaE/sI8Wum0f/XzI2/NkKdVjJL3vo0ZRgVTUiIj
 Zc9hw8IZ9kJvDptPA6pZ9E7zW5hoXAbXClfNk11KEjwFjorEr/w4EYCCNKbCnZkqEe
 dZOAycb1Z2IEg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 17 May 2023 17:42:49 +0800
Message-Id: <20230517094250.1407910-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1pzDgj-00AvD8-LP
Subject: [f2fs-dev] [PATCH 1/2] f2fs: renew value of F2FS_MOUNT_*
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

Then we can just define newly introduced mount option w/ lasted
free number rather than random free one.

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 99edc4981edf..6719cf1c5596 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -80,34 +80,34 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 /*
  * For mount options
  */
-#define F2FS_MOUNT_DISABLE_ROLL_FORWARD	0x00000002
-#define F2FS_MOUNT_DISCARD		0x00000004
-#define F2FS_MOUNT_NOHEAP		0x00000008
-#define F2FS_MOUNT_XATTR_USER		0x00000010
-#define F2FS_MOUNT_POSIX_ACL		0x00000020
-#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000040
-#define F2FS_MOUNT_INLINE_XATTR		0x00000080
-#define F2FS_MOUNT_INLINE_DATA		0x00000100
-#define F2FS_MOUNT_INLINE_DENTRY	0x00000200
-#define F2FS_MOUNT_FLUSH_MERGE		0x00000400
-#define F2FS_MOUNT_NOBARRIER		0x00000800
-#define F2FS_MOUNT_FASTBOOT		0x00001000
-#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00002000
-#define F2FS_MOUNT_DATA_FLUSH		0x00008000
-#define F2FS_MOUNT_FAULT_INJECTION	0x00010000
-#define F2FS_MOUNT_USRQUOTA		0x00080000
-#define F2FS_MOUNT_GRPQUOTA		0x00100000
-#define F2FS_MOUNT_PRJQUOTA		0x00200000
-#define F2FS_MOUNT_QUOTA		0x00400000
-#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
-#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
-#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
-#define F2FS_MOUNT_NORECOVERY		0x04000000
-#define F2FS_MOUNT_ATGC			0x08000000
-#define F2FS_MOUNT_MERGE_CHECKPOINT	0x10000000
-#define	F2FS_MOUNT_GC_MERGE		0x20000000
-#define F2FS_MOUNT_COMPRESS_CACHE	0x40000000
-#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x80000000
+#define F2FS_MOUNT_DISABLE_ROLL_FORWARD	0x00000001
+#define F2FS_MOUNT_DISCARD		0x00000002
+#define F2FS_MOUNT_NOHEAP		0x00000004
+#define F2FS_MOUNT_XATTR_USER		0x00000008
+#define F2FS_MOUNT_POSIX_ACL		0x00000010
+#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000020
+#define F2FS_MOUNT_INLINE_XATTR		0x00000040
+#define F2FS_MOUNT_INLINE_DATA		0x00000080
+#define F2FS_MOUNT_INLINE_DENTRY	0x00000100
+#define F2FS_MOUNT_FLUSH_MERGE		0x00000200
+#define F2FS_MOUNT_NOBARRIER		0x00000400
+#define F2FS_MOUNT_FASTBOOT		0x00000800
+#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00001000
+#define F2FS_MOUNT_DATA_FLUSH		0x00002000
+#define F2FS_MOUNT_FAULT_INJECTION	0x00004000
+#define F2FS_MOUNT_USRQUOTA		0x00008000
+#define F2FS_MOUNT_GRPQUOTA		0x00010000
+#define F2FS_MOUNT_PRJQUOTA		0x00020000
+#define F2FS_MOUNT_QUOTA		0x00040000
+#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00080000
+#define F2FS_MOUNT_RESERVE_ROOT		0x00100000
+#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x00200000
+#define F2FS_MOUNT_NORECOVERY		0x00400000
+#define F2FS_MOUNT_ATGC			0x00800000
+#define F2FS_MOUNT_MERGE_CHECKPOINT	0x01000000
+#define	F2FS_MOUNT_GC_MERGE		0x02000000
+#define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
+#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
