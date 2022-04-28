Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB39C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Apr 2022 22:30:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nkCeS-0006cy-TC; Thu, 28 Apr 2022 22:30:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nkCeR-0006cm-8x
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Apr 2022 22:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZKMEGI3aDCF4Hb/w532lTrDHni4JK/XD1JSEVzKbVlk=; b=hQXZo5aEm0sLvEOuRClhXPuyRj
 IUV9mJn9LYJImStus6CJ0+hyHkWXb+arz9K8xY5BL77N6yKi/VuCk1bq/TONKnjaA5ie4d2SrQLHj
 ghja9tI3yAkaPf8NUpdvlU0uBSl48HOREjlNDjpA+Ukq34UVXZlOhkPqTVRVguejDD7M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZKMEGI3aDCF4Hb/w532lTrDHni4JK/XD1JSEVzKbVlk=; b=V
 VF8dSODrNuM0sw0rTztKdp40tR/1imZ2A4a+IwbvpLAsW9Bq0oaGrFZpThSIygr6hjE2yc9P3qmXe
 qy+pVfyrZPnnAxqtsGxCGtdBnefhgytuujbxlY68SZtO7CJ8q8XyXwmkGBPItYKEsDscSk9cpbdWT
 MhahY3mC7TKIG7t0=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nkCeP-00DFZW-HI
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 Apr 2022 22:30:18 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id F32B91F4247A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1651183840;
 bh=bcfClgonf+RR4NyaZu4xkE6VsQ2rDh7rY79Hk2fkr/0=;
 h=From:To:Cc:Subject:Date:From;
 b=n6W+0k1R5Hnp5cLFsP8gLdcYlA2KDLKx12h/b1DC2byjWE3xs7D8z1Y5f9bYLlQxA
 6ejaZiPS6Idg8XOKU+bX8ZnlFB7KeW5vTK5tZyqoIa6L9khwCwC62OYQia7VVHT7ak
 JpfJFecAaLc4QnIncRvaGmyRbOn9YoxS6i7Ri99GO2aTgStTeHKxGXT1zXd+6AuMA0
 f1QZJ2aQ0lgcAHhM4fXFselCaI2h0qlzpO8JD2kGjv/JNnw8RaPBStiZ74jkJ5k/hu
 ijQc1Qrvw3ZbPGh/SUODOxLDc9Rme8ZYdBmn2ta63HXnob4d9eZSRFcrw1SWP8qw+9
 95dcCFsUrplQw==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org
Date: Thu, 28 Apr 2022 18:10:20 -0400
Message-Id: <20220428221027.269084-1-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Headers-End: 1nkCeP-00DFZW-HI
Subject: [f2fs-dev] [PATCH v2 0/7] Clean up the case-insenstive lookup path
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
Cc: ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This is the v2 of this series.  it applies Eric's comments and extend
the series to complete the merge of generic_ci_match for ext4 and f2fs.

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal of extracting ext4_ci_compare into a helper library that can be
used by both filesystems.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. The final patch
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Gabriel Krisman Bertazi (7):
  ext4: Match the f2fs ci_compare implementation
  ext4: Simplify the handling of cached insensitive names
  ext4: Implement ci comparison using unicode_name
  ext4: Simplify hash check on ext4_match
  ext4: Log error when lookup of encoded dentry fails
  ext4: Move ext4_match_ci into libfs
  f2fs: Reuse generic_ci_match for ci comparisons

 fs/ext4/ext4.h     |   2 +-
 fs/ext4/namei.c    | 110 ++++++++++++++-------------------------------
 fs/f2fs/dir.c      |  58 ++----------------------
 fs/libfs.c         |  60 +++++++++++++++++++++++++
 include/linux/fs.h |   8 ++++
 5 files changed, 106 insertions(+), 132 deletions(-)

-- 
2.35.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
