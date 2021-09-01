Return-Path: <SRS0=NJ+j=NX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10BC4320A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Sep 2021 16:41:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D7B61074;
	Wed,  1 Sep 2021 16:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 76D7B61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mLTIO-00079i-BB; Wed, 01 Sep 2021 16:41:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1mLTIB-000794-AJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Sep 2021 16:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kq5HkuhagzDb9Rj5718WDfYadIFnQlrS4DP21jFPnO8=; b=DFSAlde1x+V4A6anch49dFYRN6
 M+FxpV42h3KpLqRVDRQ57o+sKOesLO0iKhykgWTHCII+avhX04b62trGPGGJJBY6GVhJ3uvdcUNl3
 T3FKcTLVVFTBwmIMZAVQtSUScdxDYH9cN8dadi5Rm5iI3FflcJJaXpi1TdzGd/0b96f0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kq5HkuhagzDb9Rj5718WDfYadIFnQlrS4DP21jFPnO8=; b=l
 ukexqyhegMrdeSvJgIWFCa/0C50YbeG3cmfJ9YuVhn83zScaRrYFLpLd6xrjhOpkbcfW4zjsOAHT/
 EAsWPoYniMQUQ6AshIxTr9UzzwDE/WU0wiVG4E0EL8v/c4fa1CUdN91ybvsidS0wypmsnO4xoDUel
 ApHofPwUm3uUOOio=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mLTIA-00009o-7L
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Sep 2021 16:40:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 909566108B;
 Wed,  1 Sep 2021 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630514444;
 bh=mB2cwuX11vBXy1XtIvBkgbVTYycu/wT4dazyfxEhyIw=;
 h=From:To:Cc:Subject:Date:From;
 b=Nx3R5G91wUdm/u5yAlifz4js1QqtEwfml0EHVmqE3hWmjaA2NFzpiBraUo4PFSWOz
 fRYFrLXMBJeytxKQU0oa4FUzxbyxicwpraxknzgzLNTwYZKY45s6Mc2XhMzC39j4HG
 fvL07lASQFvCmefOMQSW2oaqUopXFO2ajIwQonzbQCOhYMD+wlBN53DPpOH4WI94k7
 r45PYUBYwQQ3aHb5PvsKN325REiyMUbyZqapdObzfzMkO/cEU1WcTnEB+WgWimPVHb
 Dk8N/LjoQFR1DvYk1FV3YYwqRfNTNC1mgVXyXIqXIPEN7DJ3VPbHSWyNALHDF86ijp
 pGETRjYVsuiUA==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Date: Wed,  1 Sep 2021 09:40:37 -0700
Message-Id: <20210901164041.176238-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Headers-End: 1mLTIA-00009o-7L
Subject: [f2fs-dev] [PATCH 5.4 0/4] backport fscrypt symlink fixes to 5.4
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

This series backports some patches that failed to apply to 5.4-stable
due to the prototype of inode_operations::getattr having changed in
v5.12, as well several other conflicts.  Please apply to 5.4-stable.

Eric Biggers (4):
  fscrypt: add fscrypt_symlink_getattr() for computing st_size
  ext4: report correct st_size for encrypted symlinks
  f2fs: report correct st_size for encrypted symlinks
  ubifs: report correct st_size for encrypted symlinks

 fs/crypto/hooks.c       | 44 +++++++++++++++++++++++++++++++++++++++++
 fs/ext4/symlink.c       | 11 ++++++++++-
 fs/f2fs/namei.c         | 11 ++++++++++-
 fs/ubifs/file.c         | 12 ++++++++++-
 include/linux/fscrypt.h |  7 +++++++
 5 files changed, 82 insertions(+), 3 deletions(-)

-- 
2.33.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
