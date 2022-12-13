Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83040C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 05:00:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4xOy-0000tt-To;
	Tue, 13 Dec 2022 05:00:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1p4xOn-0000tb-FR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 05:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m8ohmeLWoDBJjf/5CCyKc3b1Qplr7UP7xhqVv/Dl628=; b=Bmr72d5W9zHvyRG5ycKaJfvHkm
 Uj12NwVs5b3tIR7iiZjbiD0B1pJJkOp4MQkjcTMQWy4Sysu9NkQhxRaN9KY8pYyUNXu/IuKgXwXlQ
 1N27rzlbkXkQHSk/KNrg9G+ONrdUwaTw8eQTsuM0DzjnxynlvgfudaiTGMgDrUB2Z3lQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m8ohmeLWoDBJjf/5CCyKc3b1Qplr7UP7xhqVv/Dl628=; b=kfrqdE8GGtDA+p34LFOGTOMc9X
 nTGodT96lc3QtlBgvxQQyPaOShAPBbIqFHnUgL1EadUSZo3YLagVc4wBL9ToaWWosK65qqMvcO+aW
 734E0Rhscq6CHhyP8NBE6ZsDJajnQRmv91b8l/4vbIbuCIQOghQ5pbB+VNvNqV2LksSs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4xOm-0006k2-PH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 05:00:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD43612C4;
 Tue, 13 Dec 2022 05:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E54E3C43392;
 Tue, 13 Dec 2022 05:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670907605;
 bh=JwYXKpAVcTdwR2Rf5xb2H8UJEsAzC7+7eh/QhcipVk0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=duSrA4mWbsAjvZYkFthPT8MTLcA7ZIwzW7598dScLDDb/5rKRkAIR3yjQUvkbMIR+
 1Y64okrlt5DoTj1csZ6kf9Q5jlPDOzlfJbfnSWc+d55s3+6PR9GzYdm0PMj8wixjPy
 0Dm2Rckew6iaja0vAocnmXICjjGWFTAL/Hoy/kdxIhSYrbarO41mEogYV16Ek40b4z
 drSw1bNF5lNz3+87J+mJzJFf8HFtwc16rcWlDUcxsLLq5Sztdm3dcLw86KnxCjWk1f
 J8Eyi76/wikTU1KSCXfEyd/5fgi1c/5F5HE4cQsQx5EPhOrmH65uyWA362l47Uxx6c
 NcsEtpq4mybKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CA124C00445; Tue, 13 Dec 2022 05:00:05 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <Y5ayo48TtNrPgU9D@sol.localdomain>
References: <Y5ayo48TtNrPgU9D@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5ayo48TtNrPgU9D@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
 tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: a4bbf53d88c728da9ff6c316b1e4ded63a8f3940
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad0d9da164cb52e62637e427517b2060dc956a2d
Message-Id: <167090760582.4886.14939795830910220424.pr-tracker-bot@kernel.org>
Date: Tue, 13 Dec 2022 05:00:05 +0000
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1p4xOm-0006k2-PH
Subject: Re: [f2fs-dev] [GIT PULL] fsverity updates for 6.2
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
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Sun, 11 Dec 2022 20:48:35 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad0d9da164cb52e62637e427517b2060dc956a2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
