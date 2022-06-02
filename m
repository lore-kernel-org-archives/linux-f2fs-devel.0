Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D66EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jun 2022 07:28:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nwfFR-0000HB-Us; Thu, 02 Jun 2022 07:28:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chaoliu719@gmail.com>) id 1nwfFQ-0000H4-NR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jun 2022 07:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dO8F4huKrg7HK40w6R+II0EDqtahfzCwucyNeG/6yhE=; b=N+JpadkvBGiVM6IzDUkGZ3nweB
 5ylHahxpAJslzw4VAau3gwofc4SDoktOI7ZWyUXMcqD4vPwAfjUCda69BpEAeRB4emLVIUKGiihSH
 4+iN5jUem6YVOmuxlXfTGcAiGmf0UbGfNlbYGgqYg5OegBtLyAh+0UeKqHRAYJ3wFxiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dO8F4huKrg7HK40w6R+II0EDqtahfzCwucyNeG/6yhE=; b=D
 8ZSiT0LoQCh5QGRCDH0yT2hWWJl/XKfd35yFAZt4Z+bjdeeo5GCA/SGwVSIRpd8Ey8FOtsVngh9LW
 HBAg8CcaELoCh+yS6bJEQ6IR4WArNsj/kL8UfQKKdSAl2lGXbQMpromtmD4tKFW9WKTnmoOtZe5oT
 L/rCGzTnPEeUhe+k=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nwfFJ-0002WJ-S8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Jun 2022 07:27:59 +0000
Received: by mail-pf1-f181.google.com with SMTP id c196so4063850pfb.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 02 Jun 2022 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dO8F4huKrg7HK40w6R+II0EDqtahfzCwucyNeG/6yhE=;
 b=YbmlsAf5cKN+CIdt4ksyeiFsXj0EO16r04pJvRYTBKJYl61jvLfDPpgpGksmXE6pna
 f0o9KsvP7NHWOUk3Me3mfFvf89XjY/S+STrfm10JmnFCI8kJdybbtZGmP7v0QqyXOvec
 /b3p05S/iWQNhtPipEU3TFT8HplJgJtc8UaN9lMK4BIhSD6WSw73oa0z82tkxZQEiDtp
 VmNI88iAEOPDH7L0GG78ABi26dMu5+TROVORxgoYoCMbFyveOI6jW1eBZoNAW0umuoG8
 7mT7ZOkcL4pfHlESth8wdpUw5eoe2Kkl2Ac/EZ0AaEsqX8SotY9JRn8hmEzfUrRoDf49
 y/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dO8F4huKrg7HK40w6R+II0EDqtahfzCwucyNeG/6yhE=;
 b=aYh7xSWvdUITreRJmJv9vLf+Ov0d1l1IRa7GAVU+5yg8duzmJsuZWQCVWxhAnqDyrw
 Rm6v8IQSzxCC8l0XMNCbcr+slX+v5sOaWeHNT/9jGgckFNVkHxFfTsMDT3bh747IqN96
 r/pAPOb1y7OiWLC9A7VeTWRAXo3U8HbMY8EG6qbkc3/yzKIMhU8AVhfO/BnMVRapVEdY
 uNxzVrSs8Swcf+YQuocUfwrgKDP7nhFoXcAYHUsNPe2EVlVdppNX+URZPhcYI8lPp9Yi
 +UCjfNm3x25mU872KBbNGE5DHohplBaQXo44qgOAHTcKY4yZPTNb6k/FlejI68t5MSfv
 Ex5w==
X-Gm-Message-State: AOAM533qt4gKowaQD3/cUWuhIXHuhRWu0U0fFRuraTmiLed6/mbCwuys
 qeWnDGFwLnWRqElt7b7ip5D7dIUOpIyKsNe6P4E=
X-Google-Smtp-Source: ABdhPJxSXbdQaUbjNS/QdVvu+sLCgGBWTdnUUVvw1xqzChxB+sM8bBLz7d44zgYoS4w2B8l5C/3ElQ==
X-Received: by 2002:a63:114d:0:b0:3fc:cfa3:52f0 with SMTP id
 13-20020a63114d000000b003fccfa352f0mr2978866pgr.243.1654154869625; 
 Thu, 02 Jun 2022 00:27:49 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id
 c7-20020aa79527000000b0050dc76281ecsm2705091pfp.198.2022.06.02.00.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 00:27:48 -0700 (PDT)
From: Chao Liu <chaoliu719@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Date: Thu,  2 Jun 2022 15:25:40 +0800
Message-Id: <20220602072540.998638-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1nwfFJ-0002WJ-S8
Subject: [f2fs-dev] [PATCH] docs: filesystems: f2fs: fix description about
 compress ioctl
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
Cc: linux-doc@vger.kernel.org, Chao Liu <liuchao@coolpad.com>,
 linux-kernel@vger.kernel.org, Wayne Zhang <zhangwen@coolpad.com>,
 Yue Hu <huyue2@coolpad.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Liu <liuchao@coolpad.com>

Since commit c61404153eb6 ("f2fs: introduce FI_COMPRESS_RELEASED
instead of using IMMUTABLE bit"), we no longer use the IMMUTABLE
bit to prevent writing data for compression. Let's correct the
corresponding documentation.

BTW, this patch fixes some alignment issues in the compress
metadata layout.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 Documentation/filesystems/f2fs.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index ad8dc8c040a2..98dc24f5c6f0 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -818,10 +818,11 @@ Compression implementation
   Instead, the main goal is to reduce data writes to flash disk as much as
   possible, resulting in extending disk life time as well as relaxing IO
   congestion. Alternatively, we've added ioctl(F2FS_IOC_RELEASE_COMPRESS_BLOCKS)
-  interface to reclaim compressed space and show it to user after putting the
-  immutable bit. Immutable bit, after release, it doesn't allow writing/mmaping
-  on the file, until reserving compressed space via
-  ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or truncating filesize to zero.
+  interface to reclaim compressed space and show it to user after setting a
+  special flag to the inode. Once the compressed space is released, the flag
+  will block writing data to the file until either the compressed space is
+  reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
+  truncated to zero.
 
 Compress metadata layout::
 
@@ -830,12 +831,12 @@ Compress metadata layout::
 		| cluster 1 | cluster 2 | ......... | cluster N |
 		+-----------------------------------------------+
 		.           .                       .           .
-	.                       .                .                      .
+	  .                      .                .                      .
     .         Compressed Cluster       .        .        Normal Cluster            .
     +----------+---------+---------+---------+  +---------+---------+---------+---------+
     |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
     +----------+---------+---------+---------+  +---------+---------+---------+---------+
-	    .                             .
+	       .                             .
 	    .                                           .
 	.                                                           .
 	+-------------+-------------+----------+----------------------------+
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
