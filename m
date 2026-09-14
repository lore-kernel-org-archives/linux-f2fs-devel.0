Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B811BC88E7B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBSIO3GEpJmQ7d2TCPuIfWmEXgAfPY0J/t+wgLEbzso=; b=S4UxMeSIULzPEdlp6jP/drtrHt
	DF/2kgfjcBZQ/oSb5OuHU5cqKdRVgtxJUAdawYIP0WasGCevMI3jF0BRaNzwpaa7iMItFhROsJcxB
	RIxC8ik3MDWPO6Wb2r4bBK5/5JQby/yCqh73l86X8DtIQHxyurDf+sllF82aZHOh5nCI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x68eW-0008Pn-D9;
	Mon, 14 Sep 2026 15:31:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1x68eV-0008Pe-Ln
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qOTkNlqynpQr0wKRF6ie9yvPhlZ86hsILtCFmgTcBN0=; b=J9PXQqHvQIoZQG2SY+VeP6F7tk
 xcsWKwdSoLlRAyYsVfuelsmzXYeMkdSFXhPwHyAzKr0q68j+Ds/Rc0bBWvM4aIDvOpI+8azkuxlJf
 n9DHxinTGNAUBHIl4nbEBYkoIJO0q8O5NjoZROl8MVfXC/m62lxoslJVVhglrFaL5vNc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qOTkNlqynpQr0wKRF6ie9yvPhlZ86hsILtCFmgTcBN0=; b=GAPs5VSqwKFn18akBl3lZRDIHP
 EvO+di+Lh3mywTDjUwcucn3dQSStb+nIHeohXGk8Cmre0uNQMlWJegYC+yKmss133sEr62NvrO4n6
 vFZlYOW3+UcEzT9WnpU6/wxEfJglknU4W49XI9STUehTZohcKA3Ck5mjLnllcszkRo+s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x68eS-0003TK-Rq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 15:31:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4149D60252
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 15:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB81F1F000FF;
 Mon, 14 Sep 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399879;
 bh=qOTkNlqynpQr0wKRF6ie9yvPhlZ86hsILtCFmgTcBN0=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=lH+o+RSZCJCSUbtuSA23oc2VyVjuSxz8KhlwnhjYbV0tk5pBg2044hs8uU/MDk97K
 JEiBZ/R9ggfncJ5LmIdGXtvoJ0DiJtBj1f4OJLP1VrwkF+wYExtaj8edhZzLHz2X3a
 9P9XkvxP/bBjzfBR/9901F0KkcNbP4psY1dqdfj7J9Y/HsE0JV01Nm4rIpXs/vxTqs
 OonhoW8+uCXfSZYSn2n/y1KP4U9s3UCAo4MDdkyJkt2Y/u7r6HhwG2oeswK19T1ICt
 OEgzYWwKsQ7lNa0lc7INTxamvXq8Q5r2XmP3QK69HJLjl1DKkqS74pvQry4EKQ73M3
 O8+Sah7eJMPoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5696A3924A79; Mon, 14 Sep 2026 15:30:15 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178939981388.647967.9712319040788657342.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:30:13 +0000
References: <20260908100032.3141988-1-chao@kernel.org>
In-Reply-To: <20260908100032.3141988-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x68eS-0003TK-Rq
Subject: Re: [f2fs-dev] [PATCH] f2fs: parameterize node helpers and macros
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  8 Sep 2026 18:00:32 +0800 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> In gang-lookup loops such as last_fsync_dnode(), f2fs_sync_node_pages(),
> and f2fs_fsync_node_pages(), candidate dirty node folios returned by
> filemap_get_folios_tag() are inspected and filtered before acquiring
> their folio locks:
> - IS_DNODE
> - is_cold_node
> - ino_of_node
> - ofs_of_node (called by IS_DNODE)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: parameterize node helpers and macros
    https://git.kernel.org/jaegeuk/f2fs/c/ea3eea801c5c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
