Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F315CD37B2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZO3n7/A7GBTYEuu1IjDnQGhrxAXaQ2vT94D938RuTw=; b=XWgS2P09/yAPUxYLt5M5nFPflQ
	tTGim12B45X9O+9gD4PNhMwyPCvuBJ7K7Q5yHDEb5g3eA8EDI576Q2aGb8gnu6C1YF70hwc3zWBuz
	aET0cX+MnwP+9vDq5doSEpC2qiHknUl7dT1aEovQyOCGVf9UFh0IR5LhjbxDGUIQwYVI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFnU-0008TW-T8;
	Mon, 11 May 2026 01:51:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFnT-0008TK-B6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5UCpD+sx0CRIrz8eF6EGuKG0JI7TLJzoOB5eSVgY8wQ=; b=nQhZ1Ca6rvG4BzEv8BDthlPVfV
 pCd53CDk2+DAvVt7iDZU6+9U2toCr+0D/6pfZ6XY/JU+tGXjRyGw2yNPMkP6Qr1zwxQ5mChcWAhPi
 IW0X3nJZABuFIklk/Buvm7crItAhdHdc/YOYZBs/1j72GeInx7FnMe7mRx78S1hczHuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5UCpD+sx0CRIrz8eF6EGuKG0JI7TLJzoOB5eSVgY8wQ=; b=l7umDeydxKtjiA7BprQgaGXxFq
 3ntC5lrtzFhvtwpy5pUxQonqZx9SdZNsmCGrbuIlI0IX0dijTglwaFAh6FdqzZE4SEWsZ0iGS+JIn
 CQezgtwrGAQSV+sH6OhGPDu5u4umxNMcaexuF0YJtXjK+tP5EZD0cJ7R921BtsZhwjI8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFnT-0007dG-Gh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:51:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C028C600CB;
 Mon, 11 May 2026 01:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC4C2BCB8;
 Mon, 11 May 2026 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778464257;
 bh=9FLOOrxsdKZu1aR5ugGATl+IYTqo7brozIhS3Y9DOSI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=tRGrLpjTuk+PYCegBnN+Jk40f7FUGsIggaGlMNd5njU08Ae9UMz3VDdYafrg/ZCfG
 1PQYStE+CUd31g/6UM+b0JLxzdUUa0QdmOv9shMaOGOWBaSdxu0aI6FLQps3DVVGPn
 jN4OhbXF6hcoNZKjORdmp+zjhI6/N5RR36aErprgC8bTIRHmHyNJbf3QsMXX7Eg7Ob
 3JdUU+1UUau/mNSsy+PLSvnnoJe0hLfqNoopliiAu0avv0tiWQy9NHpcpFijSQyxSn
 94Fh9siA+60txBBOpkup15dCmrxUHPbAZjG0kw3NEl+yEQjgilzWSSWQh18EcH3Uv+
 JuU54mrkaFdGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9E9C3930039; Mon, 11 May 2026 01:50:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846420430.1981547.4906215813884027969.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 01:50:04 +0000
References: <20260506095731.1039356-1-jinbaoliu365@gmail.com>
In-Reply-To: <20260506095731.1039356-1-jinbaoliu365@gmail.com>
To: liujinbao1 <jinbaoliu365@gmail.com>
X-Headers-End: 1wMFnT-0007dG-Gh
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: Add trace_f2fs_fault_report
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

On Wed,  6 May 2026 17:57:31 +0800 you wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Add trace_f2fs_fault_report to trigger reporting upon f2fs_bug_on,
> need_fsck, stop_checkpoint, and handle_eio. Since f2fs_bug_on and
> need_fsck can be triggered in hundreds of scenarios, define set_sbi_flag
> as a macro to help capture the effective fault function and line number.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: Add trace_f2fs_fault_report
    https://git.kernel.org/jaegeuk/f2fs/c/99c73d70fcdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
