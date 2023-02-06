Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB857C05027
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Feb 2023 03:50:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pOsWS-0002mz-16;
	Mon, 06 Feb 2023 03:50:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pOsWP-0002ms-Q3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Feb 2023 03:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4KRAIpMNKR1k++hLs6gSdA+nFChXJe+tmJxD3rgZnaE=; b=cpyROA/cGa79Vb++UKEt7iz0D3
 nTTM3T8iaklrZlirnCoMYQqmBL8+bqK22DOOgxR+mI6RED4wx3bTWP/9SHXLfhBiOmfrczJy/fn8w
 VW8AiwgbrfKxDpBfKlSiruzUNXrHTrZKX/704WT9gEYzBpvpU0zzcpC7Op7Pogpl7RmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4KRAIpMNKR1k++hLs6gSdA+nFChXJe+tmJxD3rgZnaE=; b=f
 wbI9wGSWBAxktcyTDoiQHxKlYIQDRM8/TYmwEu6GibIGKM75RDNjqoNVPsyuRhfnJrRRuE8tkOuGb
 wUeoyPKL8imfM6WmNivGmy2NzIvS4AdDBnu4NeSV4YbtltdmyLo2war2kGGkmTbigmzMPqD1kARJN
 DaXF9cUG5DxYc1aU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pOsWO-00CFl5-BF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Feb 2023 03:50:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 15A54B80D33
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  6 Feb 2023 03:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B98C6C433EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  6 Feb 2023 03:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675655417;
 bh=XZ8MN0jW/pfycay6WUIhd6YIlbzs2QMrgRmqpNA588M=;
 h=Subject:From:Date:To:From;
 b=ndm3rJBTKP7omtAuyzroejp7EiaaT8qBFS746cO8CQ9sCHu4Id7f8ffuS9eiVbF8a
 criZbUnUtUBeNy7EoMQw52VBJfqTVziLfMAkgTlmgvP+rgHAHNMT3FqGMdYjz4bVgH
 7aXXAd4foFdsmgNJEXjTCLuwr02Sr1o052wbrDC7YxQo0e+QMf8vNe77oB0ouLNZS0
 eZDF/ZwPHgXDUtD+NMhaKyxKfVK5AureSGN+ZO2eZj9JkvJj4oX9Kenm6A9kOARIvF
 bM7CAOV26RxM/ZiJfZ/0zc4zd3ML4kFlTmutxfnqKs8kR0UoErPbR9ETK1nEr9+ErJ
 yvwdd9sUSNbpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 9F513E55EFB for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  6 Feb 2023 03:50:17 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167565541758.9334.12550743458866129466.git-patchwork-summary@kernel.org>
Date: Mon, 06 Feb 2023 03:50:17 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pOsWO-00CFl5-BF
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

Patch: [f2fs-dev] f2fs: fix f2fs_show_options to show nogc_merge mount option
  Submitter: Yangtao Li <frank.li@vivo.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=718064
  Lore link: https://lore.kernel.org/r/20230202094123.74342-1-frank.li@vivo.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
