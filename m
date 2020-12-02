Return-Path: <SRS0=BY5/=FG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49217C64E90
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Dec 2020 00:58:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6282076C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Dec 2020 00:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6282076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kkGTO-0004MU-B2; Wed, 02 Dec 2020 00:58:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <robinh3123@gmail.com>) id 1kkGTE-0004M0-K4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Dec 2020 00:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GphdbdQu3Kcknrat5HROBpVaQjVumjoHB33e1WX0twk=; b=kTSK43AWsiCJYRvoz4oTNOwEMU
 H/l8Cgn2gA9rWz5nZ6BT/PixZQpm67F/BJJPeRwg8w9WJ7sbt44XgKkRWCg/ixy4gl8znalW0+mA6
 /E4ieo5UxI0sqpkaXrCzMwCK09w0QgMEz/4/Y4uoEvmLu36Vs8UaMyG5Y5yVXUqzwX9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GphdbdQu3Kcknrat5HROBpVaQjVumjoHB33e1WX0twk=; b=O
 XekMqL5IYLmRcGLtRtfM7msxxL0wW2QbM9P+G8PhSA2YEhZt+kDP7HLdck9h4UvnI82EbG7w9GYef
 Uoz1nutw9jN1wlEhv0JNG0fACPybdR68Khk9lLBRQwADq5RiR8AXuv4ugb25mTfVeNTSfbr/AiWWr
 Gs3lL7vFN7K+3BdU=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kkGT8-00ACOa-Qi
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Dec 2020 00:58:12 +0000
Received: by mail-pg1-f170.google.com with SMTP id m9so21103pgb.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Dec 2020 16:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GphdbdQu3Kcknrat5HROBpVaQjVumjoHB33e1WX0twk=;
 b=Qc51ZzY2fYZ0pmDf1xci/XKQNJX430V8oMhsEEKZdqboYbIxQbh1OYoojtIdWK7h/y
 s7ufRNCdvgtr3PtQjX69l636MmwVOEjh8vz81imyZeufNJa6JpPuX3QuYjOusPmnM4/4
 V7i50NrZl/4AqswMbNBMgS+bkN2VgF4RW1CEj5SxYDfNlGAGv1DiYPobGWb2fqvuAsAb
 joVFcypy6BAON+PUuu3oDIJ9eRF29b0iTXe1r02UFXyc4LeS3K942EBQsIjoeNLRmsE9
 dBRb0oJ/dt+vwGXbt3LjVW69Rl79mjG+kesNYGWGQeOi67aWcFGcpbQH0IFut9F0FdqK
 FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GphdbdQu3Kcknrat5HROBpVaQjVumjoHB33e1WX0twk=;
 b=Yt1YG26uxUOundDWI+0WqpWKXB5AegOTbyKsbbm5s14ahoC9DfUr7IIpi5QvZ2PkhM
 Cxs6k9+JT4cYM3QZS9f0ksZSX7Csfw//A2sQZYIjPiImfXeZi8TtYxMIHJ7rjgAfTJiI
 h2E9q+w+J2GMcfM+avsoT5W3Vsm6zXMHkPS1TCxD7/cBd/QeSUQDcuQ+9C0f947KNmPI
 4Ntej+EW4GX3s4ccUXhnkWXhkFFzOOaUrx7uIUzW1Ly10a9HzoFXVzO0aCAZyLX0ukqw
 A+PT2ntcC7LUjk5US7tylkRjmzoE9pKfAN+AN7GqJETDXUxGr56RFTidfyV0bIoAkM0+
 tAIw==
X-Gm-Message-State: AOAM531Ht81xh3KsVTrpxIddjActYb2dwPpy1IyAmcIBT3JApE5X//7q
 MuQD2oZQo4JyGxvgBFBVdLGKPtFe9/U=
X-Google-Smtp-Source: ABdhPJwVlO1P3SS8ahJQ1ifd3CV1j+lkNFBxXbaPu0Ti/oSFT8y59weZMiEPjR+mdtGD7sWyx0gsFw==
X-Received: by 2002:a63:3305:: with SMTP id z5mr243875pgz.321.1606870673810;
 Tue, 01 Dec 2020 16:57:53 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com
 ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 by smtp.gmail.com with ESMTPSA id gz2sm116974pjb.2.2020.12.01.16.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 16:57:53 -0800 (PST)
From: Robin Hsu <robinh3123@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org
Date: Wed,  2 Dec 2020 08:57:21 +0800
Message-Id: <20201202005724.691458-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
X-Headers-End: 1kkGT8-00ACOa-Qi
Subject: [f2fs-dev] [PATCH 0/3] f2fs-tools: sload.f2fs to support compression
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

Robin Hsu (3):
  f2fs-tools: Added #ifdef WITH_func
  f2fs-tools:sload.f2fs compression support
  f2fs-tools:sload.f2fs compress: Fixed automake

 configure.ac            |  32 +++++++
 fsck/Makefile.am        |   9 +-
 fsck/compress_wrapper.c | 102 ++++++++++++++++++++
 fsck/compress_wrapper.h |  22 +++++
 fsck/fsck.h             |  15 +++
 fsck/main.c             | 154 +++++++++++++++++++++++++++++-
 fsck/segment.c          | 202 +++++++++++++++++++++++++++++++++++++---
 fsck/sload.c            |  67 +++++++++++++
 include/f2fs_fs.h       |  76 ++++++++++++++-
 lib/libf2fs_io.c        |  33 +++++++
 10 files changed, 695 insertions(+), 17 deletions(-)
 create mode 100644 fsck/compress_wrapper.c
 create mode 100644 fsck/compress_wrapper.h

-- 
2.29.2.454.gaff20da3a2-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
