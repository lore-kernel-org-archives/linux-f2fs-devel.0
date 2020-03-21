Return-Path: <SRS0=RYwi=5G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C0C4332D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:25:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237F220724;
	Sat, 21 Mar 2020 12:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UZAZlJ21";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SO8VClXz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS1uO6vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237F220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jFdBg-0002bh-NO; Sat, 21 Mar 2020 12:25:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jFdBg-0002ba-2q
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:25:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B28rYFVExumdpud/ewa1KE92b1Wogew2qx1YvNkCHns=; b=UZAZlJ21sSfKv7uS96Un/0bho+
 3ayAXisqACrCF7x36oCYomqD7qiC+ofB20cw8z6vmQhDmVa1USMbtVOCVjGW6tynErLDiE3AVlruQ
 QZGf5OnDxbrX8zHFAOIJoF+K1ZIiDy2P/czD4nrMvE9gnrkDNTgg5i5H30TbbyzaXBDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B28rYFVExumdpud/ewa1KE92b1Wogew2qx1YvNkCHns=; b=S
 O8VClXz7ncYbJOAHsH+RG+m6iKqu7XrycRiGZQrvhW0iZ6hPMKR7U+gNRVTa51Dv8mkx5O0xNdDsy
 TtuOmV45+oeRrHtZija9IJbq4IW9yIZnSC35JHjdPBVoVXt0josfKtECNjqa4gchHKfqNr6bX+nAD
 kZjFTnUA6YjIR0Ms=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jFdBc-00GIpW-HU
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:25:12 +0000
Received: from localhost.localdomain (unknown [49.65.245.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEB9620724;
 Sat, 21 Mar 2020 12:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584793503;
 bh=baXkY26+grqrvtO0gFEMOKOPPJpTnN3B7ErAMOGPQeI=;
 h=From:To:Cc:Subject:Date:From;
 b=LS1uO6vlEb4UBkc+v99Z26763EJTT1Z7xagXup+HO0xapJrD9yp5dh1C+61pwexiw
 DOklNap9QXfHiD7PqUgFHG/z5vH6igI/AH2TEqQSyhamQvQ2aJSyZD54RUv1Fz598A
 uBSiDcLK5AjfSXusw0t9KhSz6W/+RgpIMpQtdxk4=
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sat, 21 Mar 2020 20:24:11 +0800
Message-Id: <20200321122411.22597-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1jFdBc-00GIpW-HU
Subject: [f2fs-dev] [PATCH] f2fs: fix to clear PG_error if fsverity failed
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

From: Chao Yu <yuchao0@huawei.com>

In f2fs_decompress_end_io(), we should clear PG_error flag before page
unlock, otherwise reread will fail due to the flag as described in
commit fb7d70db305a ("f2fs: clear PageError on the read path").

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df3e6ad5b6d7..f37b83534322 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1420,15 +1420,17 @@ void f2fs_decompress_end_io(struct page **rpages,
 		if (!rpage)
 			continue;
 
-		if (err || PageError(rpage)) {
-			ClearPageUptodate(rpage);
-			ClearPageError(rpage);
-		} else {
-			if (!verity || fsverity_verify_page(rpage))
-				SetPageUptodate(rpage);
-			else
-				SetPageError(rpage);
+		if (err || PageError(rpage))
+			goto clear_uptodate;
+
+		if (!verity || fsverity_verify_page(rpage)) {
+			SetPageUptodate(rpage);
+			goto unlock;
 		}
+clear_uptodate:
+		ClearPageUptodate(rpage);
+		ClearPageError(rpage);
+unlock:
 		unlock_page(rpage);
 	}
 }
-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
