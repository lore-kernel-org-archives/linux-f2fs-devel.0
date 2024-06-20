Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2529C27C79
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:03:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sKIO3-0007q3-SG;
	Thu, 20 Jun 2024 14:03:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1sKIO1-0007pv-Uh
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 14:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=26TBuUoSoxNV5xDtRrN5F5GH8O0+KboclCGnDjLE3SE=; b=c8E5BGMzrRQKenx/ganMbW8TET
 9itb87gtvGXcL9/fUF40J+QFG/WcusfaC0xgY2tycBped0DJ/MVzYgEZpOiXRiAfLn8Rd99rPWN79
 cR044+GasUfi5sN797snckEg7L5OFzPHAMqVO2Jw39ctO+vDL92erHaFQx0/UiHnpkBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=26TBuUoSoxNV5xDtRrN5F5GH8O0+KboclCGnDjLE3SE=; b=ei9m9abZduqX8wF8TqU0V85UrL
 3Y5TKf94t9e93pZy5jJlenEobfPpnEcuzRdcgKRTEl5KFBBhvJBlVVrfEIxwUmJeqCAxzerU2AdiE
 b9KUp/I1W0ddCMbtRzQ3jIN12R/jUxg0Ap4AfZCCKMaXURx6JPHAu5fy+dZRJ0BWGR4k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sKIO3-00007Q-9w for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Jun 2024 14:03:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 32285621B7;
 Thu, 20 Jun 2024 14:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0095C32786;
 Thu, 20 Jun 2024 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718892208;
 bh=Bm2ZjNf2b+VNKHoshVbV2rXdyFmyGGFZXFG269zvKN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C5oZDmcRVKiRXGV/z66rlpXEDT79Ddpy4N7glSKSArC8UTNU8pFoRHfWsC5B9w9NS
 T5kECR2Pd0qqet8v+1zBALgtxdmy7vGcXB0hr3h+ybzQa57RAbbb7jl2TixR8zmGya
 KNVrGLpf8h8wys9zex85p0mFsWByPDzJxFo/wlCi9FF2qZcO+DFqmCc+5ofCPO0qEr
 gDlYIGSqo6ZeY8wwrUqdcgOMfaCBz1T9zWZHzDf1PyCI8QRmms3m8R+xqDvjsh9Xq/
 95/kxM22g6HOD9FeAGvZJMdqUthc9aCGNPMrB7Y5WfPtbi3+HqC8EA+IZ/68MUso3l
 pTpfMznOFFZNw==
From: Christian Brauner <brauner@kernel.org>
To: Youling Tang <youling.tang@linux.dev>
Date: Thu, 20 Jun 2024 16:03:01 +0200
Message-ID: <20240620-biografie-anlief-f8640333c226@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620032335.147136-1-youling.tang@linux.dev>
References: <20240620032335.147136-1-youling.tang@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bm2ZjNf2b+VNKHoshVbV2rXdyFmyGGFZXFG269zvKN0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSVmC17tVI48m/oNrs10XfDN+mzHTzSq/L+0dZ5Pv92S
 AR433Wu6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI6VNGhmVCq9btav7Av7Z1
 3YZtD5pS5G++tNigPeuz8dWExuNXwuIZGY7czpyYG60r4W354eu/7VvMp7/b/CL3u+Hmy8JXAgw
 nreQHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1sKIO3-00007Q-9w
Subject: Re: [f2fs-dev] [PATCH 1/3] fs: Export in_group_or_capable()
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
Cc: Youling Tang <tangyouling@kylinos.cn>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 20 Jun 2024 11:23:33 +0800, Youling Tang wrote:
> Export in_group_or_capable() as a VFS helper function.
> 
> 

This makes sense to me.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/3] fs: Export in_group_or_capable()
      https://git.kernel.org/vfs/vfs/c/daf0f1ce3585
[2/3] f2fs: Use in_group_or_capable() helper
      https://git.kernel.org/vfs/vfs/c/29a76d8b349b
[3/3] fuse: Use in_group_or_capable() helper
      https://git.kernel.org/vfs/vfs/c/d128e6b878ac


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
