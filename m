Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE4DC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Oct 2022 08:49:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ojGOC-0000c7-1N;
	Fri, 14 Oct 2022 08:49:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hrkanabar@gmail.com>) id 1ojGOA-0000bT-Bs;
 Fri, 14 Oct 2022 08:49:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e7OO4yxaPUsVNNTpu1wi+buwSaoss8IhgddIo1BpRyE=; b=O+uN187w9jTQkQThkRaEtNISYB
 fgjzsj0PCnFKS5sytKIW1ldLtOO+3a7Ks6ASdai5BJpDB+IY0XKov3IDEFQW7p0sAZDcGQQ7F4Y0Z
 gry7UBVxsprYBeFlqGRmwkZajT8ibH+MUIcHAEKtNqO8joisiGNkSHGiQGIHUYD83m5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=e7OO4yxaPUsVNNTpu1wi+buwSaoss8IhgddIo1BpRyE=; b=CRERAQgXC2cG2K/H2uyTQBnHiL
 bxPyI+8PvxdjBSSycWDCGxTvDua0b2Jf7KMLahBPso5zfuPXuJ3YfJULDc7AJuuqxE5pq09g4Rs3I
 UARq0+vRTpAY63Ugsviti2M3VA5lcuE7RoX8i+U8Ku7/RV7/A4jkLjFKpBg2cibJweoc=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ojGO8-003OL6-2o; Fri, 14 Oct 2022 08:49:53 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 m29-20020a05600c3b1d00b003c6bf423c71so4471951wms.0; 
 Fri, 14 Oct 2022 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7OO4yxaPUsVNNTpu1wi+buwSaoss8IhgddIo1BpRyE=;
 b=oC6tSxasgYZK7HLegRBPiSvjZcFyUQ6VxaiXUsn9DOOqsgYUd3GwVU3xpX+MEuUcs6
 5Zyo5II4xi0HIqzm0H97V7F94fYQdDLt8AuD+JZzU47QQ/LuGMQdYOOGSKw2dxumvRKB
 h7m582fFWyx3oprKN1q8FSc+To8Y6JDmPTRnd4hkSq/AbbkLHlkBJXB8Q+TOCpRRhl2y
 d/+ZTjaaMTxKRAiVLHhe3QjKwq7Ra5hv6vxdw+Sr9ECBJR0PxYgvhE2OVPZwv9ed7dwQ
 BaLglkid8PnXT/nXhWq1sEkYBW8NVoxmsiJn/yjvdRctbBZZqCVrgn4QIC2aa5IUvmbp
 Ws2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7OO4yxaPUsVNNTpu1wi+buwSaoss8IhgddIo1BpRyE=;
 b=ZQlvHTjMSNQU8+EOx54WqIFrCqH271gsEtMCpCcfvRfZutXnmyNt5OYUposcL37jaZ
 psTup2aOwwLG30EN5k9lExRf5xtJZbX3yJS2oLPOs9qnDc7/rZTtDJ6pKrspViF1lJXk
 cRMrAosYXwWC70/IQD0fTfCVVN5+zAVIWYItLEUCgWwYz6YvA3FNxQ+h1C+oGrwXdYqZ
 IX6VaqeMTEEEODAkMxlekvQpVOnCujt3cEy2c3GCOvH7/F44OYK1uXmVr56AwbGosqL7
 uUh3Xv9QqzL6lpz9phS6SKNv5Tw0Zv6B44VY1D722IBzruk1krfGgOQiljxlyJlgviP9
 +Baw==
X-Gm-Message-State: ACrzQf0i24FLWsqz+G4dbOvbNywrgAAngGeWpvuiaMfNmfZG9MZ+9Qmz
 IGCGfoNfUhIh+NSmF1Ud3XE=
X-Google-Smtp-Source: AMsMyM4UuuSQy7/mg7oAryPWOasHAjc2gENOIuSxoGVuTVFY95besHOPxbhAIYXtJwHmTWJN46oPAQ==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id
 hg8-20020a05600c538800b003c504c1a1f6mr2698975wmb.11.1665737385463; 
 Fri, 14 Oct 2022 01:49:45 -0700 (PDT)
Received: from hrutvik.c.googlers.com.com
 (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
 by smtp.gmail.com with ESMTPSA id
 123-20020a1c1981000000b003c6c4639ac6sm1547372wmz.34.2022.10.14.01.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 01:49:45 -0700 (PDT)
From: Hrutvik Kanabar <hrkanabar@gmail.com>
To: Hrutvik Kanabar <hrutvik@google.com>
Date: Fri, 14 Oct 2022 08:48:31 +0000
Message-Id: <20221014084837.1787196-2-hrkanabar@gmail.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221014084837.1787196-1-hrkanabar@gmail.com>
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1ojGO8-003OL6-2o
Subject: [f2fs-dev] [PATCH RFC 1/7] fs: create
 `DISABLE_FS_CSUM_VERIFICATION` config option
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, kasan-dev@googlegroups.com,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 Marco Elver <elver@google.com>, Josef Bacik <josef@toxicpanda.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Anton Altaparmakov <anton@tuxera.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ntfs-dev@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
 linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Hrutvik Kanabar <hrutvik@google.com>

When implemented and enabled, this should circumvent all redundant
checksum verification in filesystem code. However, setting of checksums
is not affected.

The aim is to aid fuzzing efforts which randomly mutate disk images and
so invalidate checksums.  Checksum verification often rejects these
mutated disk images, hindering fuzzer coverage of deep code paths. By
disabling checksum verification, all mutated images are considered valid
and so exploration of interesting code paths can continue.

This option requires the `DEBUG_KERNEL` option, and is not intended to
be used on production systems.

Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
---
 fs/Kconfig.debug  | 20 ++++++++++++++++++++
 lib/Kconfig.debug |  6 ++++++
 2 files changed, 26 insertions(+)
 create mode 100644 fs/Kconfig.debug

diff --git a/fs/Kconfig.debug b/fs/Kconfig.debug
new file mode 100644
index 000000000000..bc1018e3d580
--- /dev/null
+++ b/fs/Kconfig.debug
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DISABLE_FS_CSUM_VERIFICATION
+	bool "Disable redundant checksum verification for filesystems"
+	depends on DEBUG_KERNEL
+	help
+	  Disable filesystem checksum verification for checksums which can be
+	  trivially recomputed from the on-disk data (i.e. no encryption).
+	  Note that this does not affect setting of checksums.
+
+	  This option is useful for filesystem testing. For example, fuzzing
+	  with randomly mutated disk images can uncover bugs exploitable by
+	  specially-crafted disks. Redundant checksums are orthogonal to these
+	  exploits, as they can be recomputed for crafted disks. However, for
+	  testing it is more reliable to disable checksums within the kernel
+	  than to maintain image generators which faithfully reimplement
+	  per-filesystem checksum recomputation.
+
+	  Say N if you are unsure. Disable this for production systems!
+
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 73178b0e43a4..4689ae527993 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -979,6 +979,12 @@ source "lib/Kconfig.kmsan"
 
 endmenu # "Memory Debugging"
 
+menu "Filesystem Debugging"
+
+source "fs/Kconfig.debug"
+
+endmenu # "Filesystem Debugging"
+
 config DEBUG_SHIRQ
 	bool "Debug shared IRQ handlers"
 	depends on DEBUG_KERNEL
-- 
2.38.0.413.g74048e4d9e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
