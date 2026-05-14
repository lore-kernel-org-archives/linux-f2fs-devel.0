Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747C4CD4F39
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 May 2026 23:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UMjz5/OfRtBz+D6B8o9iJPGGNmoc9A64YDqzyjquerU=; b=NBr0jGbhn62KKeOAn3D4z7FcKm
	ZDfmlTfZ1oXPBVXOBDp6QcHnXoubfzAVVcX8Pd1vYwkPiSQxhb/Ew+b2/MBqoBjcuJHJ6P7Id4jvt
	nY/dOBS9uKwQhGXSRZEyEVWoOV0hSKslLG1/YS1BddTDgQV17l+VC5hGRomjyeTQ/afg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNfWH-0008BI-V0;
	Thu, 14 May 2026 23:31:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wNfWH-0008BB-9g
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9URgxUwtdjTLbZkN6mktKA8JbqrKMeUNsxEW76DLuKY=; b=gVP2xknIi+6DNAsc7/Iaq7qOky
 kKuVmILCBRSrbnm7dZF82XWhCcDQEs7EjqD6ax0J7+XiofXzIQwlvK5EtvJ++HRKvY+XL/ONqkDQe
 MPbCItmZlyvCcimioZdY0cX6wllwtKwNSAzjXS1uUD9vrzCxE4qkdGP6Jg4eXX78p3hI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9URgxUwtdjTLbZkN6mktKA8JbqrKMeUNsxEW76DLuKY=; b=c
 mZ7qNpxriKwwjNqZq3QaymoZDqG2c3FAlqO3t4yu35VF4J/Lze1uUcAdUZOI9EgA1tGmf4nJcrehq
 bv61DUqGXxppLPWwsPcN2VmS0g67bs8RvQwkqYgab8UjlqHkLE4FQdco/muexeWhE+9KWjBI7yFy2
 d4NXtm7KQIQ4ZbQA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNfWG-0003Wz-PC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:31:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E586743BCA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 23:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C37C2BCB3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778801458;
 bh=9m8YzkjL+YDvprNJo+iJ+aLu2ZY9z5QKNN3R3RP3BvE=;
 h=Subject:From:Date:To:From;
 b=H7GshHsbOlRG4Zxj7cgcoIU3JbEj/9Yg0jbvysv1xxFMpT4RFlr2N5XKp9fcvI+Az
 mWcCqGGT8QcoamFbNvZAG+sIPsXO0gv4a7EaqXi3KkeXhw9WeuFecrPDsg+4l2dmSt
 1ewo0onUq9t5rNb+V6tucFIvIWw79h+9ULT7rIybSfg1uvU7vl22JJCi6pKk6lkgAT
 8qlDmrWaFo++eEeweb37soZqEDD0OB+L8AcEo74shBIWP57M1j1eYA2gkW5Mhu5Zho
 nYQCEFTM8drUgC82rvYrodYK26PI/G4jbSKkmjgB0jIJWetIDEguNrwawJvMfA/P1g
 qB5dS/zdLclDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7F9B839E4DB3 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 23:30:04 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177880140318.123857.18399790076591089.git-patchwork-summary@kernel.org>
Date: Thu, 14 May 2026 23:30:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wNfWG-0003Wz-PC
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

Patch: [f2fs-dev] f2fs: optimize representative type determination in GC
  Submitter: Daeho Jeong <daeho43@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1095008
  Lore link: https://lore.kernel.org/r/20260514205513.1464863-1-daeho43@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
