Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D63C624CC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1YcB+Znfa2Nm36C2XF66t/+Brk62woLfm+SczAerx+Q=; b=e7YPDCy2vt6ENjeFHGsKwq6QsM
	6DgKVn+mMYPa2OvQGDd7cijsAtOhImUp85CNdsNUc11btkXou+5z3lK9zozDzx6c6AVoUcmRsKwgR
	KGwMsukmbfpqK7UpNK8W3OyWjQqbLYH3UgKOaB4GWolSVPLyp16KfQ1AW1zNAr0DZYtI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0yEI-0007Dj-IR;
	Mon, 31 Aug 2026 09:23:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0yEG-0007DA-0J
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3f1GWhr9QjJPjx1dSEW5B9u8nAJuwDUkgImH+lNYX8w=; b=Q2TP2oXFMe8WnADOi/51jTTfZZ
 Jki+wfE28ganHwMdBbIIT/UWWjeB0TPbWJx0cubhgN9/pO8qtFX8IPyl8/XgqrBPE9TAeF6T2q16I
 +S66TJx0zPSeb1ckXbmry9qT6MM2Ncsp0+vJaSck2f34e49pR+Cvx30TFrjexllUVxuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3f1GWhr9QjJPjx1dSEW5B9u8nAJuwDUkgImH+lNYX8w=; b=fnBgeX2F0YHChWTS4FQhEh8Ynh
 ZAnhLJzmSKmvX3qQTM4bXZniT1V/zpZ73/tgGZkrWmQQJ21IEaMEc0PSmqlynYm1FTgAB77HGC+kq
 JYMYg4jrDS+JkLssPT6oXGwIRUsh+aKiwaaNbrIYWKNEyEq58WNn63nlQNGxNzIMa8ss=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0yEE-0006yw-Dw for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 09:22:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28CE54401F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B6C1F00A3D;
 Mon, 31 Aug 2026 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168173;
 bh=3f1GWhr9QjJPjx1dSEW5B9u8nAJuwDUkgImH+lNYX8w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K9sfgT2tMmsabP9u5znNjT35VED2FL1tLAtck8VLuSgwEcwriR7wCkjmVU05Qkced
 58OepwS1a7SVBWRZ3E4G8O/gL/rXABZPbrTEXj3Gb3sOhhCX+O64J+l7JE2ABC2ONj
 tNSzysAmyRp9v4iQokg8+b6SSctPWt+oZBEHHjLCPsEhD/gup4H6hq59AbNFBUavIV
 7L3rZnxDUlG+0ga2Gns5hXD3tGnsS1uH/a+xJ/rUjf69KS/HJVa7OPBAU0/ONgOIT4
 YKxIu6k7MyxdXdlAPbkjKEoWYqaGDQcOFiekRpQWsxUL5voF7PCioQU54J/QrPWk5h
 h8uBd3K8WK5yQ==
To: jaegeuk@kernel.org
Date: Mon, 31 Aug 2026 17:22:25 +0800
Message-ID: <20260831092227.739737-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260831092227.739737-1-chao@kernel.org>
References: <20260831092227.739737-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x0yEE-0006yw-Dw
Subject: [f2fs-dev] [PATCH v5 10/12] f2fs: cache: support fault injection
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

This patch adds fault injection support for metadata cache allocations
to improve error-path test coverage.
- it integrates entry allocations with FAULT_KALLOC

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index e29b32da5338..8276682d6af8 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -167,23 +167,27 @@ static struct f2fs_cached_block *f2fs_create_cache(
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
