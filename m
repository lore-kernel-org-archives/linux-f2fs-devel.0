Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C45C98302
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 03:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bT3QGD0c00HWaMsr91P93EVB8nmUfsBOv8jC4Dobhts=; b=F5wWlBZ2m6ou9GmTvuiOEJfV1f
	LgdrxuVokvT9fMbT+KT1Tk0xQub2oXU7Yb9ZRzYxfE16cvwR3yEhE/EiW2Ql34nFhnVdpMUX0F6x+
	rMpLpPEFo1QtqWBMG6WDjzHuDuJoyVMpEZlQnD2MSWAu7NAuZKrwD+XwlRNn8UDX7YWM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9DYl-0000lv-B4;
	Wed, 23 Sep 2026 03:22:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x9DYk-0000lo-FQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 03:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zSHmKqHcFnIUZKWVcKwiw19/wD5lM0klypYXugvrpJs=; b=ZDMnAR0abFthQptdusSxzrQyHi
 yzpHnZHoPa3EYq2WGHCJTdUuxAfx0QyOUQJjeQ3J3YGUWP49LhSP4IsGfRky+vXn3F62s4Srrdahm
 aRSIHAWyT20fxVV013vei/j6gKpxmYq/RnKjcSSAGr3psdFgOTYIeelNpfJyvvQFF0ls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zSHmKqHcFnIUZKWVcKwiw19/wD5lM0klypYXugvrpJs=; b=gAxQd48wCypT8z81KG/dq5XGHr
 jdyFxnOw56VNev03PSA2HBxpoN2J4UxkHbvP9MKF2EgrnNsP+PLLXgePEeA4AaU/CVR6ie0LiOy+J
 j95YmICMaenythCC6X8OFtpF82mBkKvDeeHE1NIUDEIsIYuZajHK0aQ0s3OjyigWcUas=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9DYf-0001sA-Ik for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 03:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zS
 HmKqHcFnIUZKWVcKwiw19/wD5lM0klypYXugvrpJs=; b=Q/9anoxfMOfC7x71Te
 fR/VRcpIsCe8OySm04DQpvNtNiHzidRzi6v/+aGRKSPVrCVHdboT4LXhIoRVpblm
 34LyBmge/ChDe1dkgxpunzRCbWb2Qzv+mz9GmxcQGuspPD+BxRYzvqGEpNpGsRDc
 bSmFLL9nKnOxRANnyL8xuP5nE=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD3t5m9RbNqKbJCAA--.1172S2; 
 Wed, 23 Sep 2026 11:21:34 +0800 (CST)
To: Chao Yu <chao@kernel.org>
Date: Wed, 23 Sep 2026 11:21:31 +0800
Message-ID: <20260923032131.2227703-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <51c3f1f9-7e91-4f9a-9f22-d1ba8df357c6@kernel.org>
References: <51c3f1f9-7e91-4f9a-9f22-d1ba8df357c6@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3t5m9RbNqKbJCAA--.1172S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF47tw1fGF18tF17AFy5Jwb_yoW8tw47pF
 WUKryDJrWkXw12grnaqa15Zw13Kry5Xa17AFZ3C3W3Aas8JasxKr45Ww1jkr45tr1kJF1I
 qF4UtF1ru3WDtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRuwZsUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsB4I12qzRb4ezwAA3C
X-Headers-End: 1x9DYf-0001sA-Ik
Subject: Re: [f2fs-dev] [PATCH v2 04/14] f2fs: support atomic file large
 folios buffered write
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Thanks for the review.

I think I can extract the duplicate logic in a helper and the full change
may be like this?

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4721,6 +4721,31 @@
 	return 0;
 }
 
+static bool f2fs_try_balance_folio(struct folio *folio,
+		struct address_space *mapping, bool node_changed)
+{
+	struct inode *inode = folio->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int orig_order;
+
+	if (!node_changed || IS_NOQUOTA(inode) ||
+			!has_not_enough_free_secs(sbi, 0, 0))
+		return false;
+
+	orig_order = folio_order(folio);
+	folio_unlock(folio);
+	f2fs_balance_fs(sbi, true);
+	folio_lock(folio);
+
+	if (folio->mapping != mapping)
+		return true;
+
+	if (folio_order(folio) != orig_order)
+		return true;
+
+	return false;
+}
+
 static int prepare_large_folio_atomic_write_begin(struct inode *inode,
 		struct address_space *mapping, struct folio *folio, loff_t pos,
 		unsigned int len)
@@ -4728,7 +4753,6 @@
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	size_t ori_off = offset_in_folio(folio, pos);
 	pgoff_t start, end, index;
-	unsigned int orig_order;
 	int err = 0;
 
 	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
@@ -4774,16 +4798,8 @@
 		 * Expand the 4K-page balance decision per subpage: check
 		 * right after each preallocated block.
 		 */
-		if (node_changed && !IS_NOQUOTA(inode) &&
-		    has_not_enough_free_secs(sbi, 0, 0)) {
-			orig_order = folio_order(folio);
-			folio_unlock(folio);
-			f2fs_balance_fs(sbi, true);
-			folio_lock(folio);
-			if (unlikely(folio->mapping != mapping ||
-				     folio_order(folio) != orig_order))
-				return -EAGAIN;
-		}
+		if (f2fs_try_balance_folio(folio, mapping, node_changed))
+			return -EAGAIN;
 	}
 
 	return 0;
@@ -4876,17 +4892,10 @@
 	if (err)
 		goto put_folio;
 
-	if (need_balance && !IS_NOQUOTA(inode) &&
-			has_not_enough_free_secs(sbi, 0, 0)) {
+	if (f2fs_try_balance_folio(folio, mapping, need_balance)) {
 		folio_unlock(folio);
-		f2fs_balance_fs(sbi, true);
-		folio_lock(folio);
-		if (folio->mapping != mapping) {
-			/* The folio got truncated from under us */
-			folio_unlock(folio);
-			folio_put(folio);
-			goto repeat;
-		}
+		folio_put(folio);
+		goto repeat;
 	}
 
 	f2fs_folio_wait_writeback(folio, DATA, false, true);
-- 
Nanzhe Zhao



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
