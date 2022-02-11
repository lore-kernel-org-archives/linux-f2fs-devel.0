Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06131C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Feb 2022 06:13:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nIPBg-0004Ka-VO; Fri, 11 Feb 2022 06:13:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nIPBf-0004KI-OD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Feb 2022 06:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MBu5e7gZ/J4xZq/GMtjcc7Itc2OJBoVZZ8+hgedm7DQ=; b=a3DfNjG6CzWS3BoSHC1ZWKLzs1
 OOH1Z7cfDhm8X1TYjjnJs7D9XoSFyMxiJMryDE+gZdSdZHounxLmPtODUZbE3SLMW9R+JrQJC73Cx
 UZ+j+oSRYSbG+YO0Uvn0Rzb9LwVAU5OdlbgVTbZ4P/TnEpPix2nKba87sT31Sn4UhYuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MBu5e7gZ/J4xZq/GMtjcc7Itc2OJBoVZZ8+hgedm7DQ=; b=b
 6GCSUKXejejrRmez8RgHUSfOCaROT4+nq7Y8g7YaDN/apJoHyhwL09MdfapG8y1/3/wx0izkUxX72
 lKLsNd+/Ut7nGI0zMM1/0UGWvBvHlVKRt7iMFS2nt6kfAFi7vHOQwT0SIyjnj6aW3MD+DlwBPR8G3
 TAGbWj2wQWLmOjtg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nIPBb-00Eztn-PK
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 11 Feb 2022 06:13:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DF25BB8239F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Feb 2022 06:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787EFC340E9;
 Fri, 11 Feb 2022 06:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644560006;
 bh=BKA5jTy6pTvT/2eTBFcXj02nmCgqitj7KJJ1UiB3EpU=;
 h=From:To:Cc:Subject:Date:From;
 b=Iu5/Sa4pfkEpR9o0eBTJ1V30YT6bCxpLasszI/CU4T8A42NiY45wXgX3h3GybGgiB
 NAzGvdsxlLAolhxEa7IsbAiY3JjF3ewzNeuqCqsWmfxz6wc3ZOL7JKTGom90zAEl8N
 02IlrBVB6LknF2DDc4ILNOZuXFcduDCnLKPlC5KocAJzuYaaARaxYBTpvdGwinClME
 LQ3TYwsVH/k3NmkATxDZxPMWHcbSMYINM2CkMcygXTpniHEZDxOiqq093qz2s0tLNr
 sAvQyo3kbKf/HAmxOt+ukiAviUgVZjakrR0xmE5nlVlNkDjZ4k2/fqvceH/ietEPU7
 N7xrtFLmVK1Jw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Thu, 10 Feb 2022 22:11:51 -0800
Message-Id: <20220211061158.227688-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Headers-End: 1nIPBb-00Eztn-PK
Subject: [f2fs-dev] [RFC PATCH 0/7] make statx() return I/O alignment
 information
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patchset makes the statx() system call return I/O alignment
information, roughly following the design that was suggested at
https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u

This feature solves two problems: (a) it allows userspace to determine
when a file supports direct I/O, and with what alignment restrictions;
and (b) it allows userspace to determine the optimum I/O alignment for a
file.  For more details, see patch 1.

This is an RFC.  I'd greatly appreciate any feedback on the UAPI, as
that obviously needs to be gotten right from the beginning.  E.g., does
the proposed set of fields make sense?  Am I including the right
information in stx_offset_align_optimal?

Patch 1 adds the VFS support for STATX_IOALIGN.  The remaining patches
wire it up to ext4 and f2fs.  Support for other filesystems can be added
later.  We could also support this on block device files; however, since
block device nodes have different inodes from the block devices
themselves, it wouldn't apply to statx("/dev/$foo") but rather just to
'fd = open("/dev/foo"); statx(fd)'.  I'm unsure how useful that would be.

Note, f2fs has one corner case where DIO reads are allowed but not DIO
writes.  The proposed statx fields can't represent this.  My proposal
(patch 5) is to just eliminate this case, as it seems much too weird.
But I'd appreciate any feedback on that part.

This patchset applies on top of my other patchset
"[PATCH v11 0/5] add support for direct I/O with fscrypt using blk-crypto"
(https://lore.kernel.org/linux-fsdevel/20220128233940.79464-1-ebiggers@kernel.org/T/#u),
which can be retrieved from branch "master" of
https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git.  The statx()
patchset could be a standalone patchset; however, I wanted to show that
it will work properly on encrypted files, and the statx() patchset
probably will take longer due to the new UAPI.

Eric Biggers (7):
  statx: add I/O alignment information
  fscrypt: change fscrypt_dio_supported() to prepare for STATX_IOALIGN
  ext4: support STATX_IOALIGN
  f2fs: move f2fs_force_buffered_io() into file.c
  f2fs: don't allow DIO reads but not DIO writes
  f2fs: simplify f2fs_force_buffered_io()
  f2fs: support STATX_IOALIGN

 fs/crypto/inline_crypt.c  | 48 +++++++++++++++---------------
 fs/ext4/ext4.h            |  1 +
 fs/ext4/file.c            | 10 +++----
 fs/ext4/inode.c           | 31 ++++++++++++++++++++
 fs/f2fs/f2fs.h            | 45 -----------------------------
 fs/f2fs/file.c            | 61 ++++++++++++++++++++++++++++++++++++++-
 fs/stat.c                 |  3 ++
 include/linux/fscrypt.h   |  7 ++---
 include/linux/stat.h      |  3 ++
 include/uapi/linux/stat.h |  9 ++++--
 10 files changed, 136 insertions(+), 82 deletions(-)


base-commit: cdaa1b1941f667814300799ddb74f3079517cd5a
-- 
2.35.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
