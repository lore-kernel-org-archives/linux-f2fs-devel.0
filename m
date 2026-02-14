Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A13EF5852
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Feb 2026 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J67uySIak5NFQkEDJ3VY5idcTIcRHVRu+ISzib/oJ38=; b=CgdqXIiEWDG5c1OGvhX3LBO384
	6xiqosQvP5et1DuO7GroGII+LPZcSs1X1kcqE7jZvK1TI+6JeDd972RmycmM5SshXqaRLusxdwkp+
	JY+rEffITMs/5dh7iY1faJeLg7qwD2+8FSzVMFdkY/NtFZtFPdEYoqXur+22vV0mYfao=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrN2x-0004Ln-VG;
	Sat, 14 Feb 2026 21:19:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vrN2w-0004Le-Dj
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 21:19:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=62AguZjp2u3FS7SOqiflhxPHg3h1RMvlNEOuqzxVeno=; b=M29fXOUkjfJF7kwo79HXD/jYX0
 qDhsxZknQtqvKyGe/UAi5GRNAPWvf+JLl1E1Fi7OMeuF534baySkj4yJH8g6cBVK/vWZj09OYRie7
 beD39WMelLUNobS/oY1RLi1kpX4LGne7FJL9R2CJ7Rokyq4EWsZ/U0MfkqpmFy64K30M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=62AguZjp2u3FS7SOqiflhxPHg3h1RMvlNEOuqzxVeno=; b=i
 wgKbHHMwZabaR06hvchRt6wuhW4Bj2WIu1/VT3RswN6tuhFkBwzDNG0SANajQeT6YdSg1ieam54Ig
 xVw7NJAWahxv8AXABp2EpqtoZspw+QY59ryWUmXT6xjKEk465Mrgl2UpU6Oz4H4um7my32at1Diwz
 TtcD3+W4iaiSahwA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrN2v-0004No-RC for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 21:19:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B679409E4;
 Sat, 14 Feb 2026 21:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A6BC16AAE;
 Sat, 14 Feb 2026 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771103956;
 bh=M6VL2Ez0tT1CpEX0FgdzeilPEVi5VNIinD4KFHFmOnE=;
 h=From:To:Cc:Subject:Date:From;
 b=u1TAy0NqarrB76rRo4+F6siHdo2KE5BMGtDlvxRS1X9qcRzXmPZg/OXL3OXVGV+JB
 RbnsEHZ9ZMPULmS8glhcvIx+CnhFT5xfm5mX1BCjH0j3DA33xjoWTrM395GfLEpHsu
 DgMZ+6HqmpjdWP2LoM5DEGkvQbZCtdBsROTU6TZQQHj2FtqyPf6ZCbtF3xac3e1dvN
 Ykha2yOAuSrJhsahlm1Cw5iNWF364t54Sgp3uFMVSPeRQ5x5jIdVgMGXXDnqj4tMoR
 bdX+qz4bWRZvjNaPGB/8pbgEC9pyZ9ut5GQIMnsIsDa1dk2naoLExJpaQVq+ibk/j9
 9iL9JsLDJHMPw==
To: fsverity@lists.linux.dev
Date: Sat, 14 Feb 2026 13:18:28 -0800
Message-ID: <20260214211830.15437-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1vrN2v-0004No-RC
Subject: [f2fs-dev] [PATCH v2 0/2] fsverity: remove fsverity_verify_page()
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
Cc: linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series removes the non-large-folio-aware function
fsverity_verify_page(), which is no longer needed.

Changed in v2:
    - Made one specific part of f2fs_verify_cluster() large-folio-aware.

Eric Biggers (2):
  f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 6 +++++-
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 3 files changed, 7 insertions(+), 9 deletions(-)


base-commit: 3e48a11675c50698374d4ac596fb506736eb1c53
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
