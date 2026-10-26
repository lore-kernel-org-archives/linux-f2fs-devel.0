Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5A606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fZ6hQAQ5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NpT9Vk1T;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G1P04D2n;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+PtPfTP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=AnJFJsXQem8s+QJL/bVu0e+dssXRjHTMFLxBs42CRR8=; b=fZ6hQAQ53UNdCNnSe53FHRvdz8
	Bg5zmwNOJGpVeJmA8BIF1GkGrvmyklGF10u6dxZwRkWqbswutIo3fIjxA2Pj4VZeuAFZWTCCf5h+c
	Bp1WvRIWDb2ALRCt1OYsoZ6arwKRyw8vUVKUPORXLdlcM7Dv6//RNXZqS2mZNQhrULVQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLOD8-000000001y8-2RP1;
	Mon, 26 Oct 2026 17:10:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <patchwork-bot+f2fs@kernel.org>)
 id 1xLOD7-000000001y1-0jG6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 17:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KMdMwy0Cl/cvUJYkyeRKx2yip9AhNIVO853gv/L9f6c=; b=N
 pT9Vk1TgIJqVVt4iqSfJLNLcPXEWZQLbyElOVAa+0RnlFtmn1M3k/ovYmqWqc/5moMUyygNm5Zt/f
 1gp6kAaSuiNZp088qRqGBlhQ/d75DyO6MHW6md62oZTYa3pEUn1TgOoeI/u5xXYTlgU1xf2OnN7iO
 53mzyCTGuz7iVXjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KMdMwy0Cl/cvUJYkyeRKx2yip9AhNIVO853gv/L9f6c=; b=G1P04D2nlHpirsK9c3vF1+cOcl
 jEQQfjEHPzKwojls3BSbxygKFzE8i1/+F3QkQ4kKflOAlMSw7IFpFQR3BESI+OzhKVEIC32WHZTW2
 nD4d6QpiZhMsmmvxaRXIWmTQwimhX4zyIqpGZgt1HytrP+o1Cr4CPPbeEpSVlHz4sz90=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLOD5-000000007j3-2pNW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 17:10:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 063DB601EF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 17:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BA21F01825
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 17:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793034605;
 bh=KMdMwy0Cl/cvUJYkyeRKx2yip9AhNIVO853gv/L9f6c=;
 h=Subject:From:Date:To;
 b=b+PtPfTPPfM3UlFhJSuiFJfVp15cwLkpkT7rBxAaRCLL+E3MJmaBiNioOwLA8GCqc
 FHgXK5uCQ6AwFmUkr5wHyj6q5mlzUCJuSN+Y9+Fz7jJ6EaWrZ3v/g09x3WVECZmKtp
 NZw9XaTP9UHTk+CkD4CitKuCmxQnrjfx0+x75JTqW/K3N3sW3sLHa5UpqCmZusiGVd
 Z2szwzI74ts0tfpA5cwGUjJVXQ9RMZ+KI3f8bMElHsSJKcMH9FGktci6bjX/AJdXo6
 2YAB6hdYZSspyngmL27aFg6fJu6lph1Aw9FMmKy8DjCeXvWX1kRO/jx4//kyy06q+I
 vbUNKlDoMNDSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 83CF53AA58BF for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 17:10:05 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <179303460411.3284016.9302548973859626687.git-patchwork-summary@kernel.org>
Date: Mon, 26 Oct 2026 17:10:04 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLOD5-000000007j3-2pNW
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

Patch: [f2fs-dev] f2fs: compress: don't overwrite populated compress cache entry
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1190957/
  Lore link: https://lore.kernel.org/r/20261021110521.12345-1-chao@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
