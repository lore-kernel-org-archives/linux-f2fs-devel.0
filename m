Return-Path: <SRS0=VsZi=AT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4932EC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:12:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A79920658
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="i9QXCCSs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UyjZZsm5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="erHv15Fv";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="L6GJq+Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A79920658
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+m/lZhwBjHo3YkDcHCParhwJtNjbn8xif53uKFwzc9Y=; b=i9QXCCSsSLJ925kgVfQXU6vqtj
	qtWuuTlzvKZuSoS5AVJWHhq6sgQbBzbM8LKaGn4pHnJqpPG0fi1PmEYFcJBgc5UqqScpM723Nr+xA
	lBu2ad26c4upWHlRjSFkmj1k0z82qb7RWs+zfEQR9ka278tTNuQSOLA0VWSmSsiryHWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jt68H-0006aG-Jw; Wed, 08 Jul 2020 09:12:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3CI4FXwYKADkYmjnZibjjbgZ.Xjh@flex--drosen.bounces.google.com>)
 id 1jt68F-0006a8-IE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 09:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7bHMgVkDYjjDuKD/FxUCTfJj58TUqovKzQoEEeq5jVQ=; b=UyjZZsm5w7SgUgE1uMTA1fl7y0
 YbZRK+sIQeQeIovAS4otS2rQLaAPTIateDUMyNR29NPhL0uPC0Zis8cl5vlpxjROMf/9P6YFAYOb4
 LCU+HPj+w2ERsyGnDoh/eaz0zf97dolVIopDXCZjwoWdGP9K4kjUFOb8od9mYXxT8qN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7bHMgVkDYjjDuKD/FxUCTfJj58TUqovKzQoEEeq5jVQ=; b=e
 rHv15FvhppDe1cWuBr4Kb1yMaSMeF2CYOV+6Bb9sw7BgoOnsPvUdXWW4zbHQeXtAzsPSnICaOodM4
 bzO5u/PLaelG3VEG19yZkABKuiHFLEELXCkwtGhN8SJ0u7Xm7PQcL87K9ON5uiFB3zbGnwvKFVdaJ
 GJ4k29FJ/6IleUPo=;
Received: from mail-pl1-f201.google.com ([209.85.214.201])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jt68E-00H7XG-BY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jul 2020 09:12:47 +0000
Received: by mail-pl1-f201.google.com with SMTP id x14so16880606pln.18
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2020 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=7bHMgVkDYjjDuKD/FxUCTfJj58TUqovKzQoEEeq5jVQ=;
 b=L6GJq+QmffCuIO7dqu43ag2+8gyTCJKALyR927sB9QwrDr8ea9dQSlepyzo1/pbivU
 81VhNFeTc5ba4uNGCOKWwR6NtWw3vTd+Qu+tpL+mhk3YiLgeQ2bQlJ6iQV3e/a7Fjc+a
 Zima/ekvuWZZS6ASF9jCKBu37/A2Jin6Iy8Wn+pguLOztRhTnk0KTHaPooojcoZ/EuZI
 sYuiK6cbscTme8vE2a3QaDKbA/ZbUTqQ1RaySTP/XI6ilapmzdSCczpfKItt9bDiD5B5
 qGfYbnSRxkatzVYIsfGsnlJDgXk4iEpvIVtLpfH8c12B6aY5DEyiILWeDMM0HQEhPPox
 cUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=7bHMgVkDYjjDuKD/FxUCTfJj58TUqovKzQoEEeq5jVQ=;
 b=NEwuCHK1/j6CVzevAE6RCpS6BPAazqiHgs8tDXwesRYDpXpwaUKT55PZJNrk90y6QX
 w9hgWSVNLfk+0b7G6Ni/bu3i+wUwQb9zuf7bcJzUN9xE6UOjSkZrLZUcPnZ9OFlkwjjX
 hTZ5Iw4kegkz18+Uo9ktz8fr0MaPFSMGc3Ulh3RgbepfpkLlkA5Z4ca+03S51psqdsxP
 JHM9uHJc887FeDtvvmKIA9hJ4STyQ68P5Cc+Eja3OEYmXgjqeaSilR7fDoVLDFZwKoVA
 zejZ5hTnR/jsrpQ0pskcASSEUQoDQah0tK6D1SVHE6GtvsqixIzEC+AP9/Byd5+WyUwe
 k+fg==
X-Gm-Message-State: AOAM530heW+5RwdTrtzEZyCyBjV3Oiirn8fMB4u/TuCWgT2GW+MkGzsQ
 jvTAsiOggOq94AfIZgj20pAYjDiOqqI=
X-Google-Smtp-Source: ABdhPJzFvfpDeyxPhbKxpb3zpnUW+cZnsByq5J9vChYiBZ95cs4wd1HMbcH72CKn2IWI+wWEMSs035Y65Co=
X-Received: by 2002:a17:90a:7103:: with SMTP id
 h3mr8662006pjk.34.1594199560750; 
 Wed, 08 Jul 2020 02:12:40 -0700 (PDT)
Date: Wed,  8 Jul 2020 02:12:33 -0700
Message-Id: <20200708091237.3922153-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
To: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>, 
 linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
X-Headers-End: 1jt68E-00H7XG-BY
Subject: [f2fs-dev] [PATCH v12 0/4] Prepare for upcoming
 Casefolding/Encryption patches
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
Cc: Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This lays the ground work for enabling casefolding and encryption at the
same time for ext4 and f2fs. A future set of patches will enable that
functionality.

These unify the highly similar dentry_operations that ext4 and f2fs both
use for casefolding. In addition, they improve d_hash by not requiring a
new string allocation.

Daniel Rosenberg (4):
  unicode: Add utf8_casefold_hash
  fs: Add standard casefolding support
  f2fs: Use generic casefolding support
  ext4: Use generic casefolding support

 fs/ext4/dir.c           | 64 +-----------------------------
 fs/ext4/ext4.h          | 12 ------
 fs/ext4/hash.c          |  2 +-
 fs/ext4/namei.c         | 20 ++++------
 fs/ext4/super.c         | 12 +++---
 fs/f2fs/dir.c           | 84 +++++----------------------------------
 fs/f2fs/f2fs.h          |  4 --
 fs/f2fs/super.c         | 10 ++---
 fs/f2fs/sysfs.c         | 10 +++--
 fs/libfs.c              | 87 +++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c  | 23 ++++++++++-
 include/linux/f2fs_fs.h |  3 --
 include/linux/fs.h      | 16 ++++++++
 include/linux/unicode.h |  3 ++
 14 files changed, 165 insertions(+), 185 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
