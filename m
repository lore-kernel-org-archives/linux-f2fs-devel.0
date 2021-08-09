Return-Path: <SRS0=Sb8n=NA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A59C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Aug 2021 02:21:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1465860243
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Aug 2021 02:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1465860243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mCuuk-0007Ql-HO; Mon, 09 Aug 2021 02:21:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <changfengnan@vivo.com>) id 1mCuuj-0007QX-8r
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Aug 2021 02:21:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hcm9AqYXWwX/kdBmlwwPYT4LUqQnQtQZF5lgE3SfF4o=; b=I/38Mvh3yw5T3pi3JXu5//KzeG
 OMb52aHvI4Fxg5SrVhNz8BhsAaUM9bXHd4CfDJI9HkVgAJHg6hJW1Ir5Fa1HvP6YJaT/6Eho2JbNH
 plch+nAfHekhnrxQpEppYdFC2HsqTzzkiQWBP3uACBVluD7CUOfBOBtAyvvj2yfpwNdM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hcm9AqYXWwX/kdBmlwwPYT4LUqQnQtQZF5lgE3SfF4o=; b=Z
 d46bEfQIuOZYrNuMIt4mF7u3DeqWgDL50BFY0Wocg/rLadXRqJSMP9a3MznNCkbKfsVgeHS4eoPC0
 SOzWf8hh+vNX92ziXDl5tEj835wKLjeGK0Dlsj3pVrZJttZRVWZHKL58ny9UAMQmbCYH8NCTNbxvC
 z0iTXXMloFdOdaaY=;
Received: from mail-m17654.qiye.163.com ([59.111.176.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mCuug-0001GK-EA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Aug 2021 02:21:17 +0000
Received: from comdg01144017.vivo.xyz (unknown [218.104.188.164])
 by mail-m17654.qiye.163.com (Hmail) with ESMTPA id A865C2010C;
 Mon,  9 Aug 2021 10:21:06 +0800 (CST)
From: Fengnan Chang <changfengnan@vivo.com>
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  9 Aug 2021 10:21:04 +0800
Message-Id: <20210809022104.72220-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkaQhhWGE0ZS01CGkgYHx
 0eVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6ARw4Kj9NMSgNSgEaP0wC
 Sj0aCjlVSlVKTUlDT0xOTU1MSU1DVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WUlKQ1VKS09VSkNDVUpNT1lXWQgBWUFJQkhMNwY+
X-HM-Tid: 0a7b28b6b182d9fdkuwsa865c2010c
X-Headers-End: 1mCuug-0001GK-EA
Subject: [f2fs-dev] [PATCH v5] f2fs: compress: allow write compress released
 file after truncate to zero
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
Cc: Fengnan Chang <changfengnan@vivo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For compressed file, after release compress blocks, don't allow write
direct, but we should allow write direct after truncate to zero.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 Documentation/filesystems/f2fs.rst | 7 +++++--
 fs/f2fs/file.c                     | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 8f251a662542..9b0517d90063 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -865,8 +865,11 @@ Compression implementation
   directly in order to guarantee potential data updates later to the space.
   Instead, the main goal is to reduce data writes to flash disk as much as
   possible, resulting in extending disk life time as well as relaxing IO
-  congestion. Alternatively, we've added ioctl interface to reclaim compressed
-  space and show it to user after putting the immutable bit.
+  congestion. Alternatively, we've added ioctl(F2FS_IOC_RELEASE_COMPRESS_BLOCKS)
+  interface to reclaim compressed space and show it to user after putting the
+  immutable bit. Immutable bit, after release, it doesn't allow writing/mmaping
+  on the file, until reserving compressed space via
+  ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or truncating filesize to zero.
 
 Compress metadata layout::
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7d8ee60f6c1f..d4fc5e0d2ffe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -753,6 +753,14 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		return err;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+	/*
+	 * For compressed file, after release compress blocks, don't allow write
+	 * direct, but we should allow write direct after truncate to zero.
+	 */
+	if (f2fs_compressed_file(inode) && !free_from
+			&& is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
+		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
+
 	if (from != free_from) {
 		err = f2fs_truncate_partial_cluster(inode, from, lock);
 		if (err)
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
