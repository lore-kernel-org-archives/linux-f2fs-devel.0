Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C5FEB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jun 2023 22:14:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q9CHE-0001So-Ff;
	Tue, 13 Jun 2023 22:14:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1q9CHA-0001Si-Se
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 22:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IaNpxfe9VBRajurg4lymuYlTPKYS4B0yt+ZAn6yihIY=; b=IAN+a2FXYU6uJRNNkS6pliXHFt
 TcLH5qu5SHXDPhzoIzTPSkt9U3O40TriNSgTxRtlC04WCXlTwYuyGbqw8w7yf+yZdka3EacJjvk2z
 LMJMhupLb5Dal52a7Uwosb5Qf7a1Y39Duzv+gvEpFna5mWkhiivUWgr4y006/V6zPNbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IaNpxfe9VBRajurg4lymuYlTPKYS4B0yt+ZAn6yihIY=; b=OPKrwda/+f8hUxsb+fw5paRgk2
 INF4RTCk5V1rds08kN9HKLdt/x8yOCsaV2MZewZZH9/1ar76ee7VTZlvfn3VqbyPaOZ38SZK9MNIW
 sjjkx+nBKyR6LO9bppP7Hz3klHm4PMaCKibVrG9PxQcqMp+exdbEEdq7+F3BtBFrynRU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q9CHA-002ERL-Hh for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jun 2023 22:14:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 26A2D61884
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Jun 2023 22:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A08C433C0;
 Tue, 13 Jun 2023 22:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686694442;
 bh=BZl5RDaB9YV1iJvxCsTqdhiHN3w4NKnznFWhk6lWK64=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=oMfpyYEFVO6AHKQIpvThjeYITqASC7I2oMkJEzAx148ZcahRXmyp9nq2pbbPoOWPC
 K7Ex7mibuR6zWV4NbpcKJspZ27YbONbG8hdPzTpbloUMHJgD9Kf7vE6iuUa82ZOlvX
 S3cFv4t3Vjm75v2Dk675nc3diiFVXMqH5lbnVxxgtD5g4qv9sJ1jJth7vzAK+RT3kD
 cqmBb5OMWly5oT2v1/X/9++vQnyFGj3bT14lzOpsW5GzgojMqkHQfChPmMrdm6eiue
 QWJVeop+uS+qmBA0XXIc+NQAhIbPtzhMDGzaI2cHIOnXUw9nEBSjrdRK1PKcN+d2mm
 9qeKSU+W0QE4Q==
Date: Tue, 13 Jun 2023 15:14:00 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <ZIjqKHDUmN6u9pXa@google.com>
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606203645.3926651-1-jaegeuk@kernel.org>
X-Headers-End: 1q9CHA-002ERL-Hh
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress tmp files given extension
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

Let's compress tmp files for the given extension list.

This patch does not change the previous behavior, but allow the cases as below.

Extention example: "ext"

- abc.ext : allow
- abc.ext.abc : allow
- abc.extm : not allow

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - refactor to allow abc.ext.dontcare only

 fs/f2fs/namei.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 3e35eb7dbb8f..49573ef4115d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -23,7 +23,7 @@
 #include <trace/events/f2fs.h>
 
 static inline bool is_extension_exist(const unsigned char *s, const char *sub,
-						bool tmp_ext)
+						bool tmp_ext, bool tmp_dot)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
@@ -49,8 +49,12 @@ static inline bool is_extension_exist(const unsigned char *s, const char *sub,
 	for (i = 1; i < slen - sublen; i++) {
 		if (s[i] != '.')
 			continue;
-		if (!strncasecmp(s + i + 1, sub, sublen))
-			return true;
+		if (!strncasecmp(s + i + 1, sub, sublen)) {
+			if (!tmp_dot)
+				return true;
+			if (i == slen - sublen - 1 || s[i + 1 + sublen] == '.')
+				return true;
+		}
 	}
 
 	return false;
@@ -148,7 +152,7 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
 	hot_count = sbi->raw_super->hot_ext_count;
 	for (i = cold_count; i < cold_count + hot_count; i++)
-		if (is_extension_exist(name, extlist[i], false))
+		if (is_extension_exist(name, extlist[i], false, false))
 			break;
 	f2fs_up_read(&sbi->sb_lock);
 	if (i < (cold_count + hot_count))
@@ -156,12 +160,12 @@ static void set_compress_new_inode(struct f2fs_sb_info *sbi, struct inode *dir,
 
 	/* Don't compress unallowed extension. */
 	for (i = 0; i < noext_cnt; i++)
-		if (is_extension_exist(name, noext[i], false))
+		if (is_extension_exist(name, noext[i], false, false))
 			return;
 
 	/* Compress wanting extension. */
 	for (i = 0; i < ext_cnt; i++) {
-		if (is_extension_exist(name, ext[i], false)) {
+		if (is_extension_exist(name, ext[i], true, true)) {
 			set_compress_context(inode);
 			return;
 		}
@@ -189,7 +193,7 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
 	cold_count = le32_to_cpu(sbi->raw_super->extension_count);
 	hot_count = sbi->raw_super->hot_ext_count;
 	for (i = 0; i < cold_count + hot_count; i++)
-		if (is_extension_exist(name, extlist[i], true))
+		if (is_extension_exist(name, extlist[i], true, false))
 			break;
 	f2fs_up_read(&sbi->sb_lock);
 
-- 
2.41.0.162.gfafddb0af9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
