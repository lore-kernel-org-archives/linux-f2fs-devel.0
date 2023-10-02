Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAADE776CB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Oct 2023 23:09:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qnS2v-0006zN-3A;
	Mon, 02 Oct 2023 23:09:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3s00bZQYKAOoPdaeQZSaaSXQ.OaY@flex--drosen.bounces.google.com>)
 id 1qnS2u-0006zD-Bn for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Oct 2023 23:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h+VrPtOekhb8+q73onDrKN45JQ6nX1n1Q4LL4kdfewA=; b=b+9JIpQdkAOJk6wwhZKEBDuG9Q
 +ld9mE1QU06SbIg6pjTXH6d6uOLwrokGYUeJ0pubuwlhJeA4zFy8DBd4rjyjtyiUMEhSGfAJtxlKq
 e7141EFj00sWqB9Y9hcXo1Lb+XebxDboiUBQF/TpobY2ORXkposaCjOCMwQX0Ozv55Jc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h+VrPtOekhb8+q73onDrKN45JQ6nX1n1Q4LL4kdfewA=; b=D
 W60bYN06UnpvOFbIjw9SmtHrkVbrhrTJCRLQwwJPH0I7rDhisE/pO7QzILkTyKKvgCmj8+/UM8Toa
 Iy7csnYH5buzRZ9nsFqIcevuOGw+VE3ZVWvTc1UI8EgAyh3Q2aM4HeTIU4YNPP8/ykWsDFI7S8wA/
 Izk6LKZyXKxm9DgU=;
Received: from mail-yb1-f201.google.com ([209.85.219.201])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qnS2r-00GeZz-2i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Oct 2023 23:09:48 +0000
Received: by mail-yb1-f201.google.com with SMTP id
 3f1490d57ef6-d7fd4c23315so469032276.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Oct 2023 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696288179; x=1696892979;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h+VrPtOekhb8+q73onDrKN45JQ6nX1n1Q4LL4kdfewA=;
 b=zejLNnNdJajlRfwBx6RNh8K7B1hGSGZ9Fml4InO1ngjcCAw4XyZv7AYRb4sYLfHAbl
 RYCWeJhc3aJMMireAW3yb+OCJ6D4I80uXDAopBlzXmAErmKMDiltvmUBgEFjGHKfVtw1
 uD6xlvkRiO3ehfUNSE5qCfPKsJd69c+xrfdjx8N3OdYlgatCr5TvXzmpE34OgZSrzkvG
 p/tV2qchc4MSrMGp2HNQ4qTCIFkWiXgVlLY+fED/Pkn9TDyiM7U56jnXkiq1DKqGH1QG
 TfP3HreUlVVxHh+8fxXQSUIucjf6Bs+Y8TxgRDUrKL5475dXyqngXGtuN210kGFQWH2l
 O47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696288179; x=1696892979;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h+VrPtOekhb8+q73onDrKN45JQ6nX1n1Q4LL4kdfewA=;
 b=OAs+8C6Rir19ILyypURG7tXuoUzi8CAXWHPpeuljDXDBgtAge96+TF90P/cf7EPnN7
 bCiyJDmx52q46DEM9P36Cxrdxu3G7eHsWTszoUsXb+6vB4GNRgGgfy10b+tqb3NrexIG
 /uJ59o2Ed4gFF6PjMLwvj1hXAXBFKpFI/ddX7jRoMEsUEWxvWxxds3BQ9ibYIy51lVXp
 6ackDaAFp5SUaiIuwZiNG56wYTBupMRTa5SbhOU8Vii4kiiEQ9dZF85Sk4POS8/rkkno
 PVdFmdmExRMY3yQjcD/NT5WIVeIR8k5gkCs8Urj13izUOZz7mB8s54aURHz6o7u2VbV2
 GtoA==
X-Gm-Message-State: AOJu0YwiAZu0t7ugm4DnFpSLv/lB/jOSGjLRuQAICKyd6Unt9xNIUEtS
 zqW0CK0M8gbwJLmV7dr5Ea/mCn0yECzPBGSRvcNnnLOTjj3Yrg0/Ly+yhgz+ieJ5bKG4gkzI319
 JYoMhz+ibOPbrKeimSQuH4qa1sFbURraqWnU1y0Yu/3w2xg3YEokOQw8k+FbiMJJnOHuEYb+7uM
 Njtv0hCL0=
X-Google-Smtp-Source: AGHT+IEiQymAa7emMibbrofWKTUTBTNmFDJ5Vgb2eeRJ4K+AIcSgV+sbogBvdxPrJYARMPwpiTai1QF3ZeE=
X-Received: from drosen.mtv.corp.google.com
 ([2620:15c:211:201:459f:6e1a:6be7:55da])
 (user=drosen job=sendgmr) by 2002:a25:910:0:b0:d86:55b7:97b0 with SMTP id
 16-20020a250910000000b00d8655b797b0mr231052ybj.9.1696288179184; Mon, 02 Oct
 2023 16:09:39 -0700 (PDT)
Date: Mon,  2 Oct 2023 16:09:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231002230935.169229-1-drosen@google.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1qnS2r-00GeZz-2i
Subject: [f2fs-dev] [PATCH v2 0/1] Add 16K Support for f2fs
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2fs filesystems currently have two large restrictions around block size.
The block size must equal the page size, and the block size must be 4096.

The following patch, along with the associated f2fs-tools patch set, relax the
latter restriction, allowing you to use 16K block size f2fs on a 16K page size
system. It does not allow mounting 4K block size f2fs on a 16k page system.

Doing that would require a lot more work, requiring a refactor of all block
sized struct similar to the userspace patches, as well as handling the block
reading/writing at sub page boundaries. I'm currently leaving that to future
work.

changes for v2:
Adjusted format string

Daniel Rosenberg (1):
  f2fs: Support Block Size == Page Size

 fs/f2fs/data.c          |  2 +-
 fs/f2fs/inode.c         |  2 +-
 fs/f2fs/node.c          |  2 +-
 fs/f2fs/super.c         |  4 +--
 include/linux/f2fs_fs.h | 69 ++++++++++++++++++++++++-----------------
 5 files changed, 46 insertions(+), 33 deletions(-)


base-commit: 3e729e50d01e6a336132d1739866a6463f82faa9
-- 
2.42.0.582.g8ccd20d70d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
