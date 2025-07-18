Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9FCC83F17
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Jul 2025 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ehzUj41wOwiAuty6PUwI51eP1W5QUDp07fmKs1I6lPA=; b=ef+ZdWJ6WdKSbI7xtMhn0etyZT
	jUrYsL2YbnviLeNqquINWoLWGJraGvjfe7LBji0RCoWdI1rw47goOa9lCMSiyYEGTAjq+40FfpWFY
	ZIOoEkg/XtyZRID6P6jgDGgaigmknipPFZyYDOBQGqeVBxBgUHItaGyfaIlS3VAQXUic=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ucrYe-0007FK-Fp;
	Fri, 18 Jul 2025 20:19:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1ucrYc-0007FB-DQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Jul 2025 20:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EH2buXpxhOtqhZq3AcFEmXu8Dl6YiMBujNyBOKa4Ezg=; b=ENKNXCEdXuYJxOpAWoI1rngVOl
 g7nPkHKJG4ks+KK59t7roN+BRuQYQfT3/nLqOsh8XwGuta6AUVADMOUDgJFCkOBpWtrvWNVCnyyfE
 INyWkD6eLjS/vyjKQ9OQRynO8wA0Bg5y6LxLsQBrX2K8Bwy3CO+xBKc5XlRuCQLCGkyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EH2buXpxhOtqhZq3AcFEmXu8Dl6YiMBujNyBOKa4Ezg=; b=P
 rSmMZ6RLgwDWSk1TZqQzEB25cmjAE7HN2Io1o5m/z6frPP09xKmBmuTzycm8tIlQTm3qjr43EGYej
 VBEea3LdYaZwENdkW0nnkQuQrZrnIlU7+AZ4fpDMY6scUCaV4mLnI8WLuB2t4YiOHeCymXkNlrUIb
 AM5txMBtsbwsc82E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ucrYb-0000NI-HS for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Jul 2025 20:19:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 18CDA450D5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Jul 2025 20:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC33C4CEEB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Jul 2025 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752869984;
 bh=t6FtGYb0QWjhIAHAasrXvGSoXf4vKoK/ABxKMZxZbIQ=;
 h=Subject:From:Date:To:From;
 b=fGKz6C6vfYM8GFartfa/hrzeNt0UPWWMQ1f8WdbkOyqkLtDmqrJG7kcYvLHvM7H48
 1+hjcmI1n796g8ZOqVX7ieA+rph+exT0sddVF9oyCMXyLuqc+ubOJPkGmcsMyUZtCG
 hv8GNO9/YYRnFjsjmpd8LpqENDUG0ZMZedsEs/g+crKpKVoa8nMBVh/5QZa9EKYhvR
 0RlLZBE1bG7lyUkjYOwFYAAlJvuAAUX9Wx3pslIfFzKDgFNGXWJ54BCZ9Ya00bghXr
 5M0M1d5AAZXRXLMv1k9ZRLAtL6X64n9EAjdtb1QO9rCL35IhL2X78UqbuBTg3Ed5Ez
 rl0Z7AgmSx3OA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B192B383BA3C for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Jul 2025 20:20:04 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175287000347.2782346.8699917268198176847.git-patchwork-summary@kernel.org>
Date: Fri, 18 Jul 2025 20:20:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1ucrYb-0000NI-HS
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

Patch: [f2fs-dev] f2fs: fix to avoid out-of-boundary access in dnode page
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=983421
  Lore link: https://lore.kernel.org/r/20250717132633.1339965-1-chao@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
