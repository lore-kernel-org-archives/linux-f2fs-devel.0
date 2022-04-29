Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D1EC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Apr 2022 18:28:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nkVLT-0001Xq-MY; Fri, 29 Apr 2022 18:27:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nkVLH-0001Xa-Hl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Apr 2022 18:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pzz3TR78yjKnMD8p0e+MAEfO6kQl7yW/9n6UzlnQ5vA=; b=MUDzEezD/WKc9pEaZkhYJBqXfT
 0fwRqRuyx1FnY+zFCnmGDgPXiekmjlEiB4QmFbBBpSOuDeZ+L45SP2HPgvHUvt0LwZDnl3iwhIoTr
 cRof6DUFn8unp2lpp432VtIBBas98Jt8aE7ADglPq/IBLlvZAwZ2W2jmWfC+K+SWfW88=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pzz3TR78yjKnMD8p0e+MAEfO6kQl7yW/9n6UzlnQ5vA=; b=G
 OcV5e4uLOSlK77sR6hg7PKMChfhVsIYw27kq8CgwbIK0gvETcIVT/nTZotgpl/OLYycqSh/FoXD7y
 w2Ab72eEnzbvdNUJhuuAXUUiukNr4WfSKs4GLgW2CGIBzHNJTejU2beCuIbGO8ox92hOZX+BI/IF9
 ku5aK6N5Ybyym+ew=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nkVLC-00E43V-Bt
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Apr 2022 18:27:46 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id B275E1F4690E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1651256855;
 bh=BennjuHd6cboenERnfAOrIYnBLd5KMc0poz3LPBQ9hQ=;
 h=From:To:Cc:Subject:Date:From;
 b=M07arppDaVxsrRh+13BjTik245FkbwpbvYdveXca5NR7rll6mK85puUsuqYBuNxTv
 36b62YjR79DPSKBsaxSw3fbsOmAWdRHs7MNP5CBjXm9BI9rQTgS+EcoirCv4kSeADT
 hswVnZUTnj03JstDOzUm+mjFs/PoBFo1j5zwj4JgpBqKYIGgzUIKXuZJwaIHvDDp8B
 /zOaoshm4KeWVBUKmmHtQ6teirk1YScRsVR4unylK+XeWFUhn7d15PmPfkrzmKXVLn
 9ZBuKdx6jGfrh7lopvDdU0jaGPU9VJ0YHSM/6ZemSOIA6nq5oJJ032VBYVnZw66U8o
 KGNPWpAV/1i+A==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org
Date: Fri, 29 Apr 2022 14:27:21 -0400
Message-Id: <20220429182728.14008-1-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Headers-End: 1nkVLC-00E43V-Bt
Subject: [f2fs-dev] [PATCH v3 0/7] Clean up the case-insenstive lookup path
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

This is the v3 of this series.  It fixes a build error when building
filesystems as a module on the previous series.

* v2

This is the v2 of this series.  it applies Eric's comments and extend
the series to complete the merge of generic_ci_match for ext4 and f2fs.

* Original cover letter

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
 fs/libfs.c         |  61 +++++++++++++++++++++++++
 include/linux/fs.h |   8 ++++
 5 files changed, 107 insertions(+), 132 deletions(-)

-- 
2.35.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
