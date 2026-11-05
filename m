Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BBF606D80C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NBK4SKM5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CTiLeTn9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IdC6rstX;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjaW5H+p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=7o01VB3K1meSPONbHtPN/9GAM3Df4k2WzOgI4Tm6DMM=; b=NBK4SKM5QNpH97MmvJYQhwLzKh
	2jtVMQR4a5t6kztVZ/zdevTNFVEwvn/YyjpW7f8ZJtuoZC8DLPNy0tt1xKQzNMfg04b9kcTNq1eS3
	YFy7/08jQoE3VI9peUW55VCwm3dcquc7NhFNYXmhGe/Nirgj62mOql7mQN/DQZZQ2KfY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOw5g-0000000032l-0A8e;
	Thu, 05 Nov 2026 11:57:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOw5H-000000002yd-1e9q
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jWfWtiSRF9ohz4K/V0l41cooucJsu+dpibJLDPYDXkg=; b=CTiLeTn9Dn/7Xr3aeEhB6rXAiX
 Jw5ESZpLws6+2AYfyDbwthulE9P+02+pFZBo+vs7wENezjGVffSWsjebfOFrAu6pV0Yec0FgatTuB
 djrc3JjwFK6XJEkiu+k8J5dKOxk5p77670VdjFwr6s3xAFKYqggquRXSObf8moE4C3Ys=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jWfWtiSRF9ohz4K/V0l41cooucJsu+dpibJLDPYDXkg=; b=IdC6rstXsYvj2qUlaYdTHfl5pI
 j6F/b4hnOJGm8S5jruFSwVyXb6JhKNf1EFSNGurlhTyxy13I68YZ4wGJO4JQnSn8lRcipYS59brK8
 AZNeu9nIO6o09V9CaX6oWxyNu49v8NtaytYeZnRAe80ayPjmPB+lmBvfm4T/1M3ULfWg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOw5G-000000007ih-49kt
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:56:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 828FC406BA;
 Thu,  5 Nov 2026 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0671F00919;
 Thu,  5 Nov 2026 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793879801;
 bh=jWfWtiSRF9ohz4K/V0l41cooucJsu+dpibJLDPYDXkg=;
 h=From:To:Cc:Subject:Date;
 b=AjaW5H+psLSec360G8YGjTp9dQ4N0SAk+L8tN9wncqWl0DTzYxgvn/hGtTXHzfHOs
 QNfs7PHT3/n1ieFpBsgAq+Ad8aLbAd4WK+TB+Pdp2yBKncv6QSj8pWA0Nx7FZrgXpb
 YnbqSwrkbE/30RIwBExMTH6zdBIzmw3GQCavbq9/sYMGfJtnWUUVWCQPiyP/6kHl+d
 IMrAPnfivXIbEqserKVywaSln2M+6CyV4pTEE4+dz9UgqTLiimGPSXO/6IgukbEygT
 sgMYiVBS0RzFCI0Zy7T+XSY36pDuEKkKgvhMtvzDV5Qs7HDIfNGOyKUYMSrunQ/KaO
 1KL5jt66feBnA==
To: ebiggers@kernel.org, hch@lst.de, fsverity@lists.linux.dev, dsterba@suse.com
Date: Thu,  5 Nov 2026 12:55:25 +0100
Message-ID: <20261105115532.613467-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOw5G-000000007ih-49kt
Subject: [f2fs-dev] [PATCH v2 0/5] fsverity: lift ioctl() input masking and
 runtime inode flag to VFS
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: tytso@mit.edu, brauner@kernel.org, Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

This patchset lifts two things from filesystems to VFS level:
- No-oping FS_VERITY_FL in SET ioctl()
- runtime fsverity construction flag

The first one fixes BTRFS get-modify-set loop with
FS_IOC_GETFLAGS/SETFLAGS ioctl()s, as it does return fsverity flag but
not mask it out.

Testing, -g verity passes for all fs, except btrfs/277 and
btrfs+generic/574.

The btrfs/277 seems to fail due to difference between what kernel
and userspace versions support (btrfs-progs v7.1 doesn't seem to
support latest streams v3).

The generic/574 on BTRFS fails only for 1024 block size no matter
the change (fails on v7.3 too). I haven't checked why.

Changes in v2:
- Return ret in btrfs_begin_enable_verity()
- Include linux-fsdevel

Andrey Albershteyn (5):
  fsverity: strip FS_VERITY_FL from FS_IOC_SETFLAGS
  fsverity: add I_VERITY_BUILDING inode state flag
  btrfs: use I_VERITY_BUILDING instead of private flags
  ext4: use I_VERITY_BUILDING instead of private flags
  f2fs: use I_VERITY_BUILDING instead of private flags

 fs/btrfs/btrfs_inode.h   |  7 -------
 fs/btrfs/verity.c        | 14 +++-----------
 fs/ext4/ext4.h           |  7 -------
 fs/ext4/file.c           |  2 +-
 fs/ext4/inode.c          | 17 +++++++++--------
 fs/ext4/ioctl.c          |  3 +--
 fs/ext4/verity.c         | 18 +++++-------------
 fs/f2fs/data.c           | 10 +++++-----
 fs/f2fs/f2fs.h           |  7 -------
 fs/f2fs/verity.c         | 15 ++++-----------
 fs/file_attr.c           | 10 ++++++++++
 fs/verity/enable.c       | 22 +++++++++++++++++++---
 include/linux/fs.h       |  6 ++++++
 include/linux/fsverity.h | 21 +++++++++++++++++++++
 14 files changed, 84 insertions(+), 75 deletions(-)

-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
