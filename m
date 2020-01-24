Return-Path: <SRS0=bY38=3N=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFEBC2D0CE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jan 2020 04:14:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BC021835;
	Fri, 24 Jan 2020 04:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GRk4KdPu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="khzqPVUr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENYOqfwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BC021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iuqMK-0004fb-El; Fri, 24 Jan 2020 04:14:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1iuqMJ-0004fQ-10
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jan 2020 04:14:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Hs+BhVe8fkVlZxGtWJoVtVCUN9Ar6kxEc0eN5uOshI=; b=GRk4KdPuMPu3fF99qaEnxOFRQ4
 uIqu4//RVYXRLaE0DARwf44uSKTDCXG7q8NjXc8nLocKBTcmmLj98qSkHUbD8sMc+YSXdxjnPijDI
 sKgxvphIl5BO4nmxDgnSpEQE0wJCYzmxMcIKFOAHmIP16Ja9p7s0ieNEb1yKNxN/My+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3Hs+BhVe8fkVlZxGtWJoVtVCUN9Ar6kxEc0eN5uOshI=; b=k
 hzqPVUrtG+XQJI/pSg0sf8Eh4+mWIKkAqOpfWr+/ndi4RkG/8vVSNrajRrHL7o4VD5jR50Uae2mMe
 UMzvQkjxtu8/TgSBT1VFZEfs5vVm5Rq0IlRrOLoeraRFpvgNCDJdoNpbtjSAE9Cet9w5wo0VrxEeL
 ULt76P1/oI0yDLDk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iuqMD-003EPZ-BP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jan 2020 04:14:14 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A22D221835;
 Fri, 24 Jan 2020 04:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579839238;
 bh=9M/43ASt24xXS4PFNViJs8gRtrsAvfec/+ExbNn5fMI=;
 h=From:To:Cc:Subject:Date:From;
 b=ENYOqfwbD3Idoo/SDprBeK4AfVugyAXIQatJ4WXhb7ShxC3xiI7JvGlp6wWT22RpC
 BKf+zdUm+zUkIb92mRSPKwYfoRygux1T+WH/QpL58S5C7fEEu+F80szSGoKL+e5ECE
 m3yYsYGScHTZNz3X2QwyDjT179CYPDFaRbZmgHpM=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org
Date: Thu, 23 Jan 2020 20:12:34 -0800
Message-Id: <20200124041234.159740-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Headers-End: 1iuqMD-003EPZ-BP
Subject: [f2fs-dev] [PATCH] ext4: fix race conditions in ->d_compare() and
 ->d_hash()
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
Cc: linux-fsdevel@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Since ->d_compare() and ->d_hash() can be called in RCU-walk mode,
->d_parent and ->d_inode can be concurrently modified, and in
particular, ->d_inode may be changed to NULL.  For ext4_d_hash() this
resulted in a reproducible NULL dereference if a lookup is done in a
directory being deleted, e.g. with:

	int main()
	{
		if (fork()) {
			for (;;) {
				mkdir("subdir", 0700);
				rmdir("subdir");
			}
		} else {
			for (;;)
				access("subdir/file", 0);
		}
	}

... or by running the 't_encrypted_d_revalidate' program from xfstests.
Both repros work in any directory on a filesystem with the encoding
feature, even if the directory doesn't actually have the casefold flag.

I couldn't reproduce a crash in ext4_d_compare(), but it appears that a
similar crash is possible there.

Fix these bugs by reading ->d_parent and ->d_inode using READ_ONCE() and
falling back to the case sensitive behavior if the inode is NULL.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Cc: <stable@vger.kernel.org> # v5.2+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/dir.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 8964778aabefb..0129d14629881 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -671,9 +671,11 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
 			  const char *str, const struct qstr *name)
 {
 	struct qstr qstr = {.name = str, .len = len };
-	struct inode *inode = dentry->d_parent->d_inode;
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *inode = READ_ONCE(parent->d_inode);
 
-	if (!IS_CASEFOLDED(inode) || !EXT4_SB(inode->i_sb)->s_encoding) {
+	if (!inode || !IS_CASEFOLDED(inode) ||
+	    !EXT4_SB(inode->i_sb)->s_encoding) {
 		if (len != name->len)
 			return -1;
 		return memcmp(str, name->name, len);
@@ -686,10 +688,11 @@ static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
 {
 	const struct ext4_sb_info *sbi = EXT4_SB(dentry->d_sb);
 	const struct unicode_map *um = sbi->s_encoding;
+	const struct inode *inode = READ_ONCE(dentry->d_inode);
 	unsigned char *norm;
 	int len, ret = 0;
 
-	if (!IS_CASEFOLDED(dentry->d_inode) || !um)
+	if (!inode || !IS_CASEFOLDED(inode) || !um)
 		return 0;
 
 	norm = kmalloc(PATH_MAX, GFP_ATOMIC);
-- 
2.25.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
