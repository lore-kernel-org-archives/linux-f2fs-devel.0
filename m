Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3539D6AAEE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qnxmgZDparxPjp6sBcpECGWovYFjHUiW22qrvhxMz8g=; b=KqI/12r3RBBH+wRD4HCil5NXJD
	RgOs2rrYauEtzGBQVCKSoQgFxcHFs3DF2YEsMU0ezU29qVPG3yIoBEOVdBYAK2LV+JRpKFwEfa5kT
	vDThMPl/u6aw4RKjXVy2jRjQQem/TkBg4HeD8sDKwAhMuSMW5C+o6Xn1aPU5JSN4TtVg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w8KwP-0005ux-Mi;
	Thu, 02 Apr 2026 16:30:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1w8KwK-0005ul-Cd
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 16:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f5eliad7ELnGbazCE49XxaicWVXPf7FaV//MopeJ9qg=; b=CXTXOv66TALKVPnV/GFkX+4HnD
 Gjzzee5QwQuhnwbnQj2Ic/LdHCH0mRucy4wQL18f2cMOCpCj+XDlgXEGT2A2SJnDRA3gvYifeuPwc
 avu8UoVcQme46ercKxyor8UZ1LwtXvxh4ixUOCjnkMSY00zVX3OLdybKwDKd/BWyBZ98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f5eliad7ELnGbazCE49XxaicWVXPf7FaV//MopeJ9qg=; b=H
 kPx4D3w+d7lBDf6q38zylcEDFAh4jNbFDiJa0OshCO2G5doLeYZesaZ+7HRkQB2ShMSiiU3eSgtvL
 6PW3Ua5Frh8YIRZ2WnH9NeqbmAUwGeCMV9qiohtnjlArBOGdSP49efG7LibmWjZiAny6vP9JTulGN
 7bGax3RWag7SHJ6c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w8KwJ-0001EW-Li for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Apr 2026 16:30:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 05CCC60132
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Apr 2026 16:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B128BC116C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Apr 2026 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775147428;
 bh=kV5IUPK11ot29EtJv9oNQm3vgRNttLS+DwT/JQbWlic=;
 h=Subject:From:Date:To:From;
 b=daR2seAMTU/H1Wxv0Q3IzSwVeWgeHnPYcXkSeJNNaYdTE3Ym6mthTJKaLpZmDjCQh
 R4b77Z91gXDXfzE4VYLOiPGQQYNi3rnCn8RSqfSqs2L9H9Ax7KUYLVJKA+VBXMXBNw
 5td2qRGXWAu4TYKrPfJH49dbwMkz9yseEiUcTdp54w9HGaYLMZlBdbSX/pMfD2M+cL
 e4TERybY5q731GY7zVZLpFuvP7q/opDVgLglXb/wTMLDbzeCXdYs7yH4SDAiUEtVTG
 MTYqHJRQUWqYXzNFz1u9Umg0dnkwRtkUPJoIhXNV5KSqU+OyvDWNxIHEoFJIIzFnqW
 a6yQV6ugVGTzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3FE2F3809A07 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Apr 2026 16:30:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177514741099.519974.8495394510943152535.git-patchwork-summary@kernel.org>
Date: Thu, 02 Apr 2026 16:30:10 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1w8KwJ-0001EW-Li
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev,v2] f2fs: invalidate block device page cache on umount
  Submitter: Yongpeng Yang <monty_pavel@sina.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1071538
  Lore link: https://lore.kernel.org/r/20260324094707.3959420-2-monty_pavel@sina.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
