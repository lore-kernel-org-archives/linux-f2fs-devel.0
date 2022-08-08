Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB496C00140
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Aug 2022 18:42:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oL7hr-0001VL-SM; Mon, 08 Aug 2022 18:42:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1oL7ho-0001VF-VV
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Aug 2022 18:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bzCGxC+ZaZoAykVYReeTlOr+hsH0akL8k6baE8pdwAQ=; b=eIH278/w5tE/Xmi3JcBKTZxOsY
 yeTFVtchTzhBD7IFwm09bL4uiHGgWtUB4vJd02xKeo6rKM0d/Udj0WmSMb7CB0/lkEKNk70ywz+8h
 fI6jLCsTeuP9B3PmcCVTG1OqkLYm5E9F7h+6yuyKv03NdONkxbiXHoBesMlKzbt1HIo0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bzCGxC+ZaZoAykVYReeTlOr+hsH0akL8k6baE8pdwAQ=; b=A+pfeJy0thf80CapQgNZzBbg7z
 NXCQmSjIS5HPqrpU9uvNHf2OhPOUvepXrytqPoE4QIhjHkzjuMXfY8PLADVjBpwfJaExoNu4VcGfY
 MtVYX1L1T07u/VPgMkG8V0Zu1YScxm2QK4Mo3cd0bfOf23aROa7n3WDc8IHSbBEAvULI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oL7hh-0085nC-0z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Aug 2022 18:42:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D02DE6123A;
 Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CED8C433D6;
 Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659984126;
 bh=ePxumCSBfFzGSnKGc9mgQ/zezFfiqvOGFsKicTWV8Ic=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=AMyAeDcykGtM1NcmUiPwmEX5CCuGudJG9qroNNxL1OV6+d9fc8PWnCtp/9bxALejA
 jTuM0cgyBfz65O9LsYRCHbeoO8kb2OD+ZeKw1wGWNRBSqGXt8F/6RnC6mpw95ZJBFM
 LOdZKVXuG33ZT9yg23H7qfhqzqZ89pITjMlhymeWhkLXXsc87v+3agAa1bqj39Covp
 t/P+8OhMl06NYVkg5lidPZ9ks283XnfDV763UvYgnuwOjQZpmycF4xajJzmbXlUlE2
 qahHTKBsAAskwxoeId5my77OGo107QhcbKL7St6PSgH3SbqeYwZR8l8SaxBbVavJjJ
 tgpsGQwUCMIkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 2079AC43142; Mon,  8 Aug 2022 18:42:06 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <YvE6fO1r0znOdr60@google.com>
References: <YvE6fO1r0znOdr60@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YvE6fO1r0znOdr60@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-6.0
X-PR-Tracked-Commit-Id: 01fc4b9a6ed8eacb64e5609bab7ac963e1c7e486
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1daf117f1d6b5056e27353fa289ef1bbcb619e8d
Message-Id: <165998412611.757.4082441541287492652.pr-tracker-bot@kernel.org>
Date: Mon, 08 Aug 2022 18:42:06 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1oL7hh-0085nC-0z
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.0
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The pull request you sent on Mon, 8 Aug 2022 09:31:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1daf117f1d6b5056e27353fa289ef1bbcb619e8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
