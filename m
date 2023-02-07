Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F2EC636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Feb 2023 19:00:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPTCg-0000ta-F4;
	Tue, 07 Feb 2023 19:00:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pPTCc-0000tG-Rb
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 19:00:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MjbUjhF8zq3jHhTPQRHSi0hOBtcNFpYgTWkCMHkCEFg=; b=NgMRUklmprPrhXJtSypmYuczdt
 4S3N0+3yjlVVzCUsXGqpHkIAuckDmlh6mYBwQyieXbjGxnaIKmfXbGYNg8pd3u5Y2VYULEk1xyr4D
 dNIPGhm2WX3y8tK3e9Vw3QpGQCCe388kIkwST4Wzee88CJfexRCAv8fl6ndpkczAoa/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MjbUjhF8zq3jHhTPQRHSi0hOBtcNFpYgTWkCMHkCEFg=; b=X
 GeQCIf95xUWVKvVDZaD1ZQxGFWOmYwgDeeIHKHdDQWE6gnE/wTeQGC2rsHXmhCS5V5JXu9b5ZRAge
 JlH3ajHcLM75safyzQCd79fH2WvoZjm1yA6rfAigJHAqwrm4KuazmCfc4qQ0hZSgOE1gVl+bpjpj+
 0e4gwYFoqQrbD+iY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPTCa-0005ds-N6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Feb 2023 19:00:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 33823B81A61
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Feb 2023 19:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB70C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Feb 2023 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675796417;
 bh=KNMLzQRbXmtI14laLDIE2u3I5HHP1UTGH54PAZ/oC5M=;
 h=Subject:From:Date:To:From;
 b=FeuG62AWtaoa7+VAUNjHUQHBlNxGOEMJdNrlBfuRIgYtgGMVhv0v73uJA5UlSzEJv
 RrEnE/4F5SSCt3XjuW0m9f+8Ox0whn9JILuKmeGq2HL3HOtO6/Pw6zKdlNU58nfXv8
 yu/XbtKWN4rgeqnMZFeoYVNr+uL0U8luh0nK/u7muVYv2OjlDmudQSXA2M3zLdqal4
 C9zME804a6l+idmnK2FDr77+JxdUAqpzPF6GoYNJyWAVqxPTA5iebF369PdrhB3pu9
 yPe+muogMYHXEAab86LXWsW0Xrz38Hbwyzl/EVdGHjHmJ347N5q2c0HvQdmfOJFmKj
 NZxwds1XFDu9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 B3D9EE55F06 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Feb 2023 19:00:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167579641767.24576.7030553352235460537.git-patchwork-summary@kernel.org>
Date: Tue, 07 Feb 2023 19:00:17 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pPTCa-0005ds-N6
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

Patch: [f2fs-dev] f2fs: fix typos in comments
  Submitter: Jinyoung CHOI <j-young.choi@samsung.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=719092
  Lore link: https://lore.kernel.org/r/20230206115600epcms2p736f05524a361d5926dbb401bdd218f85@epcms2p7

Patch: [f2fs-dev] f2fs: fix kernel crash due to null io->bio
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=718989
  Lore link: https://lore.kernel.org/r/20230206034344.724593-1-jaegeuk@kernel.org

Series: [f2fs-dev,v4,1/3] f2fs: fix to set ipu policy
  Submitter: Yangtao Li <frank.li@vivo.com>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=719149
  Lore link: https://lore.kernel.org/r/20230206144310.2344-1-frank.li@vivo.com
    Patches: [f2fs-dev,v4,1/3] f2fs: fix to set ipu policy
             [f2fs-dev,v4,2/3] f2fs: add missing description for ipu_policy node


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
