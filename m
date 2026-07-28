Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6567C53209
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hD6TRV4GHfnO8VTJxEbM/1fZ8aM2owcHJmYpx909I5w=; b=aWILLU2R858HjEY6CRV2kz2nqt
	U7z5nyGzgsDApAXppxLyT7506OVj4ozHMFfdJN9Mm4IuY3kNgIdTL6w8Ob2NYb0SO85+QNhxMuPnp
	sLD3YkHp3UIRlH/Df1x/PyNSNqLL/DKBY+rynKlKXmW0grWO+XAuUA2RtYtkxu8qIiXE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1woWCB-0002e6-Kx;
	Tue, 28 Jul 2026 01:01:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1woWBs-0002di-Gy
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 01:01:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KTBJLG8ta7n4F/kFAmzRyXQDmlh8oqlDo6Wm5U0AZ4c=; b=CS6hE6MF3gEtZ4NXidIih1zR64
 TyeWPDR7rSJkUUqF1fnbkHD3HilDk5KOPq06xWW+eeQpMD+xLtpUneVaVbYdNH+XCBydMOlvNXd+y
 emU3tonqMzp5GF56vek3GxktLVT5tjZziQOD99hU21UUveXWfJ9T4ZRaAR/TmFvmtDfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KTBJLG8ta7n4F/kFAmzRyXQDmlh8oqlDo6Wm5U0AZ4c=; b=U
 uRNHWXaPrRDor4a9wBg1q3UK5AgRWXaP8JzthIldpb6WSW1caZokfU6HSNr5Oh3AwUG1Ju0I/bsUb
 CLZGornmMfP5D8D7Wmykq8AR1QaqbOPPzakYFEKvm7x+Tjq0m41hWW2w1/oCtQSBOE+QxJovC0OwY
 k4IIoQT8r1PisrNs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woWBo-0001U6-BI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 01:01:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3AF960A72
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 01:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B11F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785200454;
 bh=KTBJLG8ta7n4F/kFAmzRyXQDmlh8oqlDo6Wm5U0AZ4c=;
 h=Subject:From:Date:To;
 b=Vu96S4a2pQOfSldfkFIGl08p79DbtOoYP4nDkV+58+uGB7k3pI22UHVjKJeWOHink
 zIf/9Edd+xKTKEt7DN8asCWsdfmDUDMSv+9Vwr+J3PTPYAjUu/LbzDaun5Uyc2ps2l
 LpTU382Or49AjLR+Cz7dGgAC3HVRigNcEd8TReAxnc+NMSLiBp+J+WKbw43GysrEdf
 jyMvzRNuzxHyioEm0tApynLpU1V9THjx0Eq3E3O5Egl12UkkkpOdopNgLxl8X11Waw
 HfvkAYqgRVWjSXHiIG/Cn25oY5He/ullalV8Y4dT49UvHk6Z/4UwWQ+XtziXfM2JGF
 dy2D/qYjbfWOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0B29380CED8 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 01:00:20 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178520041953.1482784.2320721910587685483.git-patchwork-summary@kernel.org>
Date: Tue, 28 Jul 2026 01:00:19 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1woWBo-0001U6-BI
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

Patch: [f2fs-dev,v2] f2fs: fix dentry folio leak in find_in_level
  Submitter: Guanghui Yang <3497809730@qq.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1130237
  Lore link: https://lore.kernel.org/r/tencent_ED3CBD42DCDC72213E6292A83A7924155109@qq.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
