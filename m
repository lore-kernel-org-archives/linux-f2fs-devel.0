Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1C5606AE30
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZHEKvqX1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HsdZNHgl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V6NnIx90;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGoE//p+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=T2BcZHEMsD8i4ll5yUrLkWj7IezhOaZZQrwITr9lIIM=; b=ZHEKvqX12DC1/TSsh5YO29jtI8
	xPngsi5loRTuI0mHd7V9Cs93fVk66kdAJNsW6bnST/8F1wf7v4ff38ekphje+g/aaNW5617mMqMzp
	PfDvLhDtlrRPOcAhOvkdvizW/t7SD3XXu0ChTlYzMvVnstEGmNawE8VgL3dz6kfqcefY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOgwU-00000000367-3xR1;
	Wed, 04 Nov 2026 19:46:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOgwT-00000000360-34YB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lk0nkB20UHBUlsaMLEKO7TkV1KlMrxKnvx5Pki3dFMQ=; b=HsdZNHgl5VKHz8WbDW6t8pHzZi
 yeQEY7NiWCFAK4eeiDyO0CY8iNQtKyU76p9IzQAMVK36g94+XG6daC96sTOjGO7bCZNsKjmabflm+
 uVOvCZC/KnR0bf7IwT/td2YuorUGslSjrAPz0nUs2aoppN/d7S6AOivzg4F4UPx9y/gY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lk0nkB20UHBUlsaMLEKO7TkV1KlMrxKnvx5Pki3dFMQ=; b=V6NnIx900wOLRCf5QldC4gPYVV
 RTmGn/l4aLDugXkpCSq8mqWVxfB8HK6pO9tSSNwGYTGH0FrM9jjR1Ob33Pxdym0KNlntkMQ/5pQok
 y3LYJI8B7NzcThOgntZdoAxHPOsf6joQUNqZ0hMGGbd4s4PeL2WrpkDjyQS/PsX0wO+s=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOgwS-000000004Ms-1bVA
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13E5640D81;
 Wed,  4 Nov 2026 19:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033011F00A1B;
 Wed,  4 Nov 2026 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821595;
 bh=lk0nkB20UHBUlsaMLEKO7TkV1KlMrxKnvx5Pki3dFMQ=;
 h=From:To:Cc:Subject:Date;
 b=VGoE//p+hHXdD4a0I3SvmaBjEUrpDbFTIFmmepkyAZ4G80jODd/8MjIyoYzYFskCX
 PFvn4kpUR3NyJKUYLRpFEhhWjBvZwsynVHqUXqn4w2SxeWB5QSXhYnCJ+van7KNVyv
 UAyhZQ1xFTrmdhL+/Hrtx9hTibL8Nq2v8X4lj/rxwX1ZyKW0ZWjvEA3h4wGDLmzc9P
 yKmIiD5dt5VHTNMVu2boYQsT0YX1LWhFs1C8EIV8GUIKzAm4lY/4rI0PM3l0nCWsnO
 8frEcXyAP+7IckwtN8ka8x8Ircb29uVM2g63lQp1iDd449GrAExAnzyFj+hBuNNEGI
 /dYklvs3rgWIg==
To: ebiggers@kernel.org,
	hch@lst.de,
	fsverity@lists.linux.dev
Date: Wed,  4 Nov 2026 20:46:09 +0100
Message-ID: <20261104194618.103332-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOgwS-000000004Ms-1bVA
Subject: [f2fs-dev] [PATCH 0/5] fsverity: lift ioctl() input masking and
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
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

Andrey Albershteyn (5):
  fsverity: strip FS_VERITY_FL from FS_IOC_SETFLAGS
  fsverity: add I_VERITY_BUILDING inode state flag
  btrfs: use I_VERITY_BUILDING instead of private flags
  ext4: use I_VERITY_BUILDING instead of private flags
  f2fs: use I_VERITY_BUILDING instead of private flags

 fs/btrfs/btrfs_inode.h   |  7 -------
 fs/btrfs/verity.c        | 12 ++----------
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
 14 files changed, 83 insertions(+), 74 deletions(-)

-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
