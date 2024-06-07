Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB61C27C5F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Jun 2024 15:04:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sFb8h-0005ef-Nl;
	Fri, 07 Jun 2024 15:04:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1sFb8g-0005eT-PF
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jun 2024 15:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uFzSX8uY3SbbIhSKwZGizckUTkSP/JDfFKE1voLjWw8=; b=AHKf8gFbLOcTDObCJe2gsj4GVI
 esBVjm2g+WySE3t8fM4pDwHl5sPG2znshE7CHZIi/cCpeVmDVz7xxZbNyr3RkmAPTSIaz4Z1ee7Ce
 aVU5mT59465g4Fnny5OkW6NT9NUG4LhLQ5b3PRjO4f1Xv4yiu3RcPsQgWeNpH1bWGIrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uFzSX8uY3SbbIhSKwZGizckUTkSP/JDfFKE1voLjWw8=; b=RJjTB3kTKhsxKABFxl/F9bsC27
 Z3NrHeu6A+FE0WcuOs7LnnLTfQgVSRSJYzJPiQ916G2ednMz24C9OU11uSqTe5BtyS7Pg6oix5gng
 otZXOfr+D8L02hSTj7j0ThOLKoGe4qv1r9H9c/C+8a+nqQSaH6hQGjIKyc8iZ3xDdaYQ=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sFb8g-0004ge-3H for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jun 2024 15:04:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A17D1CE1D3E;
 Fri,  7 Jun 2024 15:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57512C2BBFC;
 Fri,  7 Jun 2024 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717772648;
 bh=Lzwh59pGqQPMSmXCnv1V9dwU7w38svkd4peyTHM+OsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DqxpoZzCjceNF6IHk5AADWZtZKEBqafprQcRML5t4xFHoFegD1sbOUTkcMuO8uHeF
 FNUmQZzkRMzcvAa02447Pz9kzQjduNwDkaSNgwCs8VacZVbM5Zs04ppAbITS2DleIg
 Trp4YY8MkZoRm1HfvCFfqDPXXu+BDN8e2hygdxtxFQJx9XDwsu7HFIwrMYtT5xyCu6
 h49FxhVgBON1h/M7nrVfchUjYAW2ThRnH03dXTpu5znmYh1uQsbtP5AL95AHL1CE3a
 9HnDiv79OchJuU4lebNQykIjqnYSJ3zLeQ1ilYcf3XYFlAuFRG9q0y22FmrMQTSkcE
 I2tm6465xnRXw==
From: Christian Brauner <brauner@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>, ebiggers@google.com,
 krisman@suse.de
Date: Fri,  7 Jun 2024 17:03:59 +0200
Message-ID: <20240607-erziehen-akustik-2600424fea81@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606073353.47130-1-eugen.hristev@collabora.com>
References: <20240606073353.47130-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lzwh59pGqQPMSmXCnv1V9dwU7w38svkd4peyTHM+OsY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQlKyZsql/6SWGLrCefUcj3eZJTpWUOp/A/n/P62dxHu
 19KTOLI7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIz1WGf/osalvuLyrme8bg
 tIZzhW8eP4fDq/b0rmXv8n2E9WKUnzAyNPstaJNK+JcpysxrLZYz8//FPXH+N20dVx0uPlq8q3M
 9AwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1sFb8g-0004ge-3H
Subject: Re: [f2fs-dev] [PATCH v18 0/7] Case insensitive cleanup for
 ext4/f2fs
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
Cc: tytso@mit.edu, Christian Brauner <brauner@kernel.org>,
 linux-ext4@vger.kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 kernel@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 06 Jun 2024 10:33:46 +0300, Eugen Hristev wrote:
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
> 
> I resent some of the v9 patches and got some reviews from Gabriel,
> I did changes as requested and here is v18.
> 
> Changes in v18:
> - in patch 2/7 removed the check for folded_name->len
> - in patch 4/7 simplified the use of generic_ci_match
> 
> [...]

Applied to the vfs.casefold branch of the vfs/vfs.git tree.
Patches in the vfs.casefold branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.casefold

[1/7] ext4: Simplify the handling of cached casefolded names
      https://git.kernel.org/vfs/vfs/c/f776f02a2c96
[2/7] f2fs: Simplify the handling of cached casefolded names
      https://git.kernel.org/vfs/vfs/c/632f4054b229
[3/7] libfs: Introduce case-insensitive string comparison helper
      https://git.kernel.org/vfs/vfs/c/6a79a4e187bd
[4/7] ext4: Reuse generic_ci_match for ci comparisons
      https://git.kernel.org/vfs/vfs/c/d76b92f61f3b
[5/7] f2fs: Reuse generic_ci_match for ci comparisons
      https://git.kernel.org/vfs/vfs/c/d66858eb0c72
[6/7] ext4: Move CONFIG_UNICODE defguards into the code flow
      https://git.kernel.org/vfs/vfs/c/d98c822232f8
[7/7] f2fs: Move CONFIG_UNICODE defguards into the code flow
      https://git.kernel.org/vfs/vfs/c/28add38d545f


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
