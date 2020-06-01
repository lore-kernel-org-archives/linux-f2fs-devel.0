Return-Path: <SRS0=qeLJ=7O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC20C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jun 2020 19:35:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591EC2065C;
	Mon,  1 Jun 2020 19:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CSUhjYOR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DFuzikl9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeExiaz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591EC2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jfqDL-0002YI-5p; Mon, 01 Jun 2020 19:35:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1jfqDJ-0002Y2-PP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 19:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yd8dynrFpf/G1mm4omkjOEOxOrwVlPbrkdvAkY5+iJE=; b=CSUhjYORAWrPVdSfvT8YpWLuzm
 BdlHFixTGTfumAGeLucfNEFpSf46tY5r/aM7R5S3WL2a/6t4JantenDQgIWg8kRkA7HA6fZ/cjyCU
 4imheEa6UCtU72FFNP+U61ef4gpeh0J3iPdRTKJiNanvm/NXqxRTqevnMDmOSeqjW+K8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yd8dynrFpf/G1mm4omkjOEOxOrwVlPbrkdvAkY5+iJE=; b=DFuzikl9xcKla/A82ZNi0f5tTQ
 ARXT/9C98SEwv0Sj7V4GcEUHJEmYlN1eJ3CQRuMExgjJZKDeB0LgIKog61MDGoLyN/8Zdj2JSrKRy
 B/5UwufigeY7Ccree2yaixaxaFobNTYa1esYsYyPW9zNSLrGQAfCN5taw6MqMR4//qVY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jfqDE-004f0m-G5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 19:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591040103;
 bh=FG5YZrumuxu+SUe9tE67sVQlsmLyNC7e800RwFody5U=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=KeExiaz9m5h879IZ1BEQl3nEkk8hevGPTuX/HTBMuE2abZI2ifbmaB5R/CNVUeKdW
 Zy0uNXJWso9ocrLXtq6DWF3YggXoBfGdMb0/UA5DY/dnhFAeX+EgV/wRrplS8o/GUO
 WFI1fbrkwDNfuAwAhSlYazDURGbqszfUUDgf6SE0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20200601063150.GB11054@sol.localdomain>
References: <20200601063150.GB11054@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601063150.GB11054@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 9cd6b593cfc9eaa476c9a3fa768b08bca73213d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d67829e11863072aec7cd1dd2939b1fd3eda17b
Message-Id: <159104010315.18844.6258170183596402649.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jun 2020 19:35:03 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1jfqDE-004f0m-G5
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 5.8
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 31 May 2020 23:31:50 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d67829e11863072aec7cd1dd2939b1fd3eda17b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
