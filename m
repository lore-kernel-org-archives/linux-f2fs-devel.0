Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E900C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Mar 2022 18:32:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nWjAn-0007Ud-Nk; Tue, 22 Mar 2022 18:32:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <pr-tracker-bot@kernel.org>) id 1nWjAm-0007UV-5v
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Mar 2022 18:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:Date:Message-Id:References:In-Reply-To:From:
 Subject:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b6LQdWYZgMlscH00sPTx7Ia1JB/3jh2AjQr/UcKZxZU=; b=agpwME0m+4P7MI8YiwPB/3/nZY
 yT9T7TGMxq1YANhx/WWzNutBYwxEHrGdDMBLmEZ9fcl1xfc9xHMUc61fER+GM/ETW0QmE3G2PIlnw
 72NA8HbdXz9iuUGqFHqmpGybAaN+B+B9eWU5m3FdgOjmsemvsI/XQIFWNiOZqecE/gIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:Date:Message-Id:References:In-Reply-To:From:Subject:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b6LQdWYZgMlscH00sPTx7Ia1JB/3jh2AjQr/UcKZxZU=; b=DxWWjVdPe0j43DF4wZOM3gI55p
 yFzrQz4uCIpmN4khI93MT5+PYEpJWTpM2LTwCq4+y0G14kE4UAPzq9DR+dBbj8+i/HB3rvhrevRPx
 mR2hiQ/ru5ccIywqed4Uc4ZGAlungA4MLv4/efbF2fwIIazkIYcHvmU5uCzCFdT96vzA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nWjIh-008mbc-AL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 22 Mar 2022 18:32:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 48768615D9;
 Tue, 22 Mar 2022 18:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE290C340EC;
 Tue, 22 Mar 2022 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647973923;
 bh=56pMLYS62NlbI9+1QeTpYPBinGiZHOomY/pRjTYFL/o=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=LHMYjtnlF9b8M50iF/fewdFw5UO8Ifb3H8ZX32WPn8LmTyNlXKVhQ1bCmy3wj3lEE
 oOFLcoFkOonXvmOETpTKkOaufFVS36HLEb9AkF34pn7FvyWj+XAP1Gp5Sye8Hs2jJm
 vy4RElpf0brOc9L/fP5BSwt8NbeKZ4CC4VAgzAuFIT8ZSL7IKi8uC45+EPftnGR38F
 /D35RqkybBK3uzSCuSvqZsWY+vsBF6QX69HdhGdC7AhSn0kYE/lx869p9h2x3s9sde
 Bhccq+AgV0gPgnZFemolPFKgm2IJGvaQ2MnhtVmeIFoXejpjAw69Mvs67xu1wmKBf+
 y5e2XZ9fGIkmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 9BCE5E6D406; Tue, 22 Mar 2022 18:32:03 +0000 (UTC)
From: pr-tracker-bot@kernel.org
In-Reply-To: <YjjihIZuvZpUjaSs@google.com>
References: <YjjihIZuvZpUjaSs@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <YjjihIZuvZpUjaSs@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.18
X-PR-Tracked-Commit-Id: 5b5b4f85b01604389f7a0f11ef180a725bf0e2d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef510682af3dbe2f9cdae7126a1461c94e010967
Message-Id: <164797392362.17704.11716595490664039978.pr-tracker-bot@kernel.org>
Date: Tue, 22 Mar 2022 18:32:03 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1nWjIh-008mbc-AL
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 5.18
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

The pull request you sent on Mon, 21 Mar 2022 13:39:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef510682af3dbe2f9cdae7126a1461c94e010967

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
