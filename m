Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A9C61DC7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yKzXfmmdg4i7EmvNVrqraZY1mW4HasyrQ3v52AbbHqY=; b=Mn9AeAlWr0gG9duhlF0fZ/HUUK
	V30vomLt2hOBTlDdzEVjKoD2pgIilqWlPX4b17X/UW6SSgOzcDZnI7UaACkeDVoZE+hqYc/zIFUYm
	5DUEHg0Mc1J8ruT92nazmpCoUIhZKMpkrx80qrE4wi31YjkneX5HXS5mtvE0stvMzQ4U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzqtB-00025s-9w;
	Fri, 28 Aug 2026 07:20:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jeuk20.kim@gmail.com>) id 1wzqt9-00025l-PS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uXsApZa8Vi5ynohBI7cN4DA/XtwNMqC5yo4nBQCk/iE=; b=lgxNMaIo9RvWrc6N1/H5gr+1tG
 GTGCkxYVjhG0QhOubLB+KuDoYv7ncpFItNMH6WKbP63r5zZDersmSRTerannlnR50hWQF34VTr8b5
 /DzhA+JEl6AIpXn3i3goPLoM9poaEHKS+9CE+nxgtNZjgX08rn9R/37/L7yOGlFxfbY0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uXsApZa8Vi5ynohBI7cN4DA/XtwNMqC5yo4nBQCk/iE=; b=Y
 WJxM3gHzDZzYx832HmdTFmRqCcbEfUZWKrzv5BFinevmwgmdrNcV5Cgxs6RZKBzX5msttuqiilqig
 R5tcIkNaV+ppi4GXgAkabdv1Vt+ru+qJeKnCJB6dwDEh5LJ+HGgKlK8hMYWMQsGIwhqhTY5swvPfM
 6IlIiD/3ohs5YoQk=;
Received: from mail-pg1-f176.google.com ([209.85.215.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzqtA-00030u-1K for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 07:20:36 +0000
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc1a4c62804so505373a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787901630; x=1788506430; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uXsApZa8Vi5ynohBI7cN4DA/XtwNMqC5yo4nBQCk/iE=;
 b=GYtBgHfF+Lcx2bcq+rkDj1+rKIG5AV2yR9rRjTrlhhM2acc6TOUZi2cI82rVW9zJnU
 UkMcIOsZpnQG0rCuNgl1Z2qmJS6nm7avWtbdu9X/RbgM40p+ynDLbYv9VAATTYHV4MoY
 /yxpMpJSV5lS7dH7B6XQEgh0MTkLX5meEJTzISdXqPJoeoWhaFEvTyrouF8nSieS1R7i
 HJpKkHlyhp73zTRemiIC2MNkipSHAFt29agDyF2kfMDAib6qIsYi6FlEBZAOXQ28AulC
 HAPji+zRatCphrVo63Iu9adYfUQ2P+jwl+nM4FgJEy/nZeFULS54NftQ+79hL+R7TZt/
 y/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901630; x=1788506430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXsApZa8Vi5ynohBI7cN4DA/XtwNMqC5yo4nBQCk/iE=;
 b=sggW7y/9xbO65yqPz+B96ifwGtAOv/rN/fm5eV9UYxwfIoB2KLhDCaxlpuyEIYotgo
 NoIJJapoh5l+rZOqB9a6TRWpwqxMlgoZ3qCSaAUAtlGy6lZ2JtX+nrRqBE6sVDMJ4hTy
 JEoOMrvxkm7OaWOKBcfS3u5vxESaeq43oEqXMUr7LmRBdOhPlTp7uVeFJF4nxnHm6ZW6
 +AgGEbR5jO1HBrJB+5FwuMcreN7gj9gpIS92efx2tYVBohak2WM+Xq/+t6xqpBl6G0Fb
 pc74LXWDKDubdVDwmkuuM0EPcjUowcUYwHoAe+kb80UQHx1aGB1HPDGYURF9MvoGpQGy
 2k0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxT8riG4/i8FfZWe254VCY2wo7HzopZ34XIXtW85ZiFz/6pUbYS7RoG3I3Q+PBZC6OCFFEGSKxUZUgwBHpfK6c@lists.sourceforge.net
X-Gm-Message-State: AFuF++lfmTQYvUng/VDzIqTWMZPcFioY+8IQvMsN8ehtSyDeRR2B2+Mb
 jkCl9VfvUz8f+S2tmEAsHqVefXLKDGqTdnmqLrWVym40v19j+rAHUfoO
X-Gm-Gg: AR+sD101JrpMQkBX1wHQOLgxtX+mF3YACwMZemnKx9bLn4wLzJ6qz2RpUZZO1eP6+Ad
 pO1gkxChwn/q5fuHBH5DUPd4HTO9r0dppiESHSqoUrluMJC51SC230tr7dL32ZHZwPh7PG0n9OM
 j8lZB1moLbvc5GICL5yKsR0J/fs3b8YqwjueJ5wKX+3jjl9A2fcxE52o1Sj1R60IVAessojTRcH
 KxMxs5ue8oQUDZ2VaTG2JMnz2VYP9S0lBt0SKIFy0piw41Zq/NSd75TIGnFM0ZH7DG+uOAcNOiq
 VpETatMxBy6MG22o7Da2dTdIan4YH3+7g2DZLMKWc4LGL9UNFD9dJRn+GZFUCNi2pWZ/Dav2fZG
 VkV1gx/2mdTfMiI3nxXSp5y9X25YBm75IzXzuOMUYAf0bmqwTEjzc6SyLnWTgDb/Dmk6W5Tlc7c
 kSWgyKHDJBQ/7S88bZD+U8hiMA5H00dXW49JwdZsSEjMUfWjx6w6Q+/ABdsygc5/4BcqU=
X-Received: by 2002:a17:90b:54c5:b0:395:4de4:92c7 with SMTP id
 98e67ed59e1d1-396d0e5ccc7mr10951364a91.3.1787901630320; 
 Fri, 28 Aug 2026 00:20:30 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm6123731a91.4.2026.08.28.00.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:20:30 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 28 Aug 2026 16:20:14 +0900
Message-ID: <20260828072017.44569-1-jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wzqtA-00030u-1K
Subject: [f2fs-dev] [PATCH 0/3] f2fs: add per-file out-place update control
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
Cc: yunjae00.jo@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Yohan Joung <jyh429@gmail.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS currently has only filesystem-wide controls for its update policy.
Both "mode=lfs" and ipu_policy affect every file in the filesystem, so
there is no way to force OPU for a selected file while leaving unrelated
files under the normal adaptive policy. This series adds a persistent
per-file OPU override.

Patch 1 fixes write tracking for pinned direct I/O in LFS mode. Pinned
files still overwrite in place, so FI_UPDATE_WRITE must be set to ensure
that fdatasync() flushes the device cache.

Patch 2 fixes a regression in the existing LFS-mode direct-I/O path.
Since commit 351bc761338d ("f2fs: optimize f2fs DIO overwrites"), an
O_DIRECT overwrite of an already mapped range can reuse the existing
physical block even in LFS mode. Restore OPU for those overwrites before
extending the same path to per-file OPU in patch 3.

Patch 3 adds F2FS_IOC_{SET,GET}_OPU_FILE and stores the per-file policy
in a new F2FS_OPU_FL bit in the inode's on-disk i_flags word. A
runtime-only inode flag would lose the setting on inode eviction.

There is no free bit in i_inline or i_advise, and extending extra_attr
would require a larger i_extra_isize, which cannot be assumed for existing
inodes. Store the policy in an unused i_flags bit instead, avoiding an
inode layout change and allowing the policy to be set on existing files.

Comments on the per-file interface and the use of an i_flags bit for the
persistent policy would be appreciated.

Jeuk Kim (3):
  f2fs: set FI_UPDATE_WRITE for in-place direct writes to pinned files
  f2fs: fix in-place direct I/O overwrites in LFS mode
  f2fs: add ioctl to force out-place-update per file

 fs/f2fs/data.c            | 36 ++++++++++++------
 fs/f2fs/f2fs.h            | 16 ++++++++
 fs/f2fs/file.c            | 80 ++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/f2fs.h |  2 +
 4 files changed, 113 insertions(+), 21 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
