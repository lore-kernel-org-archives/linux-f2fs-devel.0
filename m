Return-Path: <SRS0=g2Ds=DI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE4AC4363D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:25:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F29D20578;
	Thu,  1 Oct 2020 00:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="FriNCYHm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="h4zZOWzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6m1Y03N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F29D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kNmPz-0006Ee-MT; Thu, 01 Oct 2020 00:25:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kNmPu-0006EJ-Ob
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Oct 2020 00:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s1RlqnI8foTGWUwraIaP9AM6TLYo8V2DTXrJms10Q1A=; b=FriNCYHmPWi6y6KDESEapg6G08
 hhFC2C1HsDvB9M8AqspCFNwMrsPZ0DZeavBrp3hNAK5k7L0mq5mlOgsDzNiSJJ2icacbKFT9XjB+6
 JHuR/SPVP0xdBPOgGWiCsETN8jxPJ6ijuulmM4bu7pNMjr4HtEsy3yno60mAt29+imNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s1RlqnI8foTGWUwraIaP9AM6TLYo8V2DTXrJms10Q1A=; b=h4zZOWzhoAl40y+6fIfumYhr+p
 0IsTtyFre8PK37kwQvAiNErKvvfN3927CUr89ln2UEhCrpmGqxiHVLtg/2lTS9uapgiPzjnTSrrK1
 7ZLqhsP1tIB0FnS4NZhcmoHr5g9QJBw4vuo5o9Kyw3A4xDnb2cFUgrcr+eganhrxKeYI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kNmPn-00FF7z-W7
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Oct 2020 00:25:50 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2805420578;
 Thu,  1 Oct 2020 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601511931;
 bh=/nNZ5RevJQaMc15vRjvv8jrBatzCUxzaN3jBuV22Zr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G6m1Y03NmMKIk6azX9TyBZkc6TzIBTIdebrPSPYsg5sI3wKQo4jwXfJw+kUAH0eAD
 rPYOc9u75/qvgzpmhc3UQs62L6MJsh3tjJaVumqM9O9Ya84gGqxcThwywaNSGnMnBN
 3Ec82EHRpnE2YZyr60rUI0dwY3ytBEygxPbTMefs=
From: Eric Biggers <ebiggers@kernel.org>
To: fstests@vger.kernel.org
Date: Wed, 30 Sep 2020 17:25:03 -0700
Message-Id: <20201001002508.328866-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001002508.328866-1-ebiggers@kernel.org>
References: <20201001002508.328866-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kNmPn-00FF7z-W7
Subject: [f2fs-dev] [PATCH 1/5] fscrypt-crypt-util: clean up parsing
 --block-size and --inode-number
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

For --block-size, check for strtoul() reporting an overflow.

For --inode-number, check for strtoull() reporting an overflow.

Also, move the check for 32-bit inode numbers into a more logical place
(the place where we check the encryption format-specific limitations).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 src/fscrypt-crypt-util.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/src/fscrypt-crypt-util.c b/src/fscrypt-crypt-util.c
index ce9da85d..d9189346 100644
--- a/src/fscrypt-crypt-util.c
+++ b/src/fscrypt-crypt-util.c
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <stdarg.h>
 #include <stdbool.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -1756,18 +1757,6 @@ static u8 parse_mode_number(const char *arg)
 	return num;
 }
 
-static u32 parse_inode_number(const char *arg)
-{
-	char *tmp;
-	unsigned long long num = strtoull(arg, &tmp, 10);
-
-	if (num <= 0 || *tmp)
-		die("Invalid inode number: %s", arg);
-	if ((u32)num != num)
-		die("Inode number %s is too large; must be 32-bit", arg);
-	return num;
-}
-
 struct key_and_iv_params {
 	u8 master_key[MAX_KEY_SIZE];
 	int master_key_size;
@@ -1777,7 +1766,7 @@ struct key_and_iv_params {
 	bool file_nonce_specified;
 	bool iv_ino_lblk_64;
 	bool iv_ino_lblk_32;
-	u32 inode_number;
+	u64 inode_number;
 	u8 fs_uuid[UUID_SIZE];
 	bool fs_uuid_specified;
 };
@@ -1842,6 +1831,8 @@ static void get_key_and_iv(const struct key_and_iv_params *params,
 			die("%s requires --inode-number", opt);
 		if (params->mode_num == 0)
 			die("%s requires --mode-num", opt);
+		if (params->inode_number > UINT32_MAX)
+			die("%s can't use --inode-number > UINT32_MAX", opt);
 	}
 
 	switch (params->kdf) {
@@ -1957,8 +1948,9 @@ int main(int argc, char *argv[])
 	while ((c = getopt_long(argc, argv, "", longopts, NULL)) != -1) {
 		switch (c) {
 		case OPT_BLOCK_SIZE:
+			errno = 0;
 			block_size = strtoul(optarg, &tmp, 10);
-			if (block_size <= 0 || *tmp)
+			if (block_size <= 0 || *tmp || errno)
 				die("Invalid block size: %s", optarg);
 			break;
 		case OPT_DECRYPT:
@@ -1980,7 +1972,10 @@ int main(int argc, char *argv[])
 			usage(stdout);
 			return 0;
 		case OPT_INODE_NUMBER:
-			params.inode_number = parse_inode_number(optarg);
+			errno = 0;
+			params.inode_number = strtoull(optarg, &tmp, 10);
+			if (params.inode_number <= 0 || *tmp || errno)
+				die("Invalid inode number: %s", optarg);
 			break;
 		case OPT_IV_INO_LBLK_32:
 			params.iv_ino_lblk_32 = true;
-- 
2.28.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
