Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1370CA5FF1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=77pBSiv/bZ1TPbvq7JXFMY7mJSLrHjfPIUO0428W4QA=; b=myJtinCHeh3rBGcMjjyoiymO2x
	P97pnxhr9HDZoWDzLLKHTSNrEaDG3O1b7l6PXcbdhX45nOZesyU6kN8niUB9rMJ3HgYqCVvrZ8/NJ
	KGjHK5BdD4cG5AvBR6CR+qZcYDwLJsFH9vH10ZvM9j8hrzlGNd6HYgZ73eCdxH27Sbsc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEQ9w-0004ll-6O;
	Wed, 07 Oct 2026 11:50:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xEQ9u-0004ld-Tx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:50:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bULYUWQ1NflAN68ceyoD84z7KO4KdRDvgO9RXJEJf1o=; b=SwxalD3ZGk1LBN6e2B3Yq4f2d6
 DVzs0YnL2KIHnuBuHcE1YtM20bdaW53v/3raGyIxrsbUE0mkmNBPqvVZNK3czm67ANFP5REKA+Cbe
 rPkuXHbfzNkwiGSri9+3lrkeTdZgVFVMiN5lJqunoN1pUZhQnOCRZAV9+LBBacQejrNA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bULYUWQ1NflAN68ceyoD84z7KO4KdRDvgO9RXJEJf1o=; b=B
 NjtSNbteyOpwuNla+wgJumgFo5eV9Q5erKpNIQGCHM+zy/iELZNuHQSfivt1xbjoLoN3/HwFUjzSY
 UV5rnJjj3oGhpowfSQNV8PpQF/cj+if2NOZeadjPggH7jXbgwaecODLGPjRGcbh/+E4FKg9VMnAE/
 MP27n8iqv1g71fCY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEQ9q-0001I9-Oz for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 11:50:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C3EF601FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  7 Oct 2026 11:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003611F0089B;
 Wed,  7 Oct 2026 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791373796;
 bh=bULYUWQ1NflAN68ceyoD84z7KO4KdRDvgO9RXJEJf1o=;
 h=From:To:Cc:Subject:Date;
 b=khbUe/oSxxDxyT41pv2h7VTYY/HcEPBZbY2Kh5tXn32E9dcECOjLHyk5kZGIN7Rap
 Tjfn8iekn3G23vgisa6pMbrepsHxYilASGXSq2bbDotwLHHz21CVPFhd24r29uFm6l
 nGK1jeh1Pcb53fIPxw+zrPh6zTAJu1GH9ExqEPYWG4RD6Mln/wfr7ox1uBZKJcZdEM
 SQfUVjH8GoHVmgCF1IuqWc58OPzNn+PmAhgegap0DrKW2jLc5BaVz/sJJLl9le7d7U
 4pdLDG/L7T7845T0QNuSNgYqzr28Zj56k6EKQL1YWf+XXleLvLd8Kg1+VMunX04Zrw
 EIHsfKLDF6IuQ==
To: jaegeuk@kernel.org
Date: Wed,  7 Oct 2026 11:49:45 +0000
Message-ID: <20261007114949.2428048-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
MIME-Version: 1.0
X-Headers-End: 1xEQ9q-0001I9-Oz
Subject: [f2fs-dev] [PATCH 1/5] f2fs: cache: introduce metadata_cache sysfs
 node
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

From: Chao Yu <chao@kernel.org>

This patch exposes a new sysfs node 'metadata_cache' under
/sys/fs/f2fs/features/ to indicate runtime support for the in-kernel
metadata cache infrastructure.

Userspace can check this feature entry to determine support before
configuring metadata cache knobs (e.g., cache_wb_interval) or parsing
per-cache memory statistics in debugfs.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 fs/f2fs/sysfs.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index c4746c416ac2..5b196806b3bc 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -271,7 +271,7 @@ Description:	Shows all enabled kernel features.
 		inode_crtime, lost_found, verity, sb_checksum,
 		casefold, readonly, compression, test_dummy_encryption_v2,
 		atomic_write, pin_file, encrypted_casefold, linear_lookup,
-		fserror.
+		fserror, metadata_cache.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9749da70089a..afce74744d4d 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1421,6 +1421,7 @@ F2FS_FEATURE_RO_ATTR(linear_lookup);
 #endif
 F2FS_FEATURE_RO_ATTR(packed_ssa);
 F2FS_FEATURE_RO_ATTR(fserror);
+F2FS_FEATURE_RO_ATTR(metadata_cache);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1592,6 +1593,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #endif
 	BASE_ATTR_LIST(packed_ssa),
 	BASE_ATTR_LIST(fserror),
+	BASE_ATTR_LIST(metadata_cache),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
