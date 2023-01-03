Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5578AC3DA7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jan 2023 17:03:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pCkhN-0006v3-Ij;
	Tue, 03 Jan 2023 17:03:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pCkhM-0006ux-4c
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 17:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JSTur16IeoPZ4g+AK8tSb7br1k5J+/P4zoYxkGeG1/c=; b=WnikMSS3CFz87/H3Eh+oJmII1g
 KtAdiWqpNyUsnqyp69sprkdJPA0s1Z/UUYn/sln94YrFu12RGzEXDRScV6QtYS5EloI1045sIcKMN
 NUmxoz6Dq0etxdbGppKYKZQDe8mDQ/1u4T5sAXmfWOWhoeS/2CzU9q4lj4fAiZCJ/AjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JSTur16IeoPZ4g+AK8tSb7br1k5J+/P4zoYxkGeG1/c=; b=Y
 5LGOj1E7JJk+fT6vmeOmdAOZO0zyRgWf2mGryt0DvGHP4EebIebtTAjMWb3wfzzea2ki9oTWNtyYM
 7gXS2DVuLeBJr96FYnGJY6na/JkNdfYDJ9KGG97JdP7MZ0t03PfjbAW/0PpDI/vQTclExTyfqcqwN
 4MQvIBOzSNLZzDv0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pCkhK-003WIW-48 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jan 2023 17:03:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8114AB81050
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 17:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B5A7C433D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672765402;
 bh=c5LeR8X+7FOLD7Y+TDmjVJrKxhYpsPWDuDtPjPFsTuw=;
 h=Subject:From:Date:To:From;
 b=E2D2SmgvYwnDc+Ii0YjocfbUYv5DZeo/a3vEbhEDZKPu1hr4QBNx6UJya+qUHXqpX
 lBACXZcb9KYxCBir4kkwBL7AlogiGUa+sVm6MXBR6akYeYR2cZXxH+oq7Xsmjv8wYM
 JVCHcsLCEpkjZTl6Zob3ml8XkpjSf2UdzJ/U1mZKmWmUBNs0GtSnk+Vo2+0CRlGny8
 hCikb3XWxG0JZFFq/TqTyCba0Ntp6yxqxpeUPtr8XTSbbrq8MSoCNGD0k0BW2d7Jx7
 xhdD+JMDiNrtIod8QOj/67rFvLLt/gdXcVTEi1Y6fFPHQVZLaKLxIWaN1kZE3fQ9O3
 Ao5FKF7KmNMyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 066CDE5724B for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  3 Jan 2023 17:03:21 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167276540191.24190.3882266450129643314.git-patchwork-summary@kernel.org>
Date: Tue, 03 Jan 2023 17:03:21 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1pCkhK-003WIW-48
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

Patch: [f2fs-dev] f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=707735
  Lore link: https://lore.kernel.org/r/20221230154332.5082-1-chao@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
