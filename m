Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC7F47CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IiwCwSYliJI0CWKHzjdQxOO/JkdyvflKJn3albKXScc=; b=fh6JZQRXq/+fsocB5Zl7kW8NYq
	5ZqrbX85XsShEOluWe7KW3gLhJDePp7kzeIwmlYSiJjYOZOz/16JTn5nIfJQh1wNSfSKac7EYe+BB
	9EI8ba/XL2Fr+OsIbLbRJa73mna9Kn83LaVY8i1cGtNWifsWyM3QEwSuOZE9/nkMLq5g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vyEAg-0001Vo-BX;
	Thu, 05 Mar 2026 19:15:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vyEAe-0001Vb-Q3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:15:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8wKmZZXgu7Nh5ZAAnG9DZpb4tBCNWDgZwtH6+wjGXhI=; b=K+Dr/OC5wbRI2CzsDZeBlD2Lng
 COvVAF5tsqw/tY6IKiUtM+7Mei5OeM3/3Z8y0Nu7Bos4vmwfoEVaDE9Fb+/l+eppC7OXhE4RPgZDj
 RoyYxLaekL9D4CtzM/C3r1DTWHsYYn2Vx39Se/Br49GebjnKL32NqWkRtyKq+mZxroJc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8wKmZZXgu7Nh5ZAAnG9DZpb4tBCNWDgZwtH6+wjGXhI=; b=QImB8sJV640965ooyfCVlnfSqG
 wJSkOZfZi2sj3dz39tboNsrDxEc6v/7N16SnJsfWquY7EZFfXMBK1HNejFuCZ+CON9YRYgMx+EcrC
 iiE5f7i77mmab1mhramWjeWflA4Kno+Ru/2T82MYOK0uv0yLuTU2/r2SxxZL4BCIB67E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vyE5c-0001vF-74 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 19:10:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A527A60121;
 Thu,  5 Mar 2026 19:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558F4C116C6;
 Thu,  5 Mar 2026 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772737817;
 bh=fsdpQErSq5AIG6L0fc2gq39v8ab380PCc5a+7FUPkMw=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=J2CkXF0bQjtNxUP2Oyu7x1+asi+hANLmdcyxS7n06MhBg3UWVAO90WWMucF2pZZsj
 Sat4zvZa3jFWqiam5GilcK94Afm0dl8/cTCae+VxVj3MYHBTKorZlocTUZzTi9IS9s
 bNzkzHdpCJMLDlhZYyHyHRut3z1X+sXcb0nir3MukSCOj6GurBCwN0XJo9xgx6/xc4
 lQ60HW+neUZuJxHXDT2UPeZ/j+mY2eCs4StiokpLpSQTIboWdu8e03ePFpUO+TDZkn
 zBawHgMreTSAm+yGdBl4F86F4fylDrvoIJJISVl11ZVxfHn//EixiOUYLUBIiwka+7
 YCnW4+WBenpuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7CCC93808200; Thu,  5 Mar 2026 19:10:18 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177273781704.3248266.2687010312851599957.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 19:10:17 +0000
References: <20260227030254.270068-1-jinbaoliu365@gmail.com>
In-Reply-To: <20260227030254.270068-1-jinbaoliu365@gmail.com>
To: liujinbao1 <jinbaoliu365@gmail.com>
X-Headers-End: 1vyE5c-0001vF-74
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add defrag_blocks sysfs node
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
Cc: jaegeuk@kernel.org, shengyong1@xiaomi.com, liujinbao1@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 27 Feb 2026 11:02:54 +0800 you wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Add the defrag_blocks sysfs node to track
> the amount of data blocks moved during filesystem
> defragmentation.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Add defrag_blocks sysfs node
    https://git.kernel.org/jaegeuk/f2fs/c/733955115e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
