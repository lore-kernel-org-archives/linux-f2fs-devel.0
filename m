Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D58C19F28
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 31 Jul 2022 03:34:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oHzib-00058r-A6; Sun, 31 Jul 2022 03:34:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <fengnanchang@gmail.com>) id 1oHzia-00058l-4y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 31 Jul 2022 03:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I1eoH/8EfQFYBevkwF3Koqw5qL2Ry0YsGygYjLEXmoc=; b=XiIwGUhT7ERI3fPJtvNMbR3OZH
 Mn0R5C80BBNoR0Ps1VByJnXKgkuhooKt9LOlPzcdZDZzUC5327Yi2l5kJ1sMCm8T20a14bjqI71+R
 sinKlee+syJxjj/nCdt5xXJANpMUVBHZWufFABKcTkgMk57pbSA8Q3vCacu1kuYnaTJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I1eoH/8EfQFYBevkwF3Koqw5qL2Ry0YsGygYjLEXmoc=; b=f
 f57DZFa763sBoq6m+XcGOL6CQjTMozkjIVTG9SFqPFAsIHbU33BS7EhEqc8rq2DaRE88TdRlXuKL4
 uH77BhF8NnMOPl9BaVN4eVKyre3Vzawm4hKJMbLeIsgkp5R+++LiMC9jkcSIO2vwnXxqmuupLch3L
 5ehKatVCVcA409Hs=;
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1oHzia-00FdI1-92
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 31 Jul 2022 03:34:16 +0000
Received: by mail-pl1-f181.google.com with SMTP id o3so7733493ple.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 30 Jul 2022 20:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I1eoH/8EfQFYBevkwF3Koqw5qL2Ry0YsGygYjLEXmoc=;
 b=XgJeWOCIL5cnmC0vSlBgWZU4it2WWMwoxjXy0zWBFZ9fFJHUO4fNts7u6ScMSp67Bv
 dOY+vWPz0kf2JUHb47u5C9k1GTxSao9uht/RVuCISITUeniTjI3+9nt/2cfK14q7SIkZ
 a8w+qE//CZrUCuadxZ1/s3+sApec19MmswUxiQxPD0MSw6KwGdVv47EzMmoWDstXwEJ8
 F1WrjxcfSBIOqzeQ+Xy1z4Kc8EC2llyuVfT280Tut0/riBVssVcdjhr3rGypMw7TswcX
 azoZObQu3ngGBp11PoxcuWZ2z/9yPp66cA8HLNiVs59bxJn1epDbS929p4cy67iIyano
 3EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I1eoH/8EfQFYBevkwF3Koqw5qL2Ry0YsGygYjLEXmoc=;
 b=A8mBIMFI50SuAy7YBtu3r1PFqHqCwl67wxBKlKGhgQ/SUZa2saKZkCnHHhlHQwKoed
 OpO0DAHJpkUs2TYVFHQi5zrXCkmtYf95M/Fn3cT9LpJ4zIR8U+5EyfYC2rtcsROXH8ym
 xx75fgCIpr/xnqF6+nm4fAKLOAd19mzfTxM8MsQr52tpowzgeONUqkeKeIINyy8G9KZm
 tarAvqXXSvM/3npWaK157wD9NWOHbW6lyL4jMUV083R27eof+TfEWHeV6HtjlX2dIjqC
 XlF2Y3c+VXPmhctwR1Nc0k0Lbg0kJkVVurcfmMZ0Ni6KE/OTKn32cvb6au0Lmw7O+jz8
 Xr1w==
X-Gm-Message-State: ACgBeo3H7xIrQ0pvmbKu1N1RZtuMZI6u7sJtMhLHCFb8DuiRjuHKhfmD
 oW0FgwtxS8M8wcTHvhS2EHM=
X-Google-Smtp-Source: AA6agR535GQAVhwYKhWt3lWbnjBMadBxoX2r6MThyDUMFH4XAIAc0bohrpH1cT1UzlOiJfIzP1k14w==
X-Received: by 2002:a17:902:b402:b0:16c:3cab:5910 with SMTP id
 x2-20020a170902b40200b0016c3cab5910mr10858073plr.96.1659238450697; 
 Sat, 30 Jul 2022 20:34:10 -0700 (PDT)
Received: from localhost.localdomain ([103.215.126.52])
 by smtp.googlemail.com with ESMTPSA id
 e10-20020a63500a000000b0040dd052ab11sm5026631pgb.58.2022.07.30.20.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Jul 2022 20:34:10 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 31 Jul 2022 11:33:44 +0800
Message-Id: <20220731033347.455209-1-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oHzia-00FdI1-92
Subject: [f2fs-dev] [PATCH v4 0/3] support compressed file write/read
 amplifiction
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Fengnan Chang <changfengnan@vivo.com>

Optimise f2fs_write_cache_pages, and support compressed file write/read
amplifiction accounting.

v4:
  fix read amplifiction accounting when read one compressed page.
v3:
  fix enable COMPRESS_CACHE may make read amplifiction accounting
incorrect.

Fengnan Chang (3):
  f2fs: intorduce f2fs_all_cluster_page_ready
  f2fs: use onstack pages instead of pvec
  f2fs: support compressed file write/read amplifiction

 fs/f2fs/compress.c | 30 ++++++++++++++--------
 fs/f2fs/data.c     | 64 ++++++++++++++++++++++++++++++++++------------
 fs/f2fs/debug.c    |  7 +++--
 fs/f2fs/f2fs.h     | 42 +++++++++++++++++++++++++++---
 4 files changed, 111 insertions(+), 32 deletions(-)

-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
