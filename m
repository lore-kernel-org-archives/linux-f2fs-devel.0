Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80581D1BDFC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Dec 2025 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+e5xVSv0/39nani4EGcQVTfXav5LdEB9E9EWsfXxgFE=; b=GXO/08LGsuxBnD1bHJ6ASqeGx6
	rtILqazDDaqAKqqvx1n2n3p3lr7tUfYmMKCkVIKCtAPHaAtGvLi74GOW1MgJtF4JkNuISkY+bNwEZ
	wNRfJVArChsujbtOjINgpvC2j0XiRYSZ5aCbjmKul+ce4KdDbSPFRv56rSgcZ01G38oU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vQuml-0005FV-2E;
	Wed, 03 Dec 2025 21:53:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vQumj-0005FO-CC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Dec 2025 21:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E7Zn5Fi7TClDJyBu7MbKdtVWy1keJn0mouwwg91K+DY=; b=UhQXX1nOC60qAtzR01KZl0BNm+
 31IGxFTuy/+PDYlmv6pc2DwpvMH30s6JnkXnhd6bJHf3wftbn4IlMqJzlJweQhxv5YJrS7+RfR3Bv
 1uSOHXq0Ct+iGrqRqKeM0VqTpeXR8v3p/T+NnWrGfQvXy+Wka1aNOljQbU9Hkb3B92Ik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E7Zn5Fi7TClDJyBu7MbKdtVWy1keJn0mouwwg91K+DY=; b=N
 QeviLkKqa2gKcyr61EIRuvegspEZnU7KL41t3E36xEXq90PqQ86BlhNJghgePabEMoq86Kly0sjII
 lmJ3ZAX2RUMysryW0J/s9Y210/JtMNeUgENT1b1iK8cOKoE/kPh38ImLFluDQsodfVT4XmpcmmjKq
 rcNQDTErEhMmkAgE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vQumi-0007Rc-J2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Dec 2025 21:53:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF29F60126
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Dec 2025 21:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A45C4CEFB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Dec 2025 21:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764798785;
 bh=lmyelhwr3+QPG1cXlnLPZC5I5MOMXPp1+N4SYMeynHI=;
 h=Subject:From:Date:To:From;
 b=Y6Jw8OTXm+FuaGzp5PHnurIuNECVUlDZV7ROseksXePIkYrF9pGKRC+Nid7uLDJTF
 q0PW7H+gKyYvACoj62mIF8uF4bk9YAY6lA3QnW+YZmojaQxN7K5veZ12RGYobGLnpj
 phd++KF+Au6OX+QmJZP0rf+GFB5kQp0gStUdDl3ia3C/n1taHTPaY/qs2OdC1UvQP0
 8fI/gf/vMmVNa7FhIf90dPJAFgl3AMy6MDgSrkirZTxulDwZQfgNVaHZ5Yr4oMHSuG
 EwyNMl0M5B9yKh00nqHsvhmiQAq/6VzkQG43bf/SNl0rHPNZBeBX80Nov4t6NNt0jC
 w3hDlq1Ujlocw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 A0FE63AA9A81 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  3 Dec 2025 21:50:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176479860433.93351.964230492376811217.git-patchwork-summary@kernel.org>
Date: Wed, 03 Dec 2025 21:50:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1vQumi-0007Rc-J2
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

Series: block: ignore __blkdev_issue_discard() ret value
  Submitter: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1027128
  Lore link: https://lore.kernel.org/r/20251124234806.75216-1-ckulkarnilinux@gmail.com
    Patches: [f2fs-dev,V3,1/6] block: ignore discard return value
             [f2fs-dev,V3,5/6] f2fs: ignore discard return value


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
