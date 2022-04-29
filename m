Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB09DC43217
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Apr 2022 18:28:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nkVLV-0001YK-18; Fri, 29 Apr 2022 18:28:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <krisman@collabora.com>) id 1nkVLT-0001Xy-T7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Apr 2022 18:27:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LP74SXSLallJDJFvnepUZUaZ4D5qushscWLXFs5HHuM=; b=ZT1ItBVJ6IRVr847+smUa5Y23j
 dWLD7r1tjV35ZXepBi8rNd7Ke+SBR+hRwzv7HS5K3aTInKDNTfahSdlhn8GXwAZWEHGGCcKhPgzNh
 87+hHzJrfNmrloMhkrPTLgjR+oVGLLm81QIjFR7ABlwIzvTTmPLllGuOj8zOip1KE6OY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LP74SXSLallJDJFvnepUZUaZ4D5qushscWLXFs5HHuM=; b=ItoywerurUe/Bx4z/H/VM6q0in
 2OJ76BtMeD0r3iBO9auAwgBjjJUt9O2zDOWHYFtdZ4CjyWtTxDGnTwqjEkGUvPn1wKTC7RnUlKUvN
 XofZZGwHhnUD7tuJMYYC62w+bY8+0QCWcJuvWwYyRCE16SP6K3poymrYKC3Adlry5Glg=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nkVLS-0001qU-68
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Apr 2022 18:27:58 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id C488B1F46913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1651256872;
 bh=oEaF20C4aIC1tZklEgboa5zDbpP1I68FAiSAwW9buHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QZiYqebtw0VKMXprv4ZNnM3H7vtYZPKX58JkORmEchJUySqza4uy5Q9CKjmGI7mPQ
 tROHXkf7L6iG6XdVaMJGPo6eXhxseAjtwu7lY+UPuj4JUezdm7RqK20AtLL/7IOJND
 BIr+mRAC68H18gPtn9rImNJ8OOA/pgFmb1Ja+A2YJq8nhNcnvyIJSG3lq9ZF5XQ291
 Q08vP+k7+p4To4m9QumYjKXVjPjI1WuTyeoBI2yuvyrYyXFAiKc3dpVA2u2cvjCP7N
 hB+B7edkf2moDEVQ79Bdd7hFFYbRZiG6saRyhHYU700Y0qM0vMN/4se7M3G7eNsPo5
 J8im4PrK7p1xA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jaegeuk@kernel.org
Date: Fri, 29 Apr 2022 14:27:26 -0400
Message-Id: <20220429182728.14008-6-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429182728.14008-1-krisman@collabora.com>
References: <20220429182728.14008-1-krisman@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1nkVLS-0001qU-68
Subject: [f2fs-dev] [PATCH v3 5/7] ext4: Log error when lookup of encoded
 dentry fails
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
Cc: ebiggers@kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>, kernel@collabora.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---

Changes since v1:
  - reword error message "file in directory" -> "filename" (Eric)
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e450e52eef48..d53c8d101099 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1457,6 +1457,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+						 "Bad encoded filename");
 			return false;
 		}
 		return ret;
-- 
2.35.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
