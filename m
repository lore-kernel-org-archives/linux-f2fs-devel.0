Return-Path: <SRS0=GA85=N6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A70C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Sep 2021 21:51:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AB561158;
	Wed,  8 Sep 2021 21:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19AB561158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mO5Tr-0003JO-Jp; Wed, 08 Sep 2021 21:51:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1mO5To-0003J8-A0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Sep 2021 21:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DYwdBLFxgU/FQsPLqTdOI4bhk/Ofsvoo4/N9eNpc/gY=; b=FebGejd8Oi9Hx6wrjCOEWFoInH
 VpymeTbG4L9y6J196Zb38qLrGFEdh/pSIxcrJAd+d6SulO+W2eoBPLw/wH7f5hRj809aQ0DIBOmt3
 GX8noVY6nhQJHUxq1OZRmQAjUOgxWPHeph9lJqPJt9rYBklc3Uvdwtb3YGyLVpSqVKVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DYwdBLFxgU/FQsPLqTdOI4bhk/Ofsvoo4/N9eNpc/gY=; b=m
 E1dSA6Y+Nhu6KY45bpNcFbpMAY0Yj3ATpZlt4LX/ms/LdPyH9XLeiGuutvQFt8+4lU22Yv63V1fvF
 G8ANCMzE27B14LBCQ6hztsHSKTgid1JzgkI/47v6Tn3+A7a/dk1zX2eSmOyYxDpIHbdpl6s8sI9TT
 6MnBYdR5ECVwrF0c=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mO5Tm-003uED-Ql
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Sep 2021 21:51:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F27A610FF;
 Wed,  8 Sep 2021 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631137888;
 bh=AXEwcqG3tA0z2Pq2CtpORf9Ep9Dl9pqblNnUmHoDhjQ=;
 h=From:To:Cc:Subject:Date:From;
 b=fdmiZxK8ekMOjOCM6rBVyxzrcFHIcCLOdVoQ3mAnT+m5ceEppiXu/2lrEa7c8RzD2
 hNqe+pQBotx+3L9wWQxIzYJRsllAaqTEV5EzpYVjQ0uQ2WIbO5SA0rrkAEJHVOfhx7
 VKQAO5/mqnwHzMUplqvyMrtTOWdjukY29mBNQGzzTohu9hceIQe/zjqU1T+flZcaDQ
 uAAZudkSVSmLk3BKHCyRxn087bIKIK3HtpXoAUWmIUxqQEeD8YhoPpcEaWwBK4nE34
 aB+XN81vV7v+p2u3DuKwIKvv5pLsGislHlkZ7JkrYF3KTaI0pnjtYKTxi+CX35RV92
 lIss4pNBPmkpg==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Date: Wed,  8 Sep 2021 14:50:29 -0700
Message-Id: <20210908215033.1122580-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
X-Headers-End: 1mO5Tm-003uED-Ql
Subject: [f2fs-dev] [PATCH 0/4] backport fscrypt symlink fixes to 4.19
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
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series backports some patches that failed to apply to 4.19-stable
due to the prototype of inode_operations::getattr having changed in
v5.12, as well as several other conflicts.  Please apply to 4.19-stable.

Eric Biggers (4):
  fscrypt: add fscrypt_symlink_getattr() for computing st_size
  ext4: report correct st_size for encrypted symlinks
  f2fs: report correct st_size for encrypted symlinks
  ubifs: report correct st_size for encrypted symlinks

 fs/crypto/hooks.c               | 44 +++++++++++++++++++++++++++++++++
 fs/ext4/symlink.c               | 11 ++++++++-
 fs/f2fs/namei.c                 | 11 ++++++++-
 fs/ubifs/file.c                 | 12 ++++++++-
 include/linux/fscrypt_notsupp.h |  6 +++++
 include/linux/fscrypt_supp.h    |  1 +
 6 files changed, 82 insertions(+), 3 deletions(-)

-- 
2.33.0.153.gba50c8fa24-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
