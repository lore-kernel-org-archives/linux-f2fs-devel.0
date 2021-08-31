Return-Path: <SRS0=+lo7=NW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74524C432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Aug 2021 18:19:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BFE61051;
	Tue, 31 Aug 2021 18:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29BFE61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mL8MU-0001U9-S2; Tue, 31 Aug 2021 18:19:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1mL8MT-0001Tm-Q7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Aug 2021 18:19:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YstY0yi7sHQaUESjxdk6tuHbKTvoqF7wS40rbmBQ2Ko=; b=E+MD82UqrJc00cRlfpOU3z6f+6
 5RMg5XeOlcppt6tKGKdEVIuS3QXlBRp8L2YbFcG9SVRwGB/WYSA96YvIZ8EQLBXhxgcf+p5IJTR+A
 s1Frr/hNw7159CxAQh+QZpacyjcgn5q3zQnK3+xDH7m3sb8Xqn9ISHS6zLw0ZXkflosc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YstY0yi7sHQaUESjxdk6tuHbKTvoqF7wS40rbmBQ2Ko=; b=Gt3fWkWs5p9eOs0IncB0PR8bDf
 HpSaRY4lFLJWjQrq4rzXOLYj8uniZKdAfak0DaL+mpU1JRD2iFGC3y9SiLW2bce6Npb9+qER2deJ6
 BBpsltRg2tPiIQ4dk0DaikUgesnrEusHPfnsuaDbwWkZ99BFkVUlMu7yk5Ai25g+KU9o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mL8MR-009K4F-K4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Aug 2021 18:19:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPS id 0977D610A2;
 Tue, 31 Aug 2021 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630433972;
 bh=bYOm9k54W81A+1Vn8yp1T3a/DjAUIAUvtrbwF6XPC84=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Tk0B73ZMO/e2fjFDAvgwCuWrvclcS4MCaCPmR3VWQEB3CC9sp3ioRMkmFuYiyEmVo
 88WfbrUBoHKz2D8u4Jps69JR18qbnIxEgW2PFhqUeW7ewn4SE37dnM1I5Lzrx1yWnm
 3ZllQ7iUb6W0CrKYP8Cs98E5nYQ+8I6C35++WycTBSa5TgP4mLs57LZLm/nrtwPihb
 bR/eA/t7BMzfHAKKht94l6W10zSkI54j2Zr4RPER/T1y7iaYp1RodkhDD0rYbq8YmW
 QfIqade7K+ql1Oe0Kg1DVPfinb1E/Jjo+OvkKH99xv3q3HwB5e45glgxPjT/6UKNbY
 cJiM2mVbEGpHw==
From: pr-tracker-bot@kernel.org
In-Reply-To: <20210831162355.GA9959@magnolia>
References: <20210831162355.GA9959@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831162355.GA9959@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-5.15-merge-1
X-PR-Tracked-Commit-Id: d03ef4daf33a33da8d7c397102fff8ae87d04a93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 916d636e0a2df48be48b573d8ec9070408d7681f
Message-Id: <163043397201.24672.9933339306647625236.pr-tracker-bot@kernel.org>
Date: Tue, 31 Aug 2021 18:19:32 +0000
To: "Darrick J. Wong" <djwong@kernel.org>
X-Headers-End: 1mL8MR-009K4F-K4
Subject: Re: [f2fs-dev] [GIT PULL] vfs: new code for 5.15
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
Cc: Wang Shilong <wshilong@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Tue, 31 Aug 2021 09:23:55 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.15-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/916d636e0a2df48be48b573d8ec9070408d7681f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
