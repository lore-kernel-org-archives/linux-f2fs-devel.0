Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BF9EFCD96
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BE55qCqVgpJN/A1AvyBaY5jYmcv7Ct5ygm6DAtBcsPY=; b=SOeIbHFrdtzKBLEeTWd3oQNODt
	hg0yqzohlsHZuyp8wG79ggiitI7F7/Ek74DSBSSOO+YTHLiCFyAKnuIROIiw8SHlB/WPpnNLN6QPo
	vGNctlr+UaBGL+aGC/Jl2CgaAaTrTrs6qw9o67H5s4FeCvQsaI0F+FktA2A+S28vjbms=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzXzu-0004pJ-FR;
	Mon, 09 Mar 2026 10:38:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <william.allentx@gmail.com>) id 1vzXzY-0004nR-J5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 10:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3n7XWtMSYt33OB5GLqeAcUX1zFZSJspqo7CjV/jPPgA=; b=WT+16X71PtUUr/QOQf4sXQPRLI
 LSSLwteNLFLgibL36eNtM3icI0CuFk9ckqevMIufdHWe3ejQd9uFW5rHZKZ+NwyQxa+86L8WY6z6j
 fMa6E4TyZM9T4GawBGouzczpIchM+S4cpUYjeNCm5cRnVVpXgbQWNrV30MaqJIay6INk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3n7XWtMSYt33OB5GLqeAcUX1zFZSJspqo7CjV/jPPgA=; b=c
 0aiQ6bzq/Jpodh8lWGgEFKcWOq2FCJZYe5dgpBa98/Y6zviBIZThkp6PfAmQrMFClq/VF0y/fg/sb
 6tJbeFpPvwe02XXEK2SHldUf7DFqy0jT5Ege5b7K2Bf+5LEvQ/jou8zVBxwsrqEb2Pi/39xTVaf4r
 ojTZqmSGFdiyQi/4=;
Received: from mail-ot1-f45.google.com ([209.85.210.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vzXzY-0008Ew-Ux for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 10:37:41 +0000
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d756f2a06dso23491a34.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Mar 2026 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773052650; x=1773657450; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3n7XWtMSYt33OB5GLqeAcUX1zFZSJspqo7CjV/jPPgA=;
 b=HBJwCNO3e+qwrNMO2/ok/dHC2+yQpmAaeZSOLCvR+mwSZu51UGJVLt4lFthgYMSdEl
 TAquhWs3vMjIm+TbKATTB6TghoETZrAmATo0d0Jw8WYfD3vgV80TvTITilJ1WwSEk7kk
 wL+Hd0Mgd/u5PAxHIechZRuZxcKKAEVG5O3l8hpA5lqTyymfUqrSaJo+XJk9LjgUtrFN
 gVzTWc5/A7QD7K35fWatXxvgiB7cOc6arodJm7s3zk3AneJoi9SKahBZF+XrKcxJ1Z0h
 GEuQQY74zbSZfPbCLoyyPUn2rQGjM0IcbiAvWEdt7NV6nrr//PWdMQK+cuImIywTkNY4
 ScWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773052650; x=1773657450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n7XWtMSYt33OB5GLqeAcUX1zFZSJspqo7CjV/jPPgA=;
 b=Cg2zKHTzvn3DoPPskWovqLKZJzgAGsimKS1dFFDiYP+V759YwK2+kRDqQR217U5nz0
 +cUVGZoOhBW3aek9gSZsKr+JIVVgzGSKP5VqvNSzcWgWsqAsRVYKzaVFGtVo5uS8kP6H
 n+GD1akYvp27HhqV25mISQfmOSJ17wvIuzinzddD62BdW4yDiM74zpPX1A2eedSf9IXl
 lFD7xWK8Dn0hYkxif2ztG7H+vNON736bX9cu3y1MSv3GOLbkyWYfFuE2npFd0n0EQvlQ
 wphuJ6NfahTs0wpVLq3O3dW7CQ+fJ5xxKMs+6X8kXqDPTjfRtoo5mkJN5sz0Vi2tWmvL
 ytOQ==
X-Gm-Message-State: AOJu0YzcvyXtw8rmjFLFKLq8CT7KP9jHC1sBHzwRCIijiWsCQ/SCZLP0
 YuE4YLe2V/jU69rq8MAfCTxNo+OdA6zxGwKliiQBpx0FtazwmuAmCanp9Sz5oAhG
X-Gm-Gg: ATEYQzwio2M9puqkSfOTVAro66GpOroIsDnWyg6BVPAqWEWaxEJ72kdmmYykl6I31Fj
 Twwppeyk5OpjIk3fIHcZ+1NdvI4bOMqJH+noMtggaLb2Iz6+7Cx+DZ8Uq0ix3w+8e8l6RD1zsXD
 edk0dAgGEypuak1KZOb4GdiXazoSUByJxxzMz/W3R4XDp86qYMNhRiudkrrdPa2TuNzcBC+gt5Z
 PPzZ6W3q5uSddGpW3IAeKZRbTo9QtFkNB8uFZe86XantSoxrYN/9SOc5fmlQqewq3qKPdcbZhHm
 h5vjgs02lZ5NwxzAdu4btPCmGnBJYvk/rDCqu++sWlnZqx6bCcR9XNTy/RvmLagbUO977GzGirU
 skgJz8tB8laf31yHc3Ix/gI3yeOGN3EvW/1PcUPwMjkCurEq/O3y3zGzNljtsGmPMRM9Z+LZlx9
 rNdVYUqb4Lh63nEuG7mXgESEuxGW/U/fuHm+8P1UnVooDCPIh/bs4=
X-Received: by 2002:a05:6830:6205:b0:7d4:bca1:1d9d with SMTP id
 46e09a7af769-7d7278304camr7232952a34.11.1773052650056; 
 Mon, 09 Mar 2026 03:37:30 -0700 (PDT)
Received: from starman.tricat-industries.com ([136.49.86.72])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d755603798sm231247a34.29.2026.03.09.03.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 03:37:29 -0700 (PDT)
From: 'wallentx <william.allentx@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  9 Mar 2026 05:36:57 -0500
Message-ID: <20260309103700.489932-1-william.allentx@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1vzXzY-0008Ew-Ux
Subject: [f2fs-dev] [RFC PATCH 0/3] f2fs: reduce zoned LFS memory by sharing
 SIT valid maps
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 wallentx <william.allentx@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: wallentx <william.allentx@gmail.com>

This series reduces SIT-related memory overhead on zoned F2FS.

For zoned devices, F2FS operates in LFS mode. In that configuration SSR
is not used, IPU is not allowed, and discard defaults to section
granularity. That leaves a large amount of per-segment SIT bitmap
storage representing segments that are trivially empty or trivially
full.

The core change lets empty and fully valid segments reuse shared
zero/full SIT valid maps, while active or partial segments keep private
maps.

The series is split as follows:

  - [1/3] prepare lockless cur_valid_map readers for later pointer
    replacement
  - [2/3] introduce shared zero/full SIT valid maps for zoned LFS, keep
    private maps only for active or partial segments, invalidate scanned
    SIT metadata pages after mount-time rebuild, and reject
    checkpoint=disable because its accounting model does not fit the
    collapsed shared-SIT representation
  - [3/3] add shared_sit_check/noshared_sit_check to make the remaining
    CONFIG_F2FS_CHECK_FS mirror overhead optional without changing the
    default behavior

On a test system with 43 HM-SMR zoned volumes (~550 TB total) and
CONFIG_F2FS_CHECK_FS=y, static F2FS memory on top of jaegeuk/f2fs dev
at 5f04e90eedd0 changed as follows:

  - current behavior: 58.91 GiB
  - patch 2: 27.70 GiB
  - patch 2 + patch 3 with noshared_sit_check: 12.10 GiB

The same design has also been exercised for several months on a kernel
based on v6.18 on the same host. This series has also been built,
booted, and measured on top of jaegeuk/f2fs dev at 5f04e90eedd0.

Feedback is especially welcome on:

  - the 3-way split
  - the checkpoint=disable restriction in shared-SIT mode
  - whether shared_sit_check/noshared_sit_check is the right interface
    for the remaining CHECK_FS mirror cost

wallentx (3):
  f2fs: prepare cur_valid_map for safe lockless access
  f2fs: reduce zoned LFS memory by sharing SIT valid maps
  f2fs: add mount option to disable shared SIT mirror checks

 Documentation/filesystems/f2fs.rst |  11 +
 fs/f2fs/checkpoint.c               |   4 +-
 fs/f2fs/debug.c                    |  21 +-
 fs/f2fs/f2fs.h                     |  22 ++
 fs/f2fs/gc.c                       |  29 +-
 fs/f2fs/segment.c                  | 436 ++++++++++++++++++++++++-----
 fs/f2fs/segment.h                  |  31 +-
 fs/f2fs/super.c                    |  25 ++
 fs/f2fs/sysfs.c                    |   8 +-
 9 files changed, 494 insertions(+), 93 deletions(-)

-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
