Return-Path: <SRS0=DxnP=DL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F392C4363C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:34:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035BC2067D;
	Sun,  4 Oct 2020 18:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Wk5YTmWi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VtpZezd3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zlima12.com header.i=@zlima12.com header.b="ndTgqG2f";
	dkim=neutral (0-bit key) header.d=zlima12.com header.i=@zlima12.com header.b="WAvdMSqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035BC2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zlima12.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kP8pj-0008Gf-B4; Sun, 04 Oct 2020 18:34:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <bounce+3e7224.39b2c-linux-f2fs-devel=lists.sourceforge.net@zlima12.com>)
 id 1kP8pi-0008GV-OK
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 04 Oct 2020 18:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LcnsucI0zxJdZ9zLJcMLLbGGASH3AwwgQCfc6CYSVMQ=; b=Wk5YTmWi8fsw3eMgRRg9fVozJ8
 r4lCFa+aASkMk1bieC81SqxgmvCwlIAk8oRY1gzYbuXQKknicFFezkGHqKWzS7L2LkmC0oIr9U13M
 dc+nUzqLLRudcD0LC3nQquD3UGweW7bfnHAHt6+Pt5Al+V3+sJfPOOOBpXOkBlWs1jjE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:To:
 Subject:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LcnsucI0zxJdZ9zLJcMLLbGGASH3AwwgQCfc6CYSVMQ=; b=V
 tpZezd3pNSKDtitnr+TEPaD8daIRiQ19CHYQRInfw7FoL6I/e2rvZA7+HAXKbdMqcP13lTrRvijnS
 5B11X0dmvv/WoYKKMk4e+V7UjdAC/niV6VVDmR2ELpKY5CFgRn2W19MSejz1A3ZJGD7LwSrJAKDSZ
 YSRIWgI6HoazoDtg=;
Received: from z10.mailgun.us ([104.130.96.10])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kP8pY-00GWaL-Eh
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 04 Oct 2020 18:34:06 +0000
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=zlima12.com; q=dns/txt;
 s=mx; 
 t=1601836436; h=Content-Transfer-Encoding: Content-Type: MIME-Version:
 Date: Message-ID: To: Subject: From: Sender;
 bh=LcnsucI0zxJdZ9zLJcMLLbGGASH3AwwgQCfc6CYSVMQ=;
 b=ndTgqG2fKKurdrmtPi7VuucOSuwKFMdvVJcYc6Lu63ASYT55rDS0Msq1LkmKKaa5h+En9hxL
 gSjAHNG8e1hH98JnLtlSbjY/bCDa1HrB49zT+evevsxiLmPlWQS0wktdis0Dh3vNGVBZskgF
 nMl/5IDYRuTjRP4PX0AmfQrbSmQ=
X-Mailgun-Sending-Ip: 104.130.96.10
X-Mailgun-Sid: WyIxOThiNCIsICJsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIsICIzOWIyYyJd
Received: from baked-potato.zlima12.com
 (pool-98-116-127-192.nycmny.fios.verizon.net [98.116.127.192]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f7a0fa4aad2c3cd1c0a4ca3 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Sun, 04 Oct 2020 18:08:36 GMT
Received: from [10.138.20.20] (unknown [10.138.20.20])
 by baked-potato.zlima12.com (Postfix) with ESMTPSA id EFD85601BB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  4 Oct 2020 18:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zlima12.com; s=dkim;
 t=1601834916; bh=LcnsucI0zxJdZ9zLJcMLLbGGASH3AwwgQCfc6CYSVMQ=;
 h=From:Subject:To:Date;
 b=WAvdMSqtmGOCz2xirjV6JupRUvbETFIGHj1OTjGl6pPuMEeJjcQC0Pu0vV8U13IAx
 znmJilV+WQIGg5eD/QBf0YYum+1zvDUOq2wmQqU18E24xG2FQuoFh7vMBH64gvdI9T
 5iiGKrIT6J7u5CeSNtCs7xUl/L0lhpNKPG6GSnHvn/z8hqveMQ3F+5CFjPBdNk0l64
 HmRMHnyHws8A50bgd1FSHEwqJuJQXvx0fj7ZRW2WTnXU/6BoxLSSYJsVkNoXnRm37A
 CLDyz/Ydsct3P2x8RktnyGRmiXTTKu7ia1NCLwo3dgNJn2NntECQiExHKdTaSb77dU
 TkISj+R8hvhyQ==
From: "John A. Leuenhagen" <john@zlima12.com>
To: linux-f2fs-devel@lists.sourceforge.net
Autocrypt: addr=john@zlima12.com; keydata=
 mDMEXr5/uxYJKwYBBAHaRw8BAQdA0tFvcoIz8+9UtT4GeIL/SZ4pkyXlcSNWIAJfPaUbw5e0
 JUpvaG4gQS4gTGV1ZW5oYWdlbiA8am9obkB6bGltYTEyLmNvbT6IlgQTFggAPhYhBLYjxKu7
 JRJj9l2dwP2ekblaZgkEBQJevn+7AhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 AAoJEP2ekblaZgkEnvYBAPODv8Wv4M/V9EmhjbAmVgTnKI6F+gJeZIM6bm4MTn8jAQCKIxAJ
 w4qbL4jCzyYepai7xb+qXtk7aoVZdBagSG/6D7g4BF6+f7sSCisGAQQBl1UBBQEBB0CKpIrr
 ccdqihcnsSzNqs9jE6GPih7BZrrVcRmOOoUXTQMBCAeIfgQYFggAJhYhBLYjxKu7JRJj9l2d
 wP2ekblaZgkEBQJevn+7AhsMBQkJZgGAAAoJEP2ekblaZgkElj4BAO2/vdyMB/Rn76/qOHvC
 kz4QSSlOQ+dey7rgHZl4ID7sAP4zVo+cSkwabU4lKjVGI1XmKtgsNkxIvkwy49xyR35iBg==
Message-ID: <1ba13c57-712b-6472-1adb-4f4d7539a978@zlima12.com>
Date: Sun, 4 Oct 2020 14:08:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Icedove/68.9.0
MIME-Version: 1.0
Content-Language: en-US
X-Headers-End: 1kP8pY-00GWaL-Eh
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: add -h and --help
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

These two arguments would simply print the usage message.

Signed-off-by: John A. Leuenhagen <john@zlima12.com>
---
 man/mkfs.f2fs.8         |  3 +++
 mkfs/f2fs_format_main.c | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index e2aee76..7745177 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -256,6 +256,9 @@ Number of sectors. Default is determined by device size.
 .TP
 .BI \-V
 Print the version number and exit.
+.TP
+.BI \-h,\ \-\-help
+Print usage and exit.
 .SH AUTHOR
 This version of
 .B mkfs.f2fs
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index f2f0a80..b14d735 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <uuid.h>
 #include <errno.h>
+#include <getopt.h>
 
 #include "config.h"
 #ifdef HAVE_LIBBLKID
@@ -125,12 +126,16 @@ static void add_default_options(void)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:C:d:e:E:g:il:mo:O:rR:s:S:z:t:T:U:Vfw:";
+	static const char *option_string = "qa:c:C:d:e:E:g:hil:mo:O:rR:s:S:z:t:T:U:Vfw:";
+	static const struct option long_opts[] = {
+		{ .name = "help", .has_arg = 0, .flag = NULL, .val = 'h' },
+		{ .name = NULL, .has_arg = 0, .flag = NULL, .val = 0 }
+	};
 	int32_t option=0;
 	int val;
 	char *token;
 
-	while ((option = getopt(argc,argv,option_string)) != EOF) {
+	while ((option = getopt_long(argc,argv,option_string,long_opts,NULL)) != EOF) {
 		switch (option) {
 		case 'q':
 			c.dbg_lv = -1;
@@ -164,6 +169,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 			if (!strcmp(optarg, "android"))
 				c.defset = CONF_ANDROID;
 			break;
+		case 'h':
+			mkfs_usage();
+			break;
 		case 'i':
 			c.large_nat_bitmap = 1;
 			break;
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
