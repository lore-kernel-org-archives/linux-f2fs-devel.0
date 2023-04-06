Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056D6C77B6C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 22:11:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkXpf-000579-7l;
	Thu, 06 Apr 2023 22:11:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1pkXpd-000572-UT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 22:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=coZsMe54O2WSL+5w5BoY6nl+KvcdiCirzHOFGrcIRw0=; b=TUdL2iDyO3oODTn9i3/S1zfPDN
 332qpXSjmTlGHMweGr4cPhjduNkdnq/sBG2Nkz1exscN0txYysYWAHGwfGFjNNQ4d9ETiitlcMLqx
 Tf8yB6NKk73+wT85l+lCzdgnsQT9Q5ou/mLS+gLcWs84eS5MfAFWjAwiUm2Z8FZQo4hw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=coZsMe54O2WSL+5w5BoY6nl+KvcdiCirzHOFGrcIRw0=; b=J
 mPaoHp6u+ygNrzOizzuwmX88TIHw+wp6Rvq5tWSrbF+j8BmcJzE76+YC3qGvUgwjj+vaLews3LAJ1
 w5gzbtYWLM3ONldMKderqZQYuq/OgjZzOh6rnrD2XiJdmLDXb1YpfJOd2B8HAfJw/lDSy171LTVvH
 WYPd7NAsdDwqii40=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pkXpc-0005Mp-G7 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 22:11:49 +0000
Received: by mail-pl1-f176.google.com with SMTP id w4so38687073plg.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Apr 2023 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680819102; x=1683411102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=coZsMe54O2WSL+5w5BoY6nl+KvcdiCirzHOFGrcIRw0=;
 b=oJM5K77GjRqMv6Bpd41LC+NHvLVwDHVeu2rOMxPUtB9Igmf/Kop7pVnXl76pepMJQy
 b9vH/wn3kFN+cNfHVUkmK3n20RfdehkT94Z60l6/uRkfBAYmFuQujl0e1GVhxa4HDb6p
 763KisdDmgJ1+wvBHVgmAmlFIh3/BZ9+GQM2Vy2fGsqAWtLPjXu1vu4FT3toI4B5aUq+
 G774AR4WIXDbg9iri4cN8n36gzC0V90lSFDJXQJMthhUuj4jFZ4X/tXw5Hcw8UPsuGTH
 nrb10qut9SMXCO2456Eo2PwJ40uCiEj5ZZG6DEFc2WEgCOegoCRGKqTPqbeAa4kTkuAY
 xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680819102; x=1683411102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=coZsMe54O2WSL+5w5BoY6nl+KvcdiCirzHOFGrcIRw0=;
 b=aWjqM41A/rgQiZ7VovHhJS5CnCbeFo5AWN1Dh4xedsHmtyyUpv+km4o7Rqk/A4Yj2W
 49HTbAMf7vBxtjR9sAsXebqH+NLy01+PmnWe5v5Z879mG3+cZ5c10QNQQcRGQbHaO6bm
 4orjHuq7Y26oA08iIQ/hnMwt70XtNnaYIRXySRFeEpaNM4/J6W5qnllw4wSdNVxf4jam
 loFn/oY+k4QhCPyqrKLC94WdYhLchRKPjISkuHYFUe7JCo/itkh5vFMGCcXATH94bEHS
 EZA4Ux7JNaBsUvftvb5IIszvEOEsLXBqSBb0Szs1DW3IiCAxsos22QnmHGVKjtVy5Nl2
 cZ0w==
X-Gm-Message-State: AAQBX9dNlHT/zlRjPifq6grSQ8xLGi4gEn+UfguoIF43Ce/7MkFKodNC
 DJEf0BqbfQFjLfY+hmWiCuo=
X-Google-Smtp-Source: AKy350Z9b02DnKIe8F4w9l9G+VBL5Gc07oMYUeX0T6YbRsAIQMypA0GOgfmY3OCYtWtHm5MC9FLfVg==
X-Received: by 2002:a17:902:db12:b0:1a2:afdd:8476 with SMTP id
 m18-20020a170902db1200b001a2afdd8476mr776461plx.2.1680819102029; 
 Thu, 06 Apr 2023 15:11:42 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:15c:211:201:d05a:228f:924f:be2])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170902c3c100b001a053b7e892sm1807465plj.195.2023.04.06.15.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Apr 2023 15:11:41 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu,  6 Apr 2023 15:11:04 -0700
Message-Id: <20230406221104.992322-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
X-Headers-End: 1pkXpc-0005Mp-G7
Subject: [f2fs-dev] [PATCH] f2fs: fix passing relative address when discard
 zones
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

We should not pass relative address in a zone to
__f2fs_issue_discard_zone().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc0734e4fb92..84e2e558ea99 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4942,9 +4942,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 			    "New zone for curseg[%d] is not yet discarded. "
 			    "Reset the zone: curseg[0x%x,0x%x]",
 			    type, cs->segno, cs->next_blkoff);
-		err = __f2fs_issue_discard_zone(sbi, zbd->bdev,
-				zone_sector >> log_sectors_per_block,
-				zone.len >> log_sectors_per_block);
+		err = __f2fs_issue_discard_zone(sbi, zbd->bdev,	cs_zone_block,
+					zone.len >> log_sectors_per_block);
 		if (err) {
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 zbd->path, err);
-- 
2.40.0.577.gac1e443424-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
