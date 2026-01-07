Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54592CF6BE4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HmF+CP/cMPPYC9JNQAirYfEHegIEEW7SHx2Db0CBoJM=; b=S9IPonkeInt3o+kdOat4DseI5Y
	e/cG4c56CXiuF4TFWAUxVU2jwrmfIKDduwE5WW6FJ9jjUG99aVO3/kwG5FrNRbxji86B1ZgxVORQh
	5ky2XKuPeLBRBN0UTwe3bqtXUitoGmKgGkja4ChmcqRFPmbdzLjmlMYunmipRqSMBxCE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vdKIs-0002OM-05;
	Wed, 07 Jan 2026 03:33:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vdKIr-0002OD-8K
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=88rm9n/IxLk1OHVeBEsqLq01j2laNvinfPNBL8DBItE=; b=CoaIqkuCvVow6IxulJRDwk2KcZ
 2DHac1tm5MqA1QO8wpQ729xQQgu8gjGQebve47oxys7W7Mg+UxloA+omW/VdeR1UUBRe/lqB3S2vk
 VBzlCwZE3mbnGEYmUoW886Ln3bvqZ/58cyrZC6WvjR9l5klnnWieoVCiLr6DUoJRt8i4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=88rm9n/IxLk1OHVeBEsqLq01j2laNvinfPNBL8DBItE=; b=JPa9zNuN4Ygtb87DOJ9wFID1Px
 TUy/1LsABMh5i0OPPF/YGHmZYMnzbxG78czSB/pcL1wghmS1R4KOnSaDQupwxqElPJGj3+Kojzr1L
 s7OfX8y+BjS8meSdvAEHsGSV8Q/pZ+uwvv2tqG1f6gQ4PNL/0CN6fGLdEcd2ggfkNGlQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vdKIq-0004Y1-PK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Jan 2026 03:33:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2995260007;
 Wed,  7 Jan 2026 03:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB2DC4CEF7;
 Wed,  7 Jan 2026 03:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767756813;
 bh=m8At3MEU6IQ+gVkzlFgKN9mIb1EgnSUjm3RLjFGymtk=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=EAQFnmaVfw6FxlHcvgtbjRD8u6FY/s+u6Z+b2ygEsxoQnj1VQY72FkPt0OZu0wR6v
 zlK/ZytDrBIjEYT0OBazNfJ10sC5ZiC1kYgSvGfGvjwaXhBnnycYzc7NJmxpUvVoOK
 aXcoKCKUHnhCOaxO9EcluWVrddPnbQZvZ4MRcVdHSW9RpueCVjRCNJPXZQ5Yw8bKym
 Ye4v/tt451N8i1bRIJ8xrj9I+V7vpRTHF1V2uNmPsnZXo59MPwN5+OQNIu10sG5lyI
 F0GwMEyyAv1+4bXXxYlspFlO86w2igJYJozABjNT4Y44g2BVmF8UXbgky6Ujnzgfwf
 s59QtE8hviNwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 794A4380CEF5; Wed,  7 Jan 2026 03:30:12 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176775661129.2218650.4840007223667091152.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 03:30:11 +0000
References: <20251227073430.193054-2-yangyongpeng.storage@gmail.com>
In-Reply-To: <20251227073430.193054-2-yangyongpeng.storage@gmail.com>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
X-Headers-End: 1vdKIq-0004Y1-PK
Subject: Re: [f2fs-dev] [PATCH v3 1/1] f2fs: remove non-uptodate folio from
 the page cache in move_data_block
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
Cc: jaegeuk@kernel.org, yangyongpeng.storage@outlook.com,
 yangyongpeng@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 27 Dec 2025 15:34:31 +0800 you wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> During data movement, move_data_block acquires file folio without
> triggering a file read. Such folio are typically not uptodate, they need
> to be removed from the page cache after gc complete. This patch marks
> folio with the PG_dropbehind flag and uses folio_end_dropbehind to
> remove folio from the page cache.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/1] f2fs: remove non-uptodate folio from the page cache in move_data_block
    https://git.kernel.org/jaegeuk/f2fs/c/9609dd704725

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
