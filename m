Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5809CCD37B2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 01:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=B+bu9xd/UKuy6Gqus0Xiceds9KnChQjmWSRfP5SuytE=; b=Y8vlLrmgdT0oC9LxEtjynEBCM+
	mCKbp8ZFSly0fmzCklEFy5vmwjUUwjl1v+tTPHooEtGlQ3QAylZ6wi69ABzeW9/4GxSR/88Ewfl8n
	otW6GxCNCSWbFuzoXnR+bNXb7r5zgcpFSVaPHhGJ/avDsIZlJbyamcSaFloR6OR1mzvY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMFna-0005Oc-1e;
	Mon, 11 May 2026 01:51:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wMFnY-0005OU-DD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:51:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hTsOJPc2VLpdGpOLzoHQ+Th3Wkn1d153KBGCurv01uE=; b=DcJ3IljXoh+8DiM3pXsTRETiCE
 Hql39AxRq1FsR/7VLxDtDWzmuFEzTOneuUGeJ5aTrg5l2mcNK0FKBCFzJmioUF7z+HV7DzDUg5x4/
 WEpHSDFELm/ew/XdM3dqQIMv/JocI9YwEVhgcSBd/PAgRN4GmHo5pLgYpqFqEy7BtMow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hTsOJPc2VLpdGpOLzoHQ+Th3Wkn1d153KBGCurv01uE=; b=j
 +HZdff1E42scLmnd5c0GeIqvhp/AvmLR+5vveIRzB4Jdm0q5xi0/0WtPZ0IAfdpiuG/dDuJYZwSdA
 /OizqCRDJUhk6t0LYmnnfFfKURTY5xhCXdHhs92Y2zA0XIWEgt3fXMNAuaGSjP1In7OC5zTerThf9
 SwJq17gSbQVeDsfY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMFnW-0007dL-TO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 01:51:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4ECCD600C3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A65C2BCB8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778464256;
 bh=oPXt1a7l0OsIptZz/847wO09f3qkVDLiGq/mhgd329s=;
 h=Subject:From:Date:To:From;
 b=FI5Ra9wH/fnyqGOanhLeHxXEo96t73f1BGUiytNJwP0Ygyh7m/qyzuP7q/HC9fdcc
 YhXBL1CV2Fq0bmNukgElyCms7kdIzKHBeHAYzs4IrJf+3mFhZ1DAqab4kuLIvRB6as
 vnjaa32SJeALfGsfFlOUKZczBHcMViRrecAfoMTGTgW5dW/vdOT/NOtnVVBfhqH3xm
 y1tsmraEhJV1Fc7rSYhtRGPoVPs44c6l7z6g3zJ6dfkBG4yAFXCENVa6jkQwLNnPvh
 OnIbcCk8k1tWwn2jfMHMb9Ww302+fCP4a+9pXtQpw4ZgUr7jTgOsi+R0/bDI37V3aA
 9UU8Mv2rXZ7ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 427333930039 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 01:50:04 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177846420292.1981547.16924847232069950672.git-patchwork-summary@kernel.org>
Date: Mon, 11 May 2026 01:50:02 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wMFnW-0007dL-TO
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

Patch: [f2fs-dev,v3] f2fs: Add trace_f2fs_fault_report
  Submitter: liujinbao1 <jinbaoliu365@gmail.com>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1090384
  Lore link: https://lore.kernel.org/r/20260506095731.1039356-1-jinbaoliu365@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
