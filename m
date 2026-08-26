Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1FDC5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Wdwb7qxmwafl1wEBpFuCyBiWZGoEQmcH4oActyJsG4Q=; b=k3edNhD/BfHhHGVLJQ2XLCWmUU
	DcvsDpzERQN3lxuVMFLaF9wF/xMIA0Nvs+oIC5HANIV3goE4i5Aq/Soon0aDvHXBuS+pLUmLv6aK8
	HfEeMHZoyo7cQ53k21nw6RhWYB3Z49RlhkBQcWbwvrH3ASgxjjyJwTg4c+BNrXWz0+f0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzI67-0002xH-S3;
	Wed, 26 Aug 2026 18:11:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wzI63-0002x9-2T
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=70l+pktXnkTFw9cxbeR6NIJIADP4PanSEbbcQ2ECs8I=; b=muy9ZUljpSaPTQnjIYLl2nIUP7
 35Weam1s3GitLuqe20pCly4A/awNBXS9RyxD1cE4IFxxa/QfdHwYyoqCybtKD9mF9NmIU51MSBrXw
 GlqulEVVAWXg6cE5yns9i2ndOO/6pGyeVtGlVv0pBZTNAdV5kuxVtxN+MmigZHOy4BPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=70l+pktXnkTFw9cxbeR6NIJIADP4PanSEbbcQ2ECs8I=; b=O
 /SWZ7fPtHmnByb1VvOSBdCBR+qUk140tk5sq7ZzOdrGFxetDhHCZXSPwMG67vCotx/z9Z0/3EouGz
 FalZmiC+KJUmu/lz1KWYYEQJVGia4RIg6FldD1PjpUQ/EKQtNH/gDgCIqo2cyEok/87OLfNwHlnhl
 t/y6dVWtBZ5wODog=;
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzI60-0004Zx-23 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:11:32 +0000
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso788332a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787767886; x=1788372686; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=70l+pktXnkTFw9cxbeR6NIJIADP4PanSEbbcQ2ECs8I=;
 b=kScVTozCB/54h80IBVPL+w2YXQ58c9zyyNlDtP1ZUdgVJx/xmDroDVPwjOSutLxb1G
 3YEIPlKVvIJy70j51U/hlYPEpmgneKYKmnoD1VnP2gg4aetoBLdhtdJ5Sl2oj7xtGCXD
 XS/hiqpXpeVGeJNnoXqqL5kyh1mBcEV/lR3Op2kruLRpSEOztq2SSZp9OKdh93Fnq438
 vIfT9l7/BhJtk4gTVbZc7L0f0wiNEUUIS+HBmGAQAjhXoEjZfPvCCTe2Bta/wDxrCl/Q
 WtXZEE11/fijB6Oe+KC9ZYuz8nCkHA4TJhKjIAds62V1QR6v/lMK7a1z4raePT7tQl9O
 1EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767886; x=1788372686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=70l+pktXnkTFw9cxbeR6NIJIADP4PanSEbbcQ2ECs8I=;
 b=GAXet3JHOhqGu2/jh+5+GReZpbbgdvA2tThOnEc/iZKokHiuZfi8udYExS7WSXXWq2
 5C+LMObA9cMn8AVnGrpQlSpcb8LJExkoY4yYe8TMTrBfVIyg4QTKJu4L+YbEbYOzCo6q
 401Y3cmlJZ3g2vbdzwgcNVhyhBFHEZfda2GIu4HFzCeELtXEN2L5cwNO/GDsWYi0+HX5
 hVlaII/JZwGuVLkrj2TjoZ+L6r8m7DsLaPAvf4sAqrWnWxrQkzSaCwqPAsttJifdDEHP
 MwwJPKruB3ti1jOvt0r+9jU+y8NB03pzWU0AsD1r2JKOXVH1YV9bFztfh890Xladptcu
 /yxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rray9qLTWyK+izQLFw/yBi0CEoG/0KXwxGaVDggl9OSBK7jv/rcHc5lqX/EUZlZiK/VSQOa6tcX9t6SeC/055Gd@lists.sourceforge.net
X-Gm-Message-State: AFuF++kC5Fx0JF70J3alV+DregDjc25E0bSUSffDpHx7D4j/QHhDpFyj
 M3NJG/j1g6AhVtBgTNSd2PyKxV7xXz3cLqO5Gxp1Fz4+TbxaYfwN5EwG
X-Gm-Gg: AR+sD12wdM8DU9/Lt6Vqcz+Ny4IEQDqocSq4JDnvS7rRO96j/1oHpyVDAKxsZZimkek
 BBFLEBTgUrJlrkGsSR4a+NU5sM0EnfaAlnxVurCnj1q5IVPtyECCASKlCykHtvRu61D/xR0q8dl
 21GqX2HZsbeF5fPgz/cocsfOpfFhJvkNdUZ1gcx1v2q6peH1fGndXC6WqwLLmc08WaOH3r1RBCs
 u7P6CTdIf5Kx/hTnbHMhrmdF7nVpLWKDoMHUEeBYnymz3X7HhWTL2T4WecfYU9h5mmR3I3JDe9z
 98Ba6rezKd6wKv9/i1WroJCoQwanUE2xmv87mRCCufc0IBM+7G87xbfNyrHy5IEuNHNLYcKVM+3
 xwZMKZlw7XG6HlgWkx8cqGZLx0OCfS1qWRXsTgSiHYCa9gPZ08iDMB/DHzdPzG6feA0FzGQp/gH
 LArOePOaYixqGtaT1l3L/2aHWf89nPm+cxHG2HAnrfiV+7ndwGZCms/wg6wwEFZjCpM2qjWUMb3
 CPXrLjoKp22PQdAT4JplNp3LmS7xsU/aywlfl7QXedeUUt8FWvgvAPlZ3/YbUm1k/AbivwmRmkY
 svZyxnjo8djs
X-Received: by 2002:a05:6a20:94ce:b0:3c3:9df0:2d66 with SMTP id
 adf61e73a8af0-3cf7607a0ebmr19577158637.6.1787767886004; 
 Wed, 26 Aug 2026 11:11:26 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:d10e:986a:5a1c:babc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141a9036c85sm9334737c88.9.2026.08.26.11.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:11:25 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 26 Aug 2026 11:11:21 -0700
Message-ID: <20260826181121.3825702-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
MIME-Version: 1.0
X-Headers-End: 1wzI60-0004Zx-23
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: enforce alias_filename to match
 device name
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

The kernel expects the device alias file in the root directory to match
the device basename (strrchr(path, '/') + 1) to identify the target device
both during mount in f2fs_restore_device_alias() and during reserve in
f2fs_ioc_reserve_dev_alias().

If a custom alias filename that differs from the device name is used,
the kernel fails to match the alias file at mount time (leaving
FDEV(i).has_alias unset and allowing pinned files to allocate in that
range) and subsequently fails to reserve the device range when requested.

Enforce that if an alias filename is specified, it must match the device
name. Also allow specifying just '-c <device>@' as a shorthand so users
do not have to redundantly type the device basename twice.

Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
Fixes: 8cc4e257ec20 ("mkfs.f2fs: add device aliasing feature")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 man/mkfs.f2fs.8         |  4 +++-
 mkfs/f2fs_format_main.c | 27 +++++++++++++++------------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 9096646..430d180 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -121,10 +121,12 @@ Currently, the kernel is only able to mount f2fs filesystems where the
 block size matches the page size.
 The default value is 4096.
 .TP
-.BI \-c " device-list"
+.BI \-c " device_name[@alias_filename]"
 Build f2fs with these additional devices, so that the user can
 see all the devices as one big volume.
 Supports up to 7 devices except meta device.
+If '@' or '@alias_filename' is given, the device is configured as a device alias.
+Note that alias_filename must match the device name.
 .TP
 .BI \-d " debug-level"
 Specify the level of debugging options.
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 8d44a9b..99d92c5 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -191,6 +191,7 @@ static void f2fs_parse_options(int argc, char *argv[])
 	int32_t option=0;
 	int val;
 	char *token;
+	bool is_alias;
 	int dev_num;
 
 	while ((option = getopt_long(argc,argv,option_string,long_opts,NULL)) != EOF) {
@@ -218,6 +219,8 @@ static void f2fs_parse_options(int argc, char *argv[])
 				mkfs_usage();
 			}
 
+			is_alias = (strchr(optarg, '@') != NULL);
+
 			token = strtok(optarg, "@");
 			if (strlen(token) > MAX_PATH_LEN) {
 				MSG(0, "Error: device path should be equal or "
@@ -226,21 +229,21 @@ static void f2fs_parse_options(int argc, char *argv[])
 				mkfs_usage();
 			}
 			c.devices[dev_num].path = strdup(token);
-			token = strtok(NULL, "");
-			if (token) {
-				if (strlen(token) > MAX_PATH_LEN) {
-					MSG(0, "Error: alias_filename should "
-						"be equal or less than %d "
-						"characters\n", MAX_PATH_LEN);
-					mkfs_usage();
-				}
-				if (strchr(token, '/')) {
-					MSG(0, "Error: alias_filename has "
-						"invalid '/' character\n");
+
+			if (is_alias) {
+				char *dev_name = strrchr(token, '/');
+
+				dev_name = dev_name ? dev_name + 1 : token;
+
+				token = strtok(NULL, "");
+				if (token && strcmp(token, dev_name)) {
+					MSG(0,
+						"Error: alias_filename (\"%s\") must match device name (\"%s\")\n",
+						token, dev_name);
 					mkfs_usage();
 				}
 				c.devices[dev_num].alias_filename =
-					strdup(token);
+					strdup(dev_name);
 				if (!c.aliased_devices)
 					c.feature |= F2FS_FEATURE_DEVICE_ALIAS;
 				c.aliased_devices++;
-- 
2.55.0.887.g758fc8c411-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
