Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEA3C982DB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZWM/lNnxzn/yUzo7yQwBAHsiMcsQXQ51uX17FxY1o3c=; b=DZipTVXjbN4fbMxT2eOAvtqLhw
	B7bBcBboqlwMMzOE3px9j3gO0zYfb6Si7Bbfibo6qBSpCQeY71zrCBaadlFHB142NJP2yKO79gYKl
	lMpKLf8ZSiPNd6ZylRoRBo3cXQcShHK6/pfkgb4sookBgJpL+Eb3zQbhgtN1BodErGLE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x76dN-0005WI-7F;
	Thu, 17 Sep 2026 07:34:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x76dD-0005U1-Jy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:34:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u60a7hzzUwntyya3Yn4RCKAjyCDLb1Lf1oXylakCnKM=; b=YgNaDvxxMffkJFuMkWsTQyrQxV
 29kj0NHrMPE3UVU61VHV97qb3Gd/eBymZXaaLq+ks/gNhVzgQQYZGX7I9zR0XXESFVdmRmb9pScb0
 NsCTFbAZPfU+8zZ564h1ESyjQDQKduKI4yEZlR6QiQAc41o+AyIcZWEp0RBOmlfOXcrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u60a7hzzUwntyya3Yn4RCKAjyCDLb1Lf1oXylakCnKM=; b=B1MvXN1QfBK7EO9Gq84fFeSdeh
 S1m5lDCVAW5jRLxDhUosv4Trvi8xPQfQL29jTfF12gFllXzZgVpRycHtyyDHk0Annd6iOzwh05gCH
 LMEwUb4Ud1IBm3+tScofk3Z2guXso9HOXFEpCiv82Qt6BHZflbHGzbINr3CA5/ebgpPM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x76dD-0007NR-03 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:34:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E54B60233;
 Thu, 17 Sep 2026 07:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414751F0089D;
 Thu, 17 Sep 2026 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789630441;
 bh=u60a7hzzUwntyya3Yn4RCKAjyCDLb1Lf1oXylakCnKM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LW+VLmu1pERO7vjJZ20Q2z2x2+6XaB/ou+8Tm3YiQpG98P0MMjH2pHQeZbPOsfwI1
 BkCeFPEJ4v8E+MGtxe+FAgWd5IQUuZ60X2ahfcmn/LNhxXaLxSBKyk7+BMxFqd58W7
 Cehr1rB75PRMgjf03ltIGAResaM1KkblkHvSzQrh0LUXGin3Y0VOSPwNWfoseIZK3U
 ZEyGRXH3MkxvBB6nY4Wh1EJVKv9b9ASCs1GamDsHWP6ODDfE/7ZBlODYwe+HRne06N
 Z3P2tFQOde8itiSp70qduA6tT/yMvRPPljeHd4sOx2zz3UkNzV/ZjpRdLA61WctA7i
 xqbXHih1jTACQ==
To: jaegeuk@kernel.org
Date: Thu, 17 Sep 2026 15:33:41 +0800
Message-ID: <20260917073343.2823157-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260917073343.2823157-1-chao@kernel.org>
References: <20260917073343.2823157-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x76dD-0007NR-03
Subject: [f2fs-dev] [PATCH v9 10/12] f2fs: cache: support fault injection
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

This patch adds fault injection support for metadata cache allocations
to improve error-path test coverage.
- it integrates entry allocations with FAULT_KMALLOC

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index a56982a02585..0814c38b24bc 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -154,23 +154,27 @@ static struct f2fs_cached_block *f2fs_create_cache(
 		struct f2fs_cached_block_list *cache,
 		unsigned long index, bool nofail)
 {
+	struct f2fs_sb_info *sbi = cache->sbi;
 	struct f2fs_cached_block *entry;
 	unsigned int flags = GFP_NOFS;
 
 	if (index == ULONG_MAX)
 		return ERR_PTR(-ERANGE);
 
-	if (nofail)
+	if (nofail) {
 		flags |= __GFP_NOFAIL;
-
-	entry = kzalloc_obj(*entry, flags);
-	if (!entry)
-		return ERR_PTR(-ENOMEM);
-
-	entry->data = kmalloc(cache->sbi->blocksize, flags);
-	if (!entry->data) {
-		kfree(entry);
-		return ERR_PTR(-ENOMEM);
+		entry = kzalloc_obj(*entry, flags);
+		entry->data = kmalloc(sbi->blocksize, flags);
+	} else {
+		entry = f2fs_kzalloc(sbi, sizeof(*entry), flags);
+		if (!entry)
+			return ERR_PTR(-ENOMEM);
+
+		entry->data = f2fs_kmalloc(sbi, sbi->blocksize, flags);
+		if (!entry->data) {
+			kfree(entry);
+			return ERR_PTR(-ENOMEM);
+		}
 	}
 	entry->index = index;
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
