Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CF5C4450A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9gYqCufj3v1ZV2UIgwYHO/23Gp+ATRmrBxBE+OaRXgU=; b=cGPZAZ6y7BkxtNCZhe5zBuH5vr
	Lk9YQ5P5uWsdVHPQ2y7wzg3IRobsLlc+lVhQ4jKSGNfygsUxySRrxo6yXLhK3gpYhP6MfhlzriY4T
	qzcfiL34uaVpKZ1tRwBfIHhhx81GgOJoOvv8CMD2sOg9T7hvcg42RBI3+3sJ2twBVLLs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlCuC-00040q-N8;
	Sat, 18 Jul 2026 21:49:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wlCuB-00040e-Gk
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=utFnArNBvhXi0tskwzedkcauorut7DvNltLjRLrRl94=; b=f2JFPh2TkBMvJgsXlBCBTQliIt
 /5biSrAWJOm0YW+TFR/Bd1mv4vRm3jsLxbh9hoB3Lc3oF50DFFt8y3kY0sWczcFtoiWJ9HsMZ52qx
 qZ17SJoOz9oFheBi3u8MtXBNXnOr+aizRVZOr+96K3UdNdOg9a8yiOkeA27nP7IYdHuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=utFnArNBvhXi0tskwzedkcauorut7DvNltLjRLrRl94=; b=V
 gFd6eD4jdbjylN9VyJvQyTEuubnZAZOSlSfuWhkD2b7jWw6XCNuNURp19NI9Qou25rBrDvlgs5fmt
 kC1zse6D8bEuwegWrn1OApNCyW5M8WLM4Z4wv6HazbF06tuoxteQtygZQk6RrFrz2Ku3WELE5vDhJ
 PfevJnamTWHFulhQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlCuB-0003Vn-Ly for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Jul 2026 21:49:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BC7D41748
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 18 Jul 2026 21:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587D91F000E9;
 Sat, 18 Jul 2026 21:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784411342;
 bh=utFnArNBvhXi0tskwzedkcauorut7DvNltLjRLrRl94=;
 h=From:To:Cc:Subject:Date;
 b=gJM7OV9vS8RkGvdy8FXmYDuRyrrLXbUpYRKNNmTCWCICjXQ4nSIxlZoFiwYQzmMjN
 Sgrws86276SHJPSsZh4ISyc0Z8hsdM0H4ZxC/6BySsYXivC5JBUk48zn6Zzt+ikGpl
 9j3caqkmZviOWQRRMhB6g6Ie6/YV5VZX4Kl2GbQnIkBc6KqM+6GopvwKu1ys0S3HLG
 zqo45K7feLUp5ceURQW83ryUd60pYvKMbY+WloS2r6j0tpvvA68IwIF+nqTM15OdM2
 Rnmk8aGIU6xNeM06O+IH8QGOgteHHLJIHbpBcLkSuwmCQqQ9OW9ru64UxMGURbD+RT
 VmYQayDmeJ3kw==
To: linux-fscrypt@vger.kernel.org
Date: Sat, 18 Jul 2026 14:46:49 -0700
Message-ID: <20260718214655.63186-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1wlCuB-0003Vn-Ly
Subject: [f2fs-dev] [PATCH 0/6] More fscrypt and blk-crypto doc updates and
 code removals
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series applies on top of
"[PATCH v3 00/17] fscrypt: Standardize on blk-crypto"
(https://lore.kernel.org/linux-fscrypt/20260713023708.9245-1-ebiggers@kernel.org/).
It gets more documentation up to date, and it
removes a couple more functions that are no longer used.
I'm planning to take both series via the fscrypt tree.

Eric Biggers (6):
  fs: Update outdated comment for SB_INLINECRYPT
  f2fs: Update outdated comment in f2fs_write_begin()
  fscrypt: Remove unused function fscrypt_finalize_bounce_page()
  fscrypt: Update docs for data path
  blk-crypto: Remove unused function blk_crypto_config_supported()
  blk-crypto: Update docs for blk-crypto-fallback motivation

 Documentation/block/inline-encryption.rst | 43 +++++++----------
 Documentation/filesystems/fscrypt.rst     | 56 +++++++++++++++--------
 block/blk-crypto.c                        | 14 ------
 fs/f2fs/data.c                            |  2 +-
 include/linux/blk-crypto.h                |  2 -
 include/linux/fs/super_types.h            |  2 +-
 include/linux/fscrypt.h                   | 11 -----
 7 files changed, 56 insertions(+), 74 deletions(-)


base-commit: 185a45827da9459c4484ea60cfe1797c3e9966b3
-- 
2.55.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
