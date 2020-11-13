Return-Path: <SRS0=40Qh=ET=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24190C5519F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Nov 2020 00:44:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7760C20B80;
	Fri, 13 Nov 2020 00:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="O48vAmEg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GbOk0WVX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v4aVOxOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7760C20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kdNCS-0000QC-IA; Fri, 13 Nov 2020 00:44:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1kdNCR-0000Q5-7C
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Nov 2020 00:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1f2/bJJb9PlBYZmD3UslbVOSUrBGjVhe16PNuH0rPjc=; b=O48vAmEgtoIHt8hFVPhyf0k9R3
 m++CwBoL1K8kF1e9lIQj7aZfhhpIWyBiXS66CID5QqOdpG1C3HiGcWSbZPAMiAEKlLQPcBPBjY6yJ
 uM6GOM/ZNscwYSt5YzN2UWBONjiL//O1HuVjC1BaD6gcWBHTUUTMWv1VWKmMcRHrdX6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1f2/bJJb9PlBYZmD3UslbVOSUrBGjVhe16PNuH0rPjc=; b=GbOk0WVX7nrsb4tMgiFVkWCH3o
 FUJyvGUYT1phpdSWCTFtf5ggAubPMUr74jbfU98BNjCWz45343J6TOrDjYBysf8X3xWPKShvmVLXq
 lQuTFAsAuyqQJYr7nO0iNS0tNcr6CCV2Xy4ujL7GKWhnG2FDw+fbRUnOCFlTOPxiMmvk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kdNCD-001PT5-5w
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Nov 2020 00:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605228238;
 bh=BIe5HMjS9gt50Hxj+EvtbJmyK6vmFdQ/47oHVfN9Wac=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=v4aVOxObp/Bh95+DWGWwHvPWYLKI4tS+miiHRyVUCTSXsFZh3G/gb8ZOkRRqtCo41
 xrm/mGmBFFzW8H42Ri1vam2cM2NS3jcU+hyfixzrtf7UMa06AnEFZFOWKWz+18D6Bm
 MLTqgGg0h0LsHGmUdJFJYaYlfABEtJXjGxHXDVSY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <X63CTrVsH3WD+xcE@sol.localdomain>
References: <X63CTrVsH3WD+xcE@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <X63CTrVsH3WD+xcE@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: d19d8d345eecd9247cbe6cbf27aef271bd88aba7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
Message-Id: <160522823863.10618.11737091089665240139.pr-tracker-bot@kernel.org>
Date: Fri, 13 Nov 2020 00:43:58 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1kdNCD-001PT5-5w
Subject: Re: [f2fs-dev] [GIT PULL] another fscrypt fix for 5.10-rc4
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
Cc: Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Thu, 12 Nov 2020 15:16:30 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
