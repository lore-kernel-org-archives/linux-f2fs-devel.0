Return-Path: <SRS0=+EAZ=OF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964B2C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:11:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BF461178;
	Wed, 15 Sep 2021 07:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60BF461178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mQP4i-0002K7-3g; Wed, 15 Sep 2021 07:11:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+8aa05ddd91fea3e0ef51+6597+infradead.org+hch@casper.srs.infradead.org>)
 id 1mQP4h-0002K1-10
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Sep 2021 07:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZpomFWwUpYf+IqpVbx+BDcZslxhkwYY2lCkG5RS4qRY=; b=Mxh0dAud8WbX7ksD6nxIWoJhFU
 u3IVLMOHAyROuAyKUW9tEvrHeYhV5h1H+tZC61NWWelocEVOFx+kJgG5mWn+hgelVphtOHVhZUSY0
 BAm+Qg9bJQ+8wFgxlKvkbP49tM/dRm8KfrPe+GpOnOQRCk+ilp3hs2AQYTLqvCRKHyL4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZpomFWwUpYf+IqpVbx+BDcZslxhkwYY2lCkG5RS4qRY=; b=MgWO2YBjUsp7dxPcL8OZP8UGkf
 WsVsP71iY1xNArEaFZXoM1oP2VT6rsrxhY+6Ke/c9b3+L4tHqEyxgf3FGTkWuFatFE8nGG+i66anf
 3JZjLGgutHLxozKELQ4nDGpCunrPihmM4jJ1NOM8wzSftRdAme0PKlxZwd5f+CFzajWY=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mQP4g-0000SS-GJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Sep 2021 07:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ZpomFWwUpYf+IqpVbx+BDcZslxhkwYY2lCkG5RS4qRY=; b=BEWQ4g879RktvHp67Ny4ElsHRE
 MiSkfHkEbPpI3AWn4qRufIIyGPfVHrP9AXd+ORok+zE95lxJaXgBjWaVBCQcNgUrvF7O0IJnyXL/Z
 yRKtE55VKEPMoQwvbWVf6yxv1/fAUshz7YtBuiAm2/UWa8xstP/5Cbepc3vOkwGKpIyAvdKJ3aqjw
 /Ar9eV3jH9RXVnA0KJEovtEn0QM6xhyxya4d9E1o7M0IXjI0cOegLjHGWOYfN5mcfW4fSUJIWBltK
 NWEU6qalX2Jrsc6jdCtJnJ5MWrAvJ0vXybB2xYgPe/pKuPIEP64BoHrRvZ/a47PYOpUv/XmTYzywJ
 KWs+lUSg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQP3W-00FRzK-Mq; Wed, 15 Sep 2021 07:10:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Wed, 15 Sep 2021 09:00:06 +0200
Message-Id: <20210915070006.954653-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1mQP4g-0000SS-GJ
Subject: [f2fs-dev] [PATCH 11/11] unicode: only export internal symbols for
 the selftests
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Shreeya Patel <shreeya.patel@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The exported symbols in utf8-norm.c are not needed for normal
file system consumers, so move them to conditional _GPL exports
just for the selftest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 829c7e2ad764a..768f8ab448b8f 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -17,7 +17,6 @@ int utf8version_is_supported(const struct unicode_map *um, unsigned int version)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(utf8version_is_supported);
 
 /*
  * UTF-8 valid ranges.
@@ -407,7 +406,6 @@ ssize_t utf8nlen(const struct unicode_map *um, enum utf8_normalization n,
 	}
 	return ret;
 }
-EXPORT_SYMBOL(utf8nlen);
 
 /*
  * Set up an utf8cursor for use by utf8byte().
@@ -442,7 +440,6 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
 		return -1;
 	return 0;
 }
-EXPORT_SYMBOL(utf8ncursor);
 
 /*
  * Get one byte from the normalized form of the string described by u8c.
@@ -588,4 +585,10 @@ int utf8byte(struct utf8cursor *u8c)
 		}
 	}
 }
-EXPORT_SYMBOL(utf8byte);
+
+#ifdef CONFIG_UNICODE_NORMALIZATION_SELFTEST_MODULE
+EXPORT_SYMBOL_GPL(utf8version_is_supported);
+EXPORT_SYMBOL_GPL(utf8nlen);
+EXPORT_SYMBOL_GPL(utf8ncursor);
+EXPORT_SYMBOL_GPL(utf8byte);
+#endif
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
