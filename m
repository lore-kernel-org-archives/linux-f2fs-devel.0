Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891FFC54E41
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:50:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rhvPd-00087t-W2;
	Wed, 06 Mar 2024 17:50:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rhvPd-00087n-Ak
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Mar 2024 17:50:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=plfCy1nwtMYKeTAc5e8aXkC9AkA9bg4BgMzsNopiGOc=; b=jZQZ1OKhph2Q9oNwxDv3oQWmPb
 kYxExnq3/oTpwCdB2ujeLBb5yoHcX+yjdkNdrTvgnHU35kA8kPjyT5l+tMjGKort+LUByiTQsPaYb
 J1q+x2NwoRzPx75MEY1b1ZlKi05cyWXpcCGirw82T4eE98JlbLN9URMkUxg/mVDu/yTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=plfCy1nwtMYKeTAc5e8aXkC9AkA9bg4BgMzsNopiGOc=; b=Y
 3MF1tGaGvv6F351D8lxlySIXagVkRJroGoPvgK058TlA/7QazFbschkJt4hQmeayYlzszQxdjam41
 m26CSpoOf3WStYpIO2NMGUy26swrRg0YVigIukljjRxol1W2T/sObtZGk9rTnuYKzMwyUXzUulY72
 ZAOaBZ0cqPLBLSoM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rhvPV-0006Ua-Mh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 06 Mar 2024 17:50:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5BFCB6147E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09A21C433F1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  6 Mar 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709747429;
 bh=lAASYLz4/8l/r6bDSRsICWfe+a+oCljRd015yJHkHe4=;
 h=Subject:From:Date:To:From;
 b=fBszN2XXUhKlNzYc8YvzTkidnP3CSv3gxy3FYtmfpE1XfJIfHUFsC0hEcdNFbdcDg
 9mrJ71wzmkLQKNePQE/ZpdpZpCtSgVpN3GRt8HNAHT+yupBWIoYtFvmkq78ophUuvP
 jYbePEajFzUW4Pms6a8eaNJe8aDZvOZNsh4iLXdC0VgsbBbKe4qm1tVkLYWJES3qao
 32LzrzmxW0P1yCS4vCVfbZ54Lltfe3Q14A2k7csiPeEuLDKcY7blw9nV8k5seqo76W
 yt6UF1pQXfZ2K7n3jnNcWZcBBn5bp+X6XEkk994ZKOKeB9WfJNjWF9EWk1fTqvaxXs
 aKJmpFQluzjwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 E4187D9A4B5 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  6 Mar 2024 17:50:28 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170974742886.3369.17374281770211650485.git-patchwork-summary@kernel.org>
Date: Wed, 06 Mar 2024 17:50:28 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1rhvPV-0006Ua-Mh
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev] f2fs: Cast expression type to unsigned long in __count_extent_cache()
  Submitter: Roman Smirnov <r.smirnov@omp.ru>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=832410
  Lore link: https://lore.kernel.org/r/20240305080943.6922-1-r.smirnov@omp.ru


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
