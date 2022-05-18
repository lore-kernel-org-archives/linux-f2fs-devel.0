Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8E7C4321E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 May 2022 23:53:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nrTUJ-0002hb-S2; Wed, 18 May 2022 23:53:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1nrTUC-0002h9-Uj
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 23:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/9mW0P0dY4/H+pUt5Ymldd8NLKiIgbU7h4KT0mVtJhY=; b=ijJ0C/z9sScsS+SA5JOn+wU+Zc
 LYf+TpEsE6A5OvsS3QgTtIjI/DDQ+lPlLxqzZz51oRLWKN176AFPc8yxIdXQoiGk6FkehV/Wix9rj
 knpm9Q58a5tglCKu5LVhanC2EMjWZ3CSTYgbRDfN1vJzhPlfNlHT6ojINQd+/BByv3Pk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/9mW0P0dY4/H+pUt5Ymldd8NLKiIgbU7h4KT0mVtJhY=; b=J
 dtDXq9ChkqkxbnCUPz2LwrZTKJ1tpJm2xap0Km9F+dJvzmnlnbs2XuJp0wSw0y2cW7FYRRV3eTD0h
 7ZhghqiM1Jvvjw2HiG+Vliottw5ZgPfjLuEBnePOzdRgF9lgzqdMmt+J87JC/saX9tpIRkmGdZgtY
 y1S2onppdv+pnMf8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nrTU6-0006CE-Rn
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 23:53:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7C161734
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 May 2022 23:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76052C385A9;
 Wed, 18 May 2022 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652918008;
 bh=urChUY7g9muzenao6Op/35xCF3MRcXpVDil5q1s0Oy4=;
 h=From:To:Cc:Subject:Date:From;
 b=OV61lWEayn3LYEHqqYjdbT4rDnSYkojA/uBcYiviKrLQosTqoljlBxdyQuag4D38t
 QD3252d92imOW+XVDTj0qjrOJ+PoJ1FHyjBnZPYlsp6uvQj29AfMW/W9l/rAHYKyz1
 EIhGcaMmM0JN4aG/HcXCFiYrX6jbcm36zLqiheYnoEV/n8g93nWWuHGTHlbljGZIyW
 DwtikEg30uOxeLh6dEvCADQkuEKd5jCOvDNzz3suRYVpoI0hAgf8LBxjbIdG8fLEMv
 52a1BO/Ce+DjZrrYEzZcYdQZR3Zhx1bno/f/yNbVWXKZAiVyJNYG5rA6eoaqmksXog
 K4HSm1NvPH8FA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Wed, 18 May 2022 16:50:04 -0700
Message-Id: <20220518235011.153058-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1nrTU6-0006CE-Rn
Subject: [f2fs-dev] [RFC PATCH v2 0/7] make statx() return I/O alignment
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, linux-ext4@vger.kernel.org
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

This patchset applies to v5.18-rc7.

No changes since v1, which I sent a few months ago; I'm resending this
because people seem interested in it again
(https://lore.kernel.org/r/20220518171131.3525293-1-kbusch@fb.com).

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


base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
