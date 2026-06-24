Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB76CDB47F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u/MAHphSuSudm1UKkDSrRzZ6AKWrJJtGt1eDxiY3Ry0=; b=XgXylW1AIOkq5hJJQ1pjU/a2GE
	6olBx3AUUUmlsr8acnu+8Z+PQstXWNiAxWk8uK3A2KirWRclzW1mfYwqW+KgpKiZ+5RQwfG5ajv+R
	DRgdRFBK7UCJKOiiDWW5Vpc7cztRCXpXUZ21VJRu3jE7eHH30Nrz0MmR/ePuaj7FrO1Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcJTa-0008GP-0W;
	Wed, 24 Jun 2026 09:00:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wcJTS-0008DJ-30
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:00:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JjL6dhBnyDtQ1V+CFFTtu1ugVZc8avKE+2MHRbCx/4s=; b=P6DiXxuj24BZDUPiqQiAmsPZs8
 zPNYl437oLajEmhAtz5CwIN3gTjTgP3H1nzDLtHU+dyDLx6Rvc6s1SJ87U6E/A9xvhe7LlnlFY15e
 VtwvDCz0ua5HrkEn4EDGCv8ENf+EDbdXXDuqNVATUZN0JxFpIcVPbZRapXqqmbuv9D3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JjL6dhBnyDtQ1V+CFFTtu1ugVZc8avKE+2MHRbCx/4s=; b=G
 uHX1GguYKW2pcrpKpf5yK9P4/cxu6N9TjF07osRAefIUT72kmVZ0BG9cc/dmkTBu27tatbNt5Y4XQ
 vAGwnktiDYIyWo6taA1pG4OKFrY49bKVIhEIPjYDPDK1/brIbM3MvMDAeJXrvotQcJ1pXib2pfLIm
 gRcEPYj5o7CfEyMQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcJSX-0000qy-9n for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:00:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FCBA418E4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 08:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F41F000E9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782291579;
 bh=JjL6dhBnyDtQ1V+CFFTtu1ugVZc8avKE+2MHRbCx/4s=;
 h=Subject:From:Date:To;
 b=juM42ubMkgh3lzYl5GHzibttRt1ArWV5tVlSVRZ5/L+x/5oeSFfQQDzs7BEZWUrdD
 3D/WKGBLLGXyyxWiemGBlzwQTeC2qCckE7hPfRdz4OCa/LOvzsGTnJ4WwrBaIlcvfn
 hTFsLK+YegCZrgL6UUEfypAPJO/qg/bb5roRbqP+zeLLHJ0smXKtNUw2CAhR9AFsAC
 oBejqovkG1LquaXk8PADfJiBKUj1qHim5bMZEqaV4MCaHMDnvGDF0eiSF7fUtfwH5p
 sYooKEMIqYegIJRHrgVw7fJlYDBnr9s2kEjzf/LbqR0vo8ZXhEsXYTXsm6nt2EIGfs
 q7hQn65UaO+4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5932839EF964 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 08:59:29 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178229156799.2577930.16585179862992494459.git-patchwork-summary@kernel.org>
Date: Wed, 24 Jun 2026 08:59:27 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1wcJSX-0000qy-9n
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

Series: Exposing case folding behavior
  Submitter: Chuck Lever <cel@kernel.org>
  Committer: Christian Brauner <brauner@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1090897
  Lore link: https://lore.kernel.org/r/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com
    Patches: [f2fs-dev,v14,01/15] fs: Move file_kattr initialization to callers
             [f2fs-dev,v14,02/15] fs: Add case sensitivity flags to file_kattr
             [f2fs-dev,v14,03/15] fat: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,04/15] exfat: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,05/15] ntfs3: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,06/15] hfs: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,07/15] hfsplus: Report case sensitivity in fileattr_get
             [f2fs-dev,v14,08/15] xfs: Report case sensitivity in fileattr_get
             [f2fs-dev,v14,09/15] cifs: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,10/15] nfs: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,11/15] vboxsf: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,12/15] isofs: Implement fileattr_get for case sensitivity
             [f2fs-dev,v14,13/15] nfsd: Report export case-folding via NFSv3 PATHCONF
             [f2fs-dev,v14,14/15] nfsd: Implement NFSv4 FATTR4_CASE_INSENSITIVE and FATTR4_CASE_PRESERVING
             [f2fs-dev,v14,15/15] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION

Series: fs-verity support for XFS with post EOF merkle tree
  Submitter: Andrey Albershteyn <aalbersh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1098004
  Lore link: https://lore.kernel.org/r/20260520123722.405752-1-aalbersh@kernel.org
    Patches: [f2fs-dev,v10,01/22] fsverity: report validation errors through fserror to fsnotify
             [f2fs-dev,v10,04/22] fsverity: generate and store zero-block hash
             [f2fs-dev,v10,07/22] iomap: introduce IOMAP_F_FSVERITY and teach writeback to handle fsverity
             [f2fs-dev,v10,08/22] iomap: teach iomap to read files with fsverity
             [f2fs-dev,v10,09/22] iomap: introduce iomap_fsverity_write() for writing fsverity metadata

Series: [f2fs-dev,v9,01/22] fsverity: report validation errors through fserror to fsnotify
  Submitter: Andrey Albershteyn <aalbersh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1086679
  Lore link: https://lore.kernel.org/r/20260428083332.768693-2-aalbersh@kernel.org
    Patches: [f2fs-dev,v9,01/22] fsverity: report validation errors through fserror to fsnotify
             [f2fs-dev,v9,04/22] fsverity: generate and store zero-block hash
             [f2fs-dev,v9,09/22] iomap: introduce iomap_fsverity_write() for writing fsverity metadata

Patch: [f2fs-dev,GIT,PULL] f2fs update for 7.2-rc1
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1115531
  Lore link: https://lore.kernel.org/r/ajrLmn16uMPcc4Lv@google.com

Series: Subject: Exposing case folding behavior
  Submitter: Chuck Lever <cel@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1055004
  Lore link: https://lore.kernel.org/r/20260217214741.1928576-1-cel@kernel.org
    Patches: [f2fs-dev,v8,01/17] fs: Move file_kattr initialization to callers
             [f2fs-dev,v8,02/17] fs: Add case sensitivity flags to file_kattr


Total patches: 26

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
