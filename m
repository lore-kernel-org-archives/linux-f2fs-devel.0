Return-Path: <SRS0=QVvM=VQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83BC7618F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:14:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CD6208C0;
	Fri, 19 Jul 2019 01:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="EpmZwBL5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="LXeY9llI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="TKxHVlu5";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="jlECP3AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CD6208C0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g9Y5Vz8j2rslsnftEm6pSKOD0wvTqgQNuwjk0SMlAvc=; b=EpmZwBL552LWgW4Z31FjQUCe6b
	WlgLHaI6B/sGdoPhQ8ab+IJODHeQgy+BmiPq4vbHKB0KUTpLJFroOkPgpqjChDXOO7GgCuyGzXS1l
	pGLZZy27HCBxRY8msnBBM5vNvFJQFwY8CH+E9nTx9lWdKtPhkUZhHaKsIEb1G8o9GMuw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hoHTU-000484-SC; Fri, 19 Jul 2019 01:14:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <30AgxXQYKAJU2GDH3C5DD5A3.1DB@flex--drosen.bounces.google.com>)
 id 1hoHTT-00047w-By
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jul 2019 01:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=; b=LXeY9llI7oCoqoZclZLWdgTsw0
 CfFpTDTQLIb15Q2t31cPmDiW1G5bZNyU4XFL7nyIdlcxaZdXiciiBbz2ubDLDVt5bUPBed10Au+DL
 2/iY5wXCqBHGwUChch5q0eGpGS/FqWZ8PMR9I243/D+TvUcvTzin2NLbKdcdgRyulHIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=; b=T
 KxHVlu5a/2szhKbXUbTPUkyoZ5SvORFiCZDri6p2LPRKyUjuYZe9tSkXq1/K3Z9HQ/sMSaYBOv5FY
 rkZk5HILpNy+zfN42h5LdVNkuk/VlG8FszR5yq5X4eOTEGeMUsOYdQN1zOXD0w81a5BYrJwi4IPg6
 gNaTGzdRXaQ+b6rg=;
Received: from mail-qt1-f201.google.com ([209.85.160.201])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hoHTS-006hOm-0a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jul 2019 01:14:15 +0000
Received: by mail-qt1-f201.google.com with SMTP id q26so26149799qtr.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Jul 2019 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=;
 b=jlECP3AShHax5jtmkNgXohpyfl7vU5w7VHrgYsRWrEm2m4hlw/rYhIrWcKnQsgM/dy
 OZKUI6y+AIE/8YlhSPji2idKxN0l15EnM8rzrdMLZV0TLJnOlEsSZXi2fPES3upK7XOP
 P6Fu8zpLaXcgEM3opBWpKQlDf9WiVxWgEuUtKWlVO+u6rMYKgmPr9aRAZf59izPvrH50
 P2eNvCymoJmAshBV+K5iW9R/VnFb0MSoMnaF9QL2N6ZCJF1ZEOrMKEF0NoPv34W3YyUn
 QvkwFcFGXXB2EJ8HkYnTFjdiARmGNnuoUjeWQCsOvq9hLKU7Q6n//i3scNYe1DmFLOqQ
 8r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=9DEv8u8NV9GsQdpVG3YSkd6Fwchyp0Tmy7aGf7fvO/A=;
 b=lqCnfxMgD4LGkb2Kk6/du65cC7DBDhRa4T1wcjX4si3DkMjG9anyKWUIBdYWgmUNf+
 ZHkpUedd8yKbLugNfl3uMkrsCfoJXw8LwbNLbfNIVvPSSZpNq1YuM37t2Gi/4dZfL+6U
 zUbWo8yLIpgCXL4/FWrDagMg8f7Pk+7YwQ41OEEg1qJpzAPuAWFGVdxEOXlOASu7eXOO
 CbJKXOoqeDMikSyKnP206cKRiz7cops0vQUeYATduxHdFb2Mv+/28bgqdslIpxDDeQCh
 QK1y101K61sHQuPRB1HhYpdSUE2ym/pCHCd7x8Aqgfj4+MXy8hl2mqVPQZXX+YGX/KFQ
 c8hA==
X-Gm-Message-State: APjAAAVd84h3ogqhhczlbqnod78O4klM4SLHax3kOYM05gu/fsDbcJUK
 g63nK6RZdYf80r32A7j1D+ZzL3C9HoE=
X-Google-Smtp-Source: APXvYqwRtX2YZ4Wg80vezuYYq+k1K3TfOAWAb15xfWjTiHcPsAy8V60Fafp8iP5EMk8uQaIB6Ld5vnGMWuw=
X-Received: by 2002:ac8:2642:: with SMTP id v2mr32821422qtv.333.1563494608664; 
 Thu, 18 Jul 2019 17:03:28 -0700 (PDT)
Date: Thu, 18 Jul 2019 17:03:20 -0700
Message-Id: <20190719000322.106163-1-drosen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1hoHTS-006hOm-0a
Subject: [f2fs-dev] [PATCH v3 0/2] Casefolding in F2FS
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

These patches are largely based on the casefolding patches for ext4

v3: Addressed feedback, apart from F2FS_CASEFOLD_FL/FS_CASEFOLD_FL
    Added sysfs file "encoding" to see the encoding set on a filesystem
v2: Rebased patches again master, changed f2fs_msg to f2fs_info/f2fs_err

Daniel Rosenberg (2):
  f2fs: include charset encoding information in the superblock
  f2fs: Support case-insensitive file name lookups

 fs/f2fs/dir.c           | 126 ++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |  21 ++++++-
 fs/f2fs/file.c          |   9 +++
 fs/f2fs/hash.c          |  35 ++++++++++-
 fs/f2fs/inline.c        |   4 +-
 fs/f2fs/inode.c         |   4 +-
 fs/f2fs/namei.c         |  21 +++++++
 fs/f2fs/super.c         | 100 +++++++++++++++++++++++++++++++
 fs/f2fs/sysfs.c         |  23 ++++++++
 include/linux/f2fs_fs.h |   9 ++-
 10 files changed, 334 insertions(+), 18 deletions(-)

-- 
2.22.0.657.g960e92d24f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
