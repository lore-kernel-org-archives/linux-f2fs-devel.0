Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A163BC77B78
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Apr 2023 18:10:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pr0dx-0000UA-4H;
	Mon, 24 Apr 2023 18:10:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pr0dw-0000U4-2k
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 18:10:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hAebeGr0HKUsZn0g2H3a75o8C6xDncb7NjQ2lbyeOqo=; b=YwlPFqajM1jkpPeksoTwbbbBKc
 RlnQ4uxUVh3YLTdXKX7baYEOUr4lYh/STZ2AiGBak2DPZwD3WWgZJGQmDlFOC6JsFjoOdNPVt9Swk
 h+dLvZki9WJh23vDRn+q/r0ezTTCsVL8hnOB7LaPUIMUxayhH2ZRvOW1Hc9pIqG/z/I0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hAebeGr0HKUsZn0g2H3a75o8C6xDncb7NjQ2lbyeOqo=; b=h/vyr6Yy/QAba6l3FDd6qGlRQH
 zhPX5b7DVDX5LcXmXnpvqKDg1U7j/eNVJN+mR3xxkKQH7HIv/SOGBzBpaQFjctt2n1Ffaoh2/n52f
 IVg5DN4ELQpqdIwcl6NjkD+vUcLQ0cfGC5pAxZ/QGz+K9fPIwxEHQNOYdg2b7REe3RMc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pr0dt-0006Q3-Fp for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Apr 2023 18:10:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 274F1622FE;
 Mon, 24 Apr 2023 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F018C4339B;
 Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682359819;
 bh=ZIggbnNo61Pd9qiJAbI89ZQyfggHn/sva6khpCzkQds=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=nXW528/0qimThez3goOdL5VgfN04J5lJyzvXfzD/aPHw84FDgxojF+1NeW0EpDput
 22NE+bxebHPpbO8ZgfTKckVQT1CpNTLv6ZOomu5RT2oOK9CaufIgox15fWNF8TIy+a
 qHoqSlPdZym8Pi0d26F4ilYZZNdho7ZQvc9GW56ak4OwWhyH5ttwPg74bS2u2Mo3Ce
 B8Mtcgo4gW7wwujjL6GGvPgzT6e6HS4nIKySbS3epkWgWacSQvfiYxjbtYsT1fcCQJ
 ija41oYhDD4NVZJoLvLdXKIBuhCzRjdNakLlovNJlDaj/2EWkFtW2Vt79//sIPrbFw
 fzbq0eLnScHow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 6B09CC395D8; Mon, 24 Apr 2023 18:10:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168235981943.17900.16631584887911592592.git-patchwork-notify@kernel.org>
Date: Mon, 24 Apr 2023 18:10:19 +0000
References: <20230424154440.23279-1-daeho43@gmail.com>
In-Reply-To: <20230424154440.23279-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1pr0dt-0006Q3-Fp
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate node blocks for atomic write
 block replacement
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 24 Apr 2023 08:44:40 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When a node block is missing for atomic write block replacement, we need
> to allocate it in advance of the replacement.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: allocate node blocks for atomic write block replacement
    https://git.kernel.org/jaegeuk/f2fs/c/994b442b66a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
