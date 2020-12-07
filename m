Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB087C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 06:43:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626D0227C3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 06:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626D0227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmAFY-0000fB-1m; Mon, 07 Dec 2020 06:43:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <robinh3123@gmail.com>) id 1kmAFU-0000ex-Em
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 06:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BTCFo1psICK76O3jlTgVwC+qqgFVNzRJMD15/MFmEXU=; b=DRrOdckyVopThotzt5HgeJ7J9m
 I1o9VD3bC868prX/6FJmjaU58wVEkkIX68rBGRg1TzEywAUmdGPOSGoSQcle7rC0x0a5aPswTST+u
 KgJSaAgDs/+x2C44DYAlC0iLAlo4/qmmHqmCn+3jc68JwbpJoLKYnjWF+W4ShjD+CNvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BTCFo1psICK76O3jlTgVwC+qqgFVNzRJMD15/MFmEXU=; b=f
 GbhLFiyeIWil86+0lp8bYi7HBgjDHZbfva0fjCQDUVSJ/z5dmi9ZozNk95lz9ESrUflRsWKUByswu
 xw+eWFix0yMkMF6dI+aXJiQc5dOYYJc11RzKjWfrPPXfJXuHb2uJ7+QD0BMNklLor373MyiasWlc1
 v9oOosEeka6OnErQ=;
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kmAFO-001cDr-V6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 06:43:52 +0000
Received: by mail-pg1-f173.google.com with SMTP id g18so8099610pgk.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Dec 2020 22:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BTCFo1psICK76O3jlTgVwC+qqgFVNzRJMD15/MFmEXU=;
 b=KUlqcBUkfTfoQA6Gf5V60W+KndKC9YB0nfbveaRvFN9BY5Hp+5x8XZGTmy0J4t4cOr
 nLSBsWNbZ9aS2WFVxw8Vy+Y7Ek4AmyNY6yTXOOFM1m/a3kT1ymISp7DRLwLq066CckSU
 v1Q5ixdMGbGF/CARhCXven0qU6pT8EhohJMFYtMvdLlqpdL9xxVL0ZEXW6rFH7dQM7kZ
 kzaFNOzSOi0579z5jNlrWiQ+nBUk+mGc0f2E9CHhquboDmmv0DxdMfQ2hQWRPH3oIi6M
 XDOeASpd2e/jt2bJWAt/Rr4bEfUwh56palWQZxqxs47xQnCqoNB60v91UZJA9Lcv/UWK
 CXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BTCFo1psICK76O3jlTgVwC+qqgFVNzRJMD15/MFmEXU=;
 b=dYC6Qf/c20fqCaosm3Memywbo0ABpGTTC6Y/1c3MkKDZ2fXx7OqdSmUyGo3J8GGXdk
 z6/mTpmMu1x0j7spn9g5hLpSEsWfPMv/c5GSWoabFPAvcMi+7Ux3Kcb7n1xaUl7jn7Jd
 oYb1x0s3qy1mSvyV99q0EIBVr7qG9MyTo47ARzV6tRKfYCYzyVIP5rfIXm41kEjJlDlJ
 Es+dkLL09SbS7lINWaW5FyV8/IXwvAPQaiPcSCVPLbYY26UrDR19c7AHviqHiBlFEHtS
 e/6R82MXm/S45cLmKrBnh4Hf7PuFGS+QJDCOrZgsTLNWK8qctTrqGJk+EbhJhzn5H86T
 W55A==
X-Gm-Message-State: AOAM533Mhlgj3E+qEVwGm3uU2gM8dEACpIz45rOSxV+f7sdWC6YXtWcl
 fVNYPmXXtmWMXou65d5S6E1ONTw/GM0=
X-Google-Smtp-Source: ABdhPJwZ+Lw8B9E1ooTt8TvtEBSpREUdNxzXcXVMzRfRqP+zb69cahYrJW4xPn/sBsTLYsCwxqu3Ng==
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id
 s17-20020a1709029891b02900d8fdf67c04mr14700381plp.54.1607323413740; 
 Sun, 06 Dec 2020 22:43:33 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com
 ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 by smtp.gmail.com with ESMTPSA id o9sm9079984pjl.11.2020.12.06.22.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Dec 2020 22:43:32 -0800 (PST)
From: Robin Hsu <robinh3123@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org
Date: Mon,  7 Dec 2020 14:42:47 +0800
Message-Id: <20201207064250.272240-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
X-Headers-End: 1kmAFO-001cDr-V6
Subject: [f2fs-dev] [PATCH v2 0/3] f2fs-tools: sload compression support
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Robin Hsu <robinhsu@google.com>

* 3 patch set:
  #1: added some #ifdef for easier support
  #2: main code change
  #3: automake changes

v2 fix (from v1): fixed a bug and a more elegant error handling flow.

Robin Hsu (3):
  f2fs-tools: Added #ifdef WITH_func
  f2fs-tools:sload.f2fs compression support
  f2fs-tools:sload.f2fs compress: Fixed automake

 configure.ac            |  32 +++++++
 fsck/Makefile.am        |   9 +-
 fsck/compress_wrapper.c | 102 ++++++++++++++++++++
 fsck/compress_wrapper.h |  22 +++++
 fsck/fsck.h             |  15 +++
 fsck/main.c             | 157 ++++++++++++++++++++++++++++++-
 fsck/segment.c          | 202 +++++++++++++++++++++++++++++++++++++---
 fsck/sload.c            |  67 +++++++++++++
 include/f2fs_fs.h       |  76 ++++++++++++++-
 lib/libf2fs_io.c        |  33 +++++++
 10 files changed, 698 insertions(+), 17 deletions(-)
 create mode 100644 fsck/compress_wrapper.c
 create mode 100644 fsck/compress_wrapper.h

-- 
2.29.2.576.ga3fc446d84-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
