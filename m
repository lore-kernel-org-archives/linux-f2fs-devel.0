Return-Path: <SRS0=Yfjj=7M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F36DC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 30 May 2020 06:05:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ED82074B;
	Sat, 30 May 2020 06:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eTRepURg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="gtcs18Kw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwAUZ/ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ED82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jeuc7-0003SU-Mz; Sat, 30 May 2020 06:04:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jeuc0-0003Rg-0r
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 May 2020 06:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rwm7t1eZAitmhCLo5d4rSXmwSazMFohhqjdZfVSOSLM=; b=eTRepURgGe/htXEzQAs0z7IAar
 4ZG/jvNUV2z6P4AGl4zg+VnUJAzmxItXY6rYTOoyYZaMEFXUV1ohF3BJvEa0RibCXJmVVPQ4/8pvS
 1Sd5bGbgKNpl1jyvAj9GTbklpdEFO8saYoeW5GVhDSvCrwiVb9+BRkhQE+zLlD28WA5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rwm7t1eZAitmhCLo5d4rSXmwSazMFohhqjdZfVSOSLM=; b=g
 tcs18Kw0CRxUOBwfuVkjQlN1zZTuRRLUkL9rKI4tXuuL0YapXkz+Xx7HaAAc5+jkony1JOqbAsnPr
 g9xI25wc7o9+APHwmOCgKfIfmqIbi0JjaBkEOrI4WSqx1wewIEp5pwu5nEiSeR/zoPLX47Un3HSJ0
 D6xHFPw9Kpe+Qk5U=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jeuby-003dcn-Gs
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 30 May 2020 06:04:51 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19B042074B;
 Sat, 30 May 2020 06:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590818680;
 bh=f42mP4uZFz68CGLoJzgxTIkgVm0ozHVg79XnQ76VYrw=;
 h=From:To:Cc:Subject:Date:From;
 b=hwAUZ/ckiy8+KY/KQA+ZB0NnCd4BzfTTXTIbUq75mFZmHL/ki9nixoGKsmDjoVexY
 vLa3tIHIldvD1NjDbp0A8tfmInodKPkv53MjuwqJ3MUf7Qrd/u/szji1LMLgqEjWxx
 wSzw1gkRdsj2itmgCti97l+5gm1703Q0bmgbo5NQ=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 29 May 2020 23:04:18 -0700
Message-Id: <20200530060418.221707-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Headers-End: 1jeuby-003dcn-Gs
Subject: [f2fs-dev] [PATCH] f2fs: avoid utf8_strncasecmp() with unstable name
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
Cc: Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

If the dentry name passed to ->d_compare() fits in dentry::d_iname, then
it may be concurrently modified by a rename.  This can cause undefined
behavior (possibly out-of-bounds memory accesses or crashes) in
utf8_strncasecmp(), since fs/unicode/ isn't written to handle strings
that may be concurrently modified.

Fix this by first copying the filename to a stack buffer if needed.
This way we get a stable snapshot of the filename.

Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Cc: <stable@vger.kernel.org> # v5.4+
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Daniel Rosenberg <drosen@google.com>
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 44bfc464df787..5c179b72eb8a8 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1083,6 +1083,7 @@ static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
 	struct qstr qstr = {.name = str, .len = len };
 	const struct dentry *parent = READ_ONCE(dentry->d_parent);
 	const struct inode *inode = READ_ONCE(parent->d_inode);
+	char strbuf[DNAME_INLINE_LEN];
 
 	if (!inode || !IS_CASEFOLDED(inode)) {
 		if (len != name->len)
@@ -1090,6 +1091,22 @@ static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
 		return memcmp(str, name->name, len);
 	}
 
+	/*
+	 * If the dentry name is stored in-line, then it may be concurrently
+	 * modified by a rename.  If this happens, the VFS will eventually retry
+	 * the lookup, so it doesn't matter what ->d_compare() returns.
+	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
+	 * string.  Therefore, we have to copy the name into a temporary buffer.
+	 */
+	if (len <= DNAME_INLINE_LEN - 1) {
+		unsigned int i;
+
+		for (i = 0; i < len; i++)
+			strbuf[i] = READ_ONCE(str[i]);
+		strbuf[len] = 0;
+		qstr.name = strbuf;
+	}
+
 	return f2fs_ci_compare(inode, name, &qstr, false);
 }
 
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
