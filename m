Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E1BC67871
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Jan 2023 22:51:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pF0zH-0003VG-3d;
	Mon, 09 Jan 2023 22:51:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pF0zF-0003V3-6M
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Jan 2023 22:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=flsxCKvLNdMryvg0inGHSnb6q6hdQviheFmsRVM7kBE=; b=cDvZEApMGWKd1mcxKFA3Bo9CzV
 ZvPfJVt0NWnItYGi1NMCraWMVpYyTNhGVVCk+VW5lnTRVGyysgH3CTio2/ayrFxySbor7JAWvkTIV
 6ihf4tECd1VRGtq93Cg+hR3gse73yOsRl33me3TRiJpwGWyitzxpP9xvRbpUXexHb9bU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=flsxCKvLNdMryvg0inGHSnb6q6hdQviheFmsRVM7kBE=; b=eDhcF0Y63aMkaoS+6wlHf+/I4q
 SEVv9dmmFYM+JLTk7KSAL0wz3xr66AG8LR0njcU3/I1qMeb+w9Zaj/uz0BBnxGplZXr8R/dCeXC7k
 3FkUfcskmikcQfncLesi6RWJJQL8K65JbOTWWyHmQrhiOqj0cK00mVXJIZ5tf9GDXCvI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pF0zE-0005Ka-JZ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Jan 2023 22:51:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6C88061466
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  9 Jan 2023 22:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AE81C43398;
 Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673304674;
 bh=XjPLId5bteLVGoRQ3LSG9S2TniodXuedRHK/YAPOVSY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tDZwho0QNdV6o2N6kd1yaTPhx18RAVrmGQES5G+6l9wc7SPcosiMZnU+7H2gRprz9
 Njrmbi1IlQo3c9jZPt/SSt+oB6i6YtvMPw1XutFpEBzdZv4ANL/zlhMVzg3ol9ZzUo
 oQJsmm2zrrPIOhEHX9s25mdban8NADs7BYsD7dniuZyDAqKYIiqvXSOKbilnxDdjyG
 SDzsrhcmCoA9GGxUvAVnILKx44BOVaTtR7qRN6NsLLorMkOJr+p00ehgNpCQRwMTzL
 Yw8zw5bYq2LeaohvS61YOCW5jiRFcC2mH+U8FrR01E29V55+DNSC8DAoJ40EFzrjaV
 JBdLEiJpfHavA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 68CFBE21EE6; Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167330467442.13717.5107793430608586611.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jan 2023 22:51:14 +0000
References: <20221221121345.14353-1-chao@kernel.org>
In-Reply-To: <20221221121345.14353-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1pF0zE-0005Ka-JZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to call
 clear_page_private_reference in .{release, invalid}_folio
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 21 Dec 2022 20:13:45 +0800 you wrote:
> b763f3bedc2d ("f2fs: restructure f2fs page.private layout") missed
> to call clear_page_private_reference() in .{release,invalid}_folio,
> fix it, though it's not a big deal since folio_detach_private() was
> called to clear all privae info and reference count in the page.
> 
> BTW, remove page_private_reference() definition as it never be used.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to call clear_page_private_reference in .{release, invalid}_folio
    https://git.kernel.org/jaegeuk/f2fs/c/6779b5db90c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
