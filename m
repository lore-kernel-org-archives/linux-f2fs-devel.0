Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524F60A260C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SwiHW6/+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZYp3vpz8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e53Kcyc7;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTWV4yfc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=SDx0ZZrDB2hRnAUX5VGAyP5iBBtbBd8P4mj69FgDjcg=; b=SwiHW6/+c7cH74EwOAaBIdisds
	08XLg0exC7hUoZIdYWjDcjQaAADsF3eYqVP9cQIjn1f2243oFGBU+mcc3UFcBU/YQFwkVdqHL+gvl
	Ms1KbeakiBphYiwjaHSIOX1ST5SyDqM0a/h/gPnL7G0enCkcX7fppUxPex55ZqJheqa0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQvw-000000003ro-2yR5;
	Fri, 20 Nov 2026 15:53:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQvv-000000003rc-2M6D
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:53:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+LHSOGcYG6qwjHdgPt0+XZc2oJGKJ+L7kW/ZhoRQBc=; b=ZYp3vpz8z3b7m37oYgbE2VO93p
 w9w7oPAif1ZHqsHPbIvdNj3sbaGMLoI9aEMRjU+MWURQkrQAlgZahdGd+7879iQEEtL70UghVxUPM
 T3zko6cyRcZQgaAbF+rfUvs+Qq4rxDxmYS6nRI36gwekcJe29Ys8ticMrHrHpAq5kP4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+LHSOGcYG6qwjHdgPt0+XZc2oJGKJ+L7kW/ZhoRQBc=; b=e53Kcyc73yQk35MrR/Ex5y1BW+
 6MIHVIHxQJC5R/9dyb9WNPasrC3XVxFTBjBL72h42WW1OjACr9USq6Y+PJF88fOyqeuiysjE/ss0f
 dodqK/UifHVtlHVu+3nMPFK6ksP5ul2rnH9JSka00zCye4k28lvjS26fJOeXhIwWfbvo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQvt-000000003xW-4Acn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:53:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5581436A2;
 Fri, 20 Nov 2026 15:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D3D1F000D0;
 Fri, 20 Nov 2026 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190024;
 bh=v+LHSOGcYG6qwjHdgPt0+XZc2oJGKJ+L7kW/ZhoRQBc=;
 h=From:To:Cc:Subject:Date;
 b=DTWV4yfch6T4GKNBEDPtPRjXNy936zjSMDhrGuKJvN/8SwkSNSYDzrCPcYZwfLb3l
 1slRfaMzRiOXOxdJpAkxti4i6T2MFR3Nv3huXUy/H/jQBkb5ljZe7YtCK9rIE5qYap
 mh+RxfXvSz5RVEtdOTN3PqKgv9/a9jykomEYe2TrmIIYxFhBg76PlhYbpiq3dSNTmc
 oIOed94Q+baMMwrVDIjpZoS0xWYmt/adIw0ZFOzTAsJDDKTxlKbZY6XJOurL8F3r0/
 PxVhTTSv2Nl8tJnJbGWy/yZHAalZgK5QGFuikwrI1iVwJiPw7Ido60UMggXtPTwffK
 D+Vw5QInfdfcg==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:22 +0100
Message-ID: <20261120155032.187246-1-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQvt-000000003xW-4Acn
Subject: [f2fs-dev] [PATCH v3 0/7] fsverity: lift ioctl() input masking and
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
Cc: tytso@mit.edu, Andrey Albershteyn <aalbersh@kernel.org>,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org
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
- No-op'ing FS_VERITY_FL in FS_IOC_SETFLAGS ioctl()
- Runtime fsverity construction flag on inode

The second patch fixes BTRFS get-modify-set loop with
FS_IOC_GETFLAGS/SETFLAGS ioctl()s, as it does return fsverity flag but
not mask it out.

Testing, -g verity passes for all fs, except btrfs/277 and
btrfs+generic/574.

The btrfs/277 seems to fail due to difference between what kernel
and userspace versions support (btrfs-progs v7.1 doesn't seem to
support latest streams v3).

The generic/574 on BTRFS fails only for 1024 block size no matter
the change (fails on v7.3 too). I haven't checked why.

Based on v7.3-rc3.

Changes in v3:
- Add comment that I_VERITY_BUILDING is set over enable
- Revert comment changes in ext4 and f2fs
- Added I_VERITY_BUILDING to show_inode_state()
- Updated comment in begin_enable; dropped -EBUSY
- Added patch changing inode_state_read_once() to const
- Use fsverity_is_building() around ->begin_enable() call
- Use fsverity_is_building() in iomap
Changes in v2:
- Return ret in btrfs_begin_enable_verity()
- Include linux-fsdevel

Andrey Albershteyn (7):
  fs: constify inode argument of inode_state_read_once()
  fs: strip FS_VERITY_FL from FS_IOC_SETFLAGS
  fs,fsverity: add I_VERITY_BUILDING inode state flag
  iomap: use fsverity_is_building() to check for fsverity IO
  btrfs: use I_VERITY_BUILDING instead of private flags
  ext4: use I_VERITY_BUILDING instead of private flags
  f2fs: use I_VERITY_BUILDING instead of private flags

 fs/btrfs/btrfs_inode.h           |  7 -------
 fs/btrfs/verity.c                | 12 ++----------
 fs/ext4/ext4.h                   |  7 -------
 fs/ext4/file.c                   |  2 +-
 fs/ext4/inode.c                  | 17 +++++++++--------
 fs/ext4/ioctl.c                  |  3 +--
 fs/ext4/verity.c                 | 19 ++++++-------------
 fs/f2fs/data.c                   | 10 +++++-----
 fs/f2fs/f2fs.h                   |  7 -------
 fs/f2fs/verity.c                 | 12 +++---------
 fs/file_attr.c                   | 10 ++++++++++
 fs/iomap/buffered-io.c           |  2 +-
 fs/verity/enable.c               | 22 +++++++++++++++++++---
 include/linux/fs.h               |  8 +++++++-
 include/linux/fsverity.h         | 26 ++++++++++++++++++++++++--
 include/trace/events/writeback.h |  3 ++-
 16 files changed, 90 insertions(+), 77 deletions(-)

-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
