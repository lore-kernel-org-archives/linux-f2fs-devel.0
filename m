Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030A606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dhQMMc7X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RSznilov;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=glXq1r4q;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R7oQLSyE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=t6t25Mn8/liKqjzZQXCdQfFpbg5gFgElT/A+g7IESpY=; b=dhQMMc7XrPL5ZBH6Zmt8RC9llE
	8r7GftKsBNxpZmq7/tjGSIUr4VIPwex/Su8yYGUbJy//GOoArl6Ux1eiMf30uHC1BleFvFBqKv8C3
	c04V4ty31CSvk/WJ5iJea6Dk2F23N6lsRiEu3m7hVJIzcV4HyzHk2Vx7iH5DA0q5Y+GI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTTYW-000000002bS-2GEM;
	Wed, 18 Nov 2026 00:29:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <blum@kernel.org>) id 1xTTYV-000000002bM-2v8H
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qNXt9CrtwBP/UShhCkJznTf/nidzDEjoR+gXc90tUlE=; b=RSznilovVtsuxAaa32W4d2gFQ7
 u3laDs+0x97/X14wJ7yFfWM/PksADLSpyj50Sfnbx/InJtS1ejdM3Mee4ZfzAC/Q91pf6fhL9MqNz
 P/UMZ/ek07g1n2K865y0n+tJfGkPfeabIoKF8WGtFOecBrn3GotNvwbwTzsJtJGzOwrI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qNXt9CrtwBP/UShhCkJznTf/nidzDEjoR+gXc90tUlE=; b=glXq1r4qDK3BfaqRB3V9F8iwS7
 rIccj+4SeDT68DKehn0ewJfFclAyvpJLOQ43E+UphtDicoHNL+8eh8U2HeULckh025R2gUzl2Npb3
 TI24N7m+luIGqS1xIfa1wFxfn96nY0+ZV+ha1Z7U6JSyysIY+WcBWmAOQBfyR0ODZztQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTTYU-000000000jR-0WAk
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8225D61209;
 Wed, 18 Nov 2026 00:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68D01F000C4;
 Wed, 18 Nov 2026 00:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794961776;
 bh=qNXt9CrtwBP/UShhCkJznTf/nidzDEjoR+gXc90tUlE=;
 h=From:To:Cc:Subject:Date;
 b=R7oQLSyEL2pcGI1LgWXqvBRuFvDXgrxHyqrzhhpooghQUP5mlr4xyynm7F8jbOMDD
 PYH4i6YSAbmQVvYK0HyDYT6Zx5CzESmw5G+ROIhEgR+h6jiIdbMKuXnhCEjc/Lzy5L
 exwybYXRrpf4lytvHpJunftrfDkcrGwG92v6V+pWBcbqFU3FkU9wl9CGA+l9UAhVAF
 rKu/B4bKdKI7yJ7T36P1BMh6J+QlBj5OlZ7fZsgEczMYZHDwW4wzKRMlCpPTnymTXk
 NsxWx0g64DaJxxDpf5y1jmIanBDipGhZK7GPyb7+TfL4K+eRCq5GeF9pF7Gj6BKzUf
 6HeZK24C2Irmw==
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Wed, 18 Nov 2026 01:28:46 +0100
Message-ID: <20261118002845.574426-6-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=716; i=blum@kernel.org;
 h=from:subject; bh=wqbOfCuCbdUcemVKsc9HdxKwyAV8xTGLwFPgISLMeYE=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl/PtrOPPLOlNey+xjX9vwP7NPkJococ3yzDrV/Vf5Fb
 UGhytqFHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCR7qkM/109FfZ8O2wdlXJg
 YnLU4vt5bx6kpHxW+TTt088oN+1jW4oZ/tnuPNNc0OU9y7Nf7F5uZ5103Yr3KsmdDgqRnjH3dzC
 Z8AAA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTTYU-000000000jR-0WAk
Subject: [f2fs-dev] [PATCH 0/4] fscrypt: Add FSTR() helper macro and convert
 initializers
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Thorsten Blum via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Thorsten Blum <blum@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Similar to QSTR(), add FSTR() to initialize struct fscrypt_str from a
NUL-terminated string without specifying its length.

Use the helper for 8 initializers in btrfs, F2FS, and UBIFS, replacing
hard-coded lengths and explicit strlen() calls.

Thorsten Blum (4):
  fscrypt: Add FSTR() helper macro
  btrfs: Use FSTR() for the "default" name
  f2fs: Use FSTR() in f2fs_do_make_empty_dir()
  ubifs: Use FSTR() in ubifs_xattr_{set,get,remove}()

 fs/btrfs/inode.c        | 3 +--
 fs/btrfs/ioctl.c        | 3 +--
 fs/btrfs/super.c        | 3 +--
 fs/f2fs/dir.c           | 7 ++-----
 fs/ubifs/xattr.c        | 6 +++---
 include/linux/fscrypt.h | 1 +
 6 files changed, 9 insertions(+), 14 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
