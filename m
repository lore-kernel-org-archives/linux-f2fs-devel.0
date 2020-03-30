Return-Path: <SRS0=OWUn=5P=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE44C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Mar 2020 19:25:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821272072E;
	Mon, 30 Mar 2020 19:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ckNn04az";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RE8VVwpo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7oyKBsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821272072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jJ02S-0000UP-4l; Mon, 30 Mar 2020 19:25:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jJ02Q-0000UD-Bc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Mar 2020 19:25:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y6gSVL3/E8p4ZqhVdctvaK5PD0QVElVpaxRmKvaP2QI=; b=ckNn04azKiDPYO377X2H4bFqlZ
 lRmfjC7hOvPtFSVRZ+48nbvhgbiAPswH9gesRRMiZsxJ4VWXR0MWzX5HCPChFY3pVKqBSntI91EHM
 ypngsVxUMilHV0fr95gJt42NXioJoFU7Z+fdD3sq5WzuuHYy7ty9OIZGcHKzxxsYcIoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y6gSVL3/E8p4ZqhVdctvaK5PD0QVElVpaxRmKvaP2QI=; b=R
 E8VVwpo2zEpC9yJpV65VPwbcsjNjf7VrwN/c3OZdakAf+NrmvJulO1ex2rlZBAp8wffxiNJDYTAkN
 glPgqV47cxC4EQOaxCbIXMpMqzq+20CqjaMi2+NHJ/0MOlmILzlCIon+NbHzN37oRXsUtKut2o1jt
 nrEfA/PiSvVRLAZs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jJ02P-00ClPS-9M
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Mar 2020 19:25:34 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A5382072E;
 Mon, 30 Mar 2020 19:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585596325;
 bh=FPKJsyCnEC0nCygZD91NxrJ+36I26GDU630Lpsm7G0M=;
 h=From:To:Cc:Subject:Date:From;
 b=j7oyKBsXXcnrCA0J+ZyG1ppm1m+rxwnrrBGAqcPMCYtKTnr0mzuk/jYS82VJvCTJB
 0jRmJDf8jQJ86e++y6wgjBTBxFf4GKROSNtH8s79r7XGktbRFkd/3AeJOViRR1T2x/
 oCyyYSR7NFgC7zIBBfYIDd1/19Jht54g3AZdVrUg=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 30 Mar 2020 12:25:24 -0700
Message-Id: <20200330192524.8931-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
X-Headers-End: 1jJ02P-00ClPS-9M
Subject: [f2fs-dev] [PATCH] f2fscrypt: show more information of policy
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
Cc: Jaegeuk Kim <jaegeuk@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@google.com>

This patch gives more information of encryption policy.

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
Change-Id: I04a6826aa4497554ce79d884d495b3dda1b64fac
---
 tools/f2fscrypt.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
index fe3e0ff..bb3e70f 100644
--- a/tools/f2fscrypt.c
+++ b/tools/f2fscrypt.c
@@ -63,6 +63,8 @@
 #define F2FS_ENCRYPTION_MODE_AES_256_GCM	2
 #define F2FS_ENCRYPTION_MODE_AES_256_CBC	3
 #define F2FS_ENCRYPTION_MODE_AES_256_CTS	4
+#define F2FS_ENCRYPTION_MODE_ADIANTUM		9
+#define F2FS_ENCRYPTION_MODE_PRIVATE		127
 
 #define F2FS_AES_256_XTS_KEY_SIZE		64
 #define F2FS_AES_256_GCM_KEY_SIZE		32
@@ -531,6 +533,33 @@ static void get_passphrase(char *passphrase, int len)
 	*p = '\0';
 }
 
+struct enc_mode_map {
+	int mode;
+	char name[255];
+};
+
+static const struct enc_mode_map enc_mode_str[] = {
+	{F2FS_ENCRYPTION_MODE_INVALID, "invalid"},
+	{F2FS_ENCRYPTION_MODE_AES_256_XTS, "aes_256_xts"},
+	{F2FS_ENCRYPTION_MODE_AES_256_GCM, "aes_256_gcm"},
+	{F2FS_ENCRYPTION_MODE_AES_256_CBC, "aes_256_cbc"},
+	{F2FS_ENCRYPTION_MODE_AES_256_CTS, "aes_256_cts"},
+	{F2FS_ENCRYPTION_MODE_ADIANTUM, "adiantum"},
+	{F2FS_ENCRYPTION_MODE_PRIVATE, "ice"},
+};
+
+static const char *get_crypt_mode(int mode)
+{
+	int i;
+
+	for (i = 0; i < (sizeof(enc_mode_str) / sizeof(enc_mode_str[0])); ++i) {
+		if (mode == enc_mode_str[i].mode) {
+			return enc_mode_str[i].name;
+		}
+	}
+	return "N/A";
+}
+
 struct keyring_map {
 	char name[4];
 	size_t name_len;
@@ -827,6 +856,11 @@ static void do_get_policy(int argc, char **argv, const struct cmd_desc *cmd)
 		for (j = 0; j < F2FS_KEY_DESCRIPTOR_SIZE; j++) {
 			printf("%02x", (unsigned char) policy.master_key_descriptor[j]);
 		}
+		printf("\tversion: %u\n", policy.version);
+		printf("\tcontents_encryption_mode : %s\n",
+			get_crypt_mode(policy.contents_encryption_mode));
+		printf("\tfilenames_encryption_mode: %s\n",
+			get_crypt_mode(policy.filenames_encryption_mode));
 		fputc('\n', stdout);
 	}
 	exit(0);
-- 
2.26.0.rc2.310.g2932bb562d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
