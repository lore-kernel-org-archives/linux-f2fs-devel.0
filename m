Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6C606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mvB/GugY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EcxL9Dgb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jyRLnGTS;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NqJyT2sT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=zAM6Ew5cmFWufnCCen5s6fHJy3Zg2fu9N3hJeqP1CQQ=; b=mvB/GugY12Exv7NMbaViI5H2YQ
	c68Yjr2mR2/5xI6PsF6nP6Y23e01aJZh48sMBkBrtH+K5uJrC5/on2k9wkhHy18sf4PzhMM+b48aG
	sIqnAAfybBjPh/576Asi4pIIV9Z/UtbIp2uSY8IViUMEkKc7mK0ptfof7UHjhLUoxcpg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLMoL-000000006kQ-18xH;
	Mon, 26 Oct 2026 15:40:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xLMo2-000000006k8-0ChK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VV1l1Dw6OUvgc0RdQ6pV99A4xD4Px0u4FrW0ja48LyI=; b=E
 cxL9DgbiRyRziAZAFFqxApBLiNLDgoe7g9v7X9wPDw41Y4VdDdOrZMOqJCwlRQMZkgTQt5hoJ3C7t
 aLlses0TzMCUB2OKSpi84yX95oSxHONkwRGrUQREJPcC7hprxKnQsGlM8dFGE7mx5nQhqxIpulhvY
 GCaXS/2vsQe+VAp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VV1l1Dw6OUvgc0RdQ6pV99A4xD4Px0u4FrW0ja48LyI=; b=jyRLnGTSXZ1YX58Fp2M3279IGG
 GFt41V6+2tRTuRKcljyAjX4Aph3FUcSN+azvxn5DKA/UPbSWp+PGE1vm+MMLGBCs0rTNN7RrMAYfd
 sPfL7PQga9QvB43MNc0eUS6RPC+tYx4KPHUAIZLv1bDC+CG72cOr0NiP8lZZ9pKlSV74=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLMo0-000000005Rz-2C8r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:40:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2F44601EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 15:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1C91F01825
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793029206;
 bh=VV1l1Dw6OUvgc0RdQ6pV99A4xD4Px0u4FrW0ja48LyI=;
 h=Subject:From:Date:To;
 b=NqJyT2sTRoEV47DnvEBuGTwnUmNRecaTP81MSYt7om6CVaI8U8gXje/sfQPwMaFyV
 cqx6v9pbTKoi6DtqNOEerV1DT8+P22fnySd2hvEE5a+u3st24vwxClIpp907daQu3Z
 ZYMwSpvzy3oIiSF1h6YeWyRpZsVSQckH0JZB28ATu7+2g4Bs8Fapnp2ikqM/h014Za
 UwQnxKUDJeyBC+9n6bdX7Z05UJ2OxkpT74dSACZtUo5lGK11+jcwKriJCYCUYQX+W7
 SiDD1287JOydPAvoj1g7sGMyiRKmydobAsruUmnDfxZPSeCbC6GBuaZtk2qrMJ5HJf
 uR3zX+0rW2lAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 83FDD39EF95E for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 15:40:06 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179302920497.3239427.5780774533942749711.git-patchwork-summary@kernel.org>
Date: Mon, 26 Oct 2026 15:40:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLMo0-000000005Rz-2C8r
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Series: [f2fs-dev,v2,1/2] f2fs: fix to fetch ino via ino_of_node() under cache lock
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1193252/
  Lore link: https://lore.kernel.org/r/20261026002350.1451587-1-chao@kernel.org
    Patches: [f2fs-dev,v2,1/2] f2fs: fix to fetch ino via ino_of_node() under cache lock
             [f2fs-dev,v2,2/2] f2fs: fix to update superblock crc in sanity_check_area_boundary()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
