Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F21EC3ABCB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 May 2025 03:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HD7R9z6yQrq2uVUKiR9kcUJGGvPhOZPr1OCKIA+X+5A=; b=IGjVTkG66gXOJKmXvyX5NioaXu
	zEsXH+rtTni9WimzvF6r2FU+ItxItoMXe1HRloNs89YrO4H3xRkbVj6AAuNop4HSMuJBKCKLF21NU
	JCEjeHpiJlf5bQj6k8sGYppV/Jhx2HK37IMfmGVwIH/Z6CKuStdhz+MyNDLf5c2xJlps=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uEgAu-00070M-4E;
	Tue, 13 May 2025 03:19:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uEgAt-00070E-9B
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 May 2025 03:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pwzxVe22t8WliDfAavLb7067JB4lICZmLXwCVRKzsKU=; b=W+BicDlAFyC8MVld9yuYIKg2D1
 LFrWN3KO62GO5Q40bHqeMDKg5ypQdje0EijMOhJ9VrLHmXT7OeGDxNwAq7DzsXs5iCfKn5xevm8yI
 MYrwDn+3qFsd2m1GHyUbXbOFEcTT5zakSICzqYqzQ4hQihuJyUYyZzyvcag3IeH7SJiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pwzxVe22t8WliDfAavLb7067JB4lICZmLXwCVRKzsKU=; b=O
 nSNirjrRnD3+k5lNuGbMDBgv7YlGP1TwD3F/0qVZOKDPv13uZtftCBkXE2n///cUtlyOlJrDDtnuF
 w/XaDwXFnk6NMXoywNqVDtzD238d9WIkq6ivt18/QvLRbpKshjQlGaBxOpjhpWR32nPGoTlQly4ZK
 GrxIuWZ9SzXuKYow=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uEgAs-0001n7-Id for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 May 2025 03:19:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D41B062A19
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 May 2025 03:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2C8C4CEE7;
 Tue, 13 May 2025 03:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747106356;
 bh=tXvRfuxcvoFqNhJhmfkkk0vzUQskoB6+LaM/chYV20k=;
 h=From:To:Cc:Subject:Date:From;
 b=BjwU735l6oL+s2ymAO0Q3Rs+ZTHgfmVUMIcsI9ORcaX+MuPYHuaNiUt+m7qIimq6N
 l7CWUFQdo3kC8D88DnRy5cUZd9q6t/9PbmU+f1VgzcfJOoTeFDLTx73f0Ln2eSCqkN
 KTBEuCQ49b6k2X1IKxNcaMdOVC73x75+jbsjmJEAC5szqgFjLr7d9Epv7NlRkcXbNl
 F4Z0+u8aY2NRWPGtRJlrgI4xU1bL59ixxhopTHHI8PK1M3TcG2rv+rWmddQhd8WYdC
 S+4c5722wTZHMtHasURtByNd/TBi1VZSbnvHj+UEhZpxnGaJLz9hN7FXvoWKsPw54n
 jWBlmFQADW2Kg==
To: jaegeuk@kernel.org
Date: Tue, 13 May 2025 11:19:07 +0800
Message-ID: <20250513031907.2876275-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
MIME-Version: 1.0
X-Headers-End: 1uEgAs-0001n7-Id
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: add f2fs_bug_on() in
 f2fs_quota_read()
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

mapping_read_folio_gfp() will return a folio, it should always be
uptodate, let's check folio uptodate status to detect any potenial
bug.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- just add f2fs_bug_on(), get rid of error handling.
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0ee783224953..8c77a625427c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2973,6 +2973,12 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 			goto repeat;
 		}
 
+		/*
+		 * should never happen, just leave f2fs_bug_on() here to catch
+		 * any potential bug.
+		 */
+		f2fs_bug_on(sbi, !folio_test_uptodate(folio));
+
 		memcpy_from_folio(data, folio, offset, tocopy);
 		f2fs_folio_put(folio, true);
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
