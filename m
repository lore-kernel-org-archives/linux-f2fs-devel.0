Return-Path: <SRS0=qeLJ=7O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA7C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jun 2020 20:08:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE2A2074B;
	Mon,  1 Jun 2020 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fLnrIgex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QT89p7f6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWKFmytT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE2A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jfqjs-0004hy-SU; Mon, 01 Jun 2020 20:08:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jfqjr-0004hm-Tv
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 20:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y3/uOANY7bMTo2oq9mZzLCRTKxdM2HUGMbWcQAsGPY8=; b=fLnrIgex6V70mf/EWlVtNUUSC/
 3fu3NX5NSQCB1I0gWTC/nq9Op+GaVRPuyaFZqx1s73AqeXtTiiOqMqCLJ4wFgs2+Ydt0lnBjqUoEs
 muslBHFbUYfaHXdqpachszti6ag5rhsHUwAZdt3f+wSIpUpR7YtVo7eqLWz/wJXamaXY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y3/uOANY7bMTo2oq9mZzLCRTKxdM2HUGMbWcQAsGPY8=; b=Q
 T89p7f6H40Dq8KGghwZY/tqn3T1IOWiM80iTSwLy6Dpg2O+oQlu1VqhAHfqFDtgHuJT3pIiUp97Th
 TVZllA9Um6pYPq14cGWCA7CUdW03nG2twqodd6cjGet2lqdQ9eh/IQjf3ss9ymp3v7NbynV9ZhHV5
 fQl2lPdgZC4cd0yU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jfqjn-004kmq-Ls
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 20:08:51 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D119E20734;
 Mon,  1 Jun 2020 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591042115;
 bh=85zG2AyYa1iBuFIil+uEjS+WxblsLLJ2fCz4UIcuvB0=;
 h=From:To:Cc:Subject:Date:From;
 b=bWKFmytTENc3vIROh8oQVWS1O0w1comVKM+t+gE9ks8imExM5DT6P5bLl2uv+8F+H
 kmKMJK+ltnLXxYGFjA24VPmHpyD6aZeUlxiqtthaluyVGj9zT+YnYHpP8gR62W6Q4a
 t3oNWPVc1HbbNM3uvgCrfqsnhMQ48ZHYrh1mJSXE=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  1 Jun 2020 13:08:05 -0700
Message-Id: <20200601200805.59655-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Headers-End: 1jfqjn-004kmq-Ls
Subject: [f2fs-dev] [PATCH v2] f2fs: avoid utf8_strncasecmp() with unstable
 name
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

v2: Use memcpy() + barrier() instead of a byte-by-byte copy.
    Also rebased onto f2fs/dev.

 fs/f2fs/dir.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 29f70f2295cce..d35976785e8c5 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1114,11 +1114,27 @@ static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
 	const struct inode *dir = READ_ONCE(parent->d_inode);
 	const struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
 	struct qstr entry = QSTR_INIT(str, len);
+	char strbuf[DNAME_INLINE_LEN];
 	int res;
 
 	if (!dir || !IS_CASEFOLDED(dir))
 		goto fallback;
 
+	/*
+	 * If the dentry name is stored in-line, then it may be concurrently
+	 * modified by a rename.  If this happens, the VFS will eventually retry
+	 * the lookup, so it doesn't matter what ->d_compare() returns.
+	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
+	 * string.  Therefore, we have to copy the name into a temporary buffer.
+	 */
+	if (len <= DNAME_INLINE_LEN - 1) {
+		memcpy(strbuf, str, len);
+		strbuf[len] = 0;
+		entry.name = strbuf;
+		/* prevent compiler from optimizing out the temporary buffer */
+		barrier();
+	}
+
 	res = utf8_strncasecmp(sbi->s_encoding, name, &entry);
 	if (res >= 0)
 		return res;
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
