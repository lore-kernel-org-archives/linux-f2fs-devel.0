Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF9606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bXDDXnPt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AKdVr4S0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WTBIQmCf;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NS6vBSlo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UrgiEUenpty79Gir75BWpdWjQQ8Nx7JZ69HEyJDMOHk=; b=bXDDXnPtYwEcKH
	CrCord3qg6pP6B1GDN//W/+qQirvOQ3mL3Y4OfN6r3Iie6vdAXO97kIbOlkWlKH86kC479FLhvXMz
	ePIzBuxWegYgEzRygggYEYK7TRpDJgszQTFhoMTyNZO20l8uWtEK5xuem6f50bcZfSts/DKB+3k/L
	E4g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLODA-000000000JH-065Z;
	Mon, 26 Oct 2026 17:10:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xLOD7-000000000JB-2Jtb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 17:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FoafLBq/IA91uNZ2WjTdGQO86KZu+PBVe/RIbobQZwU=; b=AKdVr4S0EfqUbX0++5t/JAz7PW
 JoaT+ytSSrEKUaHoad9iK6DnAlnIzSQtBp4yM3pQAJXWtsx/26nN4jK2kJM3l3rNDIorCpdwEllT+
 9sWMKWzD+rT9lePiyphJ9bf6XSyrUWTGBqY7qX9Skv3sED4ON6H6FnO0T3eInvfxIGtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FoafLBq/IA91uNZ2WjTdGQO86KZu+PBVe/RIbobQZwU=; b=WTBIQmCfmv5+5x1n8hnnfTvu+c
 8+ot4mxdnj/AT2W1hPC+xyuS5l4+kw8LKncT69ssqJv0kVSZw90S085d+QHQwktCcF09wkUF603db
 3XtKzYEUOAgMsrRoMnJC3zY7PkKBCIr8R7ky7TIMI+S95rOwYnPLl/p/pBAPQVX2Ecbo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLOD6-000000006R6-3w2K
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 17:10:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5BCA2601F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 17:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FF71F01825;
 Mon, 26 Oct 2026 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793034607;
 bh=FoafLBq/IA91uNZ2WjTdGQO86KZu+PBVe/RIbobQZwU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=NS6vBSloEa0jMK74+6+ulw2V3yf2ZuQvZwdJb3ATbjWbrbWEK2hRdd26MZAi/H9+g
 ttzkFU6zgmUwNJBW/vNf6TmrNG9VNIF9WawtARae1igZ8ucAT23+H9dNRbDt5CG86Y
 djB79FUjiXacN1CAYNxJSv8WH71R3vMDK6WtPfMpcUVP/Qu1Wl/cfeBsuX2dDS4IRr
 0AjPTWV4aepUCdnLwjqUvOKlEbfmJ0tkUvgaEbL5LwUgWtrrge7eAubuwuCK4pqu18
 aU634Io/8PkGbMTyztp46ckaD9FSyVYK5CgbJz/Tlfos3HWRzFvHAG9o9FoqacGdCJ
 VUa/jmpCbaUhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 074CC3AA58BF; Mon, 26 Oct 2026 17:10:07 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179303460557.3284016.7707195363105812393.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 17:10:05 +0000
References: <20261021110521.12345-1-chao@kernel.org>
In-Reply-To: <20261021110521.12345-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLOD6-000000006R6-3w2K
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: don't overwrite populated
 compress cache entry
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 22 Oct 2026 02:22:43 +0000 you wrote:
> From: Chao Yu <chao@kernel.org>
> 
> f2fs_cache_compressed_page() looks up the entry of blkaddr w/
> f2fs_find_cache(), and then grabs it w/ f2fs_grab_cache() and
> F2FS_CACHE_LOCK_CREATE. If another reader populates the entry in
> between, f2fs_grab_cache() returns that uptodate entry, and we will
> overwrite its ino and data.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: compress: don't overwrite populated compress cache entry
    https://git.kernel.org/jaegeuk/f2fs/c/ee17c0cd763b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
